$PBExportHeader$w_cm_sp_sinistre.srw
forward
global type w_cm_sp_sinistre from w_8_ancetre_consultation
end type
type uo_onglet from u_onglets within w_cm_sp_sinistre
end type
type uo_bord3d from u_bord3d within w_cm_sp_sinistre
end type
type dw_1 from u_datawindow within w_cm_sp_sinistre
end type
type dw_gti from u_datawindow_detail within w_cm_sp_sinistre
end type
type dw_inter from u_datawindow_detail within w_cm_sp_sinistre
end type
type dw_produit from datawindow within w_cm_sp_sinistre
end type
type p_focus from picture within w_cm_sp_sinistre
end type
type dw_frais from datawindow within w_cm_sp_sinistre
end type
type dw_codegarantie from datawindow within w_cm_sp_sinistre
end type
type dw_detail from datawindow within w_cm_sp_sinistre
end type
type dw_refus from datawindow within w_cm_sp_sinistre
end type
type dw_codecondition from datawindow within w_cm_sp_sinistre
end type
type dw_motif from datawindow within w_cm_sp_sinistre
end type
type dw_reglement from u_datawindow_detail within w_cm_sp_sinistre
end type
type dw_codecartc from datawindow within w_cm_sp_sinistre
end type
type dw_reg_gti from datawindow within w_cm_sp_sinistre
end type
type uo_consult_euro from u_consultation_euro within w_cm_sp_sinistre
end type
type st_pochette from statictext within w_cm_sp_sinistre
end type
type dw_corb from datawindow within w_cm_sp_sinistre
end type
type dw_dossuivipar from u_datawindow within w_cm_sp_sinistre
end type
type dw_lst_contact from u_datawindow_detail within w_cm_sp_sinistre
end type
type dw_lst_cmde from u_datawindow_detail within w_cm_sp_sinistre
end type
type cb_aide from u_aidecontrat within w_cm_sp_sinistre
end type
type cb_notice from u_aidecontrat within w_cm_sp_sinistre
end type
type dw_boitearchive from u_datawindow within w_cm_sp_sinistre
end type
type dw_det_pro from u_datawindow within w_cm_sp_sinistre
end type
type cb_noboite from commandbutton within w_cm_sp_sinistre
end type
type dw_div_sin from u_datawindow within w_cm_sp_sinistre
end type
type cb_polass from commandbutton within w_cm_sp_sinistre
end type
type dw_div_det from u_datawindow within w_cm_sp_sinistre
end type
type dddw_code_divsin_charg_tempo from datawindow within w_cm_sp_sinistre
end type
type dddw_codecar_divsin_charg_tempo from datawindow within w_cm_sp_sinistre
end type
type cb_url_extranet from commandbutton within w_cm_sp_sinistre
end type
type cb_journal from commandbutton within w_cm_sp_sinistre
end type
end forward

global type w_cm_sp_sinistre from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3662
integer height = 1740
boolean controlmenu = false
boolean minbox = false
event ue_taillefenetre ( )
uo_onglet uo_onglet
uo_bord3d uo_bord3d
dw_1 dw_1
dw_gti dw_gti
dw_inter dw_inter
dw_produit dw_produit
p_focus p_focus
dw_frais dw_frais
dw_codegarantie dw_codegarantie
dw_detail dw_detail
dw_refus dw_refus
dw_codecondition dw_codecondition
dw_motif dw_motif
dw_reglement dw_reglement
dw_codecartc dw_codecartc
dw_reg_gti dw_reg_gti
uo_consult_euro uo_consult_euro
st_pochette st_pochette
dw_corb dw_corb
dw_dossuivipar dw_dossuivipar
dw_lst_contact dw_lst_contact
dw_lst_cmde dw_lst_cmde
cb_aide cb_aide
cb_notice cb_notice
dw_boitearchive dw_boitearchive
dw_det_pro dw_det_pro
cb_noboite cb_noboite
dw_div_sin dw_div_sin
cb_polass cb_polass
dw_div_det dw_div_det
dddw_code_divsin_charg_tempo dddw_code_divsin_charg_tempo
dddw_codecar_divsin_charg_tempo dddw_codecar_divsin_charg_tempo
cb_url_extranet cb_url_extranet
cb_journal cb_journal
end type
global w_cm_sp_sinistre w_cm_sp_sinistre

type variables
Private:
u_Cs_Sp_sinistre		iuoConsultation

String			isDetailConsult
String			isATraiterPar

Boolean			ibAltContact
Boolean			ibAltContactSherpa
Boolean			ibAltCmdMobile 

W_Cm_Sp_Contact		iW_Cm_Sp_Contact
W_Sp_C_Commande2	iW_Sp_C_Commande2

u_gs_sp_sinistre_contact_trace iuoCpSpContTrace

W_T_Sp_Cree_Travail 	iW_T_Sp_Cree_Travail

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
//* Fonction		: W_cm_sp_sinistre::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 16/07/1998
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord3d qui est positionné et taillé
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* DCMP990451 JFF		29/09/99 On positionne le static text informant 
//*										de l'ouverture d'une pochette ou pas.
//* #1  CAG		15/07/04 DCMP 030381 : Ajout d'un btn pour aff des
//*								polices-assurances des gti du produit du dr
//       JFF   29/08/2023 [RS5666_DOS_SUIVI_PAR]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   10
Uo_Onglet.Y			=  157 + 1  // [PB2022_TAILLE_FEN] + 1
Uo_Onglet.Height	=  109

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : En-tête sinistre                              */
/*------------------------------------------------------------------*/
Dw_1.X				=   60
Dw_1.Y				=  280
Dw_1.Width			= 3480 - 10
Dw_1.Height			= 1390 - 10

/*------------------------------------------------------------------*/
/* Dw_Inter DataWindow : Liste des Interlocuteurs                   */
/*------------------------------------------------------------------*/
Dw_Inter.X    		= Dw_1.X	+ 350
Dw_Inter.Y		   = Dw_1.Y
Dw_Inter.Width		= Dw_1.Width - 350
Dw_Inter.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Dw_Gti DataWindow : liste des garanties                          */
/*------------------------------------------------------------------*/
Dw_Gti.X    		= Dw_1.X	
Dw_Gti.Y				= Dw_1.Y
Dw_Gti.Width		= Dw_1.Width  
Dw_Gti.Height		= Dw_1.Height 

/*------------------------------------------------------------------*/
/* Dw_Reglement DataWindow : liste des règlements                   */
/*------------------------------------------------------------------*/
Dw_Reglement.X    	= Dw_1.X	
Dw_Reglement.Y			= Dw_1.Y
Dw_Reglement.Width	= Dw_1.Width  
Dw_Reglement.Height	= Dw_1.Height 

/*------------------------------------------------------------------*/
/* Liste des Contacts                                               */
/*------------------------------------------------------------------*/
dw_lst_contact.X			= Dw_1.X
dw_lst_contact.Y			= Dw_1.Y
dw_lst_contact.Width		= Dw_1.Width
dw_lst_contact.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Liste des Commandes                                              */
/*------------------------------------------------------------------*/
dw_lst_cmde.X			= Dw_1.X + 350
dw_lst_cmde.Y			= Dw_1.Y
dw_lst_cmde.Width		= Dw_1.Width - 350
dw_lst_cmde.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Dossier suivi par                                                */
/*------------------------------------------------------------------*/
dw_DosSuiviPar.X 		 = 2414
dw_DosSuiviPar.Y 		 =    9
dw_DosSuiviPar.width  = 1198
dw_DosSuiviPar.Height =   89


// [RS5666_DOS_SUIVI_PAR]
If F_CLE_A_TRUE ( "RS5666_DOS_SUIVI_PAR" ) Then
	dw_DosSuiviPar.Hide()
End If


/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* N° boîte archive                                                 */
/*------------------------------------------------------------------*/
dw_BoiteArchive.X			= 1235
dw_BoiteArchive.Y			=   21
dw_BoiteArchive.Width	= 1020
dw_BoiteArchive.Height	=   89

Cb_NoBoite.X				= 2263
Cb_NoBoite.Y				=   24
Cb_NoBoite.Width			=  110
Cb_NoBoite.Height			=   69

/*------------------------------------------------------------------*/
/* Pochette																			  */
/*------------------------------------------------------------------*/
//st_Pochette.X			=  732
st_Pochette.X			=  2181
st_Pochette.Y			=    20
st_Pochette.Width		=  202
st_Pochette.Height	=   61

/*------------------------------------------------------------------*/
/* Dw_Div_Sin  																	  */
/*------------------------------------------------------------------*/
Dw_Div_Sin.X				=   60
Dw_Div_Sin.Y				=  280
Dw_Div_Sin.Width			= 3480
Dw_Div_Sin.Height			= 1390

/*------------------------------------------------------------------*/
/* #1 CAG : 15/07/2004                                              */
/*------------------------------------------------------------------*/
Cb_PolAss.X					= 686
Cb_PolAss.Y					= 9
Cb_PolAss.Width			= 434
Cb_PolAss.Height			= 69

cb_url_extranet.X			= 686
cb_url_extranet.Y			= 80
cb_url_extranet.Width	= 434
cb_url_extranet.Height	= 64

cb_Journal.X = 1125
cb_Journal.Y = 8
cb_Journal.Width = 210
cb_Journal.Height= 68

end subroutine

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_cm_sp_sisinistre
//* Fonction		: wf_PreparerConsulter
//* Auteur			: PLJ
//* Date				: 17/07/1998 
//* Libellé			: Appel de uf_preparer_consulter
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette			
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//* #3			PLJ		12/09/2003 Gestion du text de st_pochette à l'identique de la fenêtre d'insruction
//*            JFF      11/01/2010 [DECIMAL_PAPILLON]
//             JFF      22/10/2019 [PI087_PM473_2]
//*-----------------------------------------------------------------

Boolean 	bOk, bRet2
String   sMonnaie, sNoBoite
Long     lPochette, lNbligne, lIdSin, lDeb, lFin, lRet, dcIdInter, dcIdDoc
Decimal {2} dcIdSin

// DCMP990451
st_Pochette.Hide()
SetNull ( dcIdInter )
SetNull ( dcIdDoc )


sMonnaie = Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
istPass.sTab [ 1 ] = sMonnaie

bOk = iuoConsultation.Uf_Preparer_Consulter( istPass )	

If bOk Then 

	This.Title = 	iuoConsultation.Uf_titre()				// Constitution du titre de la fenêtre

	/*------------------------------------------------------------------*/
	/* On mémorise la Gestion Contact.									  		  */
	/*------------------------------------------------------------------*/
	ibAltContact = dw_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "O"
	ibAltContactSherpa = False

	/*------------------------------------------------------------------*/
	/* #2 : JFF le 04/09/2002														  */
	/*------------------------------------------------------------------*/
	If Not ibAltContact Then
		ibAltContactSherpa = dw_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "S"
	End If
	ibAltCmdMobile = dw_Produit.GetItemString ( 1, "ALT_CMD_MOBILE" ) = "O"

	/*------------------------------------------------------------------*/
	/* Alternativement on fait apparaître l'onglet contact.		  		  */
	/*------------------------------------------------------------------*/
	Uo_Onglet.Uf_ActiverOnglet ( "05", dw_Div_Sin.Rowcount () > 0 )
	Uo_Onglet.Uf_ActiverOnglet ( "06", ibAltCmdMobile )

	/*------------------------------------------------------------------*/
	/* Modif suite DCMP990451                                           */
	/*------------------------------------------------------------------*/
	lPochette = -1

	iTrTrans.PS_S02_W_QUEUE_POCHETTE	( Dw_1.GetItemNumber ( 1, "ID_SIN"), "CONSULT" , lPochette )

	// << Veuillez ouvrir une pochette pour ce complément >>
	If lPochette = 1 Then

//		st_Pochette.X			= 1542
//		st_Pochette.Y			=   13
//		st_Pochette.Width		= 2499
//		st_Pochette.Height	=   85

		//st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK360", "Message Pochette Introuvable" )
		st_Pochette.Text =  "Poch 1"		// #3
		st_Pochette.Show()
	

	// << Pochette à Ouvrir lors de la réception du prochain complément >>
	ElseIf lPochette = 2 Then

//		st_Pochette.X			= 1542
//		st_Pochette.Y			=   57
//		st_Pochette.Width		=  180
//		st_Pochette.Height	=   85

      //st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK370", "Message Pochette Introuvable" )
		st_Pochette.Text =  "Poch 2"		// #3
		st_Pochette.Show()

	End If

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
	Cb_NoBoite.Visible = FALSE

/*
		Cb_NoBoite.Visible = dw_BoiteArchive.Visible
	
		lIdSin = istPass.lTab [1]
		dcIdSin = Dec ( lIdSin ) // [DECIMAL_PAPILLON]
	
		// [DECIMAL_PAPILLON]
		SELECT	count(*) INTO :lNbligne
		  FROM   sysadm.wkfs_w_queue where id_sin = :dcIdSin
		 USING	SqlCa;
	
		If lNbLigne > 0 Then
			dw_boitearchive.Modify ( "Text_t.Text = 'En attente d~~~'archivage'" )
		Else
				// [DECIMAL_PAPILLON]
				SELECT no_boite INTO :sNoBoite
				 FROM  sysadm.routage where id_sin = :dcIdSin
				USING	 SqlCa;
	
				If Not IsNull ( sNoboite ) Then 	
					dw_boitearchive.Modify ( "Text_t.Text = 'Présent dans boîte " + sNoBoite + "'" )
				Else
					dw_boitearchive.Modify ( "Text_t.Text = ''" )
				End If
		End If
*/

End If

/*------------------------------------------------------------------*/
/* On affiche le dernier type de monnaie connu.                     */
/*------------------------------------------------------------------*/
Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

cb_Aide.uf_SetIdProd ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )
cb_Notice.uf_SetIdProd ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )

// Couleur Bt journal
If SQLCA.PS_S_TRACE_JOURNAL_DELAI () = 1 Then
	cb_journal.weight = 700
Else 
	cb_journal.weight = 400
End If 

// [JOURNAL]
cb_journal.show ()

// === A LAISSER A LA FIN ===== CODE AU DESSUS =====
// [PI087_PM473_2]
// Gestion de la trace de consultation (d'encours) ici ET je Commit. 
lRet = SQLCA.PS_I_PI087_TRACE_DOSSIER_V01 ( lIdSin, "CONSULTATION", stGLB.sCodOper, dcIdInter, dcIdDoc )

bRet2 = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 And lRet > 0

F_Commit ( SQLCA, bRet2 ) 

If Not bRet2 Then
	stMessage.sTitre		= "Consultation d'un dossier"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= False
	stMessage.sVar[1] 	= "PS_I_PI087_TRACE_DOSSIER"
	stMessage.sVar[2] 	= String ( SQLCA.SqlDbCode )
	stMessage.sVar[3] 	= SQLCA.SqlErrText
	stMessage.sCode		= "WSIN849"
	F_Message ( stMessage )

End If 

Return ( bOk )
end function

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_cm_sp_Sinistre
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	PLJ
//* Date				:	16/07/1998
//* Libellé			:	Initialisation de la fenêtre de consultation de 
//*					 	sinistre
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG  07/02/2003  DCMP 020450 : Ajout des boîtes archives
//* #2  CAG	 20/02/2003 modifs suite Test JFF sur DCMP 020450 : 
//*										en fonction de la présence dans DET_PRO
//*										(gestion des BARC pour certains produits)
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwNorm[5]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM
String		sNoBoite

/*------------------------------------------------------------------*/
/* Positionnement des objets de la fenêtre                          */
/*------------------------------------------------------------------*/
iTrTrans =SQLCA

wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglet.Uf_Initialiser ( 6, 1 )

Uo_Onglet.Uf_EnregistrerOnglet ( "01", "Sinistre"      , "", Dw_1,         True  )
Uo_Onglet.Uf_EnregistrerOnglet ( "02", "Garanties"     , "", Dw_Gti,       False )
Uo_Onglet.Uf_EnregistrerOnglet ( "03", "Interlocuteurs", "", Dw_Inter,     False )
Uo_Onglet.Uf_EnregistrerOnglet ( "04", "Règlements",     "", Dw_Reglement, False )
Uo_Onglet.Uf_EnregistrerOnglet ( "05", "Divers",			"", dw_div_sin,	False )
Uo_Onglet.Uf_EnregistrerOnglet ( "06", "Commandes",		"", dw_Lst_Cmde,	False )
Uo_Onglet.Uf_ActiverOnglet ( "06", False )

/*------------------------------------------------------------------*/
/* Déclaration du nvuo liée à la fenêtre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Sinistre
iuoCpSpContTrace = Create U_Gs_Sp_Sinistre_Contact_Trace

/*------------------------------------------------------------------*/
/* #1 : ajout de boîte archive                                      */
/*------------------------------------------------------------------*/
/* #2 : ajout dw_det_pro                                            */
/*------------------------------------------------------------------*/
iuoConsultation.uf_init_Sinistre (	iTrTrans,			&
											   Dw_1,					&
											   Dw_Gti,				&
											   Dw_Inter,			&
												Dw_Reglement,		&
												Dw_Produit,			&
												Dw_Frais,			&
												Dw_Detail,			&
												Dw_Reg_Gti,			&
												Dw_CodeGarantie,	&
												Dw_CodeCondition, &
												Dw_CodeCarTc, 		&
												Dw_Refus,			&
												Dw_Motif,			&
												Dw_Lst_Contact,	&
												Dw_Corb,				&
											   Uo_Onglet,       	&
												Dw_DosSuiviPar,	&
												Dw_Lst_Cmde,		&
												Dw_BoiteArchive,	&
												Dw_Det_Pro,			&
												Dw_div_sin,			&
												Dw_div_det,			&
												dddw_code_divsin_charg_tempo , &
												dddw_codecar_divsin_charg_tempo &
	  										)

iuoCpSpContTrace.Uf_Initialiser  	 ( dw_1, dw_Lst_Contact, dw_Produit, dw_DosSuiviPar, iTrTrans )

/*------------------------------------------------------------------*/
/* Positionnement des Focus indicators                              */
/*------------------------------------------------------------------*/

dw_Gti.Uf_Activer_Selection ( True )
dw_Reglement.Uf_Activer_Selection ( True )
dw_inter.SetRowFocusIndicator ( p_Focus, 40, 260 )
dw_Lst_Cmde.SetRowFocusIndicator ( p_Focus, 20, 170 )

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Gti
dwNorm [ 3 ] = dw_Inter
dwNorm [ 4 ] = dw_Reglement
dwNorm [ 5 ] = dw_div_sin

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

/*------------------------------------------------------------------*/
/* Initialisation de l'objet u_AideContrat                          */
/*------------------------------------------------------------------*/
cb_Aide.uf_Initialiser ( "AIDE", "Aide" )
cb_Notice.uf_Initialiser ( "NOTICE", "Notice" )




end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cm_Sp_Sinistre
//* Evenement 		:	ue_Modifier
//* Auteur			:	PLJ
//* Date				:	20/07/1998
//* Libellé			:	Gestion de la sélection d'une u_datawindow_detail
//* Commentaires	:	
//*		
//*-----------------------------------------------------------------
//       JFF   05/02/2018 [PM360-2]
//*-----------------------------------------------------------------

String   sOngletCourant
Date		dDteCree, dDteJour
s_Pass	stPass

stPass = istPass

sOngletCourant = uo_onglet.Uf_RecupererOngletCourant()

SetPointer ( HourGlass! )

Choose Case sOngletCourant
Case "02"
	isDetailConsult = "dw_gti"

	If Dw_Gti.ilLigneClick > 0 Then

		stPass.sTab [ 1 ]		= This.Title
		stPass.sTab [ 2 ]		= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

		stPass.dwMaster		= dw_1						// DataWindow Sinistre

		stPass.dwNorm [  1 ]	= dw_Detail					// DataWindow Detail
		stPass.dwNorm [  2 ] = dw_refus					// DataWindow Refus
		stPass.dwNorm [  3 ]	= dw_Produit				// DataWindow Produit
		stPass.dwNorm [  4 ] = dw_CodeCondition		// DataWindow code_Condition
		stPass.dwNorm [  5 ] = dw_CodeGarantie			// DataWindow code_Garantie
		stPass.dwNorm [  6 ] = dw_Motif					// DataWindow Motif
		stPass.dwNorm [  7 ] = dw_CodeCarTc				// DataWindow Code_Car pour type Carte
		stPass.dwNorm [  8 ] = dw_Inter 					// u_DataWindow dw_Inter
		stPass.dwNorm [  9 ] = dddw_code_divsin_charg_tempo 
		stPass.dwNorm [ 10 ] = dddw_codecar_divsin_charg_tempo


		stPass.dwTab [ 1 ] 	= Dw_Gti
		stPass.udwTab [ 1 ] 	= Dw_Div_Det
		stPass.udwTab [ 2 ] 	= Dw_Det_Pro

		If	stPass.sTab [ 2 ]	<> stGLB.sMonnaieFormatDesire		Then	
			Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
		End If
			
		F_OuvreConsultation ( w_Cm_Sp_Garantie, "", stPass )

	End If

Case "03"
	isDetailConsult = "dw_inter"

	If Dw_Inter.ilLigneClick > 0 Then
			
		stPass.sTab [ 1 ]		= This.Title
		stPass.sTab [ 2 ]		= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

		stPass.dwMaster		= dw_1						// DataWindow Sinistre			

		stPass.dwNorm [  1 ]	= dw_Frais					// DataWindow Detail

		stPass.dwTab [ 1 ] 	= Dw_Inter
		
		stPass.uDwTab [ 1 ]  = Dw_Det_Pro	// [PM360-2]

		If	stPass.sTab [ 2 ]	<> stGLB.sMonnaieFormatDesire		Then	
			Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
		End If
		
		F_OuvreConsultation ( w_Cd_Sp_Inter, "", stPass )

	End If

Case "04"
	isDetailConsult = "dw_reglement"

	If Dw_Reglement.ilLigneClick > 0 Then
			
		stPass.sTab [ 1 ]		= This.Title
		stPass.sTab [ 2 ]		= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

		stPass.dwMaster		= dw_1						// DataWindow Sinistre			

		stPass.dwNorm [ 1 ]	= dw_Reglement				// DataWindow Reglement
		stPass.dwNorm [ 2 ]	= dw_Inter					// DataWindow Interlocuteur
		stPass.dwNorm [ 3 ]	= dw_Reg_Gti				// DataWindow Reg_Gti
		stPass.dwNorm [ 4 ]	= dw_Gti						// DataWindow Dw_Gti
		stPass.dwNorm [ 5 ]  = dw_Frais					// DataWindow Dw_Frais

		stPass.uDwTab [ 1 ]  = Dw_Det_Pro	// [PM360-2]

		If	stPass.sTab [ 2 ]	<> stGLB.sMonnaieFormatDesire		Then	
			Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
		End If

		F_OuvreConsultation ( w_Cd_Sp_Reglement, "", stPass )

	End If


Case "05"

	isDetailConsult = "dw_lst_contact"

	SetPointer ( HourGlass! )	

	stPass.bInsert		= False
	stPass.bControl		= True

	stPass.sTab [ 1 ]	= This.Title
	stPass.sTab [ 2 ]	= "C"

	stPass.dwTab [ 1 ]	= Dw_Lst_Contact
	stPass.dwTab [ 2 ]	= Dw_Inter

	stPass.udwTab [ 1 ]	= dw_DosSuiviPar

	stPass.dwNorm [ 1 ]	= Dw_Corb
	stPass.dwNorm [ 2 ]	= Dw_Produit

	stPass.dwMaster		= dw_1

	/*------------------------------------------------------------------*/
	/* Si Message du jour Ok pour Suppression, sinon possible uniquement*/
	/* par responsable                                                  */
	/*------------------------------------------------------------------*/

	dDteCree	=	Date ( String ( Dw_Lst_Contact.GetItemDateTime ( Dw_Lst_Contact.ilLigneClick, "CREE_LE" ), "DD/MM/YYYY" ) )
	dDteJour = 	Today ( )
				
	stPass.bSupprime   = dDteCree >= dDteJour Or Long ( stGlb.sTypOper) >= 5	
	F_OuvreConsultation ( iW_Cm_Sp_Contact, "", stPass )

Case "06"

	isDetailConsult = "dw_lst_cmde"

	SetPointer ( HourGlass! )	

	stPass.bInsert		= False
	stPass.bControl		= True

	stPass.sTab [ 1 ]	= This.Title + "/ Commande n° " + String (dw_lst_cmde.GetItemNumber ( dw_lst_cmde.GetRow (), "ID_SEQ" ))
	stPass.sTab [ 2 ]	= "C"
	stPass.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	stPass.dwTab [ 1 ]	= Dw_Lst_Cmde
	stPass.dwTab [ 2 ]	= Dw_Gti

	stPass.dwMaster		= dw_1
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
	stPass.dwNorm [ 1 ]	= dw_Produit

	F_OuvreTraitement ( iW_Sp_C_Commande2, stPass )

End Choose

SetPointer ( Arrow! )
end event

on hide;call w_8_ancetre_consultation::hide;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Hide
//* Evenement 		: Hide
//* Auteur			: Catherine Abdmeziem
//* Date				: 15/07/2004
//* Libellé			: 
//* Commentaires	: DCMP 030381 : fermeture de la popup sur hide
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

If IsValid ( w_T_Sp_Popup_Pol_Ass ) Then Close ( w_T_Sp_Popup_Pol_Ass )

end on

on ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Sinistre (OVERRIDE !!)
//* Evenement 		: Ue_Retour
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libellé			: 
//* Commentaires	: Fermeture définitive de la fenêtre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//*-----------------------------------------------------------------

Boolean bOkPourFermer

bOkPourFermer = TRUE

/*------------------------------------------------------------------*/
/* DCMP990451                                           				  */
/*------------------------------------------------------------------*/
st_Pochette.Hide()


If IsValid ( W_Consulter_Paragraphe ) Then Close ( W_Consulter_Paragraphe )

/*------------------------------------------------------------------*/
/* Gestion des contacts en consultation.                            */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
If ibAltcontact Then 
	iuoCpSpContTrace.uf_Retour_GestionTrace  ( bOkPourFermer, isATraiterPar )
ElseIf ibAltcontactSherpa Then 
	iuoCpSpContTrace.uf_Retour_GestionSherpa  ( bOkPourFermer )
End If

If bOkPourFermer Then 
	This.TriggerEvent ( "UE_MajAccueil" )
	Call Super::Ue_Retour
End If


end on

event ue_enablefenetre;call super::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Sinistre::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 25/03/1999 17:06:51
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1	JCA	27/02/2008	[SUISSE].LOT3
//*-----------------------------------------------------------------

String sMonnaie

/*------------------------------------------------------------------*/
/* On est en consultation, on détermine d'ou l'on vient (GTI,       */
/* INTER ou REGLEMENT), on récupére la valeur de la monnaie pour    */
/* cette fenêtre, et on positionne la même valeur pour la fenêtre   */
/* en cours.                                                        */
/*------------------------------------------------------------------*/
Choose Case isDetailConsult
Case "dw_inter"
	sMonnaie = W_Cd_Sp_Inter.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

Case "dw_gti"
	sMonnaie = W_Cm_Sp_Garantie.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

Case "dw_reglement"
	sMonnaie = W_Cd_Sp_Reglement.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

End Choose

// [SUISSE].LOT3
//If	This.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante () <> sMonnaie	Then
//	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
//End If


end event

on ue_creer;call w_8_ancetre_consultation::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cm_Sp_Sinistre
//* Evenement 		:	ue_Creer
//* Auteur			:	Fabry JF
//* Date				:	14/01/01
//* Libellé			:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


String   sOngletCourant
Date		dDteCree, dDteJour
s_Pass	stPass
Long		lNbContact, lCpt
Boolean	bOk
stPass = istPass

sOngletCourant = uo_onglet.Uf_RecupererOngletCourant()

SetPointer ( HourGlass! )

Choose Case sOngletCourant

Case "05"

	lNbContact	=	Dw_Lst_Contact.RowCount ()
	bOk			=	True

	For lCpt = 1 To lNbContact 

		If Dw_Lst_Contact.GetItemStatus ( lCpt, 0, PRIMARY! ) = New! 			Or &
			Dw_Lst_Contact.GetItemStatus ( lCpt, 0, PRIMARY! ) = NewModified! Then

			bOk = False
			Exit
		End If 

		If Dw_Lst_Contact.GetItemString ( lCpt, "ALT_VALIDE" ) = "O" Then

			bOk = False
			Exit
		End If 

	Next

	stpass.bInsert		= True
	stpass.bControl		= True
	
	stpass.sTab [ 1 ]	= This.Title
	stpass.sTab [ 2 ]	= "C"

	stpass.dwTab [ 1 ]	= Dw_Lst_Contact
	stpass.dwTab [ 2 ]	= Dw_Inter

	stPass.udwTab [ 1 ]	= dw_DosSuiviPar

	stpass.dwNorm [ 1 ]	= Dw_Corb
	stpass.dwNorm [ 2 ]	= Dw_Produit


	stpass.dwMaster		= dw_1
	F_OuvreConsultation ( iW_Cm_Sp_Contact, "", stPass )



End Choose
end on

on ue_item5;call w_8_ancetre_consultation::ue_item5;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Item 5
//* Evenement 		: Item5
//* Auteur			: FABRY JF
//* Date				: 01/02/2002
//* Libellé			: 
//* Commentaires	: Evenement déclenché à partir de la fenêtre contacts
//*					  en consultation pour récupérer les init de la personne
//*					  qui va traiter le travail.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

isATraiterPar = iW_Cm_Sp_Contact.dw_a_traiter_par.GetItemString ( 1, "DOS_SUIVI_PAR" ) 


end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Sinistre
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 16/07/1998
//* Libellé			: 
//* Commentaires	: Fermeture définitive de la fenêtre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//* #1  CAG		06/07/04 DCMP 030381 : ajout d'une popup police/assurance
//*-----------------------------------------------------------------

Destroy iuoConsultation
Destroy iuoCpSpContTrace


If IsValid ( iW_T_Sp_Cree_Travail 		) Then Close ( iW_T_Sp_Cree_Travail )

If IsValid ( iW_Cm_Sp_Contact ) Then Close ( iW_Cm_Sp_Contact )

/*------------------------------------------------------------------*/
/* #1 : CAG 15/07/2004                                              */
/*------------------------------------------------------------------*/
If IsValid ( w_T_Sp_Popup_Pol_Ass ) Then Close ( w_T_Sp_Popup_Pol_Ass )

end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Sinistre (Extend)
//* Evenement 		: We_ChildActivate
//* Auteur			: PLJ
//* Date				: 16/07/1998 
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

on w_cm_sp_sinistre.create
int iCurrent
call super::create
this.uo_onglet=create uo_onglet
this.uo_bord3d=create uo_bord3d
this.dw_1=create dw_1
this.dw_gti=create dw_gti
this.dw_inter=create dw_inter
this.dw_produit=create dw_produit
this.p_focus=create p_focus
this.dw_frais=create dw_frais
this.dw_codegarantie=create dw_codegarantie
this.dw_detail=create dw_detail
this.dw_refus=create dw_refus
this.dw_codecondition=create dw_codecondition
this.dw_motif=create dw_motif
this.dw_reglement=create dw_reglement
this.dw_codecartc=create dw_codecartc
this.dw_reg_gti=create dw_reg_gti
this.uo_consult_euro=create uo_consult_euro
this.st_pochette=create st_pochette
this.dw_corb=create dw_corb
this.dw_dossuivipar=create dw_dossuivipar
this.dw_lst_contact=create dw_lst_contact
this.dw_lst_cmde=create dw_lst_cmde
this.cb_aide=create cb_aide
this.cb_notice=create cb_notice
this.dw_boitearchive=create dw_boitearchive
this.dw_det_pro=create dw_det_pro
this.cb_noboite=create cb_noboite
this.dw_div_sin=create dw_div_sin
this.cb_polass=create cb_polass
this.dw_div_det=create dw_div_det
this.dddw_code_divsin_charg_tempo=create dddw_code_divsin_charg_tempo
this.dddw_codecar_divsin_charg_tempo=create dddw_codecar_divsin_charg_tempo
this.cb_url_extranet=create cb_url_extranet
this.cb_journal=create cb_journal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglet
this.Control[iCurrent+2]=this.uo_bord3d
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_gti
this.Control[iCurrent+5]=this.dw_inter
this.Control[iCurrent+6]=this.dw_produit
this.Control[iCurrent+7]=this.p_focus
this.Control[iCurrent+8]=this.dw_frais
this.Control[iCurrent+9]=this.dw_codegarantie
this.Control[iCurrent+10]=this.dw_detail
this.Control[iCurrent+11]=this.dw_refus
this.Control[iCurrent+12]=this.dw_codecondition
this.Control[iCurrent+13]=this.dw_motif
this.Control[iCurrent+14]=this.dw_reglement
this.Control[iCurrent+15]=this.dw_codecartc
this.Control[iCurrent+16]=this.dw_reg_gti
this.Control[iCurrent+17]=this.uo_consult_euro
this.Control[iCurrent+18]=this.st_pochette
this.Control[iCurrent+19]=this.dw_corb
this.Control[iCurrent+20]=this.dw_dossuivipar
this.Control[iCurrent+21]=this.dw_lst_contact
this.Control[iCurrent+22]=this.dw_lst_cmde
this.Control[iCurrent+23]=this.cb_aide
this.Control[iCurrent+24]=this.cb_notice
this.Control[iCurrent+25]=this.dw_boitearchive
this.Control[iCurrent+26]=this.dw_det_pro
this.Control[iCurrent+27]=this.cb_noboite
this.Control[iCurrent+28]=this.dw_div_sin
this.Control[iCurrent+29]=this.cb_polass
this.Control[iCurrent+30]=this.dw_div_det
this.Control[iCurrent+31]=this.dddw_code_divsin_charg_tempo
this.Control[iCurrent+32]=this.dddw_codecar_divsin_charg_tempo
this.Control[iCurrent+33]=this.cb_url_extranet
this.Control[iCurrent+34]=this.cb_journal
end on

on w_cm_sp_sinistre.destroy
call super::destroy
destroy(this.uo_onglet)
destroy(this.uo_bord3d)
destroy(this.dw_1)
destroy(this.dw_gti)
destroy(this.dw_inter)
destroy(this.dw_produit)
destroy(this.p_focus)
destroy(this.dw_frais)
destroy(this.dw_codegarantie)
destroy(this.dw_detail)
destroy(this.dw_refus)
destroy(this.dw_codecondition)
destroy(this.dw_motif)
destroy(this.dw_reglement)
destroy(this.dw_codecartc)
destroy(this.dw_reg_gti)
destroy(this.uo_consult_euro)
destroy(this.st_pochette)
destroy(this.dw_corb)
destroy(this.dw_dossuivipar)
destroy(this.dw_lst_contact)
destroy(this.dw_lst_cmde)
destroy(this.cb_aide)
destroy(this.cb_notice)
destroy(this.dw_boitearchive)
destroy(this.dw_det_pro)
destroy(this.cb_noboite)
destroy(this.dw_div_sin)
destroy(this.cb_polass)
destroy(this.dw_div_det)
destroy(this.dddw_code_divsin_charg_tempo)
destroy(this.dddw_codecar_divsin_charg_tempo)
destroy(this.cb_url_extranet)
destroy(this.cb_journal)
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

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cm_sp_sinistre
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cm_sp_sinistre
boolean visible = false
integer x = 2967
integer y = 36
integer width = 201
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cm_sp_sinistre
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 190
end type

type uo_onglet from u_onglets within w_cm_sp_sinistre
integer x = 18
integer y = 232
integer width = 2432
integer height = 116
integer taborder = 180
boolean border = false
end type

type uo_bord3d from u_bord3d within w_cm_sp_sinistre
integer x = 1541
integer y = 32
integer width = 402
integer height = 116
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Bord3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 16/07/1998 
//* Libellé			: Positionnement de de l'objet uo_Bord3d
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
This.Width		= 3520
This.Height		= 1420

Call U_Bord3D::Constructor
end on

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type dw_1 from u_datawindow within w_cm_sp_sinistre
event ue_ouvrir_fentrv pbm_custom71
event ue_ouvrir_fensaisie pbm_custom70
integer x = 55
integer y = 488
integer width = 416
integer height = 384
integer taborder = 110
string dataobject = "d_sp_c_sinistre"
boolean border = false
end type

event ue_ouvrir_fentrv;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenTrv
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Overture de la fenêtre des travaux
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

s_Pass	stPass

/*----------------------------------------------------------------------------*/
/* Ouverture de la fenêtre des travaux en invisible à partir de l'objet       */
/* contact_trace.                                                             */
/*----------------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des paramètres    */
/*------------------------------------------------------------------*/
stPass.trTrans 	= itrTrans
stPass.bControl	= True		// Utilisation du bouton Contôler.
stPass.wParent		= Parent
stPass.sTab [ 1 ] = String ( This.GetItemNumber ( 1, "ID_SIN" ) )
stPass.bInsert		= True
stPass.sTab [2] 	= "WORKFLOW_EN_CONSULT_PERM"
stPass.sTab [3] 	= "TOUT"

SetRedraw ( False )
F_OuvreTraitement ( iW_T_Sp_Cree_Travail, stPass )
iW_T_Sp_Cree_Travail.Hide () 

iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "COD_TYP_RECU", "C" )
iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "COD_RECU", "T" )
iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "ID_SIN", Long ( stPass.sTab [ 1 ] ) )
iW_T_Sp_Cree_Travail.Dw_1.SetText ( stPass.sTab [ 1 ] )
iW_T_Sp_Cree_Travail.Dw_1.SetColumn ( "ID_SIN" )
iW_T_Sp_Cree_Travail.Dw_1.TriggerEvent ( "ItemChanged" )

iuoCpSpContTrace.uf_set_DteFinGti ( iW_T_Sp_Cree_Travail.Dw_1.GetItemDateTime ( 1, "DTE_FIN_GTI" ), &
												Not IsNull ( iW_T_Sp_Cree_Travail.Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) ) // [PI056] Date -> Datetime

iW_T_Sp_Cree_Travail.Dw_1.Reset ()
iW_T_Sp_Cree_Travail.TriggerEvent ( "ue_Retour" )

SetRedraw ( True )
end event

on ue_ouvrir_fensaisie;call u_datawindow::ue_ouvrir_fensaisie;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenSaisie
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Overture de la fenêtre d'accueil dce saisie de sinistre
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Ouverture de la fenêtre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )

If IsValid ( W_a_Sp_Wkf_Saisie ) Then 
	W_a_Sp_Wkf_Saisie.Show()
Else
	OpenSheetWithParm ( W_a_Sp_Wkf_Saisie, stGLB, W_Mdi_Sp, 0, Layered! )
End If

W_a_Sp_Wkf_Saisie.BringToTop = True

W_a_Sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")
end on

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet			:	w_Cm_Sp_Sinistre::dw_1
//* Evenement 		:	DoubleClicked
//* Auteur			:	PLJ
//* Date				:	23/07/1998 
//* Libellé			:	Consultation du message Post It
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


s_Pass	stPass

stPass.sTab[1] = Parent.Title
stPass.sTab[2] = dw_1.GetItemString ( 1, "TXT_MESS" )
stPass.sTab[3] = "S"

stPass.wParent	= Parent

If ( Upper ( Left ( GetObjectAtPointer (), 7 ) ) = "POST_IT" ) Then
	
	OpenWithParm ( W_Cd_Sp_Message, stPass, stPass.wParent.ParentWindow () )

End If


end on

type dw_gti from u_datawindow_detail within w_cm_sp_sinistre
integer x = 553
integer y = 488
integer width = 416
integer height = 384
integer taborder = 170
string dataobject = "d_sp_c_lst_gti"
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: 	W_Cm_Sp_Sinistre::dw_Gti
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

Uf_Mnu_CacherItem ( 1 )							// creer
Uf_Mnu_CacherItem ( 3 )							// supprimer
Uf_Mnu_ChangerText ( 2, "Consulter" )		// modifier
end on

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_inter from u_datawindow_detail within w_cm_sp_sinistre
integer x = 1051
integer y = 488
integer width = 416
integer height = 384
integer taborder = 160
string dataobject = "d_sp_c_lst_inter"
boolean vscrollbar = true
boolean border = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: 	W_Cm_Sp_Sinistre::dw_Inter
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

Uf_Mnu_CacherItem ( 1 )							// creer
Uf_Mnu_CacherItem ( 3 )							// supprimer
Uf_Mnu_ChangerText ( 2, "Consulter" )		// modifier
end on

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	//SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_produit from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 123
integer y = 1452
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_produit"
boolean livescroll = true
end type

type p_focus from picture within w_cm_sp_sinistre
boolean visible = false
integer x = 2999
integer y = 32
integer width = 91
integer height = 76
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type dw_frais from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 3232
integer y = 268
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_c_st_frais"
boolean livescroll = true
end type

type dw_codegarantie from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 439
integer y = 1452
integer width = 242
integer height = 100
boolean bringtotop = true
string dataobject = "d_sp_sin_code_garantie"
boolean livescroll = true
end type

type dw_detail from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 3232
integer y = 392
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_c_st_detail"
boolean livescroll = true
end type

type dw_refus from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 3232
integer y = 516
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_c_st_refus"
boolean livescroll = true
end type

type dw_codecondition from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 754
integer y = 1452
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_sin_code_condition"
end type

type dw_motif from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 1070
integer y = 1452
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_motif"
end type

type dw_reglement from u_datawindow_detail within w_cm_sp_sinistre
integer x = 1550
integer y = 488
integer width = 416
integer height = 384
integer taborder = 120
string dataobject = "d_sp_lst_reglement"
boolean vscrollbar = true
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: 	W_Cm_Sp_Sinistre::dw_Reglement
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

Uf_Mnu_CacherItem ( 1 )							// creer
Uf_Mnu_CacherItem ( 3 )							// supprimer
Uf_Mnu_ChangerText ( 2, "Consulter" )		// modifier
end on

type dw_codecartc from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 1385
integer y = 1452
integer width = 242
integer height = 100
boolean bringtotop = true
string dataobject = "dddw_sp_code_car"
boolean livescroll = true
end type

type dw_reg_gti from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 3232
integer y = 640
integer width = 242
integer height = 100
boolean bringtotop = true
string dataobject = "d_sp_c_st_reg_gti"
boolean livescroll = true
end type

type uo_consult_euro from u_consultation_euro within w_cm_sp_sinistre
integer x = 251
integer y = 8
integer taborder = 200
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type st_pochette from statictext within w_cm_sp_sinistre
boolean visible = false
integer x = 2181
integer y = 20
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "POCH"
boolean border = true
boolean focusrectangle = false
end type

type dw_corb from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 1701
integer y = 1452
integer width = 242
integer height = 100
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_sin_contact_stkcorb"
end type

type dw_dossuivipar from u_datawindow within w_cm_sp_sinistre
integer x = 2414
integer y = 8
integer width = 1198
integer height = 92
integer taborder = 90
string dataobject = "dddw_sp_wkf_dosuivipar"
boolean border = false
boolean livescroll = false
end type

on constructor;call u_datawindow::constructor;ilpremcol = 0
ilderncol = 0
end on

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

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

DataWindowChild dwChild
String	sData

sData = Upper ( This.GetText () )
This.GetChild ( "DOS_SUIVI_PAR", dwChild ) 

If dwChild.Find ( "COD_OPER = '" + sData + "'", 1, dwChild.Rowcount () ) <= 0 And Not IsNull ( sData ) Then
//Migration PB8-WYNIWYG-03/2006 FM
//	SetActionCode ( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

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

//Migration PB8-WYNIWYG-03/2006 FM
//SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on losefocus;call u_datawindow::losefocus;This.AcceptText ()
end on

type dw_lst_contact from u_datawindow_detail within w_cm_sp_sinistre
integer x = 2016
integer y = 484
integer width = 439
integer height = 388
integer taborder = 100
string dataobject = "d_sp_sin_lst_contacts"
boolean vscrollbar = true
boolean livescroll = false
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Contact
//* Evenement 		: SqlPreview
//* Auteur			: JFF
//* Date				: 30/04/2001 15:42:44
//* Libellé			: 
//* Commentaires	: Insertion des Contacts d'un sinistre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSql, sTxtMess1, sTxtMess2	// commande SQL qui doit être envoyée.
Long			lLig					// N° de la ligne à insèrer ou supprimer.
dwBuffer		dwBuf					// buffer de donnée de la Dw.

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = This.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		// Gestion des quotes dans la saisie des messages
		/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//		This.GetUpdateStatus ( lLig, dwBuf )
		lLig = row
		dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

		sTxtMess1	=	Dw_Lst_Contact.GetItemString ( lLig, "TXT_MESS1" )
		sTxtMess2	=	Dw_Lst_Contact.GetItemString ( lLig, "TXT_MESS2" )

		If IsNull ( sTxtMess1 ) Or sTxtMess1 = "" Then

			sTxtMess1 = "''"
		Else

			sTxtMess1 = f_Remplace ( sTxtMess1, ",", "." )
			sTxtMess1 = "'" + f_Remplace ( sTxtMess1, "'", " " ) + "'"
		End If

		If IsNull ( sTxtMess2 ) Or sTxtMess2 = "" Then

			sTxtMess2 = "''"
		Else

			sTxtMess2 = f_Remplace ( sTxtMess2, ",", "." )
			sTxtMess2 = "'" + f_Remplace ( sTxtMess2, "'", " " ) + "'"
		End If

		sSql	=	"EXECUTE sysadm.DW_I01_CONTACT "        										+ &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_SIN" ) )				+ "," + &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_MSG_SEQ" ) )			+ "," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "ID_TYP_MSG"   )		+ "," + &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_NAT_MSG" ) )			+ "," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "ID_CANAL"     )		+ "," + &
            	f_GetItem ( Dw_Lst_Contact, lLig, "COD_I_PROV"   ) 	+ "," + &
            	sTxtMess1													 	+ "," + &
            	sTxtMess2													 	+ "," + &
            	f_GetItem ( Dw_Lst_Contact, lLig, "ALT_VALIDE"   ) 	+ "," + &
					"'" + String ( dw_Lst_Contact.GetItemDateTime ( lLig, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss" )			+ "'," + &
					"'" + String ( dw_Lst_Contact.GetItemDateTime ( lLig, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )			+ "'," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "MAJ_PAR"      )   

		This.SetSqlPreview ( sSql )

End Choose
end event

type dw_lst_cmde from u_datawindow_detail within w_cm_sp_sinistre
integer x = 55
integer y = 928
integer width = 416
integer height = 384
integer taborder = 80
string dataobject = "d_c_commande"
boolean vscrollbar = true
boolean border = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: U_DataWindow_detail
// Evenement 	: ue_ModifierMenu
//	Auteur		: Fabry JF
//	Date			: 04/09/01
// Libellé		: Menu contextuel 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Uf_Mnu_SupprimerItem ( 1 )
This.Uf_Mnu_SupprimerItem ( 3 )

If This.GetRow () <= 0 Then Return

This.Uf_Mnu_ChangerText ( 2, "&Consulter" )





end on

type cb_aide from u_aidecontrat within w_cm_sp_sinistre
integer x = 489
integer y = 8
integer width = 192
integer height = 68
integer taborder = 210
end type

event clicked;
// [CONSULT_RESTREINTE]
// !! OVERRIDE !!!

Long lIdSin, lRet 

lIdSin = SetNull ( lIdSin )

// [CONSULT_RESTREINTE]

lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, lIdSin, "" )
If lRet < 0 Then
	stMessage.sTitre		= "Consultation restreinte"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE175"
	stMessage.bTrace  	= False

	F_Message ( stMessage )				
	Return 0
End If 

Call Super::clicked 
end event

type cb_notice from u_aidecontrat within w_cm_sp_sinistre
integer x = 489
integer y = 76
integer width = 192
integer height = 68
integer taborder = 60
boolean bringtotop = true
end type

event clicked;// [CONSULT_RESTREINTE]
// !! OVERRIDE !!!

Long lIdSin, lRet 

lIdSin = SetNull ( lIdSin )

// [CONSULT_RESTREINTE]

lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, lIdSin, "" )
If lRet < 0 Then
	stMessage.sTitre		= "Consultation restreinte"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE175"
	stMessage.bTrace  	= False

	F_Message ( stMessage )				
	Return 0
End If 

Call Super::clicked 
end event

type dw_boitearchive from u_datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 1275
integer y = 1200
integer width = 1019
integer height = 88
integer taborder = 40
string dataobject = "d_sp_sin_boite_archive"
boolean border = false
end type

type dw_det_pro from u_datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 2025
integer y = 1452
integer width = 242
integer height = 100
integer taborder = 30
boolean enabled = false
string dataobject = "d_lst_det_pro"
end type

type cb_noboite from commandbutton within w_cm_sp_sinistre
boolean visible = false
integer x = 2304
integer y = 1204
integer width = 110
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Sinistre::cb_noboite
//* Evenement     : clicked
//* Auteur        : PLJ
//* Date          : 05/09/2003 09:46:33
//* Libellé       : 
//* Commentaires  : Ouvre la fenêtre de gestion des numéros de boîte
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------
String	sNoBoite, sNoBoiteOrigine
s_Pass	stPass	

stPass.udwTab[1] = dw_BoiteArchive
stPass.sTab[1]   = 'CS'

OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )



end on

type dw_div_sin from u_datawindow within w_cm_sp_sinistre
integer x = 2482
integer y = 480
integer width = 466
integer height = 396
integer taborder = 20
string dataobject = "d_lst_div_sin"
boolean vscrollbar = true
boolean border = false
end type

type cb_polass from commandbutton within w_cm_sp_sinistre
integer x = 686
integer y = 8
integer width = 439
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Police assurance"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 15/07/2004 
//* Libellé       : 
//* Commentaires  : Ajout du bouton pour affichage polices et 
//*						assurances des gti du produit du dr DCMP 030381
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	 FPI	 26/10/2009	[EXPANSION5.LIB_POLICE] Ajout du param id_boutique_adh
//*-----------------------------------------------------------------

s_Pass	stPass
Long 		lRow // #1

stPass.dwMaster = dw_1
stPass.trTrans = itrTrans
stPass.lTab [ 1 ] = Parent.X
stPass.lTab [ 2 ] = Parent.Y
stPass.sTab [ 1 ] = "C"

// #1 - [EXPANSION5.LIB_POLICE]
if dw_div_sin.RowCount() > 0 Then
	lRow = dw_div_sin.Find("nom_zone='id_boutique_adh'", &
		1, dw_div_sin.RowCount())
		
	If lRow > 0 Then
		stPass.sTab [ 2 ] = dw_div_sin.getItemString( lRow,"VAL_CAR")
	End if
End if
// Fin #1 - [EXPANSION5.LIB_POLICE]

OpenWithParm ( w_t_sp_popup_pol_ass,  stPass)

end event

type dw_div_det from u_datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 2350
integer y = 1452
integer width = 242
integer height = 100
integer taborder = 10
boolean enabled = false
string dataobject = "d_lst_div_det"
boolean livescroll = false
end type

type dddw_code_divsin_charg_tempo from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 2624
integer y = 1452
integer width = 242
integer height = 100
integer taborder = 150
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_spb_code"
end type

type dddw_codecar_divsin_charg_tempo from datawindow within w_cm_sp_sinistre
boolean visible = false
integer x = 2894
integer y = 1452
integer width = 242
integer height = 100
integer taborder = 140
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_code_car"
end type

type cb_url_extranet from commandbutton within w_cm_sp_sinistre
integer x = 686
integer y = 80
integer width = 434
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "URL site de Cmde"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Cm_Sp_Sinistre::Click
//* Auteur        : FABRY JF
//* Date          : 19/02/2007 
//* Libellé       : 
//* Commentaires  : Info donnant l'URL du site de commande lié au produit
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sURL
Long   lDeb, lFin, lIdProd
n_cst_string lnvPFCString
Long lIdSin, lRet 

// [CONSULT_RESTREINTE]
lIdSin = SetNull ( lIdSin )

// [CONSULT_RESTREINTE]

lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, lIdSin, "" )
If lRet < 0 Then
	stMessage.sTitre		= "Consultation restreinte"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE175"
	stMessage.bTrace  	= False

	F_Message ( stMessage )				
	Return 0
End If 

Call Super::clicked 

lIdProd = dw_1.GetItemNumber ( 1, "ID_PROD" )

F_RechDetPro ( lDeb, lFin, dw_Det_Pro, lIdProd, "-DP", 80 ) 

If lDeb > 0 Then
	sURL = lnvPFCString.of_getkeyvalue (dw_Det_Pro.GetItemString ( lDeb, "VAL_CAR" ), "URL", ";")
	If Pos ( Upper ( sURL ), "HTTP://", 1 ) <= 0 Then
			sURL = "L'URL est mal paramètrée, contactez la cellule paramètrage au 2245"
	End If
	stMessage.sVar[1] = sURL
	stMessage.sCode = "COMD442"
Else 
	stMessage.sCode = "COMD443"
End If 

stMessage.sTitre		= "URL site de commande"
stMessage.Icon			= Information!
stMessage.bErreurG	= False
f_Message ( stMessage )

end event

type cb_journal from commandbutton within w_cm_sp_sinistre
integer x = 1125
integer y = 8
integer width = 210
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Journal"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Fabry JF
//* Date          : 07/05/2019
//* Libellé       : 
//* Commentaires  : 
//*						
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.lTab [ 1 ] = dw_1.GetItemNumber ( 1, "ID_PROD" )

OpenWithParm ( w_t_sp_journal,  stPass)
end event

