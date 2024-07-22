HA$PBExportHeader$w_a_sp_traitement.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre de lancement des traitements SIMPA2
forward
global type w_a_sp_traitement from w_8_accueil
end type
type dw_dates from datawindow within w_a_sp_traitement
end type
type dw_dept from datawindow within w_a_sp_traitement
end type
type uo_defil from u_barredefil within w_a_sp_traitement
end type
type dw_volcane from u_volcane within w_a_sp_traitement
end type
type dw_etat from datawindow within w_a_sp_traitement
end type
end forward

global type w_a_sp_traitement from w_8_accueil
boolean visible = true
integer x = 0
integer y = 0
integer width = 3456
integer height = 1772
string title = "Fen$$HEX1$$ea00$$ENDHEX$$tre Anc$$HEX1$$ea00$$ENDHEX$$tre accueil Traitement"
dw_dates dw_dates
dw_dept dw_dept
uo_defil uo_defil
dw_volcane dw_volcane
dw_etat dw_etat
end type
global w_a_sp_traitement w_a_sp_traitement

type variables
Private :

	Boolean		ibStop	 = False	//Bool$$HEX1$$e900$$ENDHEX$$en pour stopper le traitement



Protected :
	U_Sp_Gs_Trait_Anc	iuoTrt

	String			isTypTrt		//Type de traitement $$HEX2$$e0002000$$ENDHEX$$effectuer: 
end variables

on ue_initialiser;call w_8_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Traitement::Ue_Initialiser (EXTEND)
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 17:05:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


String 					sSelectionne_Oui	//Bitmab pour les p$$HEX1$$e900$$ENDHEX$$riodes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es
String 					sSelectionne_Non	//Bitmab pour les p$$HEX1$$e900$$ENDHEX$$riodes non s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es

sSelectionne_Oui 	= "K:\PB4OBJ\BMP\8_COCHER.BMP"
sSelectionne_Non 	= ""

/*------------------------------------------------------------------*/
/* La cr$$HEX1$$e900$$ENDHEX$$ation de la datawindow est r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e sur le script          */
/* descendant.                                                      */
/*------------------------------------------------------------------*/

end on

on w_a_sp_traitement.create
int iCurrent
call super::create
this.dw_dates=create dw_dates
this.dw_dept=create dw_dept
this.uo_defil=create uo_defil
this.dw_volcane=create dw_volcane
this.dw_etat=create dw_etat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dates
this.Control[iCurrent+2]=this.dw_dept
this.Control[iCurrent+3]=this.uo_defil
this.Control[iCurrent+4]=this.dw_volcane
this.Control[iCurrent+5]=this.dw_etat
end on

on w_a_sp_traitement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_dates)
destroy(this.dw_dept)
destroy(this.uo_defil)
destroy(this.dw_volcane)
destroy(this.dw_etat)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_traitement
integer taborder = 40
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_traitement
boolean visible = false
integer x = 4105
integer y = 336
integer taborder = 0
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_traitement
boolean visible = false
integer x = 4105
integer y = 484
integer taborder = 0
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_traitement
integer x = 32
integer y = 388
integer taborder = 50
end type

on dw_1::rowfocuschanged;//
end on

on dw_1::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::dw_1
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 28/12/1998 16:39:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$lection et d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lection Etats
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.SelectRow ( This.GetClickedRow (), Not ( This.IsSelected ( This.GetClickedRow () ) ) )
end on

on dw_1::doubleclicked;// 
end on

on dw_1::we_touche;// 
end on

type pb_tri from w_8_accueil`pb_tri within w_a_sp_traitement
boolean visible = false
integer x = 4105
integer y = 188
integer taborder = 0
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_traitement
integer x = 4105
integer y = 40
integer taborder = 0
end type

type dw_dates from datawindow within w_a_sp_traitement
integer x = 731
integer y = 52
integer width = 1257
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_date_traitement"
boolean border = false
boolean livescroll = true
end type

type dw_dept from datawindow within w_a_sp_traitement
integer x = 2258
integer y = 16
integer width = 1010
integer height = 172
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sp_choix_departement"
boolean border = false
boolean livescroll = true
end type

type uo_defil from u_barredefil within w_a_sp_traitement
integer x = 599
integer y = 216
integer height = 76
integer taborder = 0
end type

type dw_volcane from u_volcane within w_a_sp_traitement
boolean visible = false
integer x = 1920
integer y = 384
integer width = 421
integer height = 264
integer taborder = 0
end type

type dw_etat from datawindow within w_a_sp_traitement
boolean visible = false
integer x = 2779
integer y = 356
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
boolean livescroll = true
end type

