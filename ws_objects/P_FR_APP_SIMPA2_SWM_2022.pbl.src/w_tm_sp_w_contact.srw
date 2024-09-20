$PBExportHeader$w_tm_sp_w_contact.srw
$PBExportComments$Fenêtres de saisie d'un contact
forward
global type w_tm_sp_w_contact from w_8_traitement_master
end type
type dw_a_traiter_par from u_datawindow within w_tm_sp_w_contact
end type
end forward

global type w_tm_sp_w_contact from w_8_traitement_master
integer width = 2304
integer height = 1276
dw_a_traiter_par dw_a_traiter_par
end type
global w_tm_sp_w_contact w_tm_sp_w_contact

type variables
Private :

u_gs_sp_sinistre_Contact	iuoGsSpContact
String			isTypeTrt

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Contact::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 24/04/2001 
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Dw_1																				  */
/*------------------------------------------------------------------*/
Dw_1.X			=  691
Dw_1.Y			=  397
Dw_1.Width		= 2959
Dw_1.Height		=  945


dw_a_traiter_par.X			=  2369
dw_a_traiter_par.Y			=  41
dw_a_traiter_par.Width		= 1203
dw_a_traiter_par.Height		=  113


end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PreparerModifier
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Opération avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoGsSpContact.Uf_PreparerModifier ( istPass )

Return True
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PreparerInserer
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Opération avant insertion
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoGsSpContact.Uf_PreparerInserer ( istPass )

Return True
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie
//* Auteur			: Fabry JF
//* Date				: 26/04/2001 13:59:07
//* Libellé			: Contrôle de saisie des zones
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

dw_A_Traiter_Par.AcceptText()

Return ( iuoGsSpContact.uf_ControlerSaisie () )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerGestion
//* Auteur			: Fabry JF
//* Date				: 26/04/2001 13:59:07
//* Libellé			: Contrôle de gestion
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

Return ( iuoGsSpContact.uf_ControlerGestion () )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_PreparerSupprimer
//* Auteur			: Fabry JF
//* Date				: 27/04/01
//* Libellé			: Demande de confirmation avant suppression
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Return ( iuoGsSpContact.uf_PreparerSupprimer () )
end function

on ue_valider;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::ue_Valider (OVERRIDE !!)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Validation
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

// Récupération des Initiales de la personne qui va traiter le dossier
// à partir de la fenêtre de sinistre.
If iuoGsSpContact.uf_Valider () Then iwParent.TriggerEvent ("ue_Item5")

Call super::ue_valider
end on

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Contact::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

Wf_PositionnerObjets ()

Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]


/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpContact = Create U_Gs_Sp_Sinistre_Contact

stPass.dwMaster  = Dw_1  // Trt Contact
stPass.dwTab [1] = istPass.dwTab [ 1 ]
stPass.dwTab [2] = istPass.dwTab [ 2 ]

stPass.udwTab [1] = istPass.udwTab [ 1 ]
stPass.udwTab [2] = dw_a_traiter_par

stPass.dwNorm [ 1 ]	= istPass.dwNorm [ 1 ]	
stPass.dwNorm [ 2 ]	= istPass.dwNorm [ 2 ]	

stPass.sTab [2]  = istPass.sTab [ 2 ]

iuoGsSpContact.uf_Initialiser ( 	stPass 			,&
										  	pb_Controler	,&
										  	pb_Supprimer	,&
										  	pb_Valider		,&
											iTrTrans			,&
											istPass.dwMaster &
									   )


end on

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;istPass.dwTab [ 1 ].SelectRow ( 0, False )
istPass.dwTab [ 1 ].Sort ()
end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::We_ChildActivate
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

on w_tm_sp_w_contact.create
int iCurrent
call super::create
this.dw_a_traiter_par=create dw_a_traiter_par
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_a_traiter_par
end on

on w_tm_sp_w_contact.destroy
call super::destroy
destroy(this.dw_a_traiter_par)
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Close
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 18:46:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iUoGsSpContact
end on

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_w_contact
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_w_contact
integer x = 64
integer y = 220
integer width = 494
integer height = 428
integer taborder = 20
string dataobject = "d_sp_sin_w_contact"
boolean border = false
end type

on dw_1::itemerror;call w_8_traitement_master`dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Contact::itemError
//* Evenement 		: itemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsSpContact.uf_GererMessage ( Upper ( This.isErrCol ) )
end on

on dw_1::itemchanged;call w_8_traitement_master`dw_1::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Contact::itemChanged
//* Evenement 		: itemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsSpContact.uf_ControlerZone ( Upper ( This.isNomCol ) ) 


end on

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_w_contact
boolean visible = false
integer x = 2999
integer y = 44
integer width = 137
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_w_contact
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 30
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_w_contact
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_w_contact
boolean visible = false
integer x = 3008
integer y = 140
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_w_contact
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_w_contact
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 60
end type

type dw_a_traiter_par from u_datawindow within w_tm_sp_w_contact
integer x = 617
integer y = 228
integer width = 471
integer height = 420
integer taborder = 10
string dataobject = "dddw_sp_wkf_dosuivipar"
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild
String	sData

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

sData = Upper ( This.GetText () )
This.GetChild ( "DOS_SUIVI_PAR", dwChild ) 

If dwChild.Find ( "COD_OPER = '" + sData + "'", 1, dwChild.Rowcount () ) <= 0 And Not IsNull ( sData ) Then

//Migration PB8-WYNIWYG-03/2006 CP
//	SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
	
End If

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


stMessage.sTitre		= "Dossier à traiter par"
stMessage.Icon			= Information!
stMessage.sCode		= "CONT019"
stMessage.bErreurG	= False

f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 CP
//SetActionCode ( 1 )
		Return 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

on constructor;call u_datawindow::constructor;ilPremCol = 0
ilDernCol = 0
end on

