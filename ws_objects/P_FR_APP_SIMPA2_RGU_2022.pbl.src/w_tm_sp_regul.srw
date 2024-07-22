HA$PBExportHeader$w_tm_sp_regul.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour la saisie des r$$HEX1$$e900$$ENDHEX$$gularisations
forward
global type w_tm_sp_regul from w_8_traitement_master
end type
type uo_3d from u_bord3d within w_tm_sp_regul
end type
type uo_ong from u_onglets within w_tm_sp_regul
end type
type dw_lst_reg from u_datawindow_detail within w_tm_sp_regul
end type
type dw_inter from datawindow within w_tm_sp_regul
end type
type dw_produit from datawindow within w_tm_sp_regul
end type
type dw_w_queue from datawindow within w_tm_sp_regul
end type
type dw_w_a_virer from datawindow within w_tm_sp_regul
end type
type dw_frais from datawindow within w_tm_sp_regul
end type
type dw_reg_gti from datawindow within w_tm_sp_regul
end type
type dw_regul_ff from u_datawindow within w_tm_sp_regul
end type
end forward

global type w_tm_sp_regul from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
event ue_regul pbm_custom01
event ue_item10 pbm_custom02
event ue_taillefenetre ( )
uo_3d uo_3d
uo_ong uo_ong
dw_lst_reg dw_lst_reg
dw_inter dw_inter
dw_produit dw_produit
dw_w_queue dw_w_queue
dw_w_a_virer dw_w_a_virer
dw_frais dw_frais
dw_reg_gti dw_reg_gti
dw_regul_ff dw_regul_ff
end type
global w_tm_sp_regul w_tm_sp_regul

type variables
Private :
	U_Gs_Sp_Regul	iuoGsSpRegul

	String		isTypeRegul
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_valider ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_droit_factu ()
end prototypes

event ue_regul;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Regul
//* Evenement 		: Ue_Regul
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF     01/08/2005 Contr$$HEX1$$f400$$ENDHEX$$le particuliers si RM demand$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------

Long lTypeRegul
Boolean bOk
Long lRow

s_Pass stPass_Dga

stPass_Dga 			= istPass
isDetailActif		= "dw_lst_reg"

lTypeRegul			= Message.WordParm

// [REGL_LBE]
lRow=Dw_lst_reg.GetSelectedRow (0)
if Upper ( Trim ( dw_Lst_Reg.GetItemString ( lRow, "COD_MODE_REG" ) ) )  = "XA" Then
	stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "REGU220"
	stMessage.Bouton		= OK!
	f_message(stMessage)
	
	Return 
End if
// :[REGL_LBE]

/*------------------------------------------------------------------*/
/* #1 : Contr$$HEX1$$f400$$ENDHEX$$le particuliers si RM demand$$HEX1$$e900$$ENDHEX$$e.                       */
/*------------------------------------------------------------------*/
Choose Case lTypeRegul 
	Case 2,4
		bOk = iuoGsSpRegul.uf_Controle_Suppl_RM_RP ( lTypeRegul , Dw_lst_reg.GetItemnumber ( Dw_lst_reg.GetSelectedRow (0), "ID_REG" ) ) 
		If Not bOk Then Return
End Choose

/*------------------------------------------------------------------*/
/* On arme une variable d'instance de la fen$$HEX1$$ea00$$ENDHEX$$tre pour le choix du   */
/* type de r$$HEX1$$e900$$ENDHEX$$gularisation. Cette variable sera utilis$$HEX1$$e900$$ENDHEX$$e sur         */
/* Ue_EnableFenetre.                                                */
/*------------------------------------------------------------------*/
isTypeRegul			= String ( lTypeRegul )

SetPointer ( HourGlass! )
/*------------------------------------------------------------------*/
/* On arme la structure pour expliquer un certain nombre de         */
/* choses. On est en modification, on ne veut pas du bouton CTRL.   */
/* On passe la DW de d$$HEX1$$e900$$ENDHEX$$tail ainsi que la DW Master (Sinistre).      */
/* Cette derni$$HEX1$$e800$$ENDHEX$$re est tr$$HEX1$$e900$$ENDHEX$$s importante. Elle va $$HEX1$$e900$$ENDHEX$$viter d'utiliser    */
/* des instances de fen$$HEX1$$ea00$$ENDHEX$$tres.                                       */
/*------------------------------------------------------------------*/
stPass_Dga.bInsert		= False
stPass_Dga.bSupprime		= False
stPass_Dga.bControl		= True
	
stPass_Dga.sTab [ 1 ]	= This.Title
stPass_Dga.sTab [ 2 ]	= String ( lTypeRegul )

stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Reg
stPass_Dga.dwMaster		= dw_1
stPass_Dga.dwMaster1		= dw_Regul_FF			// DataWindow REGULARISATION

stPass_Dga.dwNorm [ 1 ]	= dw_Produit			// DataWindow PRODUIT
stPass_Dga.dwNorm [ 2 ]	= dw_Inter				// DataWindow INTERLOCUTEURS
stPass_Dga.dwNorm [ 3 ]	= dw_Frais				// DataWindow FRAIS
stPass_Dga.dwNorm [ 4 ]	= dw_Reg_Gti			// DataWindow REG_GTI

F_OuvreTraitement ( W_Td_Sp_Saisie_Regul, stPass_Dga )


end event

on ue_item10;call w_8_traitement_master::ue_item10;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Item10
//* Evenement 		: Ue_Item10
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Saisie d'un RP li$$HEX4$$e9002000e0002000$$ENDHEX$$une Garantie
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "Ue_Regul", 4, 0 )
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

This.Height = 1825

end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Regul::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
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
Uo_Ong.X			=   10
Uo_Ong.Y			=  157
Uo_Ong.Width	=  109

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   60
Dw_1.Y			=  310
Dw_1.Width		= 2075
Dw_1.Height		=  810


/*------------------------------------------------------------------*/
/* Liste des Interlocuteurs.                                        */
/*------------------------------------------------------------------*/
Dw_Inter.X			= Dw_1.X
Dw_Inter.Y			= Dw_1.Y
Dw_Inter.Width		= Dw_1.Width
Dw_Inter.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Liste des R$$HEX1$$e800$$ENDHEX$$glements.                                            */
/*------------------------------------------------------------------*/
Dw_Lst_Reg.X			= Uo_3D.X
Dw_Lst_Reg.Y			= Dw_1.Y + Dw_1.Height + 40
Dw_Lst_Reg.Width		= Uo_3D.Width
Dw_Lst_Reg.Height		= 480

/*------------------------------------------------------------------*/
/* Apparition de la r$$HEX1$$e900$$ENDHEX$$gularisation. (Si au moins une ligne)         */
/*------------------------------------------------------------------*/
Dw_Regul_FF.X			= 2220
Dw_Regul_FF.Y			= Dw_1.Y
Dw_Regul_FF.Width		= 1330
Dw_Regul_FF.Height	= 1270
end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Regul::Wf_PreparerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab [ 1 ] = istPass.sTab [ 1 ]			// ID_SIN en cours de traitement

iuoGsSpRegul.Uf_Traitement ( 2, stPass_Dga )

/*------------------------------------------------------------------*/
/* Au retour, on arme le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre de la mani$$HEX1$$e800$$ENDHEX$$re          */
/* suivante.                                                        */
/* Code Produit + Libell$$HEX2$$e9002000$$ENDHEX$$Produit + N$$HEX2$$b0002000$$ENDHEX$$Dossier + Nom + Pr$$HEX1$$e900$$ENDHEX$$nom.      */
/*------------------------------------------------------------------*/

If	stPass_Dga.bRetour Then
	This.Title = stPass_Dga.sTab [ 1 ]
End If

/*------------------------------------------------------------------*/
/* L'acc$$HEX1$$e900$$ENDHEX$$s au bouton CONTROLER est g$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$dans la fonction du NVUO.   */
/* En effet, s'il existe un travail en cours ou un virement dans    */
/* W_A_VIRER il est impossible de faire CTL-VAL.                    */
/*------------------------------------------------------------------*/
If	stPass_Dga.lTab[1] = 0	Then
	This.Pb_Controler.Enabled = False
Else
	This.Pb_Controler.Enabled = True
End If

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Regul::Wf_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re enti$$HEX1$$e900$$ENDHEX$$rement la validation, sans faire appel $$HEX2$$e0002000$$ENDHEX$$la fonction anc$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Dans la fonction du NVUO, on va appeler la fonction de           */
/* validation. Il n'y a pas besoin de faire d'Update sur DW_1. Il   */
/* n'y a pas besoin de faire appel aux fonctions                    */
/* Uf_PreparerValider (), Uf_ExecuterValider (),                    */
/* Uf_TerminerValider (). La gestion du COMMIT ou du ROLLBACK, est  */
/* du ressort du NVUO.                                              */
/*------------------------------------------------------------------*/

s_Pass	stPass_Dga

iuoGsSpRegul.Uf_Traitement ( 7, stPass_Dga )

Return ( stPass_Dga.bRetour )





end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Regul::Wf_ControlerSaisie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:50:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de la saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			"" = Tout va bien
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

iuoGsSpRegul.Uf_Traitement ( 4, stPass_Dga )

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function string wf_controlergestion ();
String sCodModeReg=""
String sPos=""

If dw_regul_ff.RowCount() = 0 Then Return ""

sCodModeReg=dw_regul_ff.GetItemString(1,"COD_MODE_REG")
// [VDOC14621]
If sCodModeReg="FM"  Then
	if not wf_droit_factu( ) Then
		stMessage.sTitre		= "R$$HEX1$$e900$$ENDHEX$$gularisation FM"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode="REGU210"
		
		f_message(stmessage)
		
		sPos="ID_SIN"
	End if
End if
// :[VDOC14621]

Return sPos
end function

public function boolean wf_droit_factu ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_regul::wf_droit_factu
//* Auteur			: F. Pinon
//* Date				: 24/06/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc14621]
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long 		lTotLigne

/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 208 pour l'op$$HEX1$$e900$$ENDHEX$$rateur */
/* connect$$HEX60$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 208		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;
 
 return (lTotLigne >0)
end function

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga
DataWindow	dwNorm[6]
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwPassageEuro[4]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* On commence $$HEX2$$e0002000$$ENDHEX$$initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpRegul = Create U_Gs_Sp_Regul

/*------------------------------------------------------------------*/
/* On initialise les objets principaux.                             */
/*------------------------------------------------------------------*/
iuoGsSpRegul.Uf_Initialisation ( dw_1, itrTrans, Uo_Ong )

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = dw_Produit
dwNorm[ 2] = dw_Inter
dwNorm[ 3] = dw_W_Queue
dwNorm[ 4] = dw_W_A_Virer
dwNorm[ 5] = dw_Frais
dwNorm[ 6] = dw_Reg_Gti

iuoGsSpRegul.Uf_Initialiser_Dw ( dw_Lst_Reg, dw_Regul_FF, dwNorm[] )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 2, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Sinistre", 			"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Interlocuteurs", 	"", dw_Inter,		False )

iuoGsSpRegul.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage $$HEX2$$e0002000$$ENDHEX$$l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro[ 1 ] = dw_1
dwPassageEuro[ 2 ] = dw_Inter
dwPassageEuro[ 3 ] = dw_Regul_Ff
dwPassageEuro[ 4 ] = dw_Lst_Reg

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro

end on

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil
//* Auteur			: Erick John Stark
//* Date				: 28/08/1998 16:03:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construction de la chaine pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild dwChild
String 	sTab, sLibCourt, sIdSin, sNom, sPrenom, sLibEtat, sCodEtat
Long lLig, lTotprod


sLibCourt	= dw_Produit.GetItemString ( 1, "LIB_COURT" )
sIdSin		= String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )
sNom			= dw_1.GetItemString ( 1, "NOM" )
sPrenom		= dw_1.GetItemString ( 1, "PRENOM" )
sLibEtat		= ""
sCodEtat		= String ( dw_1.GetItemNumber ( 1, "COD_ETAT" ) )

sTab    = "~t"

isMajAccueil	=	sLibCourt		+ sTab	+ &
						sIdSin			+ sTab	+ &
						sNom				+ sTab	+ &
						sPrenom			+ sTab	+ &
						sLibEtat			+ sTab	+ &
						sCodEtat
					

end on

on ue_enablefenetre;call w_8_traitement_master::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_EnableFenetre (EXTEND)
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 16/03/1999 17:11:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de la fen$$HEX1$$ea00$$ENDHEX$$tre de saisie des r$$HEX1$$e900$$ENDHEX$$gularisations
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab[1] = isTypeRegul

iuoGsSpRegul.Uf_Traitement ( 8, stPass_Dga )

end on

on ue_item11;call w_8_traitement_master::ue_item11;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Item101
//* Evenement 		: Ue_Item11
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Saisie d'un RP li$$HEX4$$e9002000e0002000$$ENDHEX$$un Frais
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "Ue_Regul", 5, 0 )
end on

on ue_item8;call w_8_traitement_master::ue_item8;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Item8
//* Evenement 		: Ue_Item8
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Saisie d'un RM li$$HEX4$$e9002000e0002000$$ENDHEX$$un Frais
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "Ue_Regul", 3, 0 )
end on

on w_tm_sp_regul.create
int iCurrent
call super::create
this.uo_3d=create uo_3d
this.uo_ong=create uo_ong
this.dw_lst_reg=create dw_lst_reg
this.dw_inter=create dw_inter
this.dw_produit=create dw_produit
this.dw_w_queue=create dw_w_queue
this.dw_w_a_virer=create dw_w_a_virer
this.dw_frais=create dw_frais
this.dw_reg_gti=create dw_reg_gti
this.dw_regul_ff=create dw_regul_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3d
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.dw_lst_reg
this.Control[iCurrent+4]=this.dw_inter
this.Control[iCurrent+5]=this.dw_produit
this.Control[iCurrent+6]=this.dw_w_queue
this.Control[iCurrent+7]=this.dw_w_a_virer
this.Control[iCurrent+8]=this.dw_frais
this.Control[iCurrent+9]=this.dw_reg_gti
this.Control[iCurrent+10]=this.dw_regul_ff
end on

on w_tm_sp_regul.destroy
call super::destroy
destroy(this.uo_3d)
destroy(this.uo_ong)
destroy(this.dw_lst_reg)
destroy(this.dw_inter)
destroy(this.dw_produit)
destroy(this.dw_w_queue)
destroy(this.dw_w_a_virer)
destroy(this.dw_frais)
destroy(this.dw_reg_gti)
destroy(this.dw_regul_ff)
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:46:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermeture d$$HEX1$$e900$$ENDHEX$$finitive de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iUoGsSpRegul

end on

on we_childactivate;call w_8_traitement_master::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
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

on ue_item5;call w_8_traitement_master::ue_item5;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Item5
//* Evenement 		: Ue_Item5
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Saisie d'un RI
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "Ue_Regul", 1, 0 )

end on

on ue_item7;call w_8_traitement_master::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Regul::Ue_Item7
//* Evenement 		: Ue_Item7
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Saisie d'un RM li$$HEX4$$e9002000e0002000$$ENDHEX$$la Garantie
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "Ue_Regul", 2, 0 )
end on

event show;call super::show;//*-----------------------------------------------------------------
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

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_regul
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_regul
integer x = 41
integer y = 324
integer width = 530
integer height = 460
string dataobject = "d_sp_sinistre_regul"
boolean border = false
boolean livescroll = false
end type

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_regul
boolean visible = false
integer x = 3406
integer y = 24
integer width = 105
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_regul
integer x = 9
integer y = 4
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_regul
integer x = 494
integer y = 4
integer width = 242
integer height = 144
integer taborder = 60
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_regul
boolean visible = false
integer x = 983
integer y = 4
integer taborder = 0
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_regul
integer x = 251
integer y = 4
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_regul
boolean visible = false
integer x = 741
integer y = 4
integer taborder = 0
boolean enabled = false
end type

type uo_3d from u_bord3d within w_tm_sp_regul
integer x = 1367
integer y = 52
integer width = 320
integer height = 120
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
This.Width		= 2120
This.Height		=  880

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_ong from u_onglets within w_tm_sp_regul
integer x = 9
integer y = 156
integer width = 946
integer height = 108
integer taborder = 20
boolean border = false
end type

type dw_lst_reg from u_datawindow_detail within w_tm_sp_regul
integer x = 727
integer y = 336
integer width = 530
integer height = 460
integer taborder = 30
string dataobject = "d_sp_lst_reglement_regul"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Reg::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 11/03/1999 17:50:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  04/08/2005 Modif pour gestion APF.				  
//*-----------------------------------------------------------------

Long lCpt, lDeb, lTotFrais, lTotGti, lIdGti
String sCodMotReg, sCodModeReg , sFiltre, sCodInter
Decimal {2} dcMtReg

Boolean bGti, bOk

bOk = True
For	lCpt = 1	To 4
		This.Uf_Mnu_CacherItem ( lCpt )
Next

/*------------------------------------------------------------------*/
/* #1 Dor$$HEX1$$e900$$ENDHEX$$navant toute R$$HEX1$$e900$$ENDHEX$$gul RI/RM/RP doit se faire par rapport $$HEX4$$e000200020002000$$ENDHEX$$*/
/* un RN de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence, donc il doit au moins y avoir une ligne      */
/* cliqu$$HEX1$$e900$$ENDHEX$$e.                                                         */
/*------------------------------------------------------------------*/
If This.ilLigneClick <=0 Then bOk = False

/*------------------------------------------------------------------*/
/* #1 Dor$$HEX1$$e900$$ENDHEX$$navant toute R$$HEX1$$e900$$ENDHEX$$gul RI/RM/RP doit se faire par rapport $$HEX4$$e000200020002000$$ENDHEX$$*/
/* un RN de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence															  */
/*------------------------------------------------------------------*/
If bOk Then
	sCodMotReg = This.GetItemString ( This.ilLigneClick, "COD_MOT_REG" )
	sCodModeReg = This.GetItemString ( This.ilLigneClick, "COD_MODE_REG" )
	sCodInter = This.GetItemString ( This.ilLigneClick, "COD_INTER" )

	If sCodMotReg <> "RN" Then bOk = False
End If

/*------------------------------------------------------------------*/
/* #1 Fin premiers contr$$HEX1$$f400$$ENDHEX$$le													  */
/*------------------------------------------------------------------*/
If Not bOk Then
	For	lCpt = 5 To 11
			This.Uf_Mnu_CacherItem ( lCpt )
	Next

	stMessage.sTitre		= "R$$HEX1$$e900$$ENDHEX$$gul. Impossible"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "REGU150"
	F_Message (stMessage) 
	Return
End If

/*------------------------------------------------------------------*/
/* On ne peut saisir qu'une seule r$$HEX1$$e900$$ENDHEX$$gularisation $$HEX2$$e0002000$$ENDHEX$$la fois.         */
/*------------------------------------------------------------------*/
If	dw_Regul_FF.RowCount () > 0	Then 
	For	lCpt = 5 To 11
			This.Uf_Mnu_CacherItem ( lCpt )
	Next

	Return
End If

/*------------------------------------------------------------------*/
/* On va d'abord modifier tous les libell$$HEX1$$e900$$ENDHEX$$s des menus.              */
/*------------------------------------------------------------------*/
This.Uf_Mnu_ChangerText ( 5, "RI Repr$$HEX1$$e900$$ENDHEX$$sentation Impay$$HEX1$$e900$$ENDHEX$$s sur R$$HEX1$$e900$$ENDHEX$$glement de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence N$$HEX1$$b000$$ENDHEX$$" + String ( This.ilLigneClick ) + "/" + sCodMotReg + "/" + sCodModeReg + "/" + sCodInter )   // Code 1
This.Uf_Mnu_ChangerText ( 6, "-" )

This.Uf_Mnu_ChangerText ( 7, "RM $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$duire sur garantie sur R$$HEX1$$e900$$ENDHEX$$glement de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence N$$HEX1$$b000$$ENDHEX$$" + String ( This.ilLigneClick ) + "/" + sCodMotReg + "/" + sCodModeReg + "/" + sCodInter )  // Code 2
This.Uf_Mnu_ChangerText ( 8, "RM $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$duire sur frais sur R$$HEX1$$e900$$ENDHEX$$glement de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence N$$HEX1$$b000$$ENDHEX$$" + String ( This.ilLigneClick ) + "/" + sCodMotReg + "/" + sCodModeReg + "/" + sCodInter )    // Code 3
This.Uf_Mnu_ChangerText ( 9, "-" )

This.Uf_Mnu_ChangerText ( 10, "RP $$HEX2$$e0002000$$ENDHEX$$ajouter sur garantie sur R$$HEX1$$e900$$ENDHEX$$glement de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence N$$HEX1$$b000$$ENDHEX$$" + String ( This.ilLigneClick ) + "/" + sCodMotReg + "/" + sCodModeReg + "/" + sCodInter )  // Code 4
This.Uf_Mnu_ChangerText ( 11, "RP $$HEX2$$e0002000$$ENDHEX$$ajouter sur frais sur R$$HEX1$$e900$$ENDHEX$$glement de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence N$$HEX1$$b000$$ENDHEX$$" + String ( This.ilLigneClick ) + "/" + sCodMotReg + "/" + sCodModeReg + "/" + sCodInter )     // Code 5

/*------------------------------------------------------------------*/
/* On fait apparaitre les menus.                                    */
/*------------------------------------------------------------------*/
For	lCpt = 5 To 11
		This.Uf_Mnu_MontrerItem ( lCpt )
Next

/*------------------------------------------------------------------*/
/* RI/RP/RM sur Frais Impossible si CodModeReg="FM"                 */
/*------------------------------------------------------------------*/
If sCodModeReg = "FM" Then 
	This.Uf_Mnu_CacherItem ( 5 )
	This.Uf_Mnu_CacherItem ( 6 )
	This.Uf_Mnu_CacherItem ( 8 )
   This.Uf_Mnu_CacherItem ( 11 )
End If

/*------------------------------------------------------------------*/
/* Attention s'il n'existe aucun r$$HEX1$$e800$$ENDHEX$$glement pour le sinistre         */
/* ilLigneClick est NULL.                                           */
/*------------------------------------------------------------------*/
If	This.ilLigneClick > 0	Then
	sCodMotReg = This.GetItemString ( This.ilLigneClick, "COD_MOT_REG" )

	If	sCodMotReg <> "RN"	Then
		This.Uf_Mnu_CacherItem ( 5 )
		This.Uf_Mnu_CacherItem ( 6 )
	End If
End If

/*------------------------------------------------------------------*/
/* On ne peut saisir un RM que si MT_REG > 0.                       */
/*------------------------------------------------------------------*/
dcMtReg = dw_1.GetItemDecimal ( 1, "MT_REG" )
If	dcMtReg <= 0	Then
	This.Uf_Mnu_CacherItem ( 5 )
	This.Uf_Mnu_CacherItem ( 6 )

	This.Uf_Mnu_CacherItem ( 7 )
	This.Uf_Mnu_CacherItem ( 8 )
	This.Uf_Mnu_CacherItem ( 9 )
End If

/*------------------------------------------------------------------*/
/* On ne peut pas saisir un RM (Frais) s'il n'y a pas de frais.     */
/*------------------------------------------------------------------*/
lTotFrais = dw_Frais.RowCount ()
If	lTotFrais = 0	Then
	This.Uf_Mnu_CacherItem ( 8 )
End If

/*------------------------------------------------------------------*/
/* On ne peut pas saisir un RM (Garantie) s'il n'y a aucune         */
/* garantie (Hors Frais) dans REG_GTI.                              */
/*------------------------------------------------------------------*/
sFiltre = ""
dw_Reg_Gti.SetFilter ( sFiltre )
dw_Reg_Gti.Filter ()

lTotGti = dw_Reg_Gti.RowCount ()
bGti = False
For	lCpt = 1 To lTotGti
		lIdGti = dw_Reg_Gti.GetItemNumber ( lCpt, "ID_GTI" )
		If	lIdGti = -1	Then 
			Continue
		Else
			bGti = True
			Exit
		End If
Next

If	Not bGti	Then
	This.Uf_Mnu_CacherItem ( 7 )
End If


end event

type dw_inter from datawindow within w_tm_sp_regul
integer x = 1449
integer y = 324
integer width = 530
integer height = 460
boolean bringtotop = true
string dataobject = "d_sp_inter_regul"
boolean vscrollbar = true
boolean border = false
end type

type dw_produit from datawindow within w_tm_sp_regul
boolean visible = false
integer x = 256
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_produit"
end type

type dw_w_queue from datawindow within w_tm_sp_regul
boolean visible = false
integer x = 535
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_w_queue_regul"
end type

type dw_w_a_virer from datawindow within w_tm_sp_regul
boolean visible = false
integer x = 814
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_w_a_virer_regul"
end type

type dw_frais from datawindow within w_tm_sp_regul
boolean visible = false
integer x = 1093
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_frais_regul"
end type

type dw_reg_gti from datawindow within w_tm_sp_regul
boolean visible = false
integer x = 1371
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_reg_gti_regul"
end type

type dw_regul_ff from u_datawindow within w_tm_sp_regul
integer x = 2153
integer y = 324
integer width = 530
integer height = 460
integer taborder = 0
boolean enabled = false
string dataobject = "d_sp_detail_saisie_regul"
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
end type

