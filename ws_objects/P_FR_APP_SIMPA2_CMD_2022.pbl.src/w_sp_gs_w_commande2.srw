$PBExportHeader$w_sp_gs_w_commande2.srw
$PBExportComments$Fenêtre au niveau affichant le résumé d'une commande.
forward
global type w_sp_gs_w_commande2 from w_8_traitement_master
end type
type dw_client from u_datawindow within w_sp_gs_w_commande2
end type
type uo_consult_euro from u_consultation_euro within w_sp_gs_w_commande2
end type
type pb_annuler from picturebutton within w_sp_gs_w_commande2
end type
type dw_cmd_frn from u_datawindow within w_sp_gs_w_commande2
end type
type cb_dern from commandbutton within w_sp_gs_w_commande2
end type
type cb_prem from commandbutton within w_sp_gs_w_commande2
end type
type cb_prec from commandbutton within w_sp_gs_w_commande2
end type
type cb_suiv from commandbutton within w_sp_gs_w_commande2
end type
type aff_pg_cmd_t from statictext within w_sp_gs_w_commande2
end type
type cb_commune_livr from commandbutton within w_sp_gs_w_commande2
end type
type cb_commune_fact from commandbutton within w_sp_gs_w_commande2
end type
type cb_imei from commandbutton within w_sp_gs_w_commande2
end type
type cb_maj_presta from commandbutton within w_sp_gs_w_commande2
end type
type st_mode_reprise from statictext within w_sp_gs_w_commande2
end type
type cb_aide_mode_reprise from commandbutton within w_sp_gs_w_commande2
end type
type cb_modif_adr from commandbutton within w_sp_gs_w_commande2
end type
type mle_comment_frn from multilineedit within w_sp_gs_w_commande2
end type
type mle_info_frn_spb_cplt from multilineedit within w_sp_gs_w_commande2
end type
type mle_info_spb_frn_cplt from multilineedit within w_sp_gs_w_commande2
end type
type dw_ann_cmde from datawindow within w_sp_gs_w_commande2
end type
end forward

global type w_sp_gs_w_commande2 from w_8_traitement_master
integer x = 1075
integer y = 481
integer width = 3648
integer height = 1836
event ue_taillefenetre ( )
dw_client dw_client
uo_consult_euro uo_consult_euro
pb_annuler pb_annuler
dw_cmd_frn dw_cmd_frn
cb_dern cb_dern
cb_prem cb_prem
cb_prec cb_prec
cb_suiv cb_suiv
aff_pg_cmd_t aff_pg_cmd_t
cb_commune_livr cb_commune_livr
cb_commune_fact cb_commune_fact
cb_imei cb_imei
cb_maj_presta cb_maj_presta
st_mode_reprise st_mode_reprise
cb_aide_mode_reprise cb_aide_mode_reprise
cb_modif_adr cb_modif_adr
mle_comment_frn mle_comment_frn
mle_info_frn_spb_cplt mle_info_frn_spb_cplt
mle_info_spb_frn_cplt mle_info_spb_frn_cplt
dw_ann_cmde dw_ann_cmde
end type
global w_sp_gs_w_commande2 w_sp_gs_w_commande2

type variables
Private:

n_cst_w_commande2	invCmd

String			isTypeTrt
Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N

DataWindow		idwAutorisation 	//* [DCMP080479]
DataWindow		idw_wDetail  // [ANN_RPC_NRGLT]

end variables

forward prototypes
public function boolean wf_preparermodifier ()
public subroutine wf_positionnerobjets ()
public function boolean wf_controler ()
private subroutine wf_tb_consultation ()
public function boolean wf_preparervalider ()
public subroutine wf_activation_maj_presta_manuelle (boolean abactiver)
public function string wf_format_affichage_zone (string astab[], integer ailongueur, string assepaajouter)
public function string wf_format_affichage_zone (string aschaine, long allongueur)
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

// This.Height = 1810// [PB2022_TAILLE_FEN] Je commente
end event

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
//* MAJ PAR		Date		Modification
//*				  
//* #1  CAG		03/06/03 Ajout de la zone ID_ANN : désormais le bouton
//*							annuler n'est plus disponible si l'état ne le permet pas
//*							( avant, msg + blocage )
//* #2  CAG		30/09/04 DCMP 040349 : Seuls les utilisateurs dont le niveau
//*								opérateur est au moins AU peuvent supprimer une cmde
//* #3  JFF	   06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #4  JCA	   27/02/2007		DCMP 070085 - Permettre annulation du flux émis vers C-Discount
//* #5  JFF    20/06/2008 [DCMP080479]
//*	  FPI    22/07/2010 [PC321] Autorisation de modifier la commande pour SCR
//*     JFF    14/09/2011 [VDOC5013]
//*     FPI    07/10/2011 [VDOC5312] Ajout du droit d'annulation de presta 221
//*     JFF    09/12/2011 [VDOC6164] Autrosier 213 à annuler PEC_A_RECYCLER en RFO
//		FPI	23/05/2012	[PM103] Affichage du btn cb_maj_presta
//      JFF   23/05/2012 [PM103][1]
//		FPI	11/06/2012	[PM103][FPI] Ajout autorisation 224
//    JFF   19/11/2012  [PC543][MANTIS5739]
//    JFF   16/05/2014  [VDOC14180]
//		FPI	07/11/2014	[VDOC15529]
//		JFF   04/06/2015  [ANN_RPC_NRGLT]
//		JFF   23/08/2016  [ETAT_153_SUR_ANN_2AC]
//		FPI	14/10/2016	[PC151255]
//*-----------------------------------------------------------------

String	sMonnaie, sCodEtat, sIdRefFour, sIdTypArt, sIdFour, sMod
Long lIdProcess, lNb, lPos, lRow
n_cst_string lnvPFCString
Boolean bPrestaRepBaseMan, bPasseDroit 
String sVal
n_cst_string nvString
String sTab[], sTab2[]
Integer iCpt, iNbCar


/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

// CAG : 19/05/2003 : Gestion des boutons + affichage des dw dans le nvuo
//dw_1.Show ()
//dw_Client.Hide ()
cb_Suiv.Enabled = True
cb_Prec.Enabled = False

invCmd.Uf_PreparerModifier ( istPass )

If isTypeTrt = "S" then 

	pb_Controler.Enabled = dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) <= 0
	
	/*------------------------------------------------------------------*/
	/* #2 CAG : 30/09/2004                                              */
	/*------------------------------------------------------------------*/
	pb_Supprimer.Enabled = dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) <= 0 And stGlb.sTypOper >= "3" 
	/*------------------------------------------------------------------*/
	/* #1 CAG : 03/06/2003                                              */
	/*------------------------------------------------------------------*/
	sCodEtat = Dw_1.GetItemString ( 1, "COD_ETAT" )
	sIdTypArt = Dw_1.GetItemString ( 1, "ID_TYP_ART" )
	sIdFour 	= Dw_1.GetItemString ( 1, "ID_FOUR" )
	
	Choose Case sCodEtat
		// #4 ajout de "DEF" wf_GetAutorisation
		// [VDOC5013] Ajout "ECL"
		// [PC543][MANTIS5739] RPC
		Case "RCF", "ECT", "CWE", "DEF", "ECL", "RPC", "RFO"

			bPasseDroit = False
			lIdProcess=dw_1.GetItemNumber ( 1, "INFO_SPB_FRN" )  			

			// [PC543][MANTIS5739]
			If sCodEtat = "RPC" Then
				
				// Passe droit permettant l'annulation par Process pour un RPC
				Choose Case lIdProcess
					Case 2010
						bPasseDroit = True

					Case Else
						
						// [VDOC14180]
						Choose Case True
							Case sIdTypArt = "CAF" And sIdFour = "AUC"
								bPasseDroit = True
							Case sIdTypArt = "CAF" And sIdFour = "ELD"
								bPasseDroit = True
							Case sIdTypArt = "CAF" And sIdFour = "CMA"
								bPasseDroit = True
							Case sIdFour = "CAR" // Sur demande de Perrine et accord JFF Le 15/05/20
								bPasseDroit = True								
							Case Else
								pb_Annuler.Enabled = False
								dw_Ann_Cmde.Visible = False
						End Choose 
				End Choose
				
				// [ANN_RPC_NRGLT]
				// ON permet l'annulation d'une presta RPC si le détail associé n'est pas réglé.
				lRow = idw_wDetail.Find ( "ID_GTI = " + String ( dw_1.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
												 "ID_DETAIL = " + String ( dw_1.GetItemNumber ( 1, "ID_DETAIL" ) ) &
											  , 1, idw_wDetail.RowCount ( ) ) 
				If lRow > 0 Then
					If sCodEtat = "RPC" And idw_wDetail.GetItemNumber ( lRow, "COD_ETAT" ) <> 600 Then
						bPasseDroit = True
					End If
				End If
				
			End If

			If sCodEtat <> "RPC" Or bPasseDroit Then

				pb_Annuler.Enabled = dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 //* #5  [DCMP080479]
	
				// #5  [DCMP080479] wf_GetAutorisation (213) remplace stGlb.sTypOper >= "3"
				// [VDOC5312] Ajout du contrôle sur Autorisation 221
				dw_Ann_Cmde.Visible = dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 And &
											  ( invCmd.uf_GetAutorisation (213) Or &
												 Upper ( Dw_1.GetItemString ( 1, "ID_FOUR" ) ) = "WBA"  or &
												invCmd.uf_GetAutorisation_221 (lIdProcess)) // #3
			End If 

			
		// [VDOC6164]
		Case "RFO"
			sIdRefFour = dw_1.GetItemString ( 1, "ID_REF_FOUR" )

			Choose Case sIdRefFour 
				Case "PEC_A_RECYCLER", "A_DIAGNOSTIQUER", "A_REPARER_FORCE", "REFUSE_A_REEXP"
					pb_Annuler.Enabled = dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 
					
				Case Else						
					pb_Annuler.Enabled = False
					dw_Ann_Cmde.Visible = False
					
			End Choose 
			
		Case Else
			pb_Annuler.Enabled = False
			dw_Ann_Cmde.Visible = False
	End Choose

	// [PC321]
	If dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 and sCodEtat <> "RPC" and sCodEtat <> "ANN" Then
			Choose Case dw_1.getItemNumber(1, "INFO_SPB_FRN")
				Case 1415,1420,1425,1426, 1430, 2811,2830 // [PC151255]
					pb_Controler.Enabled=TRUE
			End Choose
		End if
	// :[PC321]
	
End If

/*------------------------------------------------------------------*/
/* On arme la valeur de la monnaie avec celle de la fenêtre de      */
/* SINISTRE. (En consultation uniquement).                          */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	sMonnaie = istPass.sTab [ 3 ]
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
End If

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = gbModeReprise_223
st_mode_reprise.Visible = gbModeReprise_223 
// :[PM103][1]

Dw_1.SetColumn ( "PROBLEME" )
Dw_1.SetFocus ()

// [PM103]
bPrestaRepBaseMan = lnvPFCString.of_getkeyvalue (dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" ), "PRESTA_REPRISE_BASE_MANUELLE", ";") = "OUI" And &
						  dw_1.GetItemString ( 1, "COD_ETAT" ) <> "CNV"

bPrestaRepBaseMan = 	bPrestaRepBaseMan And (gbModeReprise_223 Or invCmd.uf_GetAutorisation(224) ) // [PM103][FPI]

If bPrestaRepBaseMan Then
	wf_activation_maj_presta_manuelle( TRUE)
	cb_maj_presta.bringtotop=TRUE
	
	pb_Controler.Enabled = isTypeTrt = "S" And bPrestaRepBaseMan 
	
End If
// :[PM103]

// [VDoc15529]
sVal=dw_1.getItemString(1, "info_frn_spb_cplt")
if isnull(sVal) Then
	sVal=""
Else
	sVal=wf_format_affichage_zone(sVal, 60)
End if

mle_info_frn_spb_cplt.Text=sVal

// Comment_frn

sVal=dw_1.getItemString(1, "comment_frn")
if isnull(sVal) Then
	sVal=""
Else
	sVal=wf_format_affichage_zone(sVal, 60)
End if

mle_comment_frn.Text=sVal

//info_spb_frn_cplt
sVal=dw_1.getItemString(1, "info_spb_frn_cplt")
if isnull(sVal) Then
	sVal=""
Else
	sVal=wf_format_affichage_zone(sVal, 85)
End if

mle_info_spb_frn_cplt.Text=sVal
mle_info_spb_frn_cplt.BringToTop=TRUE

sMod = "B_TRACE_PRESTA.VISIBLE = 1"	

Return True

end function

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Positionnement des objets
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//* #2  CAG		26/05/03	Ajout de 2 boutons pour revenir directement à la 1ère ou dernière page
//* #3  CAG		03/06/03 Ajout de la zone ID_ANN = catégorie d'annulation
//      JFF   23/05/2012 [PM103][1]
//      JFF   13/01/2014 [PM246]
//		FPI	07/11/2014	[VDOC15529]
//*-----------------------------------------------------------------

dw_1.X				= 28
dw_1.Y				= 157
dw_1.Width			= 3566
dw_1.Height			= 1521


dw_Client.X			= dw_1.X
dw_Client.Y			= dw_1.Y
dw_Client.Width	= dw_1.Width
dw_Client.Height	= dw_1.Height

/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.X		= dw_1.X
dw_Cmd_Frn.Y		= dw_1.Y
dw_Cmd_Frn.Width	= dw_1.Width
dw_Cmd_Frn.Height	= dw_1.Height

/*------------------------------------------------------------------*/
/* #3 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
dw_Ann_Cmde.X			= 1239
dw_Ann_Cmde.Y			= 65
dw_Ann_Cmde.Width		= 992
dw_Ann_Cmde.Height	= 81

/*------------------------------------------------------------------*/
/* #2 : CAG 26/05/2003                                              */
/*------------------------------------------------------------------*/
cb_Prem.X			= 2849
cb_Prem.Y			=   29
cb_Prem.Width		=  161
cb_Prem.Height		=   65

cb_Prec.X			= 3013
cb_Prec.Y			=   29
cb_Prec.Width		=  161
cb_Prec.Height		=   65

cb_Suiv.X			= 3178
cb_Suiv.Y			=   29
cb_Suiv.Width		=  161
cb_Suiv.Height		=   65

cb_Dern.X			= 3342
cb_Dern.Y			=   29
cb_Dern.Width		=  161
cb_Dern.Height		=   65

aff_pg_cmd_t.X		= 3054
aff_pg_cmd_t.Y		=	 93

cb_commune_livr.x		= 1590
cb_commune_livr.y		= 930
cb_commune_livr.width	= 83
cb_commune_livr.height	= 73

cb_commune_fact.Hide ()   // Plus besoin pour l'instant, nous ne travaillons plus avec ARVATO.
cb_commune_fact.x		= 3365
cb_commune_fact.y		= 930
cb_commune_fact.width	= 83
cb_commune_fact.height	= 73

cb_Imei.x		= 1194
cb_Imei.y		= 1093
cb_Imei.width	= 590
cb_Imei.height	= 81


// [PM103][1]
st_mode_reprise.X = 2249
st_mode_reprise.Y = 8
st_mode_reprise.Width = 411
st_mode_reprise.Height = 136

cb_aide_mode_reprise.X = 2665
cb_aide_mode_reprise.Y = 4
cb_aide_mode_reprise.Width = 178
cb_aide_mode_reprise.Height = 140
// :[PM103][1]

// [PM246]
cb_modif_adr.visible = True
cb_modif_adr.X = 1800
cb_modif_adr.Y = 688
cb_modif_adr.Width = 978
cb_modif_adr.Height = 112


// [VDoc15529]
mle_info_spb_frn_cplt.visible=True
mle_info_spb_frn_cplt.text=""

mle_info_frn_spb_cplt.visible=True
mle_info_frn_spb_cplt.text=""

end subroutine

public function boolean wf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Positionnement des objets
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

String sPos
Int	 iRet

sPos = invCmd.uf_ControlerSaisie ()

If sPos <> "" Then

	If dw_Client.Visible Then
		cb_Suiv.Enabled = False
		cb_Prec.Enabled = True
		dw_Client.SetColumn ( sPos )
		dw_Client.Setfocus  ()
	End If 

	If dw_1.Visible Then
		cb_Suiv.Enabled = True
		cb_Prec.Enabled = False
		dw_1.SetColumn ( sPos )
		dw_1.Setfocus  ()
	End If 

End If

If sPos = "" Then 
	sPos = invCmd.uf_ControlerGestion ()

	If sPos <> "" Then
		If dw_Client.Visible Then
			cb_Suiv.Enabled = False
			cb_Prec.Enabled = True
			dw_Client.SetColumn ( sPos )
			dw_Client.Setfocus  ()
		End If 

		If dw_1.Visible Then
			cb_Suiv.Enabled = True
			cb_Prec.Enabled = False
			dw_1.SetColumn ( sPos )
			dw_1.Setfocus  ()
		End If 
	End If 

End If

Return sPos = ""
end function

private subroutine wf_tb_consultation ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Gar_Sin::Wf_Tb_Consultation (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/07/1998 15:44:13
//* Libellé			: 
//* Commentaires	: On est en validation/Consultation, on rend les boutons invisibles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG		03/06/03 Ajout de la zone ID_ANN = catégorie d'annulation
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow dwNorm[1]
DataWindow dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur Ue_Initialiser de la fenêtre.     */
/*------------------------------------------------------------------*/

pb_Controler.Visible 	= False
pb_Controler.Enabled 	= False

pb_Valider.Visible 		= False
pb_Valider.Enabled 		= False

pb_Supprimer.Visible 	= False
pb_Supprimer.Enabled 	= False

pb_Imprimer.Visible 		= False
pb_Imprimer.Enabled 		= False

pb_Annuler.Visible		= False
pb_Annuler.Enabled  		= False

/*------------------------------------------------------------------*/
/* #1 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
dw_Ann_Cmde.Visible = False

Uo_Consult_Euro.X			= 252
Uo_Consult_Euro.Y			= 9

Uo_Consult_Euro.Visible	= False // [SUISSE].LOT3 Bouton Invisible
Uo_Consult_Euro.Enabled	= False // [SUISSE].LOT3

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )


end subroutine

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PreparerValider
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libellé			: 
//* Commentaires	: Opération avant validation
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


invCmd.uf_PreparerValider ( )

Return True
end function

public subroutine wf_activation_maj_presta_manuelle (boolean abactiver);//*-----------------------------------------------------------------
//*
//* Fonction		: W_sp_gs_w_commande2::wf_activation_maj_presta_manuelle
//* Auteur			: F. PINON	
//* Date				: 23/05/2012
//* Libellé			: 
//* Commentaires	: Affiche le bouton de maj presta manuelle
//*
//* Arguments		: True pour activer, False sinon
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
cb_maj_presta.visible=abActiver
end subroutine

public function string wf_format_affichage_zone (string astab[], integer ailongueur, string assepaajouter);//*-----------------------------------------------------------------
//*
//* Fonction      :w_sp_gs_w_commande2::wf_format_affichage_zone 
//* Auteur        : FPI
//* Date          : ?
//* Libellé       : Formatte une chaine pour les zones sur plusieurs lignes
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
String sVal
Integer iNbCar, iCpt

For iCpt=1 To UpperBound(asTab)
	iNbCar+=Len(asTab[iCpt])
	if iNbCar >=aiLongueur  Then
		if sVal <> "" Then sVal+="~r~n"
		iNbCar=Len(asTab[iCpt])
	End if
	sVal+=asTab[iCpt] + asSepAAjouter
Next

Return sVal
end function

public function string wf_format_affichage_zone (string aschaine, long allongueur);//*-----------------------------------------------------------------
//*
//* Fonction      :w_sp_gs_w_commande2::wf_format_affichage_zone 
//* Auteur        : FPI
//* Date          : ?
//* Libellé       : Formatte une chaine pour les zones sur plusieurs lignes
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

String sRetour=""
String sVal
String sTab[]
Long lPos, lIndex

if isnull(aschaine) Then return aschaine

If pos(aschaine," ") = 0 and pos(aschaine,";") =0 Then
	// Découpe à n car
	do while Len(asChaine) > allongueur
		sRetour+=Left(asChaine,alLongueur) + "~r~n"
		asChaine=Mid(asChaine, alLongueur +1)
	Loop
	sRetour+=asChaine
	
	Return sRetour
End if

// Découpe avec séparateur " " ou ";"
lIndex=1
do while asChaine <> ""

	lPos=pos(aschaine," ")
	if lPos=0 Then 
		lPos=pos(aschaine,";")
	Elseif pos(aschaine,";") > 0 Then
		lPos=Min(lPos,pos(aschaine,";"))
	End if
	
	if lPos=0 Then
		sTab[lIndex] = wf_format_affichage_zone( aschaine, allongueur)
		asChaine=""
	Else
		sVal=Left(asChaine,lPos - 1)
		sTab[lIndex] = wf_format_affichage_zone( sVal, allongueur)
		sTab[lIndex + 1] = Mid(asChaine, lPos,1)
		asChaine=Mid(asChaine, lPos +1)
		lIndex+=2
	End if
	
Loop

lPos=0
For lIndex=1 to UpperBound(sTab)
	
	If Mod(lIndex,2) = 0 Then
		sRetour+=sTab[lIndex]
		lPos++
		Continue
	End if
	
	lPos+=Len(sTab[lIndex])
	if lPos > alLongueur Then
		sRetour+="~r~n"
		lPos=Len(sTab[lIndex])
	End if
	sRetour+=sTab[lIndex]
Next

Return sRetour

end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//* #2  CAG		03/06/03 Ajout de la zone ID_ANN = catégorie d'annulation
//* #3  JFF		24/08/03 DCMP 030362 Gestion des communes
//* #4  JFF		01/09/03 Gestion des TAc_IMEI
//* #5  JFF    04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #6  JFF    20/06/2008 [DCMP080479]
//*  	  JFF	   13/04/2010 [WEBSIM2].[FRANCE]
//       JFF   13/01/2014 [PM246]
//		JFF   04/06/2015  [ANN_RPC_NRGLT]
//*-----------------------------------------------------------------

s_Pass	stPass
//Migration PB8-WYNIWYG-03/2006 FM
//u_Datawindow  dwPassageEuro [2]
u_Datawindow  dwPassageEuro []
//Fin Migration PB8-WYNIWYG-03/2006 FM
DataWindow	dwTab1, dwTab2, dwTab3
Long			lCpt

Wf_PositionnerObjets ()

Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )


/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
ibAltCommune = istPass.bTab[ 1 ]
stPass.bTab [1] = ibAltCommune 

If isTypeTrt = "C" Then Wf_Tb_consultation ()

pb_Controler.Visible = isTypeTrt = "S"
pb_Supprimer.Visible = isTypeTrt = "S"
pb_Valider.Visible = isTypeTrt = "S"
pb_Annuler.Visible = isTypeTrt = "S"
/*------------------------------------------------------------------*/
/* #2 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
dw_Ann_Cmde.Visible = isTypeTrt = "S"

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
invCmd = Create n_cst_w_commande2

stPass.dwMaster  = Dw_1  // Trt Cmde
stPass.dwMaster1 = dw_Client
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
stPass.udwTab [1] = dw_Cmd_Frn

stPass.dwTab [1] = istPass.dwTab [ 1 ]  // idw_LstCMde 
stPass.dwTab [2] = istPass.dwTab [ 2 ]  // idw_LstGti  
stPass.dwTab [ 3 ] = istPass.dwTab [ 3 ]	// dw_w_div_det  // #5
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On ajoute la DW DW_WDETAIL afin de controler que le détail       */
/* n'est pas A REGLER si l'on cherche à supprimer la commande liée  */
/* à ce détail.                                                     */
/*------------------------------------------------------------------*/
stPass.dwNorm [ 1 ]	= istPass.dwNorm [ 1 ]
idw_wDetail = stPass.dwNorm [ 1 ] // [ANN_RPC_NRGLT]

/*------------------------------------------------------------------*/
/* #2 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
stPass.dwNorm [2] = dw_Ann_Cmde
stPass.dwNorm [6] = istPass.dwNorm [6]  // #3 Passage de la dw des commune
stPass.dwNorm [7] = istPass.dwNorm [7]  // #4 Passage de la dw Tac_Imei
idwAutorisation   = istPass.dwNorm [8]  //* #6  [DCMP080479]
stPass.dwNorm [8] = istPass.dwNorm [8]  //* #6  [DCMP080479]
stPass.dwNorm [9] = istPass.dwNorm [9]  // [WEBSIM2].[FRANCE]

stPass.sTab [2]  = istPass.sTab [ 2 ]

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002 + CAG 12/09/02 : à compléter, dwTabX à initialiser */
/*------------------------------------------------------------------*/
invCmd.Uf_Initialiser_Dw ( istPass.dwNorm [ 4 ], istPass.dwNorm [ 5 ], FALSE )
invCmd.Uf_Initialiser_Dw_Sfr ( istPass.dwNorm [ 2 ], istPass.dwNorm [ 3 ], dwTab1, dwTab2, dwTab3, FALSE )

// [PM246]
invCmd.uf_Initialiser ( stPass, cb_Prec, cb_Suiv, cb_Prem, cb_Dern, cb_Commune_Livr, cb_Commune_Fact, cb_imei, aff_pg_cmd_t, cb_modif_adr )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1
/*------------------------------------------------------------------*/
/* #1 : CAG 19/05/2003                                              */
/*------------------------------------------------------------------*/
dwPassageEuro [ 2 ] = dw_cmd_frn

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro

return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

on ue_item6;call w_8_traitement_master::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_gs_w_commande2
//* Evenement     : ue_Item6
//* Auteur        : Fabry JF
//* Date          : 23/09/2003 17:22:30
//* Libellé       : Armement de l'IMEI de l'adhésion, corrigé
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

String sIMEIAdh, sIMEICorrige
Boolean bRet

sIMEIAdh = istPass.sTab [ 4 ]  

bRet = F_IMEI ( sIMEIAdh, sIMEICorrige )

/*------------------------------------------------------------------*/
/* Placement de l'IMEI Corrigé (ou pas) dans le clipboard.          */
/*------------------------------------------------------------------*/
ClipBoard ( sIMEICorrige )

/*------------------------------------------------------------------*/
/* S'il est bon sur l'adhésion												  */
/*------------------------------------------------------------------*/
If bRet Then
	stMessage.sCode		= "SFRP130"
	stMessage.sVar[1]		= sIMEICorrige 

/*------------------------------------------------------------------*/
/* S'il a été corrigé.                                              */
/*------------------------------------------------------------------*/
ElseIf Not bRet And sIMEICorrige <> "" Then
	stMessage.sCode		= "SFRP140"
	stMessage.sVar[1]		= sIMEICorrige 

/*------------------------------------------------------------------*/
/* Sinon                                                            */
/*------------------------------------------------------------------*/
Else 
	stMessage.sCode		= "SFRP150"

End If

stMessage.sTitre		= "Armement IMEI provenant de l'adhésion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


F_Message ( stMessage )


end on

on ue_item5;call w_8_traitement_master::ue_item5;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact
//* Evenement 		: ue_Item5
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: ANNULATION D'UNE COMMANDE.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Annulation d'une commande validée.                               */
/*------------------------------------------------------------------*/
If invCmd.uf_Annuler_Cmde () > 0 Then
	pb_Annuler.Enabled = FALSE
	pb_Valider.TriggerEvent ( "clicked" )
End If
end on

on ue_controler;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Controler
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des informations de la fenêtre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************

If	dw_1.AcceptText () > 0 Then

	If dw_Client.AcceptText () > 0 Then
		If wf_AcceptText() Then
			If wf_Controler () Then
				wf_Pb_Ctl_Vld ( 1 )
			End If
		End If

	Else
		dw_1.Hide ()
		dw_Client.Show ()
		cb_Suiv.Enabled = False
		cb_Prec.Enabled = True
		dw_client.SetFocus ()
	

	End If
Else
	dw_1.Show ()
	dw_Client.Hide ()
	cb_Suiv.Enabled = True
	cb_Prec.Enabled = False
	dw_1.SetFocus ()
End If
end on

event ue_supprimer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Ue_Supprimer (OVERRIDE!!)
//* Evenement 		: Ue_Supprimer
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF 04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*-----------------------------------------------------------------

Long lIdGti, lIdDetail

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	invCmd.uf_Bt_Supprimer_Cmd ( lIdGti, lIdDetail ) > 0	Then

	stMessage.sTitre = "Supprimer une commande"
	stMessage.sCode = "COMD017"
	stMessage.icon = Question!
	stMessage.bouton = YesNo!

	If F_Message ( stMessage ) = 1 Then 
		// #3 Mis à jour des données de prises en charge.
		invCmd.Uf_MajPec ( lIdGti, lIdDetail )

		Call Super::Ue_Supprimer
	End If

End If

end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Fabry JF
//* Date				: 04/09/01
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

on w_sp_gs_w_commande2.create
int iCurrent
call super::create
this.dw_client=create dw_client
this.uo_consult_euro=create uo_consult_euro
this.pb_annuler=create pb_annuler
this.dw_cmd_frn=create dw_cmd_frn
this.cb_dern=create cb_dern
this.cb_prem=create cb_prem
this.cb_prec=create cb_prec
this.cb_suiv=create cb_suiv
this.aff_pg_cmd_t=create aff_pg_cmd_t
this.cb_commune_livr=create cb_commune_livr
this.cb_commune_fact=create cb_commune_fact
this.cb_imei=create cb_imei
this.cb_maj_presta=create cb_maj_presta
this.st_mode_reprise=create st_mode_reprise
this.cb_aide_mode_reprise=create cb_aide_mode_reprise
this.cb_modif_adr=create cb_modif_adr
this.mle_comment_frn=create mle_comment_frn
this.mle_info_frn_spb_cplt=create mle_info_frn_spb_cplt
this.mle_info_spb_frn_cplt=create mle_info_spb_frn_cplt
this.dw_ann_cmde=create dw_ann_cmde
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_client
this.Control[iCurrent+2]=this.uo_consult_euro
this.Control[iCurrent+3]=this.pb_annuler
this.Control[iCurrent+4]=this.dw_cmd_frn
this.Control[iCurrent+5]=this.cb_dern
this.Control[iCurrent+6]=this.cb_prem
this.Control[iCurrent+7]=this.cb_prec
this.Control[iCurrent+8]=this.cb_suiv
this.Control[iCurrent+9]=this.aff_pg_cmd_t
this.Control[iCurrent+10]=this.cb_commune_livr
this.Control[iCurrent+11]=this.cb_commune_fact
this.Control[iCurrent+12]=this.cb_imei
this.Control[iCurrent+13]=this.cb_maj_presta
this.Control[iCurrent+14]=this.st_mode_reprise
this.Control[iCurrent+15]=this.cb_aide_mode_reprise
this.Control[iCurrent+16]=this.cb_modif_adr
this.Control[iCurrent+17]=this.mle_comment_frn
this.Control[iCurrent+18]=this.mle_info_frn_spb_cplt
this.Control[iCurrent+19]=this.mle_info_spb_frn_cplt
this.Control[iCurrent+20]=this.dw_ann_cmde
end on

on w_sp_gs_w_commande2.destroy
call super::destroy
destroy(this.dw_client)
destroy(this.uo_consult_euro)
destroy(this.pb_annuler)
destroy(this.dw_cmd_frn)
destroy(this.cb_dern)
destroy(this.cb_prem)
destroy(this.cb_prec)
destroy(this.cb_suiv)
destroy(this.aff_pg_cmd_t)
destroy(this.cb_commune_livr)
destroy(this.cb_commune_fact)
destroy(this.cb_imei)
destroy(this.cb_maj_presta)
destroy(this.st_mode_reprise)
destroy(this.cb_aide_mode_reprise)
destroy(this.cb_modif_adr)
destroy(this.mle_comment_frn)
destroy(this.mle_info_frn_spb_cplt)
destroy(this.mle_info_spb_frn_cplt)
destroy(this.dw_ann_cmde)
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Close
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy invCmd
end on

event ue_retour;call super::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_gs_w_commande2
//* Evenement 		: ue_retour
//* Auteur			: F. Pinon
//* Date				: 08/03/2011 08:32:26
//* Libellé			: 
//* Commentaires	: [PC321]
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 	FPI	13/08/2012	[PC796] Remboursement en numéraire
//*-----------------------------------------------------------------
Long lIdProcess
Long lDeb, lFin
String sVal
Datawindow dwDetPro
n_cst_string nvString

lIdProcess=dw_1.GetItemNumber( 1,"INFO_SPB_FRN")

If (lIdProcess = 1442  or lIdProcess=1443) And isTypeTrt = "S" Then
	stMessage.berreurg=FALSE
	stMessage.icon=Information!
	stMessage.bouton=Ok!
	stMessage.scode="COMD655"
	
	// [PC796]
	dwDetPro=invcmd.uf_get_dwdetpro( )
	f_rechdetpro(lDeb, lFin,dwDetPro ,invcmd.uf_get_idprod( ) , "-DP", 141)
	sVal =dwDetPro.GetItemString(lDeb,"VAL_CAR")
	sVal=nvString.of_getkeyvalue( sVal, "TYPE_RBT", ";")
	if sVal="NUMERAIRE" Then stMessage.scode="COMD735"
	// :[PC796]
	
	f_message(stMessage)
End if
end event

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
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )


end event

type cb_debug from w_8_traitement_master`cb_debug within w_sp_gs_w_commande2
end type

type dw_1 from w_8_traitement_master`dw_1 within w_sp_gs_w_commande2
integer x = 128
integer y = 216
integer width = 475
integer height = 432
integer taborder = 60
string dataobject = "d_gs_w_commande2"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;//*****************************************************************************
//
// Objet 		: w_Traitement::dw_1
// Evenement 	: Itemchanged
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************

// [MIGPB8COR] PHG
//invCmd.Uf_ControlerZone ( "DW_1", isNomCol, This.GetText () )
return invCmd.Uf_ControlerZone ( "DW_1", isNomCol, This.GetText () )


end event

event dw_1::itemerror;call super::itemerror;//*****************************************************************************
//
// Objet 		: w_Traitement::dw_1
// Evenement 	: ItemError
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************

// [MIGPB8COR] - PHG : Correction de la gestion de l'itemerror
//invCmd.Uf_GererMessage ( "DW_1" )
// remplace par 
if ibErreur then
	return invCmd.Uf_GererMessage ( "DW_1" )
Else
	return AncestorReturnValue
End If
// [MIGPB8COR]
end event

event dw_1::buttonclicked;call super::buttonclicked;//       JFF   19/09/2016 [PM346-1]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!

String sInfoSpbCplt, sURLFourn , sIdFour, sPathIE, sIdSin, sIdSeq, sInfoSpbFrnCplt 
Long lIdSin, lIdProd, lIdSeq, lIdDepotS2 
s_Pass stPass
String sRepExcel, sIdHubPresta
DataStore  dsTracePresta 

Choose Case  dwo.name
	Case "b_psm" 
		stPass.sTab[1]=This.GetItemString(row,"INFO_SPB_FRN_CPLT")
		stPass.lTab[1]=This.GetItemNumber(row,"ID_SIN")
		stPass.lTab[2]=This.GetItemNumber(row,"ID_SEQ")
		stPass.lTab[3]=invcmd.uf_get_idprod( )
		
		OpenWithParm(w_sp_boutique_psm_cmd, stPass)
	
	Case "b_pm346_1"
		
		// [PM346-1]
		sIdFour = This.GetItemString (row,"ID_FOUR")
		sIdSin = String ( This.GetItemNumber(row,"ID_SIN") )
		sIdSeq = String ( This.GetItemNumber(row,"ID_SEQ") )
		
		Choose Case sIdFour 
				
			Case "PSM"
				sURLFourn = ProfileString ( stGlb.sFichierIni, "PM346_1_EXTR_FOURN", "URL_PM346_1_PSM", "" )					
				sURLFourn = F_REMPLACE ( sURLFourn, "#ID_SIN_ID_SEQ#", sIdSin + "-" + sIdSeq ) 
				
			Case "O2M"
				sURLFourn = ProfileString ( stGlb.sFichierIni, "PM346_1_EXTR_FOURN", "URL_PM346_1_O2M", "" )									
				
		End Choose

		sPathIE = ProfileString ( stGlb.sFichierIni, "DOCUMENTATION", "IE_W7", "" )
		If Trim ( sPathIE ) = "" Then
			stMessage.sTitre		= "Contrôle de gestion"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WSIN746"
			stMessage.Bouton		= OK!
			stMessage.sVar[1]    = "DOCUMENTATION"
			stMessage.sVar[2]    = "IE_W7"
		
			F_Message ( stMessage ) 
			Return 
		End IF
		
		If Not FileExists ( sPathIE ) Then
			sPathIE = ProfileString ( stGlb.sFichierIni, "DOCUMENTATION", "IE_XP_ET_TS", "" )
			If Trim ( sPathIE ) = "" Then
				stMessage.sTitre		= "Contrôle de gestion"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WSIN746"
				stMessage.Bouton		= OK!
				stMessage.sVar[1]    = "DOCUMENTATION"
				stMessage.sVar[2]    = "IE_XP_ET_TS"
				
				F_Message ( stMessage ) 
				Return 
			End IF	
		End If
		
		
		Run( sPathIE + " " + sURLFourn, Maximized!)

	Case "b_trace_presta"
		
		lIdSin = This.GetItemNumber (row, "ID_SIN") 
		lIdSeq = This.GetItemNumber (row, "ID_SEQ") 

		sRepExcel=F_GetExcelPath() 

		dsTracePresta = Create datastore
		dsTracePresta.DataObject = "d_sp_c_trace_presta"
		dsTracePresta.SetTransObject (SQLCA)

		dsTracePresta.Retrieve ( lIdSin, lIdSeq ) 
		
		dsTracePresta.SaveAs ( stglb.sRepTempo + "TracePresta.XLS", Excel8!, TRUE ) // [MIG_PB2022]
		RUN ( sRepExcel + " " + stglb.sRepTempo + "TracePresta.XLS" )
		
		
	Case "b_voir_hub"
		
		lIdSin = This.GetItemNumber (row, "ID_SIN") 
		lIdSeq = This.GetItemNumber (row, "ID_SEQ") 
		sInfoSpbFrnCplt = This.GetItemString (row, "INFO_SPB_FRN_CPLT") 
		lIdDepotS2 = Long ( F_CLE_VAL ( "HP_IDENTITY", sInfoSpbFrnCplt, ";" ) )
		sIdHubPresta = F_CLE_VAL ( "HP_ID_HUB_PRESTA", sInfoSpbFrnCplt, ";" )

		If sIdHubPresta = "FICTIVE" Then
			stMessage.sTitre		= "Prestation Inexistante sur le Hub"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "HUBP014"
			stMessage.Bouton		= OK!
			
			F_Message ( stMessage ) 
			
		Else 
			stPass.sTab[50] = "CONSULTATION_PRESTATION_ALLER"		
			
			stPass.ltab[1] = lIdSin 
			stPass.ltab[2] = lIdSeq
			stPass.ltab[3] = lIdDepotS2
			
			OpenWithParm( w_sp_trt_saisie_hub_prestataire,  stPass ) 
		End If 

		
End Choose 
end event

type st_titre from w_8_traitement_master`st_titre within w_sp_gs_w_commande2
boolean visible = false
integer x = 3712
integer y = 48
integer width = 165
end type

type pb_retour from w_8_traitement_master`pb_retour within w_sp_gs_w_commande2
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_valider from w_8_traitement_master`pb_valider within w_sp_gs_w_commande2
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_sp_gs_w_commande2
boolean visible = false
integer x = 3877
integer y = 60
integer taborder = 110
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_sp_gs_w_commande2
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_sp_gs_w_commande2
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 100
end type

type dw_client from u_datawindow within w_sp_gs_w_commande2
integer x = 658
integer y = 208
integer width = 475
integer height = 432
integer taborder = 40
string dataobject = "d_gs_w_commande21"
boolean border = false
boolean livescroll = false
end type

event itemerror;call super::itemerror;//*****************************************************************************
//
// Objet 		: w_Traitement::dw_client
// Evenement 	: ItemError
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************
// [MIGPB8COR] - PHG : Correction de la gestion de l'itemerror
//invCmd.Uf_GererMessage ( "DW_CLIENT" )
// remplace par 
if ibErreur then
	return invCmd.Uf_GererMessage ( "DW_CLIENT" )
Else
	return AncestorReturnValue
End If
// [MIGPB8COR]

end event

event itemchanged;call super::itemchanged;//*****************************************************************************
//
// Objet 		: w_Traitement::dw_client
// Evenement 	: Itemchanged
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************

// [MIGPB8COR] PHG
// invCmd.Uf_ControlerZone ( "DW_CLIENT", isNomCol, This.GetText () )
return invCmd.Uf_ControlerZone ( "DW_CLIENT", isNomCol, This.GetText () )



end event

type uo_consult_euro from u_consultation_euro within w_sp_gs_w_commande2
integer x = 978
integer y = 8
integer taborder = 220
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type pb_annuler from picturebutton within w_sp_gs_w_commande2
integer x = 978
integer y = 8
integer width = 233
integer height = 144
integer taborder = 210
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annuler"
string picturename = "k:\pb4obj\bmp\8_REFUS.BMP"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Annuler
//* Evenement 		: cb_Annuler
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Annulation d'une commande validée.                               */
/*------------------------------------------------------------------*/
Parent.TriggerEvent ( "ue_item5")
end on

type dw_cmd_frn from u_datawindow within w_sp_gs_w_commande2
integer x = 128
integer y = 680
integer width = 475
integer height = 432
integer taborder = 20
string dataobject = "d_gs_w_commande22"
boolean border = false
end type

event buttonclicked;call super::buttonclicked;//       JFF   17/12/2018 [PM458-1]
//       JFF   02/09/2019 [DT424]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]


String sInfoSpbCplt, sURLtracking , sIdBonTransp, sPathIE
s_Pass stPass
String sRepExcel, sVal
DataStore  dsTracePresta 
String sInfoSpbFrnCplt 
String sIdHubPresta

Choose Case  dwo.name

	// [DT424]
	Case "b_consultcomment"
		
		sVal = dw_cmd_frn.GetItemString ( 1, "COMMENT_FRN" ) 
		stMessage.sTitre		= "Commentaire"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE013"
		stMessage.Bouton		= OK!
		stMessage.sVar[1]    = sVal
	
		F_Message ( stMessage ) 

	// [DT424]
	Case "b_consultifsc"

		sVal = dw_cmd_frn.GetItemString ( 1, "INFO_FRN_SPB_CPLT" ) 
		stMessage.sTitre		= "Infos fournisseur supplémentaires"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE013"
		stMessage.Bouton		= OK!
		stMessage.sVar[1]    = sVal
	
		F_Message ( stMessage ) 
	
	
	Case "b_tracking"

		// [PM346-1]
		sIdBonTransp = Trim ( This.GetItemString (row,"ID_BON_TRANSP") )
		If IsNull ( sIdBonTransp ) Then sIdBonTransp = ""
		
		If sIdBonTransp = "" Then
			Return 
		End If 
		
		sURLtracking = ProfileString ( stGlb.sFichierIni, "PM458_1_TRACKING", "URL_PM458_1_TRACKING", "" )									
		sURLtracking += sIdBonTransp
				
		sPathIE = ProfileString ( stGlb.sFichierIni, "DOCUMENTATION", "IE_W7", "" )
		If Trim ( sPathIE ) = "" Then
			stMessage.sTitre		= "Contrôle de gestion"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WSIN746"
			stMessage.Bouton		= OK!
			stMessage.sVar[1]    = "DOCUMENTATION"
			stMessage.sVar[2]    = "IE_W7"
		
			F_Message ( stMessage ) 
			Return 
		End IF
		
		If Not FileExists ( sPathIE ) Then
			sPathIE = ProfileString ( stGlb.sFichierIni, "DOCUMENTATION", "IE_XP_ET_TS", "" )
			If Trim ( sPathIE ) = "" Then
				stMessage.sTitre		= "Contrôle de gestion"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WSIN746"
				stMessage.Bouton		= OK!
				stMessage.sVar[1]    = "DOCUMENTATION"
				stMessage.sVar[2]    = "IE_XP_ET_TS"
				
				F_Message ( stMessage ) 
				Return 
			End IF	
		End If
		
		Run( sPathIE + " " + sURLtracking, Maximized!)

		
	Case "b_voir_hub"
		
		sInfoSpbFrnCplt = This.GetItemString (row, "INFO_SPB_FRN_CPLT") 
		sIdHubPresta = F_CLE_VAL ( "HP_ID_HUB_PRESTA", sInfoSpbFrnCplt, ";" )

		If sIdHubPresta = "FICTIVE" Then
			stMessage.sTitre		= "Prestation Inexistante sur le Hub"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "HUBP014"
			stMessage.Bouton		= OK!
			
			F_Message ( stMessage ) 
			
		Else 
			stPass.sTab[50] = "CONSULTATION_PRESTATION_RETOUR"		
			
			stPass.stab[1] = sIdHubPresta 
			
			OpenWithParm( w_sp_trt_saisie_hub_prestataire,  stPass ) 
		End If 

		
End Choose 
		

end event

type cb_dern from commandbutton within w_sp_gs_w_commande2
integer x = 1358
integer y = 300
integer width = 160
integer height = 64
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = ":"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Dern
//* Evenement 		: clicked
//* Auteur			: Abdmeziem Catherine
//* Date				: 26/05/2003
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//		FPI	23/05/2012	[PM103] Affichage du btn cb_maj_presta
//		FPI	07/11/2014	[VDOC15529]
//*-----------------------------------------------------------------

Boolean bPrestaRepBaseMan 
n_cst_string lnvPFCString


invCmd.uf_GestionBoutons (0, "DERN", True )
// cb_maj_presta.bringtotop=cb_maj_presta.Visible // [PM103]

// [PM103]
bPrestaRepBaseMan = lnvPFCString.of_getkeyvalue (dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" ), "PRESTA_REPRISE_BASE_MANUELLE", ";") = "OUI" And &
						  dw_1.GetItemString ( 1, "COD_ETAT" ) <> "CNV"

bPrestaRepBaseMan = 	bPrestaRepBaseMan And (gbModeReprise_223 Or invCmd.uf_GetAutorisation(224) ) // [PM103][FPI]

If bPrestaRepBaseMan Then
	wf_activation_maj_presta_manuelle( TRUE)
	cb_maj_presta.bringtotop=TRUE
	
	pb_Controler.Enabled = isTypeTrt = "S" And bPrestaRepBaseMan 
	
End If

// [VDOC15529]
mle_info_spb_frn_cplt.bringtotop=dw_1.Visible
mle_info_spb_frn_cplt.visible=dw_1.Visible
mle_info_frn_spb_cplt.bringtotop=dw_cmd_frn.Visible
mle_info_frn_spb_cplt.visible=dw_cmd_frn.Visible
mle_comment_frn.bringtotop=dw_cmd_frn.Visible
mle_comment_frn.visible=dw_cmd_frn.Visible

end event

type cb_prem from commandbutton within w_sp_gs_w_commande2
integer x = 1193
integer y = 228
integer width = 160
integer height = 64
integer taborder = 190
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "9"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Prem
//* Evenement 		: clicked
//* Auteur			: Abdmeziem Catherine
//* Date				: 26/05/2003
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//		FPI	23/05/2012	[PM103] Affichage du btn cb_maj_presta	  
//		FPI	07/11/2014	[VDOC15529]
//*-----------------------------------------------------------------

Boolean bPrestaRepBaseMan 
n_cst_string lnvPFCString

invCmd.uf_GestionBoutons( 0, "PREM", True )
//cb_maj_presta.bringtotop=cb_maj_presta.Visible // [PM103]

// [PM103]
bPrestaRepBaseMan = lnvPFCString.of_getkeyvalue (dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" ), "PRESTA_REPRISE_BASE_MANUELLE", ";") = "OUI" And &
						  dw_1.GetItemString ( 1, "COD_ETAT" ) <> "CNV"

bPrestaRepBaseMan = 	bPrestaRepBaseMan And (gbModeReprise_223 Or invCmd.uf_GetAutorisation(224) ) // [PM103][FPI]

If bPrestaRepBaseMan Then
	wf_activation_maj_presta_manuelle( TRUE)
	cb_maj_presta.bringtotop=TRUE
	
	pb_Controler.Enabled = isTypeTrt = "S" And bPrestaRepBaseMan 
	
End If

// [VDOC15529]
mle_info_spb_frn_cplt.bringtotop=dw_1.Visible
mle_info_spb_frn_cplt.visible=dw_1.Visible
mle_info_frn_spb_cplt.bringtotop=dw_cmd_frn.Visible
mle_info_frn_spb_cplt.visible=dw_cmd_frn.Visible
mle_comment_frn.bringtotop=dw_cmd_frn.Visible
mle_comment_frn.visible=dw_cmd_frn.Visible



end event

type cb_prec from commandbutton within w_sp_gs_w_commande2
integer x = 1358
integer y = 228
integer width = 160
integer height = 64
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "3"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Prec
//* Evenement 		: clicked
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//		FPI	23/05/2012	[PM103] Affichage du btn cb_maj_presta
//		FPI	07/11/2014	[VDOC15529]
//*-----------------------------------------------------------------

Boolean bPrestaRepBaseMan 
n_cst_string lnvPFCString

// 19/05/2003 : déportation du code dans le nvuo
invCmd.uf_GestionBoutons ( 0, "PREC", True )
//cb_maj_presta.bringtotop=cb_maj_presta.Visible // [PM103]


// [PM103]
bPrestaRepBaseMan = lnvPFCString.of_getkeyvalue (dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" ), "PRESTA_REPRISE_BASE_MANUELLE", ";") = "OUI" And &
						  dw_1.GetItemString ( 1, "COD_ETAT" ) <> "CNV"

bPrestaRepBaseMan = 	bPrestaRepBaseMan And (gbModeReprise_223 Or invCmd.uf_GetAutorisation(224) ) // [PM103][FPI]

If bPrestaRepBaseMan Then
	wf_activation_maj_presta_manuelle( TRUE)
	cb_maj_presta.bringtotop=TRUE
	
	pb_Controler.Enabled = isTypeTrt = "S" And bPrestaRepBaseMan 
	
End If

// [VDOC15529]
mle_info_spb_frn_cplt.bringtotop=dw_1.Visible
mle_info_spb_frn_cplt.visible=dw_1.Visible
mle_info_frn_spb_cplt.bringtotop=dw_cmd_frn.Visible
mle_info_frn_spb_cplt.visible=dw_cmd_frn.Visible
mle_comment_frn.bringtotop=dw_cmd_frn.Visible
mle_comment_frn.visible=dw_cmd_frn.Visible



end event

type cb_suiv from commandbutton within w_sp_gs_w_commande2
integer x = 1193
integer y = 300
integer width = 160
integer height = 64
integer taborder = 200
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "4"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Cb_Suiv
//* Evenement 		: click
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//		FPI	23/05/2012	[PM103] Affichage du btn cb_maj_presta
//		FPI	07/11/2014	[VDOC15529]
//*-----------------------------------------------------------------

Boolean bPrestaRepBaseMan 
n_cst_string lnvPFCString


// 19/05/2003 : déportation du code dans le nvuo
invCmd.uf_GestionBoutons ( 0, "SUIV", True )

//cb_maj_presta.bringtotop=cb_maj_presta.Visible // [PM103]

// [PM103]
bPrestaRepBaseMan = lnvPFCString.of_getkeyvalue (dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" ), "PRESTA_REPRISE_BASE_MANUELLE", ";") = "OUI" And &
						  dw_1.GetItemString ( 1, "COD_ETAT" ) <> "CNV"

bPrestaRepBaseMan = 	bPrestaRepBaseMan And (gbModeReprise_223 Or invCmd.uf_GetAutorisation(224) ) // [PM103][FPI]

If bPrestaRepBaseMan Then
	wf_activation_maj_presta_manuelle( TRUE)
	cb_maj_presta.bringtotop=TRUE
	
	pb_Controler.Enabled = isTypeTrt = "S" And bPrestaRepBaseMan 
	
End If

// [VDOC15529]
mle_info_spb_frn_cplt.bringtotop=dw_1.Visible
mle_info_spb_frn_cplt.visible=dw_1.Visible
mle_info_frn_spb_cplt.bringtotop=dw_cmd_frn.Visible
mle_info_frn_spb_cplt.visible=dw_cmd_frn.Visible
mle_comment_frn.bringtotop=dw_cmd_frn.Visible
mle_comment_frn.visible=dw_cmd_frn.Visible



end event

type aff_pg_cmd_t from statictext within w_sp_gs_w_commande2
integer x = 1234
integer y = 388
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "page 1 / 3"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_commune_livr from commandbutton within w_sp_gs_w_commande2
integer x = 1198
integer y = 488
integer width = 82
integer height = 72
integer taborder = 140
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
//* Objet         : cb_Commune_livr
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:07:58
//* Libellé       : Bouton d'ouverture de la fenêtre de recherche
//*					  des communes
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

s_Commune	stCom			// Structure dw_Commune

This.Enabled = FALSE

stCom.dw_Commune = istPass.dwNorm [ 6 ]


/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
OpenWithParm ( w_rech_Commune, stCom )

stCom = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On est ressorti en validant notre choix.                         */
/*------------------------------------------------------------------*/
If stCom.bValider Then
	dw_client.SetItem ( 1, "ADR_CP", stCom.sCP )
	dw_client.SetItem ( 1, "ADR_VILLE", stCom.sCommune )
End If 

This.Enabled = TRUE



end on

type cb_commune_fact from commandbutton within w_sp_gs_w_commande2
integer x = 1317
integer y = 488
integer width = 82
integer height = 72
integer taborder = 160
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
//* Objet         : cb_Commune_Fact
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:07:58
//* Libellé       : Bouton d'ouverture de la fenêtre de recherche
//*					  des communes
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

s_Commune	stCom			// Structure dw_Commune

This.Enabled = FALSE

stCom.dw_Commune = istPass.dwNorm [ 6 ]


/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
OpenWithParm ( w_rech_Commune, stCom )

stCom = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On est ressorti en validant notre choix.                         */
/*------------------------------------------------------------------*/
If stCom.bValider Then
	dw_client.SetItem ( 1, "ADRFC_CP", stCom.sCP )
	dw_client.SetItem ( 1, "ADRFC_VILLE", stCom.sCommune )
End If 

This.Enabled = TRUE



end on

type cb_imei from commandbutton within w_sp_gs_w_commande2
boolean visible = false
integer x = 681
integer y = 700
integer width = 590
integer height = 80
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Récup. IMEI Adh. Corrigé"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_IMEI
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 23/09/2003 17:24:44
//* Libellé       : Armement IMEI de l'adhésion Corrigé
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


Parent.TriggerEvent ("ue_item6")
end on

type cb_maj_presta from commandbutton within w_sp_gs_w_commande2
boolean visible = false
integer x = 2843
integer y = 168
integer width = 613
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Maj Presta manuelle"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction		: W_sp_gs_w_commande2::cb_maj_presta.clicked
//* Auteur			: F. PINON	
//* Date				: 23/05/2012
//* Libellé			: [PM103]
//* Commentaires	: Ouvre la fenêtre de maj presta manuelle
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
s_pass stPass
Integer iRet

If not invCmd.uf_GetAutorisation (223) Then
	stMessage.sTitre		= "Mode reprise de base manuelle"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.bouton		= YesNo!
	stMessage.sCode		= "WSIN727"
	iRet=F_Message ( stMessage )
	
	If iRet <> 1 Then Return
End if

stPass.udwtab[1] = dw_1
stPass.dwNorm[1] = invcmd.uf_get_dwdetpro( )
stPass.ltab[1] = invcmd.uf_get_idprod()

OpenWithParm (w_sp_trt_maj_presta_manuelle,stPass)
end event

type st_mode_reprise from statictext within w_sp_gs_w_commande2
integer x = 2249
integer y = 8
integer width = 411
integer height = 136
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 255
string text = "MODE REPRISE DE BASE MANUELLE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_aide_mode_reprise from commandbutton within w_sp_gs_w_commande2
integer x = 2665
integer y = 4
integer width = 178
integer height = 140
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aide !!"
end type

event clicked;//*
//* Fonction		: Clicked
//* Auteur			: JFF
//* Date				: 23/05/2012
//* Libellé			: 
//* Commentaires	: [PM103]
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


stMessage.sTitre		= "Mode reprise de base manuelle"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.bouton		= Ok!
stMessage.sCode		= "WSIN723"
F_Message ( stMessage )

end event

type cb_modif_adr from commandbutton within w_sp_gs_w_commande2
integer x = 1509
integer y = 484
integer width = 978
integer height = 112
integer taborder = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Modifier adresse et renvoyer le flux"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_modif_adr
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 16/01/2014 
//* Libellé       : Modif adresses
//*					  
//* Commentaires  : [PM246]
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    24/11/2015  [ITSM343686]
//*       JFF    08/11/2018  [VDOC26900]
//*		 JFF    17/02/2025  [20250217155600]
//        JFF    17/05/2025  [HUB1505]
//*-----------------------------------------------------------------

String sCodEtat, sVal, sIdFour, sInfoSpbFrnCplt, sInfoFrnSpbCplt, sIdHubPresta 
Int	 iCptValide
n_cst_string lnvPFCString

sCodEtat = Dw_1.GetItemString ( 1, "COD_ETAT" )
sIdFour = Dw_1.GetItemString  ( 1, "ID_FOUR" )
sInfoSpbFrnCplt = Dw_1.GetItemString  ( 1, "INFO_SPB_FRN_CPLT" ) // [HUB1505]
sInfoFrnSpbCplt = Dw_1.GetItemString  ( 1, "INFO_FRN_SPB_CPLT" ) // [HUB1505]

// [ITSM343686]
If sCodEtat = "CNV" Then
	stMessage.sTitre		= "Modification Adresse"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD930"
	stMessage.Bouton		= Ok!
	F_Message ( stMessage )
	Return
End If

If sCodEtat = "ANN" and sIdFour = "COR" Then
	stMessage.sTitre		= "Modification Adresse"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD995"
	stMessage.Bouton		= Ok!
	F_Message ( stMessage )
	Return
End If 

//[VDOC26900]
If sIdFour = "COR" Then
	sVal = Dw_1.GetItemString ( 1, "INFO_FRN_SPB_CPLT" )
	sVal = lnvPFCString.of_getkeyvalue (sVal, "PRBLE_LIVRAISON", ";")

	// [20250217155600]
	If IsNull ( sVal ) Then sVal = ""
	
	If Len ( sVal ) <= 0 Then
		stMessage.sTitre		= "Blocage vDoc26900/R.Adam"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD979"
		stMessage.Bouton		= Ok!
		F_Message ( stMessage )
		Return
	End If 
End If 


// [HUB1505]
If F_CLE_A_TRUE ( "HUB1505" ) Then
	sIdHubPresta = F_CLE_VAL ( "HP_ID_HUB_PRESTA", sInfoSpbFrnCplt, ";" )
	If Len ( sIdHubPresta ) > 0 Then
		sVal = F_CLE_VAL ( "PRBLE_LIVRAISON", sInfoFrnSpbCplt, ";" )
		IF Len ( sVal ) > 0 Then 
			Choose Case sVal
				Case "COLIS_PERDU"
					stMessage.sTitre		= "HUB1505 : Cause non autorisée"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "COMT008"
					stMessage.Bouton		= Ok!
					stMessage.sVar [1]   = sVal
					F_Message ( stMessage )
					Return					
				Case Else 
					
					// OK
					
			End Choose 
					
		Else
			stMessage.sTitre		= "HUB1505 : Aucun problème de livraions"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMT007"
			stMessage.Bouton		= Ok!
			F_Message ( stMessage )
			Return					
		End IF 
		
	End If 
End If


iCptValide = Dw_1.GetItemNumber ( 1, "CPT_VALIDE" )
sVal = Dw_1.GetItemString ( 1, "INFO_SPB_FRN_CPLT" )

Dw_1.SetItem ( 1, "COD_ETAT", "CNV" )

cb_modif_adr.Enabled = False

lnvPFCString.of_Setkeyvalue ( sVal, "COD_ETAT", sCodEtat, ";")
lnvPFCString.of_Setkeyvalue ( sVal, "MAJ_PRS", "OUI", ";")
lnvPFCString.of_Setkeyvalue ( sVal, "MAJ_PRSHUB", "OUI", ";") // [HUB1505]
lnvPFCString.of_Setkeyvalue ( sVal, "MAJ_ADRESSE", "OUI", ";")
Dw_1.SetItem ( 1, "INFO_SPB_FRN_CPLT", sVal )


dw_client.uf_Proteger &
		( {	"ADR_COD_CIV"		,&
				"ADR_NOM"			,& 
				"ADR_PRENOM"		,& 
				"ADR_LIVR1" 		,&
				"ADR_LIVR2"			,&
				"ADR_LIVR_CPL"		,&
				"ADR_CP"				,&
				"ADR_VILLE"			,&
				"ADR_TEL1"			,&
				"ADR_TEL2"			,&
				"ADR_TEL3"			&
		}, "0" )
		
pb_Controler.Enabled = TRUE
end event

type mle_comment_frn from multilineedit within w_sp_gs_w_commande2
integer x = 105
integer y = 848
integer width = 1687
integer height = 276
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean border = false
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_info_frn_spb_cplt from multilineedit within w_sp_gs_w_commande2
integer x = 105
integer y = 1212
integer width = 1687
integer height = 276
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean border = false
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_info_spb_frn_cplt from multilineedit within w_sp_gs_w_commande2
boolean visible = false
integer x = 864
integer y = 928
integer width = 2560
integer height = 372
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean border = false
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ann_cmde from datawindow within w_sp_gs_w_commande2
integer x = 1221
integer y = 64
integer width = 992
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ann_cmde"
boolean border = false
boolean livescroll = true
end type

