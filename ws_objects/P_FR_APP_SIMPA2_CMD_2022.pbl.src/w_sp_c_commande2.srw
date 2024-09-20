$PBExportHeader$w_sp_c_commande2.srw
$PBExportComments$Fenêtre au niveau sinistre affichant le résumé d'une commande.
forward
global type w_sp_c_commande2 from w_8_traitement_master
end type
type dw_client from u_datawindow within w_sp_c_commande2
end type
type uo_consult_euro from u_consultation_euro within w_sp_c_commande2
end type
type dw_cmd_frn from u_datawindow within w_sp_c_commande2
end type
type cb_dern from commandbutton within w_sp_c_commande2
end type
type cb_prem from commandbutton within w_sp_c_commande2
end type
type cb_prec from commandbutton within w_sp_c_commande2
end type
type cb_suiv from commandbutton within w_sp_c_commande2
end type
type aff_pg_cmd_t from statictext within w_sp_c_commande2
end type
end forward

global type w_sp_c_commande2 from w_8_traitement_master
integer width = 3351
integer height = 1336
event ue_taillefenetre ( )
dw_client dw_client
uo_consult_euro uo_consult_euro
dw_cmd_frn dw_cmd_frn
cb_dern cb_dern
cb_prem cb_prem
cb_prec cb_prec
cb_suiv cb_suiv
aff_pg_cmd_t aff_pg_cmd_t
end type
global w_sp_c_commande2 w_sp_c_commande2

type variables
Private :

u_DataWindow_Detail	idw_LstCmde, idw_LstGti
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.           */
/*------------------------------------------------------------------*/
DataWindow		idw_Produit

/*------------------------------------------------------------------*/
/* DCMP 030207 : CAG 20/05/03                     */
/*------------------------------------------------------------------*/
Integer			iiNbMaxPg = 3	//  nbre de pages max à gérer
Integer			iiCptPgCte	//  compteur de page courante

U_DataWindow		idwPg[3]		// tableau des dw correspondant aux pages
String			isPgCol[3]	// tableau des colonnes recevant le focus sur activation d'une page


end variables

forward prototypes
public function boolean wf_preparermodifier ()
public subroutine wf_positionnerobjets ()
private subroutine wf_tb_consultation ()
private function string wf_formatage_tel (string asText, boolean abSwitch)
public subroutine wf_gestionboutons (string asbouton, boolean abposdef)
private subroutine wf_gestionzone_infospbfrn ()
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
//* MAJ   PAR      Date	     Modification
//* #1    CAG		07/05/03	  DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								  => ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//* #2    CAG		03/06/03   Ajout de la zone ID_ANN = catégorie d'annulation
//* #3	 JFF		05/07/04   DMCP 040206
//* #4	 PHG		05/12/06	  DCMP xxxxxx Urbanisation : Unification de fonction
//* #5 	 JFF	   20/10/08	  [FNAC_PROD_ECH_TECH]
//*-----------------------------------------------------------------

String	sMonnaie, sMod, sIdFour, sIdTypArt
Long		lCpt, lIdProd 
n_cst_cmd_commun	lnvCmdCommun
/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
iiCptPgCte = 1
Aff_Pg_Cmd_t.Text = "page 1 / " + String ( iiNbMaxPg )
idwPg [ iiCptPgCte ].Show ()

For lCpt = 2 To iiNbMaxPg
	idwPg [ lCpt ].Hide ()
Next

//dw_1.Show ()
//dw_Client.Hide ()

cb_Suiv.Enabled = True

cb_Prec.Enabled = False

/*------------------------------------------------------------------*/
/* On arme la valeur de la monnaie avec celle de la fenêtre de      */
/* SINISTRE. (En consultation uniquement).                          */
/*------------------------------------------------------------------*/
sMonnaie = istPass.sTab [ 3 ]
Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

/*------------------------------------------------------------------*/
/* On recopie la ligne du détail de la fenêtre parent dans          */
/* dw_wGarSin de GARANTIE.                                          */
/*------------------------------------------------------------------*/
dw_1.Uf_CopierLigne ()

/*------------------------------------------------------------------*/
/* On supprime les espaces des n° de Tel seulement pour les n°      */
/* Français à 10 Chiffres.                                          */
/*------------------------------------------------------------------*/
dw_Client.SetItem ( 1, "ADR_TEL1", Wf_Formatage_Tel ( dw_Client.GetItemString ( 1, "ADR_TEL1" ), TRUE ) )
dw_Client.SetItem ( 1, "ADR_TEL2", Wf_Formatage_Tel ( dw_Client.GetItemString ( 1, "ADR_TEL2" ), TRUE ) )
dw_Client.SetItem ( 1, "ADR_TEL3", Wf_Formatage_Tel ( dw_Client.GetItemString ( 1, "ADR_TEL3" ), TRUE ) )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21	And Upper ( dw_1.GetItemString ( 1, "ID_TYP_ART" ) ) = "PRS" Then
	sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL_PORT.BMP'"
Else
	sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL.BMP'"
End If
/*------------------------------------------------------------------*/
/* On execute le modify sur la DW.                                  */
/*------------------------------------------------------------------*/
dw_Client.Modify ( sMod )

/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003 : modification des libellés de la dw des     */
/* données fournisseur									                    */
/*------------------------------------------------------------------*/
sIdFour = dw_1.GetItemString ( 1, "ID_FOUR" )
sIdTypArt = dw_1.GetItemString ( 1, "ID_TYP_ART" )
lIdProd = istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" )

// #4 Unification de Fonction :
// This.wf_Changer_Lib_Dw ( lIdProd, sIdFour, sIdTypArt )
// Remplacé par :
//* #5 [FNAC_PROD_ECH_TECH] ajout isTypeTrt = "C"
lnvCmdCommun.uf_Changer_Lib_Dw ( dw_Cmd_Frn, lIdProd, sIdFour, sIdTypArt, "C" )

/*------------------------------------------------------------------*/
/* #2 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
If dw_1.GetItemString ( 1, "COD_ETAT" ) = "ANN" Then
	sMod = "ID_ANN.VISIBLE = 1 ID_ANN_T.VISIBLE = 1"
Else
	sMod = "ID_ANN.VISIBLE = 0 ID_ANN_T.VISIBLE = 0"
End If
dw_1.Modify ( sMod )
dw_Cmd_Frn.Modify ( sMod )

sMod = "B_TRACE_PRESTA.VISIBLE = 1"	

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
This.wf_GestionZone_InfoSpbFrn()

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
//* MAJ PAR		Date		Modification
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//* #2  CAG		26/05/03	Ajout de 2 boutons pour revenir directement à la 1ère ou dernière page
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
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.X			= dw_1.X
dw_Cmd_Frn.Y			= dw_1.Y
dw_Cmd_Frn.Width		= dw_1.Width
dw_Cmd_Frn.Height		= dw_1.Height

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

Aff_Pg_Cmd_t.X		= 3054
Aff_Pg_Cmd_t.Y		=   93

end subroutine

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

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow dwNorm[2]
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

Uo_Consult_Euro.X			= 252
Uo_Consult_Euro.Y			= 9

Uo_Consult_Euro.Visible	= False // [SUISSE].LOT3 Bouton Invisible
Uo_Consult_Euro.Enabled	= False // [SUISSE].LOT3

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1
/*------------------------------------------------------------------*/
/* #1 : CAG 26/05/2003                                              */
/*------------------------------------------------------------------*/
dwNorm [ 2 ] = dw_cmd_frn

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )


end subroutine

private function string wf_formatage_tel (string asText, boolean abSwitch);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_c_commandes2:wf_Formatage_Tel (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libellé			: Formatage des N° de Tel
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  abSwitch	Boolean		Val		True : on insére des espaces
//*																False: on retire les espaces
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sVal
Int		iLen
Long		lCpt


sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )

CHOOSE CASE abSwitch
	CASE TRUE

		CHOOSE CASE iLen
		
			// Standard Français 1234567890 -> 12 34 56 78 90
			CASE 10
		
				sVal = Left ( sVal, 2 ) 	+ " " + &
						 Mid  ( sVal, 3, 2 ) + " " + &
						 Mid  ( sVal, 5, 2 ) + " " + &
						 Mid  ( sVal, 7, 2 ) + " " + &
						 Right( sVal, 2 ) 

		END CHOOSE

	CASE ELSE

		/*------------------------------------------------------------------*/
		/* Pas d'espace pour les numéros de téléphone.                      */
		/*------------------------------------------------------------------*/
		For lCpt = iLen To 1 Step -1
			If Mid ( sVal, lCpt, 1 ) = " " Then 
				sVal = Replace ( sVal, lCpt, 1, "" )
			End If
		Next

		If Len ( sVal ) <> 10 Then sVal = Trim ( asText )

END CHOOSE

Return sVal
end function

public subroutine wf_gestionboutons (string asbouton, boolean abposdef);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_W_Commande2::uf_GestionBoutons
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 19/05/2003 15:50:00
//* Libellé       : DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//* Commentaires  : => ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//*
//* Arguments     : ( Val )	String	asBouton	:	indique le bouton sur lequel on a appuyé
//*					  ( Val )	Boolean	abPosDef	:	indique si l'on doit se positionner sur la 1ère zone modifiable par défaut
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


Integer	iPgPrec

iPgPrec = iiCptPgCte
Choose Case asBouton
	Case "SUIV"
		iiCptPgCte ++
	Case "PREC"
		iiCptPgCte --
	Case "PREM"
		iiCptPgCte = 1
	Case "DERN"
		iiCptPgCte = iiNbMaxPg
End Choose

If idwPg [ iPgPrec ].AcceptText () < 0 Then Return

idwPg [ iiCptPgCte ].Show ()
idwPg [ iPgPrec ].Hide ()

Choose Case iiCptPgCte
	Case 1
		cb_Prec.Enabled = False
		cb_Suiv.Enabled = True
		cb_Prem.Enabled = False
		cb_Dern.Enabled = True
	Case iiNbMaxPg
		cb_Prec.Enabled = True
		cb_Suiv.Enabled = False
		cb_Prem.Enabled = True
		cb_Dern.Enabled = False
	Case Else
		cb_Prec.Enabled = True
		cb_Suiv.Enabled = True
		cb_Prem.Enabled = True
		cb_Dern.Enabled = True
End Choose

// Mise à jour de l'affichage du compteur des pages
Aff_Pg_Cmd_t.Text = "page " + String ( iiCptPgCte ) + " / " + String ( iiNbMaxPg )

If abPosDef Then
	If isPgCol [ iiCptPgCte ] <> "" Then
		idwPg [ iiCptPgCte ].SetColumn ( isPgCol [ iiCptPgCte ] )
	End If
	idwPg [ iiCptPgCte ].SetFocus ()
End If

end subroutine

private subroutine wf_gestionzone_infospbfrn ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_c_Commande2::wf_GestionZone_InfoSpbFrn (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 30/06/2004 14:58:44
//* Libellé       : Gestion de la zone Info_Spb_Frn
//* Commentaires  : DCMP 040206
//*					  à Partir du code (élément de la liste), il faut retrouver le code la liste,
//*					  le label à placer devant la zone
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

Long	lIdCodeElt, lIdListe
DataWindowChild dwChild
String sLabel

lIdCodeElt = dw_1.GetItemNumber ( 1, "INFO_SPB_FRN" )

If IsNull ( lIdCodeElt ) Then return

/*------------------------------------------------------------------*/
/* On détermine le code de la liste correspondante.                 */
/*------------------------------------------------------------------*/
lIdListe = ( Int ( lIdCodeElt / 100 ) ) * 100

dw_1.GetChild ( "INFO_SPB_FRN", dwChild )

dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 1 ) )
dwChild.Filter ()

If dwChild.RowCount () <> 1 Then 
	dwChild.SetFilter( "" ) 
	dwChild.Filter() 
	Return
End If

/*------------------------------------------------------------------*/
/* Mise à jour de label.                                            */

/*------------------------------------------------------------------*/
sLabel = dwChild.GetItemString ( 1, "LIB_CODE" )
sLabel  = F_Remplace ( sLabel , "'", "~~'" )

dw_1.Modify ( "info_spb_frn_t.text = '" + sLabel  + "'" )

dwChild.SetFilter( "" ) 
dwChild.Filter() 

end subroutine

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
//* #1  CAG		20/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//* #2  CAG		04/06/03 Ajout de la zone ID_ANN = catégorie d'annulation
//* #3  CAG		05/07/04 DCMP 040206
//* #4  JCA		31/08/06	suppression de [ADR_MAIL] dans l'appel de [dw_client.uf_InitialiserCouleur] et de [dw_client.uf_Proteger]
// 		FPI	10/07/2017	[ITSM475226] - Pour le scrollbar du probleme
//*-----------------------------------------------------------------

u_Datawindow  		dwPassageEuro [2]
DataWindowChild	dwChild, dwChild1
Long					lCpt


idw_LstCmde = istPass.dwTab [ 1 ]
idw_LstGti  = istPass.dwTab [ 2 ]

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
idw_Produit	= istPass.dwNorm[ 1 ]

Wf_PositionnerObjets ()
Wf_Tb_consultation ()
Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )

dw_1.ShareData ( dw_client )
/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dw_1.ShareData ( dw_Cmd_Frn )

idw_LstCMde.GetChild ( "ID_TYP_ART", dwChild )
dw_1.GetChild ( "ID_TYP_ART", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstCMde.GetChild ( "ID_FOUR", dwChild )
dw_1.GetChild ( "ID_FOUR", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstCMde.GetChild ( "COD_ETAT", dwChild )
dw_1.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstGti.GetChild ( "ID_GTI", dwChild )
dw_1.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )
dw_client.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* # CAG : Modification SFR # Le 06/09/2002.                        */
/*------------------------------------------------------------------*/
idw_LstCMde.GetChild ( "ID_BSP", dwChild )
dw_1.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )
dw_client.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstCMde.GetChild ( "ADR_COD_CIV", dwChild )
dw_1.GetChild ( "ADR_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )
dw_client.GetChild ( "ADR_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )
dw_client.GetChild ( "ADRFC_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )


/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
dw_Cmd_Frn.GetChild ( "STATUS_GC", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-GC" )

/*------------------------------------------------------------------*/
/* #2 : CAG 04/06/2003                                              */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "ID_ANN", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-CA" )

/*------------------------------------------------------------------*/
/* #3: 																				  */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "INFO_SPB_FRN", dwChild)
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-IF" )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
dw_1.uf_InitialiserCouleur &
		( {	"ID_SERIE_ANC"		,&
				"DTE_RDV_CLI"		,&
				"HRDV_CLI_MIN"		,&
				"HRDV_CLI_MAX"		 &
		} ) // [ITSM475226] Suppression de PROBLEME

dw_client.uf_InitialiserCouleur &
		( {	"ADR_NOM"			,& 
				"ADR_PRENOM"		,& 
				"ADR_LIVR1" 		,&
				"ADR_LIVR2"			,&
				"ADR_LIVR_CPL"		,&
				"ADR_CP"				,&
				"ADR_VILLE"			,&
				"ADRFC_NOM"			,& 
				"ADRFC_PRENOM"		,& 
				"ADRFC_LIVR1" 		,&
				"ADRFC_LIVR2"		,&
				"ADRFC_LIVR_CPL"	,&
				"ADRFC_CP"			,&
				"ADRFC_VILLE"		,&
				"ADR_TEL1"			,&
				"ADR_TEL2"			,&
				"ADR_TEL3"			&
		} )

dw_1.uf_Proteger &
		( {	"PROBLEME"			,& 
				"ID_SERIE_ANC"		,&
				"DTE_RDV_CLI"		,&
				"HRDV_CLI_MIN"		,&
				"HRDV_CLI_MAX"		 &
		}, "1" )

dw_client.uf_Proteger &
		( {	"ADR_NOM"			,& 
				"ADR_PRENOM"		,& 
				"ADR_LIVR1" 		,&
				"ADR_LIVR2"			,&
				"ADR_LIVR_CPL"		,&
				"ADR_CP"				,&
				"ADR_VILLE"			,&
				"ADRFC_NOM"			,& 
				"ADRFC_PRENOM"		,& 
				"ADRFC_LIVR1" 		,&
				"ADRFC_LIVR2"		,&
				"ADRFC_LIVR_CPL"	,&
				"ADRFC_CP"			,&
				"ADRFC_VILLE"		,&
				"ADR_TEL1"			,&
				"ADR_TEL2"			,&
				"ADR_TEL3"			&
		}, "1" )


/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1
/*------------------------------------------------------------------*/
/* #1 : CAG 20/05/2003                                              */
/*------------------------------------------------------------------*/
dwPassageEuro [ 2 ] = dw_cmd_frn

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro

/*------------------------------------------------------------------*/
/* #1 : CAG 19/05/2003                                              */
/*------------------------------------------------------------------*/
/* Initialisation du tableau des dw - pages, ainsi que des          */
/* colonnes qui recevront le focus sur activation de chaque page    */
/*------------------------------------------------------------------*/
For lCpt = 1 To iiNbMaxPg
	Choose Case lCpt
		Case 1
			idwPg [ lCpt ] = dw_1
			isPgCol [ lCpt ] = "PROBLEME"
		Case 2
			idwPg [ lCpt ] = dw_Cmd_Frn
			isPgCol [ lCpt ] = ""
		Case 3
			idwPg [ lCpt ] = dw_Client
			isPgCol [ lCpt ] = "ADR_COD_CIV"
	End Choose
Next

// [ITSM475226] - Pour le scrollbar
dw_1.uf_proteger({"probleme"},"0")
dw_1.Modify("probleme.Edit.displayOnly='Yes'")
dw_1.Modify("probleme.Edit.AutoSelect='No'")

end event

event we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande::We_ChildActivate (!!OVERRIDE!!)
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

Boolean					bOk
w_traitement_master	wMasterParent

This.X			=    1
This.Y			=    1
// [PB2022_TAILLE_FEN] + xxx
This.Height		= 1769 + 90


// [PB2022_TAILLE_FEN] + xxx
This.Width		= 3598 + 50


If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilisée pour enable )	

	istPass.wParent			=	This			// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans		// Objet de transaction par defaut
//	istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
														// lors de l'appel d'une fenêtre de traitement	This.TriggerEvent ( "ue_Initialiser" )
//	istPass.bCloseRetour		=	False			// Doit on fermer la fenêtre sur le bouton retour. Décision du script client


	wf_ActiverMajAccueil( True )	

	// Si il s'agit d'une fenêtre fille d'un master on la stock pour pouvoir la fermer

	If ( ibOpen ) Then

		This.TriggerEvent ( "ue_Initialiser" )
		IbOpen = False

	End If

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_DisableFenetre" )
	End If

	// Initialisation des variables d'instance

	Dw_1.ibErreur 	= False
	Dw_1.isNomCol	= ""
	Dw_1.isErrCol	= ""

	// Positionnement des boutons Controle et valider

	// Preparation avant affichage


	pb_Supprimer.Enabled = istPass.bSupprime
	bOk = wf_PreparerModifier ()

	// Arrêt d'ouverture de la fenêtre si problème

	If Not bOk Then

		This.TriggerEvent ( "ue_retour" )
	Else
		wf_Changer_Controle( Dw_1 )

		If ( ibModeDetail ) Then

/*------------------------------------------------------------------*/
/* Uniquement pour que la datawindow puisse retrouver ses petits    */
/* lors d'un RowCopy. ( Bug Pb )                                    */
/*------------------------------------------------------------------*/

			dw_1.SetSort(dw_1.isTri)
			dw_1.Sort()

		End If

		This.Show()
		Dw_1.SetFocus ()

	End If

End If

end event

on w_sp_c_commande2.create
int iCurrent
call super::create
this.dw_client=create dw_client
this.uo_consult_euro=create uo_consult_euro
this.dw_cmd_frn=create dw_cmd_frn
this.cb_dern=create cb_dern
this.cb_prem=create cb_prem
this.cb_prec=create cb_prec
this.cb_suiv=create cb_suiv
this.aff_pg_cmd_t=create aff_pg_cmd_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_client
this.Control[iCurrent+2]=this.uo_consult_euro
this.Control[iCurrent+3]=this.dw_cmd_frn
this.Control[iCurrent+4]=this.cb_dern
this.Control[iCurrent+5]=this.cb_prem
this.Control[iCurrent+6]=this.cb_prec
this.Control[iCurrent+7]=this.cb_suiv
this.Control[iCurrent+8]=this.aff_pg_cmd_t
end on

on w_sp_c_commande2.destroy
call super::destroy
destroy(this.dw_client)
destroy(this.uo_consult_euro)
destroy(this.dw_cmd_frn)
destroy(this.cb_dern)
destroy(this.cb_prem)
destroy(this.cb_prec)
destroy(this.cb_suiv)
destroy(this.aff_pg_cmd_t)
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
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )

end event

type cb_debug from w_8_traitement_master`cb_debug within w_sp_c_commande2
end type

type dw_1 from w_8_traitement_master`dw_1 within w_sp_c_commande2
integer x = 128
integer y = 208
integer width = 475
integer height = 432
integer taborder = 40
string dataobject = "d_c_commande2"
boolean border = false
end type

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
		stPass.lTab[3]=idw_produit.GetItemNumber(1,"ID_PROD")
		
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

type st_titre from w_8_traitement_master`st_titre within w_sp_c_commande2
boolean visible = false
integer x = 3712
integer y = 48
integer width = 165
end type

type pb_retour from w_8_traitement_master`pb_retour within w_sp_c_commande2
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_valider from w_8_traitement_master`pb_valider within w_sp_c_commande2
boolean visible = false
integer x = 494
integer y = 8
integer taborder = 70
boolean enabled = false
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_sp_c_commande2
boolean visible = false
integer x = 3877
integer y = 60
integer taborder = 90
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_sp_c_commande2
boolean visible = false
integer x = 251
integer y = 8
integer taborder = 60
boolean enabled = false
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_sp_c_commande2
boolean visible = false
integer x = 736
integer y = 8
integer taborder = 80
boolean enabled = false
end type

type dw_client from u_datawindow within w_sp_c_commande2
integer x = 658
integer y = 208
integer width = 475
integer height = 432
integer taborder = 30
string dataobject = "d_c_commande21"
boolean border = false
boolean livescroll = false
end type

type uo_consult_euro from u_consultation_euro within w_sp_c_commande2
integer x = 978
integer y = 8
integer taborder = 110
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type dw_cmd_frn from u_datawindow within w_sp_c_commande2
integer x = 128
integer y = 672
integer width = 475
integer height = 432
integer taborder = 10
string dataobject = "d_c_commande22"
boolean border = false
end type

event buttonclicked;call super::buttonclicked;//       JFF   17/12/2018 [PM458-1]
//       JFF   02/09/2019 [DT424]


String sInfoSpbCplt, sURLtracking , sIdBonTransp, sPathIE, sVal
s_Pass stPass
String sRepExcel
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

type cb_dern from commandbutton within w_sp_c_commande2
integer x = 1349
integer y = 340
integer width = 160
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = ":"
end type

on clicked;//*-----------------------------------------------------------------
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
//*				  
//*-----------------------------------------------------------------

wf_GestionBoutons("DERN", True)

end on

type cb_prem from commandbutton within w_sp_c_commande2
integer x = 1184
integer y = 220
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
string text = "9"
end type

on clicked;//*-----------------------------------------------------------------
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
//*				  
//*-----------------------------------------------------------------

wf_GestionBoutons("PREM", True)

end on

type cb_prec from commandbutton within w_sp_c_commande2
integer x = 1349
integer y = 220
integer width = 160
integer height = 64
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "3"
end type

on clicked;//*-----------------------------------------------------------------
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
//* #1  CAG		20/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//*-----------------------------------------------------------------

wf_GestionBoutons("PREC", True)

//If Dw_Client.AcceptText () < 0 Then Return
//
//Dw_1.Show ()
//Dw_Client.Hide ()
//cb_prec.Enabled = False
//cb_suiv.Enabled = True
//
//Dw_1.SetColumn ( "PROBLEME" )
//Dw_1.SetFocus ()

end on

type cb_suiv from commandbutton within w_sp_c_commande2
integer x = 1184
integer y = 340
integer width = 160
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "4"
end type

on clicked;//*-----------------------------------------------------------------
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
//* #1  CAG		20/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw supplémentaire => modif gestion des boutons prec et suiv
//*-----------------------------------------------------------------

wf_GestionBoutons("SUIV", True)

//If Dw_1.AcceptText () < 0 Then Return
//
//Dw_1.Hide ()
//Dw_Client.Show ()
//cb_prec.Enabled = True
//cb_suiv.Enabled = False
//
///*------------------------------------------------------------------*/
///* # Modification SFR # Le 10/09/2002.                              */
///*------------------------------------------------------------------*/
///* CAG : Remplacement de ADR_NOM par ADR_COD_CIV                    */
///*------------------------------------------------------------------*/
//
//Dw_Client.SetColumn ( "ADR_COD_CIV" )
//Dw_client.SetFocus ()

end on

type aff_pg_cmd_t from statictext within w_sp_c_commande2
integer x = 1230
integer y = 424
integer width = 256
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
string text = "page 2 / 3"
alignment alignment = center!
boolean focusrectangle = false
end type

