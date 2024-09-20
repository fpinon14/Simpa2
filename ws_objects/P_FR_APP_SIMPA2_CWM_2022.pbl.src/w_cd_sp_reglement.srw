$PBExportHeader$w_cd_sp_reglement.srw
forward
global type w_cd_sp_reglement from w_8_ancetre_consultation
end type
type dw_1 from u_datawindow within w_cd_sp_reglement
end type
type dw_reg_gti from u_datawindow within w_cd_sp_reglement
end type
type dw_reg_frais from u_datawindow within w_cd_sp_reglement
end type
type uo_consult_euro from u_consultation_euro within w_cd_sp_reglement
end type
type st_1 from statictext within w_cd_sp_reglement
end type
type cb_frais_anx from commandbutton within w_cd_sp_reglement
end type
end forward

global type w_cd_sp_reglement from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
boolean controlmenu = false
boolean minbox = false
event ue_taillefenetre ( )
dw_1 dw_1
dw_reg_gti dw_reg_gti
dw_reg_frais dw_reg_frais
uo_consult_euro uo_consult_euro
st_1 st_1
cb_frais_anx cb_frais_anx
end type
global w_cd_sp_reglement w_cd_sp_reglement

type variables
Private:
u_Cs_Sp_Reglement	iuoConsultation
end variables

forward prototypes
public function boolean wf_preparerconsulter ()
private subroutine wf_positionnerobjets ()
private subroutine wf_afficher_autre_montant (string asmonnaie)
public subroutine wf_traduction_mvt_financier ()
public subroutine wf_voirventilfraisanxfrn ()
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

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Reglement
//* Fonction		: wf_PreparerConsulter
//* Auteur			: FABRY JF
//* Date				: 03/12/1998 
//* Libellé			: Appel de uf_preparer_consulter
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------
//*      JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

Boolean 	bOk = True
String sMonnaie

bOk = iuoConsultation.Uf_Preparer_Consulter ()	

This.Title = istPass.sTab [ 1 ] 

/*------------------------------------------------------------------*/
/* On affiche le dernier type de monnaie connu.                     */
/*------------------------------------------------------------------*/
sMonnaie = istPass.sTab [ 2 ]
Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

Wf_Afficher_Autre_Montant ( sMonnaie )

st_1.Visible = False
st_1.Visible = True
wf_Traduction_Mvt_Financier () 

// [PM80_FA12_FRANEX]
cb_frais_anx.visible = SQLCA.PS_S02_REG_FRAIS_ANNEXE_FRN ( dw_1.GetItemNumber ( 1, "ID_SIN" ) , dw_1.GetItemNumber ( 1, "ID_REG") ) > 0 

Return ( bOk )
end function

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_cd_sp_Inter::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 21/07/1998
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord3d qui est positionné et taillé
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : Dw règlement sur Fenêtre Règlement            */
/*------------------------------------------------------------------*/
Dw_1.X				=   80
Dw_1.Y				=  200
Dw_1.Width			= 1564
Dw_1.Height			= 1225

/*------------------------------------------------------------------*/
/* Dw_Reg_Gti  DataWindow : Dw règlement par garantie sur  			  */	
/* Fenêtre Règlement            												  */
/*------------------------------------------------------------------*/
Dw_Reg_Gti.X		= Dw_1.Width + 150
Dw_Reg_Gti.Y		= Dw_1.Y
Dw_Reg_Gti.Width	= 1830
Dw_Reg_Gti.Height	= 750

/*------------------------------------------------------------------*/
/* Dw_Reg_Gti  DataWindow : Dw règlement par garantie sur  			  */	
/* Fenêtre Règlement            												  */
/*------------------------------------------------------------------*/
Dw_Reg_Frais.X			= Dw_1.Width + 150
Dw_Reg_Frais.Y			= Dw_Reg_Gti.Y + Dw_Reg_Gti.Height + 71
Dw_Reg_Frais.Width	= 1830
Dw_Reg_Frais.Height	= 650

cb_frais_anx.X		   = Dw_1.Width + 150
cb_frais_anx.Y			= Dw_Reg_Gti.Y + Dw_Reg_Gti.Height + 340
cb_frais_anx.Width	= 1780
cb_frais_anx.Height	= 350


end subroutine

private subroutine wf_afficher_autre_montant (string asmonnaie);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Cd_Sp_Reglement::Wf_Afficher_Autre_Montant (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/03/1999 14:12:22
//* Libellé			: 
//* Commentaires	: Affichage des colonnes calculées au bon format
//*
//* Arguments		: String			asMonnaie			(Val)	Valeur de la monnaie
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 PHG	15/02/2008	[SUISSE].LOT3 : Gestion Dynamique de la Monnaie
String sFormat1, sFormat2


// #1 [SUISSE].LOT3 Gestion Dynamique de la Monnaie
Choose Case asMonnaie
	Case "F"
		sFormat1 = "TOT_GTI.Format='#,##0.00 \F'"
		sFormat2 = "TOT_FRAIS.Format='#,##0.00 \F'"
	Case stGlb.sMonnaieFormatDesire
		sFormat1 = "TOT_GTI.Format='#,##0.00 \"+stGlb.sMonnaiesymboleDesire+"'"
		sFormat2 = "TOT_FRAIS.Format='#,##0.00 \"+stGlb.sMonnaiesymboleDesire+"'"
	Case Else
		sFormat1 = "TOT_GTI.Format='#,##0.00 \€'"
		sFormat2 = "TOT_FRAIS.Format='#,##0.00 \€'"
End Choose

dw_Reg_Gti.Modify ( sFormat1 )
dw_Reg_Frais.Modify ( sFormat2 )
end subroutine

public subroutine wf_traduction_mvt_financier ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Reglement
//* Fonction		: wf_Traduction_Mvt_Financier
//* Auteur			: FABRY JF
//* Date				: 14/12/2016
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------
//       JFF   07/08/2019 [PM462-1][V3]
//*-----------------------------------------------------------------

String sCodModeReg, sCodMotReg, sLibInter, sNomInter, sTxtOrig, sLibReg


sCodModeReg = dw_1.GetItemString ( 1, "COD_MODE_REG" )
sCodMotReg = dw_1.GetItemString ( 1, "COD_MOT_REG" )
sLibInter	= dw_1.Describe ( "Evaluate ( 'LookUpDisplay ( COD_INTER )', 1) " ) 
sNomInter	= dw_1.Describe ( "Evaluate ( 'LookUpDisplay ( ID_I )', 1) " ) 
sLibReg     = dw_1.GetItemString ( 1, "LIB_REG" ) // [PM462-1][V3]

st_1.Text = ""

Choose Case TRUE
	Case sCodMotReg = "RI"
		st_1.Text = "Suite rejet de la banque, SPB représente le règlement du RN de référence à " + sNomInter + ", du même montant, mais ne génère aucun mouvement financier vers l'assureur." 
		
		
	Case sCodMotReg = "RP" And sCodModeReg = "FM"
		st_1.Text = "SPB réclame ce montant à l'assureur et règle le fournisseur " + sNomInter + " de ce même montant." 
		
		
	Case sCodMotReg = "RM" And sCodModeReg = "FM"		

		st_1.Text = "SPB redonne ce montant à l'assureur et déduit ce montant du prochain règlement au fournisseur " + sNomInter + "."		
		
		
	Case sCodMotReg = "RP" And sCodModeReg = "C"	And sLibInter = "FOURN."

		st_1.Text = "SPB réclame ce montant à l'assureur mais ne génère aucun mouvement financier vers le fournisseur " + sNomInter + "."		
		
	Case sCodMotReg = "RM" And sCodModeReg = "C" And sLibInter = "FOURN."

		st_1.Text = "SPB redonne ce montant à l'assureur mais ne génère aucun mouvement financier vers le fournisseur " + sNomInter + "."		

	Case sCodMotReg = "RP" And sCodModeReg = "C"	
		
		st_1.Text = "SPB réclame ce montant à l'assureur mais ne génère aucun mouvement financier vers " + sNomInter + "."		

	Case sCodMotReg = "RP" And sCodModeReg = "XA"	And sLibInter = "FOURN."

		st_1.Text = "SPB réclame ce montant à l'assureur pour maj du dossier uniquement, sans mvt financier réél, mais ne génère aucun mouvement financier vers le fournisseur " + sNomInter + "."		
		
	Case sCodMotReg = "RM" And sCodModeReg = "XA" And sLibInter = "FOURN."

		st_1.Text = "SPB redonne ce montant à l'assureur pour maj du dossier uniquement, sans mvt financier réél, mais ne génère aucun mouvement financier vers le fournisseur " + sNomInter + "."		

	Case sCodMotReg = "RP" And sCodModeReg = "XA"	
		
		st_1.Text = "SPB réclame ce montant à l'assureur pour maj du dossier uniquement, sans mvt financier réél, mais ne génère aucun mouvement financier vers " + sNomInter + "."		
		
	Case sCodMotReg = "RM" And sCodModeReg = "XA"			

		st_1.Text = "SPB redonne ce montant à l'assureur pour maj du dossier uniquement, sans mvt financier réél, mais ne génère aucun mouvement financier vers le fournisseur " + sNomInter + "."		
				

	Case sCodMotReg = "RM" And sCodModeReg = "C"			

		st_1.Text = "SPB redonne ce montant à l'assureur mais ne génère aucun mouvement financier vers " + sNomInter + "."				
		
	Case sCodMotReg = "RN" And sCodModeReg = "FM"		

		st_1.Text = "SPB régle le fournisseur " + sNomInter + ", ce montant sera donc réclamé à l'assureur."

	Case sCodMotReg = "RN" And sCodModeReg = "XA" And sLibInter = "FOURN."		 

		st_1.Text = "SPB régle le fournisseur " + sNomInter + " pour maj du dossier uniquement, sans mvt financier réél, ce montant ne sera donc pas réclamé à l'assureur."
			
	Case sCodMotReg = "RN" And sCodModeReg = "XA" 	 

		st_1.Text = "SPB régle " + sNomInter + " pour maj du dossier uniquement, sans mvt financier réél, ce montant ne sera donc pas réclamé à l'assureur."		

	Case sCodMotReg = "RN" 

		st_1.Text = "SPB régle " + sNomInter + ", ce montant sera donc réclamé à l'assureur."		

	// [PM462-1][V3]
	Case sCodMotReg = "PF" And sCodModeReg = "CB"		

		st_1.Text = sNomInter + " a payé à SPB sa franchise par Carte Bancaire à partir de l'extranet (mvt financier pour mémoire non transmis à l'assureur)."

	// [PM462-1][V3]
	Case sCodMotReg = "RF" And sCodModeReg = "CB"		

		st_1.Text = "SPB régularise le remboursement. de franchise que l'assuré " + sNomInter + " avait payé à SPB par Carte Bancaire (type PF) à partir de l'extranet et qui lui a été remboursé par un virement ou chèque (mvt financier pour mémoire annulant le PF non transmis à l'assureur)."				
		
End Choose 

end subroutine

public subroutine wf_voirventilfraisanxfrn ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Reglement
//* Fonction		: wf_VoirVentilFraisAnxFrn
//* Auteur			: FABRY JF
//* Date				: 14/10/2022
//* Libellé			: 
//* Commentaires	: [PM80_FA12_FRANEX]
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------

s_Pass stPass
DateTime dtCreeLe, dtPivotMepPm80
stPass.lTab[1] = dw_1.GetItemNumber ( 1, "ID_SIN" )
stPass.lTab[2] = dw_1.GetItemNumber ( 1, "ID_REG" )

dtCreeLe = dw_1.GetItemDateTime ( 1, "CREE_LE" ) 

If SQLCA.PS_S03_REG_FRAIS_ANNEXE_FRN ( stPass.lTab[1] , stPass.lTab[2], dtPivotMepPm80 ) <= 0 Then
	stMessage.sTitre		= "Aucun frais annexe"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= False

	If  dtCreeLe < dtPivotMepPm80 Then 
		stMessage.sCode	= "GENE186"
		stMessage.sVar [1]= String ( dtCreeLe, "dd/mm/yyyy à hh:mm:ss" ) 
		stMessage.sVar [2]= String ( dtPivotMepPm80, "dd/mm/yyyy à hh:mm:ss" ) 
	Else 
		stMessage.sCode	= "GENE187"		
	End IF 
	stMessage.bTrace  	= False
	
	F_Message ( stMessage )	
	
	Return
End If 

OpenWithParm( w_cd_sp_reg_annexes, stPass )

stPass = Message.Powerobjectparm


end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_Cd_Sp_Reglement
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	JFF
//* Date				:	07/12/1998
//* Libellé			:	Initialisation de la fenêtre de consultation  
//*					 	des réglements
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   05/02/2018 [PM360-2]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwNorm[3]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Positionnement des objets de la fenêtre                          */
/*------------------------------------------------------------------*/
wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* Déclaration du nvuo liée à la fenêtre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Reglement

/*------------------------------------------------------------------*/
/* Sur fenêtre Sinistre															  */
/*	stPass.sTab   [ 1 ]	= This.Title										  */
/* stPass.dwMaster		= dw_1				// DataWindow Sinistre	  */
/*  																					  */
/*	stPass.dwNorm [ 1 ]	= dw_Reglement		// DataWindow Reglement   */
/*	stPass.dwNorm [ 2 ]	= dw_Inter			// DataWindow Inter		  */
/*	stPass.dwNorm [ 3 ]  = dw_Reg_Gti 		// DataWindow Reg_Gti	  */	
/*	stPass.dwNorm [ 4 ]  = dw_Gti 			// DataWindow Gti			  */	
/*	stPass.dwNorm [ 5 ]  = dw_Frais 			// DataWindow Frais		  */	
/*------------------------------------------------------------------*/
// [PM360-2]
iuoConsultation.uf_Init_Reglement (	iTrTrans,				&
												istPass.dwMaster,		&
										   	istPass.dwNorm[1],	&
										   	istPass.dwNorm[2],	&
										   	istPass.dwNorm[3],	&
										   	istPass.dwNorm[4],	&
										   	istPass.dwNorm[5],	&
										   	Dw_1,						&
												Dw_Reg_Gti,				&
												Dw_Reg_Frais,			&
												istPass.uDwTab [1]   &
												)


/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Reg_Gti
dwNorm [ 3 ] = dw_Reg_Frais

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cd_Sp_Reglement
//* Evenement 		: We_ChildActivate
//* Auteur			: FABRY JF
//* Date				: 03/12/1998
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

on w_cd_sp_reglement.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_reg_gti=create dw_reg_gti
this.dw_reg_frais=create dw_reg_frais
this.uo_consult_euro=create uo_consult_euro
this.st_1=create st_1
this.cb_frais_anx=create cb_frais_anx
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_reg_gti
this.Control[iCurrent+3]=this.dw_reg_frais
this.Control[iCurrent+4]=this.uo_consult_euro
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_frais_anx
end on

on w_cd_sp_reglement.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_reg_gti)
destroy(this.dw_reg_frais)
destroy(this.uo_consult_euro)
destroy(this.st_1)
destroy(this.cb_frais_anx)
end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Reglement
//* Evenement 		:	Close
//* Auteur			:	FABRY JF
//* Date				:	03/12/1998
//* Libellé			:	Opérations à effectuer à la fermeture de la 
//*					 	fenêtre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iuoConsultation
end on

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet 			: Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		 Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )



end event

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cd_sp_reglement
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cd_sp_reglement
boolean visible = false
integer x = 2866
integer y = 24
integer width = 206
long backcolor = 8421376
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cd_sp_reglement
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 40
end type

type dw_1 from u_datawindow within w_cd_sp_reglement
integer x = 46
integer y = 164
integer width = 489
integer height = 476
integer taborder = 30
string dataobject = "d_sp_c_detail_reglement"
boolean border = false
end type

type dw_reg_gti from u_datawindow within w_cd_sp_reglement
integer x = 585
integer y = 160
integer width = 489
integer height = 476
integer taborder = 20
string dataobject = "d_sp_c_reg_gti"
boolean vscrollbar = true
boolean border = false
end type

type dw_reg_frais from u_datawindow within w_cd_sp_reglement
integer x = 1161
integer y = 160
integer width = 489
integer height = 476
integer taborder = 10
string dataobject = "d_sp_c_reg_gti_frais"
boolean vscrollbar = true
boolean border = false
end type

type uo_consult_euro from u_consultation_euro within w_cd_sp_reglement
integer x = 251
integer y = 8
integer taborder = 50
end type

on ue_changer_monnaie;call u_consultation_euro::ue_changer_monnaie;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Consult_Euro::Ue_Changer_Monnaie
//* Evenement 		: Ue_Changer_Monnaie
//* Auteur			: Erick John Stark
//* Date				: 29/03/1999 12:07:52
//* Libellé			: 
//* Commentaires	: Dans cette fenêtre, il a deux zones calculées
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

sMonnaie = This.Uf_Recuperer_Monnaie_Courante ()

Wf_Afficher_Autre_Montant ( sMonnaie )
end on

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type st_1 from statictext within w_cd_sp_reglement
integer x = 91
integer y = 1348
integer width = 1545
integer height = 292
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 15793151
string text = "Traduction réelle de ce mouvement financier"
boolean border = true
boolean focusrectangle = false
end type

type cb_frais_anx from commandbutton within w_cd_sp_reglement
integer x = 1682
integer y = 1200
integer width = 1623
integer height = 436
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Voir la ventilation des frais annexes fournisseurs"
end type

event clicked;Parent.wf_VoirVentilFraisAnxFrn ()
end event

