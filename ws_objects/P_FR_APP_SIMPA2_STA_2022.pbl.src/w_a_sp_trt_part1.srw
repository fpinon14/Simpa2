HA$PBExportHeader$w_a_sp_trt_part1.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement particuliers 1 : Stat des nbre de motif de refus.
forward
global type w_a_sp_trt_part1 from w_8_accueil
end type
type dw_saisie from u_datawindow within w_a_sp_trt_part1
end type
type st_encours from statictext within w_a_sp_trt_part1
end type
type pb_excel from picturebutton within w_a_sp_trt_part1
end type
end forward

global type w_a_sp_trt_part1 from w_8_accueil
int Width=3658
int Height=2129
dw_saisie dw_saisie
st_encours st_encours
pb_excel pb_excel
end type
global w_a_sp_trt_part1 w_a_sp_trt_part1

type variables
Private : 

u_sp_gs_trait_part1	uo_TraitPart1
end variables

forward prototypes
public subroutine wf_positionnerobjets ()
end prototypes

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PositionnerObjets (Public)
//* Auteur			: Fabry JF
//* Date				: 07/05/1999 16:49:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionne les objets sur la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Datawindow de saisie des arguments.                              */
/*------------------------------------------------------------------*/
Dw_Saisie.x			= 1300
Dw_Saisie.y			= 20
Dw_Saisie.Width	= 2954
Dw_Saisie.Height	= 310


/*------------------------------------------------------------------*/
/* Datawindow d'affichage de l'$$HEX1$$e900$$ENDHEX$$tat.                                */
/*------------------------------------------------------------------*/
Dw_1.x				= 70
Dw_1.y				= 345
Dw_1.Width			= 3475
Dw_1.Height			= 1415

/*------------------------------------------------------------------*/
/* StaticText indiquant 'En cours..'                                */
/*------------------------------------------------------------------*/
st_EnCours.x		= 350
st_EnCours.y		= 1400
st_EnCours.width	= 2894
st_EnCours.height = 389

end subroutine

on ue_initialiser;call w_8_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part1
//* Evenement 		: Initiliaser
//* Auteur			: Fabry JF
//* Date				: 07/05/1999 15:14:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tres
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

itrTrans	  = SQLCA


This.Title = "Traitement PARTICULIER : Nombre de motifs de refus coch$$HEX1$$e900$$ENDHEX$$s sur les garanties et d$$HEX1$$e900$$ENDHEX$$tails de garantie"

This.Wf_PositionnerObjets()

uo_TraitPart1 = CREATE U_Sp_Gs_Trait_Part1

uo_TraitPart1.Uf_Initialiser ( Dw_Saisie, Dw_1, st_EnCours, iTrTrans )







end on

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part1
//* Evenement 		: ue_Creer
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 19:28:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion du bouton "Lancer"
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_TraitPart1.Uf_Lancer ( pb_Imprimer, pb_Excel ) 


end on

on ue_item6;call w_8_accueil::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part1
//* Evenement 		: ue_item6
//* Auteur			: Fabry JF
//* Date				: 20/05/1999 10:57:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Sauve en fichier Excel les donn$$HEX1$$e900$$ENDHEX$$es qui ont servies
//*					  $$HEX2$$e0002000$$ENDHEX$$ConsTruire l'$$HEX1$$e900$$ENDHEX$$tat.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_TraitPart1.uf_Excel ()
end on

on ue_imprimer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part1 (OVERRIDE)
//* Evenement 		: ue_imprimer
//* Auteur			: Fabry JF
//* Date				: 19/05/1999 12:07:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Impression de l'$$HEX1$$e900$$ENDHEX$$tat (via l'objet)
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_TraitPart1.uf_Imprimer ()
end on

on w_a_sp_trt_part1.create
int iCurrent
call w_8_accueil::create
this.dw_saisie=create dw_saisie
this.st_encours=create st_encours
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_saisie
this.Control[iCurrent+2]=st_encours
this.Control[iCurrent+3]=pb_excel
end on

on w_a_sp_trt_part1.destroy
call w_8_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_saisie)
destroy(this.st_encours)
destroy(this.pb_excel)
end on

on close;call w_8_accueil::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part1
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 07/05/1999 17:20:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DESTROY uo_TraitPart1
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_trt_part1
int X=23
int Width=247
int Height=145
int TabOrder=40
boolean OriginalSize=false
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_trt_part1
int X=4211
int Y=89
int TabOrder=60
boolean Visible=false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_trt_part1
int X=284
int Width=247
int Height=145
int TabOrder=50
string Text="&Lancer"
string PictureName="k:\pb4obj\bmp\8_valid.bmp"
boolean OriginalSize=false
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_trt_part1
int X=83
int Y=405
int Width=517
int Height=389
int TabOrder=30
boolean Visible=true
end type

on dw_1::rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::dw_1
//* Evenement 		: RButtonDown (OVERRIDE)		
//* Auteur			: Fabry JF
//* Date				: 19/05/1999 16:09:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne g$$HEX1$$e800$$ENDHEX$$re pas le click droit de la souris.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


end on

on dw_1::ue_trier;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_saisie
//* Evenement 		: ue_Trier (OverRide)
//* Auteur			: Fabry JF
//* Date				: 11/05/1999 15:56:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ev$$HEX1$$e900$$ENDHEX$$nement en OVERRIDE
//* Commentaires	: Aucun script sur cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement. Juste pass$$HEX2$$e9002000$$ENDHEX$$en 
//*					  OVERRIDE afin de ne pas lancer le tri sur la DW.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


end on

type pb_tri from w_8_accueil`pb_tri within w_a_sp_trt_part1
int X=4453
int Y=89
int TabOrder=80
boolean Visible=false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_trt_part1
int X=545
int Width=247
int Height=145
int TabOrder=20
boolean Visible=true
end type

type dw_saisie from u_datawindow within w_a_sp_trt_part1
int X=641
int Y=405
int Width=517
int Height=389
int TabOrder=10
string DataObject="d_traitement_part1"
boolean Border=false
end type

type st_encours from statictext within w_a_sp_trt_part1
int X=1194
int Y=405
int Width=517
int Height=389
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-22
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_excel from picturebutton within w_a_sp_trt_part1
int X=805
int Y=17
int Width=247
int Height=145
int TabOrder=70
boolean Enabled=false
boolean BringToTop=true
string Text="&Excel"
string PictureName="k:\pb4obj\bmp\8_savfil.bmp"
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_excel
//* Evenement 		: ue_item6
//* Auteur			: Fabry JF
//* Date				: 20/05/1999 10:39:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Sauve en fichier Excel les donn$$HEX1$$e900$$ENDHEX$$es qui ont servies
//*					  $$HEX2$$e0002000$$ENDHEX$$ConsTruire l'$$HEX1$$e900$$ENDHEX$$tat.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ("ue_item6")
end on

