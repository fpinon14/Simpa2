HA$PBExportHeader$w_a_sp_trt_dde.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement sur demande
forward
global type w_a_sp_trt_dde from w_a_sp_trt
end type
type dw_2 from u_datawindow within w_a_sp_trt_dde
end type
type dw_saisie from u_datawindow within w_a_sp_trt_dde
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_a_sp_trt_dde
end type
end forward

global type w_a_sp_trt_dde from w_a_sp_trt
integer width = 3305
dw_2 dw_2
dw_saisie dw_saisie
st_avertissement_monnaie st_avertissement_monnaie
end type
global w_a_sp_trt_dde w_a_sp_trt_dde

type variables
Protected :

u_sp_gs_trait_etat_dde    iuoTrtEtatDde
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
end prototypes

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
/* Dw_2  DataWindow : Dw affichant la liste des $$HEX1$$e900$$ENDHEX$$tats		           */
/*------------------------------------------------------------------*/
Dw_2.X				=   71
Dw_2.Y				=  600
Dw_2.Width			= 3500
Dw_2.Height			= 1150

/*------------------------------------------------------------------*/
/* Dw_Saisie  DataWindow : Dw de saisie 						           */
/*------------------------------------------------------------------*/
Dw_Saisie.X			=  654
Dw_Saisie.Y			=   30
Dw_Saisie.Width	= 2922
Dw_Saisie.Height	=  401

/*------------------------------------------------------------------*/
/* Barre defilement                                                 */
/*------------------------------------------------------------------*/

uo_Defil.x 			= 1930
uo_Defil.y 			= 460

// [SUISSE].LOT3 Avertissement Mon$$HEX1$$e900$$ENDHEX$$taire : Postion relative $$HEX2$$e0002000$$ENDHEX$$la barre de defilement
st_avertissement_monnaie.x = uo_Defil.x - st_avertissement_monnaie.width - 10
st_avertissement_monnaie.y = uo_Defil.y

end subroutine

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_dde (OverRide)
//* Evenement 		: ue_Initialiser
//* Auteur			: JFF
//* Date				: 01/03/1999 12:00:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*-----------------------------------------------------------------

This.Title 	  = "Traitement sur DEMANDE"

This.Wf_PositionnerObjets()

iuoTrtEtatDde = Create u_sp_gs_Trait_Etat_dde

itrTrans	     = SQLCA

/*------------------------------------------------------------------*/
/* dw_1 : DataWindow identique $$HEX2$$e0002000$$ENDHEX$$la dw_1 des fen$$HEX1$$ea00$$ENDHEX$$tres mens, trim,...*/
/* 		 elle restera invisible et aucun retrieve ne sera fait     */
/*			 dessus. Elle sera populis$$HEX1$$e900$$ENDHEX$$e en fonction du choix de l'uti-*/
/* 		 sateur.																     */
/* dw_2 : DataWindow pr$$HEX1$$e900$$ENDHEX$$sentant la liste des $$HEX1$$e900$$ENDHEX$$tats disponibles pour */
/* 		 le traitement sur demande.										  */
/* dw_saisie : DataWindow permettant la saisie des param$$HEX1$$e800$$ENDHEX$$tres sou-  */
/*					hait$$HEX2$$e9002000$$ENDHEX$$par l'utilisateur, pour le lancement de son    */
/*					$$HEX1$$e900$$ENDHEX$$tat.																  */
/* dw_Etat : DataWindow identique $$HEX2$$e0002000$$ENDHEX$$la dw_Etat des fen$$HEX1$$ea00$$ENDHEX$$tre mens,    */
/*				 trim, etc...														  */
/*------------------------------------------------------------------*/

iuoTrtEtatDde.Uf_Initialiser ( dw_1, dw_2, dw_saisie, dw_Etat, dw_Volcane, uo_Defil, itrTrans )

iuoTrtEtatDde.uf_Generer_Dw ()

Dw_Saisie.SetFocus ()

end on

on w_a_sp_trt_dde.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_saisie=create dw_saisie
this.st_avertissement_monnaie=create st_avertissement_monnaie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_saisie
this.Control[iCurrent+3]=this.st_avertissement_monnaie
end on

on w_a_sp_trt_dde.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_saisie)
destroy(this.st_avertissement_monnaie)
end on

type cb_debug from w_a_sp_trt`cb_debug within w_a_sp_trt_dde
end type

type pb_retour from w_a_sp_trt`pb_retour within w_a_sp_trt_dde
integer width = 242
integer height = 144
end type

type pb_interro from w_a_sp_trt`pb_interro within w_a_sp_trt_dde
end type

type pb_creer from w_a_sp_trt`pb_creer within w_a_sp_trt_dde
end type

type dw_1 from w_a_sp_trt`dw_1 within w_a_sp_trt_dde
integer x = 1870
integer y = 296
integer width = 480
integer height = 468
end type

type pb_tri from w_a_sp_trt`pb_tri within w_a_sp_trt_dde
end type

type pb_imprimer from w_a_sp_trt`pb_imprimer within w_a_sp_trt_dde
end type

type dw_dates from w_a_sp_trt`dw_dates within w_a_sp_trt_dde
boolean visible = false
integer x = 4119
integer y = 836
integer taborder = 30
end type

type dw_dept from w_a_sp_trt`dw_dept within w_a_sp_trt_dde
boolean visible = false
integer x = 4123
integer y = 652
integer taborder = 50
end type

type uo_defil from w_a_sp_trt`uo_defil within w_a_sp_trt_dde
integer x = 105
integer y = 800
integer width = 1627
end type

type dw_volcane from w_a_sp_trt`dw_volcane within w_a_sp_trt_dde
integer x = 4110
integer y = 984
end type

type dw_etat from w_a_sp_trt`dw_etat within w_a_sp_trt_dde
integer x = 1280
integer y = 296
integer width = 480
integer height = 468
integer taborder = 40
end type

type pb_lancer from w_a_sp_trt`pb_lancer within w_a_sp_trt_dde
integer width = 242
integer height = 144
integer taborder = 60
end type

on pb_lancer::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: Pb_Lancer::Clicked (OverRide)
//* Auteur			: JFF
//* Date				: 04/03/1999 14:00:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

This.Enabled = False
Pb_Retour.Enabled = False

If iuotrtetatDde.Uf_Controler_Lancer () Then

	iuotrtetatDde.Uf_Populisation_Dw1 ()
	
	iuotrtetatDde.Uf_Efface_Col_En_Cours ()

	iuotrtetatDde.Uf_LancerTrt ( Dw_2, "D" )

End IF

This.Enabled = True
Pb_Retour.Enabled = True
end on

type cb_sel from w_a_sp_trt`cb_sel within w_a_sp_trt_dde
boolean visible = false
end type

type cb_desel from w_a_sp_trt`cb_desel within w_a_sp_trt_dde
boolean visible = false
end type

type cb_selpart from w_a_sp_trt`cb_selpart within w_a_sp_trt_dde
boolean visible = false
end type

type dw_2 from u_datawindow within w_a_sp_trt_dde
integer x = 101
integer y = 296
integer width = 480
integer height = 468
integer taborder = 20
string dataobject = "d_etat_dde"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on we_touche;call u_datawindow::we_touche;//*-----------------------------------------------------------------
//*
//* Evenement		: we_Touche
//* Auteur			: JFF
//* Date				: 28/02/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion de l fl$$HEX1$$e800$$ENDHEX$$che press$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


This.SetRedraw ( False )


If KeyDown ( KeyDownArrow! ) Then

	iuotrtetatDde.Uf_Gestion_Des_Fleches ("bas")

ElseIf KeyDown ( KeyUpArrow! ) Then

	iuotrtetatDde.Uf_Gestion_Des_Fleches ("haut")

End If

This.SetRedraw ( True )
end on

on clicked;call u_datawindow::clicked;//*-----------------------------------------------------------------
//*
//* Evenement		: Clicked
//* Auteur			: JFF
//* Date				: 28/02/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion du click sur un $$HEX1$$e900$$ENDHEX$$tat.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long 		lRow

lRow = This.GetClickedRow()

If lRow > 0 then 
	This.SelectRow ( 0, False 	 )
	This.SelectRow ( lRow, True )
	This.SetRow		( lRow 	    )

	iuoTrtEtatDde.uf_Controler_etat ()
End IF

end on

type dw_saisie from u_datawindow within w_a_sp_trt_dde
integer x = 690
integer y = 296
integer width = 480
integer height = 468
integer taborder = 10
string dataobject = "d_traitement_dde"
boolean border = false
end type

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Evenement		: ItemError
//* Auteur			: JFF
//* Date				: 28/02/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Se d$$HEX1$$e900$$ENDHEX$$clanche lors d'une erreur de saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

// [MIGPB8COR]
//iuoTrtEtatDde.uf_erreur_Saisie ()
//remplace par
return iuoTrtEtatDde.uf_erreur_Saisie ()
end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Evenement		: ItemChanged
//* Auteur			: JFF
//* Date				: 28/02/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de la saisie de Dw_Saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

// [MIGPB8COR] PHG
// iuoTrtEtatDde.uf_Controler_Saisie ()
return iuoTrtEtatDde.uf_Controler_Saisie ()
end event

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_a_sp_trt_dde
integer x = 823
integer y = 72
integer width = 1810
boolean bringtotop = true
string text = "Les montants des fichiers Excel sont exprim$$HEX1$$e900$$ENDHEX$$s en"
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: (OVERRIDE)
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

this.text += " " +stGlb.sMonnaieLitteralDesire+"s"
end event

