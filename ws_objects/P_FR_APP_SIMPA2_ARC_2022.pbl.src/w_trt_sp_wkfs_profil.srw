HA$PBExportHeader$w_trt_sp_wkfs_profil.srw
forward
global type w_trt_sp_wkfs_profil from w_8_traitement_master
end type
type st_message from statictext within w_trt_sp_wkfs_profil
end type
type dw_stk_profil from u_datawindow within w_trt_sp_wkfs_profil
end type
end forward

global type w_trt_sp_wkfs_profil from w_8_traitement_master
int Width=3612
int Height=1821
st_message st_message
dw_stk_profil dw_stk_profil
end type
global w_trt_sp_wkfs_profil w_trt_sp_wkfs_profil

type variables
Private:

n_cst_sp_profil	invProfil
end variables

forward prototypes
public subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparervalider ()
end prototypes

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_wkfs_profil::wf_PositionnerObjets
//* Auteur			: PLJ
//* Date				: 14/08/20003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positonne et taille les objets
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre.                                                         */
/*------------------------------------------------------------------*/
This.X					=    1
This.Y					=    1
This.Width				= 3617
This.Height				= 2057


/*------------------------------------------------------------------*/
/* Objets contenus dans l'onglet 01                                 */
/*------------------------------------------------------------------*/
/* Profil                                                           */
/*------------------------------------------------------------------*/
Dw_1.X					=   42
Dw_1.Y					=  221
Dw_1.Width				= 2094
Dw_1.Height				=  497

end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_profil::wf_PreparerModifier
//* Auteur			:	PLJ
//* Date				:	14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


Return invProfil.uf_preparer ( 'M', istPass )


end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_profil::wf_PreparerInserer
//* Auteur			:	PLJ
//* Date				:	18/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : L'insertion peut continuer
//*									
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


Return invProfil.uf_preparer ( 'C', istPass )


end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_profil::wf_ControlerSaisie
//* Auteur			:	PLJ
//* Date				:	18/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle des zones obligatoires
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	La colonne en d$$HEX1$$e900$$ENDHEX$$faut
//*
//*-----------------------------------------------------------------

String sPos

sPos = invProfil.Uf_ControlerSaisie()

Return sPos
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_profil::wf_controlergestion
//* Auteur			:	PLJ
//* Date				:	19/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Colonne en erreur
//*
//*-----------------------------------------------------------------


Return  invProfil.Uf_ControlerGestion()


end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_Tm_Sp_Wkfs_Profil::wf_PreparerSupprimer
//* Auteur			:	PLJ
//* Date				:	19/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Return invProfil.uf_PreparerSupprimer ()


end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Wkfs_Profil::Wf_PreparerValider
//* Auteur			: PLJ
//* Date				: 18/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------



Return invProfil.Uf_PreparerValider ()
end function

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_Profil
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	PLJ
//* Date				:	28/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 				sTab			  // Code tabulation

String 				sLibProfil


//Long              lIdCie, lIdTypArch, lLigne, lTot
//String				sLibCie, sLibTypArch
//DatawindowChild 	dwChild

sTab		= "~t"

///*------------------------------------------------------------------*/
///* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie                          */
///*------------------------------------------------------------------*/
//dw_1.GetChild ( "ID_CIE", dwChild )
//
//lIdCie 	= dw_1.GetItemNumber ( 1, "ID_CIE" )  
//lTot 		= dwChild.RowCount ()
//lLigne   = dwChild.find ( "ID_CIE = " + String (lIdCie), 1, lTot )
//sLibCie  = dwChild.GetItemString ( lLigne, "LIB_CIE" )
//
///*------------------------------------------------------------------*/
///* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$de la m$$HEX1$$e900$$ENDHEX$$thode                            */
///*------------------------------------------------------------------*/
//dw_1.GetChild ( "ID_TYP_ARCH", dwChild )
//
//lIdTypArch 	= dw_1.GetItemNumber ( 1, "ID_TYP_ARCH" )  
//lTot 		   = dwChild.RowCount ()
//lLigne      = dwChild.find ( "ID_CODE = " + String (lIdTypArch), 1, lTot )
//sLibTypArch = dwChild.GetItemString ( lLigne, "LIB_CODE" )

sLibProfil = dw_1.GetItemString ( 1, "LIB_PROFIL" )

/*------------------------------------------------------------------*/
/* Constitution de la cha$$HEX1$$ee00$$ENDHEX$$ne de retour                              */
/*------------------------------------------------------------------*/
isMajAccueil 	=	String ( dw_1.GetItemNumber ( 1, "ID_PROFIL"     ) )						+ sTab + &
 						         slibProfil																	+ sTab + &
						String ( dw_1.GetItemDateTime ( 1, "CREE_LE"     ) )						+ sTab + &
						String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"      ) )						+ sTab + &
						         dw_1.GetItemString   ( 1, "MAJ_PAR"     ) 
						




end on

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_profil
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


This.Wf_PositionnerObjets ()


invProfil = create n_cst_sp_Profil


invProfil.Uf_Initialiser ( dw_1, dw_stk_profil, pb_supprimer, st_message )
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_profil
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*--------------------------------------------*/
/* Destruction du NVUO de Gestion             */
/*--------------------------------------------*/
Destroy	invProfil 
end on

on w_trt_sp_wkfs_profil.create
int iCurrent
call w_8_traitement_master::create
this.st_message=create st_message
this.dw_stk_profil=create dw_stk_profil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_message
this.Control[iCurrent+2]=dw_stk_profil
end on

on w_trt_sp_wkfs_profil.destroy
call w_8_traitement_master::destroy
destroy(this.st_message)
destroy(this.dw_stk_profil)
end on

type dw_1 from w_8_traitement_master`dw_1 within w_trt_sp_wkfs_profil
int X=51
int Y=213
int Width=2094
int Height=497
int TabOrder=20
string DataObject="dw_trt_sp_wkfs_profil"
boolean Border=false
end type

on dw_1::itemchanged;call w_8_traitement_master`dw_1::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_Profil::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 23/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contrle des zones
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iActionCode

iActionCode = invProfil.uf_ControlerZone ( isNomCol, GetText() )
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( iActionCode )
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM
end on

type st_titre from w_8_traitement_master`st_titre within w_trt_sp_wkfs_profil
int X=3530
int Y=69
int Width=371
boolean Visible=false
end type

type pb_retour from w_8_traitement_master`pb_retour within w_trt_sp_wkfs_profil
int Y=25
int TabOrder=30
end type

type pb_valider from w_8_traitement_master`pb_valider within w_trt_sp_wkfs_profil
int Y=25
int TabOrder=50
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_trt_sp_wkfs_profil
int Y=25
int TabOrder=70
end type

type pb_controler from w_8_traitement_master`pb_controler within w_trt_sp_wkfs_profil
int Y=25
int TabOrder=40
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_trt_sp_wkfs_profil
int Y=25
int TabOrder=60
end type

type st_message from statictext within w_trt_sp_wkfs_profil
int X=2204
int Y=253
int Width=1345
int Height=81
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Un regroupement poss$$HEX1$$e800$$ENDHEX$$de ce profil"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=14267805
long BorderColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_stk_profil from u_datawindow within w_trt_sp_wkfs_profil
int X=65
int Y=825
int Width=3484
int Height=733
int TabOrder=10
string DataObject="dw_stk_sp_wkfs_profil"
end type

