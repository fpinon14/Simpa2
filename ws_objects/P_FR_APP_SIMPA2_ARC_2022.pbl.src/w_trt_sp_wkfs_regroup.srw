HA$PBExportHeader$w_trt_sp_wkfs_regroup.srw
forward
global type w_trt_sp_wkfs_regroup from w_8_traitement_master
end type
type dw_stk_regroup from u_datawindow within w_trt_sp_wkfs_regroup
end type
type st_1 from statictext within w_trt_sp_wkfs_regroup
end type
type st_message from statictext within w_trt_sp_wkfs_regroup
end type
end forward

global type w_trt_sp_wkfs_regroup from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3616
integer height = 2056
dw_stk_regroup dw_stk_regroup
st_1 st_1
st_message st_message
end type
global w_trt_sp_wkfs_regroup w_trt_sp_wkfs_regroup

type variables
Private:

n_cst_sp_regroup	invRegroup
end variables

forward prototypes
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
end prototypes

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_Regroup::wf_PreparerInserer
//* Auteur			:	PLJ
//* Date				:	21/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant Insertion
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


Return invRegroup.uf_preparer ( 'C', istPass )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_Regroup::wf_PreparerModifier
//* Auteur			:	PLJ
//* Date				:	21/08/2003
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


Return invRegroup.uf_preparer ( 'M', istPass )


end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_regroup::wf_ControlerSaisie
//* Auteur			:	PLJ
//* Date				:	25/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle des zones obligatoires
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	La colonne en d$$HEX1$$e900$$ENDHEX$$faut
//*
//*-----------------------------------------------------------------

String sPos

sPos = invRegroup.Uf_ControlerSaisie()

Return sPos
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_Regroup::wf_controlergestion
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


Return  invRegroup.Uf_ControlerGestion()
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Wkfs_Regroup::Wf_PreparerValider
//* Auteur			: PLJ
//* Date				: 26/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------



Return invRegroup.Uf_PreparerValider ()
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_Tm_Sp_Wkfs_Profil::wf_PreparerSupprimer
//* Auteur			:	PLJ
//* Date				:	26/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Return invRegroup.uf_PreparerSupprimer ()

end function

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_Regroup
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

Long              lIdCie, lIdProfil, lLigne, lTot
String				sLibCie, sLibProfil

DatawindowChild 	dwChild

sTab		= "~t"

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie                          */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "ID_CIE", dwChild )

lIdCie 	= dw_1.GetItemNumber ( 1, "ID_CIE" )  
lTot 		= dwChild.RowCount ()
lLigne   = dwChild.find ( "ID_CIE = " + String (lIdCie), 1, lTot )
sLibCie  = dwChild.GetItemString ( lLigne, "LIB_CIE" )

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$du profil                                */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "ID_PROFIL", dwChild )

lIdProfil	= dw_1.GetItemNumber ( 1, "ID_PROFIL"   ) 
lTot 			= dwChild.RowCount ()
lLigne   	= dwChild.find ( "ID_PROFILE = " + String (lIdProfil), 1, lTot )
sLibProfil	= dwChild.GetItemString ( lLigne, "LIB_PROFILE" )


/*------------------------------------------------------------------*/
/* Constitution de la cha$$HEX1$$ee00$$ENDHEX$$ne de retour                              */
/*------------------------------------------------------------------*/
isMajAccueil 	=	String ( dw_1.GetItemNumber ( 1, "ID_PROD"       ) )						+ sTab + &
 						String ( dw_1.GetItemNumber ( 1, "ID_ETS"        ) )						+ sTab + &
						String ( lIdCie )																		+ sTab + &
						         slibCie																		+ sTab + &
						String ( lIdProfil )																	+ sTab + &
									sLibProfil																	+ sTab + &
						String ( dw_1.GetItemDateTime ( 1, "CREE_LE"     ) )						+ sTab + &
						String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"      ) )						+ sTab + &
						         dw_1.GetItemString   ( 1, "MAJ_PAR"     ) 						+ sTab + &
						String ( dw_1.GetItemDatetime     ( 1, "DTE_VAL_DEB" ),"DD/MM/YYYY"  )	+ sTab + &
						String ( dw_1.GetItemDatetime     ( 1, "DTE_VAL_FIN" ),"DD/MM/YYYY"  )	+ sTab 






end event

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_regroup
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 21/08/2003
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


//This.Wf_PositionnerObjets ()


invRegroup = create n_cst_sp_Regroup


invRegroup.Uf_Initialiser ( dw_1, dw_Stk_Regroup, pb_controler, pb_supprimer, st_message )
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_Regroup
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 21/08/2003
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
Destroy	invRegroup
end on

on w_trt_sp_wkfs_regroup.create
int iCurrent
call super::create
this.dw_stk_regroup=create dw_stk_regroup
this.st_1=create st_1
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_stk_regroup
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_message
end on

on w_trt_sp_wkfs_regroup.destroy
call super::destroy
destroy(this.dw_stk_regroup)
destroy(this.st_1)
destroy(this.st_message)
end on

type cb_debug from w_8_traitement_master`cb_debug within w_trt_sp_wkfs_regroup
end type

type dw_1 from w_8_traitement_master`dw_1 within w_trt_sp_wkfs_regroup
integer x = 9
integer y = 240
integer width = 3579
integer height = 428
integer taborder = 20
string dataobject = "dw_trt_sp_wkfs_regroup"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_Regroup::dw_1
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

//[MIGPB8COR] PHG
////invRegroup.uf_GererMessage ( "DW_TRT_REGROUP", isErrCol, {GetText()} )
////Migration PB8-WYNIWYG-03/2006 FM
////le message d'erreur doit avoir $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par la fonction au-dessus
////on n'affiche donc pas le message PB (Item xxxx does not pass validation test)
//return 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
// remplace par 
return invRegroup.uf_GererMessage ( "DW_TRT_REGROUP", isErrCol, {GetText()} )
// afin d'uniformiser les methode de gestion des ItemError

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_Regroup::dw_1
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

iActionCode = invRegroup.uf_ControlerZone ( isNomCol, GetText() )
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( iActionCode )
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement_master`st_titre within w_trt_sp_wkfs_regroup
boolean visible = false
integer x = 1819
integer y = 28
integer width = 576
end type

type pb_retour from w_8_traitement_master`pb_retour within w_trt_sp_wkfs_regroup
integer y = 24
integer width = 242
integer height = 144
integer taborder = 30
end type

type pb_valider from w_8_traitement_master`pb_valider within w_trt_sp_wkfs_regroup
integer y = 24
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_trt_sp_wkfs_regroup
integer y = 24
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_controler from w_8_traitement_master`pb_controler within w_trt_sp_wkfs_regroup
integer y = 24
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_trt_sp_wkfs_regroup
integer y = 24
integer width = 242
integer height = 144
integer taborder = 60
end type

type dw_stk_regroup from u_datawindow within w_trt_sp_wkfs_regroup
integer x = 41
integer y = 864
integer width = 3538
integer height = 888
integer taborder = 10
string dataobject = "dw_stk_sp_wkfs_regroup"
end type

type st_1 from statictext within w_trt_sp_wkfs_regroup
integer x = 50
integer y = 788
integer width = 1079
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Liste des regroupements affect$$HEX1$$e900$$ENDHEX$$s au produit"
boolean focusrectangle = false
end type

type st_message from statictext within w_trt_sp_wkfs_regroup
integer x = 50
integer y = 684
integer width = 1943
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 14267805
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

