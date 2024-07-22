HA$PBExportHeader$w_cm_sp_garantie.srw
forward
global type w_cm_sp_garantie from w_8_ancetre_consultation
end type
type uo_onglet from u_onglets within w_cm_sp_garantie
end type
type uo_refus from u_tagger within w_cm_sp_garantie
end type
type dw_1 from u_datawindow within w_cm_sp_garantie
end type
type uo_bord3d from u_bord3d within w_cm_sp_garantie
end type
type dw_detail from u_datawindow_detail within w_cm_sp_garantie
end type
type uo_consult_euro from u_consultation_euro within w_cm_sp_garantie
end type
end forward

global type w_cm_sp_garantie from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
boolean controlmenu = false
boolean minbox = false
event ue_quitteronglet011 pbm_custom01
event ue_quitteronglet021 pbm_custom02
event ue_quitteronglet031 pbm_custom03
event ue_taillefenetre ( )
uo_onglet uo_onglet
uo_refus uo_refus
dw_1 dw_1
uo_bord3d uo_bord3d
dw_detail dw_detail
uo_consult_euro uo_consult_euro
end type
global w_cm_sp_garantie w_cm_sp_garantie

type variables
Private:
u_Cs_Sp_Garantie		iuoConsultation



end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparerconsulter ()
private subroutine wf_fermer_consulter_paragraphe ()
end prototypes

on ue_quitteronglet011;call w_8_ancetre_consultation::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Garantie
//* Evenement 		: Ue_QuitterOnglet011
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va quitter l'onglet 01
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()
end on

on ue_quitteronglet021;call w_8_ancetre_consultation::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Garantie
//* Evenement 		: Ue_QuitterOnglet021
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va quitter l'onglet 02
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()
end on

event ue_taillefenetre();//*-----------------------------------------------------------------
//*
//* Objet 			: Ue_TailleFenetre
//* Evenement 		: Ue_TailleFenetre
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

// Je r$$HEX1$$e900$$ENDHEX$$ajuste la hauteur pour W10

This.Height = 1810

end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_cm_sp_Garantie::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord3d qui est positionn$$HEX2$$e9002000$$ENDHEX$$et taill$$HEX1$$e900$$ENDHEX$$
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   10
Uo_Onglet.Y			=  157
Uo_Onglet.Height	=  109

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : En-t$$HEX1$$ea00$$ENDHEX$$te Garantie                              */
/*------------------------------------------------------------------*/
Dw_1.X			=   33
Dw_1.Y			=  273
Dw_1.Width		= 3484
Dw_1.Height		=  917


/*------------------------------------------------------------------*/
/* Uo_Refus U_Tagger : Liste des Refus                              */
/*------------------------------------------------------------------*/
Uo_Refus.X				= Dw_1.X
Uo_Refus.Y				= Dw_1.Y
Uo_Refus.Width			= Dw_1.Width
Uo_Refus.Height		= Dw_1.Height


/*------------------------------------------------------------------*/
/* Dw_Lst DataWindow : Liste des Details.                           */
/*------------------------------------------------------------------*/
Dw_Detail.X				= Uo_Bord3D.X
Dw_Detail.Y				= Dw_1.Y + Dw_1.Height + 40
Dw_Detail.Width		= Uo_Bord3D.Width
Dw_Detail.Height		= 430
end subroutine

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Garantie
//* Fonction		: wf_PreparerConsulter
//* Auteur			: PLJ
//* Date				: 27/07/1998 
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
String sMonnaie

bOk = iuoConsultation.Uf_Preparer_Consulter ()	

/*-------------------------------------------------------*/
/* Je dois apr$$HEX1$$e800$$ENDHEX$$s avoir charg$$HEX2$$e9002000$$ENDHEX$$dw_detail, 	faire 	une 	*/
/* de la premi$$HEX1$$e800$$ENDHEX$$re ligne, sinon la barre  de  s$$HEX1$$e900$$ENDHEX$$lection	*/
/* n'appara$$HEX1$$ee00$$ENDHEX$$t pas !!! Pourquoi ???								*/
/*-------------------------------------------------------*/
If bOk Then Dw_Detail.SelectRow ( 1, True )

This.Title = istPass.sTab [ 1 ] 

/*------------------------------------------------------------------*/
/* On affiche le dernier type de monnaie connu.                     */
/*------------------------------------------------------------------*/
sMonnaie = istPass.sTab [ 2 ]
Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

Return ( bOk )
end function

private subroutine wf_fermer_consulter_paragraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Cm_Sp_Garantie:Wf_Fermer_Consulter_Paragraphe (PRIVATE)
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation est ouverte, on la rend invisible
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

If	IsValid ( W_Consulter_Paragraphe ) Then
	If W_Consulter_Paragraphe.Visible = True Then W_Consulter_Paragraphe.Hide ()
End If
end subroutine

on ue_modifier;call w_8_ancetre_consultation::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cm_Sp_Garantie
//* Evenement 		:	ue_Modifier
//* Auteur			:	PLJ
//* Date				:	28/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass = istPass

SetPointer ( HourGlass! )

If Dw_Detail.ilLigneClick > 0 Then

	stPass.sTab [ 1 ]	= This.Title
	stPass.sTab [ 2 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	stPass.dwMaster1		= dw_1						// DataWindow garantie

	stPass.dwTab [ 2 ] 	= Dw_Detail					// Liste des d$$HEX1$$e900$$ENDHEX$$tails

	If	stPass.sTab [ 2 ]	<> stGLB.sMonnaieFormatDesire		Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
			
   F_OuvreConsultation ( w_Cd_Sp_Detail, "", stPass )

End If


end on

on ue_enablefenetre;call w_8_ancetre_consultation::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Garantie::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 25/03/1999 17:06:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

/*------------------------------------------------------------------*/
/* On vient forc$$HEX1$$e900$$ENDHEX$$ment de la fen$$HEX1$$ea00$$ENDHEX$$tre des d$$HEX1$$e900$$ENDHEX$$tails. On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la     */
/* valeur de la monnaie pour cette fen$$HEX1$$ea00$$ENDHEX$$tre, et on positionne la     */
/* m$$HEX1$$ea00$$ENDHEX$$me valeur pour la fen$$HEX1$$ea00$$ENDHEX$$tre en cours.                            */
/*------------------------------------------------------------------*/
sMonnaie = W_Cd_Sp_Detail.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

If	This.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante () <> sMonnaie	Then
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
End If


end on

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_Cm_Sp_Garantie
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	PLJ
//* Date				:	27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation  
//*					 	d'Interlocuteur
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwNorm[2]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Positionnement des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre                          */
/*------------------------------------------------------------------*/
wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglet.Uf_Initialiser ( 2, 1 )

Uo_Onglet.Uf_EnregistrerOnglet ( "01", "Garantie", "", Dw_1     , True  )
Uo_Onglet.Uf_EnregistrerOnglet ( "02", "Refus",    "", Uo_Refus,  False )


/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$claration du nvuo li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre                            */
/*------------------------------------------------------------------*/


iuoConsultation = Create u_Cs_Sp_Garantie

/*------------------------------------------------------------------*/
/* istPass.dwMaster			( w_Cm_Sp_Sinistre.Dw_1					)	  */
/* istPass.dwTab[1]			( w_Cm_Sp_Sinistre.Dw_Gti				)	  */
/* istPass.dwNorm[1]			( w_Cm_Sp_Sinistre.Dw_Detail			)	  */
/* istPass.dwNorm[2]			( w_Cm_Sp_Sinistre.Dw_Refus			)	  */
/* istPass.dwNorm[6]			( W_Cm_Sp_Sinistre.Dw_Motif   		)	  */
/* istPass.dwNorm[4]			( W_Cm_Sp_Sinistre.Dw_Codecondition )    */
/* Dw_1							( w_Cm_Sp_Garantie.Dw_1					)	  */
/* Dw_Detail					( w_Cm_Sp_Garantie.Dw_Detail			)	  */
/*------------------------------------------------------------------*/

iuoConsultation.uf_Init_Garantie (	iTrTrans,				&
												istPass.dwMaster,		&					
										   	istPass.dwTab[1],		&					
												istPass.dwNorm[1],	&	
												istPass.dwNorm[2],   &
												istPass.dwNorm[6],   &
												istPass.dwNorm[4],   &
												istPass.dwNorm[8],   &
												Dw_1,						&					
												Dw_Detail,				&	
												Uo_Refus,				&				
										   	Uo_Onglet       )


/*------------------------------------------------------------------*/
/* Positionnement du Focus indicator                                */
/*------------------------------------------------------------------*/
Dw_Detail.Uf_Activer_Selection( True )

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Detail

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )


end on

on ue_retour;call w_8_ancetre_consultation::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Garantie
//* Evenement 		:	Ue_Retour
//* Auteur			:	PLJ
//* Date				:	31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Wf_Fermer_Consulter_Paragraphe ()
end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Garantie
//* Evenement 		:	Close
//* Auteur			:	PLJ
//* Date				:	31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iuoConsultation


end on

on we_childactivate;call w_8_ancetre_consultation::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Garantie
//* Evenement 		: We_ChildActivate
//* Auteur			: PLJ
//* Date				: 27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

on w_cm_sp_garantie.create
int iCurrent
call super::create
this.uo_onglet=create uo_onglet
this.uo_refus=create uo_refus
this.dw_1=create dw_1
this.uo_bord3d=create uo_bord3d
this.dw_detail=create dw_detail
this.uo_consult_euro=create uo_consult_euro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglet
this.Control[iCurrent+2]=this.uo_refus
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.uo_bord3d
this.Control[iCurrent+5]=this.dw_detail
this.Control[iCurrent+6]=this.uo_consult_euro
end on

on w_cm_sp_garantie.destroy
call super::destroy
destroy(this.uo_onglet)
destroy(this.uo_refus)
destroy(this.dw_1)
destroy(this.uo_bord3d)
destroy(this.dw_detail)
destroy(this.uo_consult_euro)
end on

event show;call super::show;
//*-----------------------------------------------------------------
//*
//* Objet 			: Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )

end event

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cm_sp_garantie
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cm_sp_garantie
boolean visible = false
integer x = 2775
integer y = 48
integer width = 183
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cm_sp_garantie
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type uo_onglet from u_onglets within w_cm_sp_garantie
integer x = 18
integer y = 200
integer width = 992
integer height = 116
integer taborder = 30
boolean border = false
end type

type uo_refus from u_tagger within w_cm_sp_garantie
integer x = 567
integer y = 460
integer width = 416
integer height = 388
integer taborder = 40
end type

on constructor;call u_tagger::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Refus::Constructor (EXTEND)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 03/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e900$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre			= False

/*------------------------------------------------------------------*/
/* On ne veut pas de RowFocusIndicator.                             */
/*------------------------------------------------------------------*/
ibIndicateur	= False

/*------------------------------------------------------------------*/
/* On ne veut pas d'effet 3D pour l'objet.                          */
/*------------------------------------------------------------------*/
ibEffet3D		= False

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve la bordure, qui permet de mieux l'objet pendant le     */
/* d$$HEX1$$e900$$ENDHEX$$veloppement.                                                   */
/*------------------------------------------------------------------*/
This.Border = False

end on

on ue_dwtrt_rbuttondown;call u_tagger::ue_dwtrt_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: W_CM_SP_Garantie::Uo_Refus
//* Evenement 		: ue_dwtrt_rButtonDown
//* Auteur			: PLJ
//* Date				: 31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Visualisation du texte associ$$HEX2$$e9002000$$ENDHEX$$au paragraphe
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig

String sCol, sIdPara, sCptVer

s_Pass	stPass

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine si on se trouve sur une ligne valide.               */
/*------------------------------------------------------------------*/
lLig = F_GetObjectAtPointer ( This.dw_Trt, sCol )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On a besoin d'un objet de transaction. Le seul valide qui        */
/* existe est celui de la fen$$HEX1$$ea00$$ENDHEX$$tre. Il n'y a aucun objet de          */
/* transaction sur les DW.                                          */
/*------------------------------------------------------------------*/
	stPass.trTrans = Parent.itrTrans

	sIdPara				= This.dw_Trt.GetItemString ( lLig, "ID_PARA" )
	sCptVer				= This.dw_Trt.GetItemString ( lLig, "CPT_VER" )

	stPass.sTab[1]		= sIdPara
	stPass.sTab[2] 	= "Paragraphe : " + sIdPara + "." + sCptVer + " - " + This.dw_Trt.GetItemString ( lLig, "LIB_MOTIF" )

	If	IsValid ( W_Consulter_Paragraphe )	Then
		W_Consulter_Paragraphe.Show ()
	Else
		Open ( W_Consulter_Paragraphe )
	End If

	W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

End If



end on

on uo_refus.destroy
call u_tagger::destroy
end on

type dw_1 from u_datawindow within w_cm_sp_garantie
integer x = 64
integer y = 460
integer width = 416
integer height = 388
integer taborder = 10
string dataobject = "d_sp_c_gti"
boolean border = false
end type

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet			:	w_Cm_Sp_Garantie::dw_1
//* Evenement 		:	DoubleClicked
//* Auteur			:	FABRY JF
//* Date				:	09/11/1998 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Consultation du message Post It sur fen$$HEX1$$ea00$$ENDHEX$$tre Garantie (Consultation)
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

type uo_bord3d from u_bord3d within w_cm_sp_garantie
integer x = 741
integer y = 28
integer width = 293
integer height = 112
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Bord3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 27/07/1998 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionnement de de l'objet uo_Bord3d
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
This.Width		= 3534
This.Height		=  950

Call U_Bord3D::Constructor
end on

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type dw_detail from u_datawindow_detail within w_cm_sp_garantie
integer x = 73
integer y = 976
integer width = 905
integer height = 300
integer taborder = 20
string dataobject = "d_sp_c_lst_detail"
boolean vscrollbar = true
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: 	W_Cm_Sp_Garantie::dw_Detail
//* Evenement 		: 	ue_ModifierMenu
//* Auteur			: 	PLJ
//* Date				: 	31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 	Changement des propri$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$s du menu contextuel li$$HEX1$$e900$$ENDHEX$$
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
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type uo_consult_euro from u_consultation_euro within w_cm_sp_garantie
integer x = 251
integer y = 8
integer taborder = 60
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

