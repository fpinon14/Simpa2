$PBExportHeader$u_gs_sp_regul_detail.sru
$PBExportComments$---} User Object pour la gestion des régularisations. (Saisie du détail)
forward
global type u_gs_sp_regul_detail from nonvisualobject
end type
end forward

global type u_gs_sp_regul_detail from nonvisualobject
end type
global u_gs_sp_regul_detail u_gs_sp_regul_detail

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow		idw_Sin
	u_DataWindow		idw_RegFF

	u_DataWindow		idw_RegulFF
	u_DataWindow		idw_RegulMaster

	u_DataWindow_Detail	idw_LstReg

	DataWindow		idw_Produit
	DataWindow		idw_Inter
	DataWindow		idw_Frais
	DataWindow		idw_RegGti

	u_Onglets		iUoOng

	String			isTypeRegul





end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_initialisation_zone ()
private subroutine uf_tb_saisie ()
public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_lstreg, ref u_datawindow adw_regff, ref u_datawindow adw_regulff, ref u_datawindow adw_regulmaster, ref datawindow adw_norm[4])
private subroutine uf_armer_regroupement ()
public subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_zn_idrgpt ()
private subroutine uf_preparervalider (ref s_pass astpass)
private subroutine uf_modification_rm_rp_fm ()
private function long uf_zn_rib ()
private function long uf_zn_codmodereg ()
private function long uf_zn_mttotreg ()
private function long uf_zn_idi ()
public function long uf_zn_trt (ref s_pass astpass)
public function boolean uf_droit_factu ()
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fenêtre)
	Uf_InitialiserFenetre ()

Case 2					// MODIFICATION		(Wf_PreparerModifier)
	Uf_PreparerModifier ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )

Case 6					// PREPARER VALIDER	(Wf_PreparerValider)
	Uf_PreparerValider	( astPass )

End Choose

end subroutine

public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(Réf)	DataWindow de traitement du sinistre
//*					  u_Transaction			atrTrans			(Réf)	Objet de transaction
//*					  u_Onglets					auOnglet			(Réf)	Onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_Sin		= adw_Sin
itrTrans		= atrTrans
iuoOng		= auOnglet

end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Initialisation de la fenêtre (FREEFORM) d'une régularisation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

String sCol[8]

/*------------------------------------------------------------------*/
/* On récupére les DDDW qui ne changent jamais.                     */
/* Colonnes COD_INTER, ID_I, COD_MODE_REG.                          */
/*------------------------------------------------------------------*/
idw_LstReg.GetChild ( "ID_I", dwChild )
idw_RegFF.GetChild ( "ID_I", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Inter.GetChild ( "COD_INTER", dwChild )
idw_RegFF.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_RegulFF.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Inter.GetChild ( "COD_MODE_REG", dwChild )
idw_RegFF.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_RegulFF.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [  1 ] = "COD_MODE_REG"
sCol [  2 ] = "RIB_BQ"
sCol [  3 ] = "RIB_GUI"
sCol [  4 ] = "RIB_CPT"
sCol [  5 ] = "RIB_CLE"
sCol [  6 ] = "MT_TOT_REG"
sCol [  7 ] = "ID_I"
sCol [  8 ] = "ID_RGPT"

idw_RegulFF.Uf_InitialiserCouleur ( sCol )

end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la modification d'une régularisation
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   04/10/2019 [PM462-1][V3]
//*-----------------------------------------------------------------

String sTitre, sMod
String sCodMod 
Long lIdSin, lRet 

/*------------------------------------------------------------------*/
/* On recopie la ligne de règlement de la fenêtre parent dans       */
/* dw_RegFF.                                                        */
/*------------------------------------------------------------------*/
idw_RegFF.Uf_CopierLigne ()

isTypeRegul = astPass.sTab[1]
Choose Case isTypeRegul
	Case "1"		// RI
		sTitre = "Représentation Impayé (RI)"

	Case "2"		// RM (Garantie)
		sTitre = "RM à déduire sur garantie"

	Case "3"		// RM (Frais)
		sTitre = "RM à déduire sur frais"

	Case "4"		// RP (Garantie)
		sTitre = "RP à ajouter sur garantie"

	Case "5"		// RP (Frais)
		sTitre = "RP à ajouter sur frais"
End Choose

/*------------------------------------------------------------------*/
/* On modifie le titre de la DW pour la saisie de la                */
/* régularisation.                                                  */
/*------------------------------------------------------------------*/
sMod = "s_Titre.Text='" + sTitre + "'"
idw_RegulFF.Uf_Modify ( sMod )

Uf_Initialisation_Zone ()

// [202210171224]
idw_RegFF.SetItem ( 1, "TYP_ENCOURS", idw_RegulFF.GetItemString ( 1, "COD_MOT_REG" ) )

astPass.bRetour	= True

// [PM462-1][V3]
/*
If F_CLE_A_TRUE ( "PM462-1" ) Then
 	sCodMod = idw_RegulFF.GetItemString ( 1, "COD_MODE_REG" )	
	lIdSin = idw_Sin.GetItemNumber ( 1, "ID_SIN" )	
	lRet = SQLCA.PS_S_PRESENCE_FRANCHISE_CB ( lIdSin ) 

	If lRet > 0 And sCodMod = "FM" Then 
		stMessage.sTitre		= "Présence Franchise CB..."
		stMessage.Icon		= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "REGU260"		
		F_Message ( stMessage ) 
	End If 
End If
*/

end subroutine

private subroutine uf_initialisation_zone ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation_Zone (Private)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   02/10/2002   DCMP 020351 K.Letullier : Si RM sur RN en FM à l'origine
//*			     				  Alors mettre le RM aussi en FM
//*-----------------------------------------------------------------

Decimal {2} dcMtTotReg
String sCodInter, sFiltre, sRech, sNom, sVal, sTab, sCodModOrig, sCodModDef
Long lIdI, lIdRegBase, lTotInter, lLig, lRow

Date dDteReg
DateTime dtCreeLe

dtCreeLe = DateTime ( Today (), Now () )
dDteReg	= Date( Today () ) // [PI057]
sTab		= "~t"

/*------------------------------------------------------------------*/
/* On insére une ligne dans la DW qui va servir à la saisie.        */
/*------------------------------------------------------------------*/
idw_RegulFF.Reset ()
idw_RegulFF.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* On initialise la DDLB sur ID_I.                                  */
/*------------------------------------------------------------------*/
idw_RegulFF.ClearValues ( "ID_I" )

/*------------------------------------------------------------------*/
/* #1 DCMP 020351 : JFF Le 02/10/2002                               */
/*------------------------------------------------------------------*/
lRow = iDw_LstReg.GetSelectedRow ( 0 ) 
If lRow > 0 Then
	sCodModOrig = idw_LstReg.GetItemString ( lRow, "COD_MODE_REG" )
Else
	sCodModOrig = ""
End If


Choose Case isTypeRegul
Case "1"										// RI
	idw_RegFF.Visible = True

	dcMtTotReg 	= idw_RegFF.GetItemDecimal ( 1, "MT_TOT_REG" )
	lIdRegBase	= idw_RegFF.GetItemNumber ( 1, "ID_REG" )
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sCodInter	= idw_RegFF.GetItemString ( 1, "COD_INTER" )

	idw_RegulFF.SetItem ( 1, "MT_TOT_REG", dcMtTotReg )
	idw_RegulFF.SetItem ( 1, "ID_REG_BASE", lIdRegBase )
	idw_RegulFF.SetItem ( 1, "ID_I", lIdI )
	idw_RegulFF.SetItem ( 1, "COD_INTER", sCodInter )

	idw_RegulFF.SetItem ( 1, "COD_MOT_REG", "RI" )

/*------------------------------------------------------------------*/
/* On s'occupe maintenant de la DDLB sur ID_I.                      */
/*------------------------------------------------------------------*/
	lTotInter = idw_Inter.RowCount ()
	sRech = "ID_I = " + String ( lIdI )
	lLig = idw_Inter.Find ( sRech, 1, lTotInter )
	sNom = idw_Inter.GetItemString ( lLig, "NOM" )
	sVal = sNom + sTab + String ( lIdI ) 
	idw_RegulFF.SetValue ( "ID_I", 1, sVal )

Case "2", "3"									// RM (Garantie) et RM (Frais)
	idw_RegFF.Visible = True

	lIdRegBase	= idw_RegFF.GetItemNumber ( 1, "ID_REG" )
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sCodInter	= idw_RegFF.GetItemString ( 1, "COD_INTER" )

	idw_RegulFF.SetItem ( 1, "ID_REG_BASE", lIdRegBase )
	idw_RegulFF.SetItem ( 1, "ID_I", lIdI )
	idw_RegulFF.SetItem ( 1, "COD_INTER", sCodInter )

/*------------------------------------------------------------------*/
/* #1 DCMP 020351 : JFF Le 02/10/2002                               */
/*------------------------------------------------------------------*/
	Choose Case sCodModOrig
		Case "FM"
			sCodModDef = "FM"

		Case Else
			sCodModDef = "C"
	End Choose

	idw_RegulFF.SetItem ( 1, "COD_MODE_REG", sCodModDef )

	idw_RegulFF.SetItem ( 1, "COD_MOT_REG", "RM" )

	Uf_Armer_Regroupement ()

Case "4", "5"									// RP (Garantie) et RP (Frais)
	idw_RegFF.Visible = True

	lIdRegBase	= idw_RegFF.GetItemNumber ( 1, "ID_REG" )
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sCodInter	= idw_RegFF.GetItemString ( 1, "COD_INTER" )

	idw_RegulFF.SetItem ( 1, "ID_REG_BASE", lIdRegBase )
	idw_RegulFF.SetItem ( 1, "ID_I", lIdI )
	idw_RegulFF.SetItem ( 1, "COD_INTER", sCodInter )

/*------------------------------------------------------------------*/
/* #1 DCMP 020351 : JFF Le 02/10/2002                               */
/*------------------------------------------------------------------*/
	Choose Case sCodModOrig
		Case "FM"
			sCodModDef = "FM"

		Case Else
			sCodModDef = "C"
	End Choose

	idw_RegulFF.SetItem ( 1, "COD_MODE_REG", sCodModDef )

	idw_RegulFF.SetItem ( 1, "COD_MOT_REG", "RP" )

	Uf_Armer_Regroupement ()

End Choose

idw_RegulFF.SetItem ( 1, "DTE_REG", dDteReg )
idw_RegulFF.SetItem ( 1, "CREE_LE", dtCreeLe )
idw_RegulFF.SetItem ( 1, "MAJ_LE", dtCreeLe )
idw_RegulFF.SetItem ( 1, "MAJ_PAR", stGLB.sCodOper )

Uf_Tb_Saisie ()
end subroutine

private subroutine uf_tb_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Saisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder en saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


Choose Case isTypeRegul
Case "1"						// RI
	idw_RegulFF.Uf_Proteger ( { "LIB_REG", "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
	idw_RegulFF.Uf_Proteger ( { "MT_TOT_REG", "ID_RGPT", "ID_I" }, "1" )

	idw_RegulFF.ilPremCol 	=  4		// LIB_REG
	idw_RegulFF.ilDernCol 	= 11		// COD_MODE_REG

	idw_RegulFF.isNomCol		= "LIB_REG"

Case "2", "3"				// RM (Garantie) et RM (Frais)
	idw_RegulFF.Uf_Proteger ( { "MT_TOT_REG", "LIB_REG", "ID_RGPT" }, "0" )
	idw_RegulFF.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE",  "ID_I"  }, "1" )

	idw_RegulFF.ilPremCol 	=  3		// MT_TOT_REG
	idw_RegulFF.ilDernCol 	= 13		// ID_I

	idw_RegulFF.isNomCol		= "MT_TOT_REG"

Case "4", "5"				// RP (Garantie) et RP (Frais)
	idw_RegulFF.Uf_Proteger ( { "MT_TOT_REG", "LIB_REG", "ID_RGPT" }, "0" )
	idw_RegulFF.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE",  "ID_I"  }, "1" )

	idw_RegulFF.ilPremCol 	=  3		// MT_TOT_REG
	idw_RegulFF.ilDernCol 	= 13		// ID_I

	idw_RegulFF.isNomCol		= "MT_TOT_REG"

End Choose


end subroutine

public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_lstreg, ref u_datawindow adw_regff, ref u_datawindow adw_regulff, ref u_datawindow adw_regulmaster, ref datawindow adw_norm[4]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstReg			(Réf)	DataWindow sur les règlements
//*					  U_DataWindow				adw_RegFF			(Réf)	DataWindow Master de la fenêtre
//*					  U_DataWindow				adw_RegulFF			(Réf)	
//*					  U_DataWindow				adw_RegulMaster
//*					  DataWindow				adw_Norm[4]			(Réf)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les REGLEMENTS. Liste => U_DataWindow_Detail.     */
/*------------------------------------------------------------------*/
idw_LstReg	= adw_LstReg

/*------------------------------------------------------------------*/
/* DataWindow sur le REGLEMENT en cours. => U_DataWindow.           */
/*------------------------------------------------------------------*/
idw_RegFF	= adw_RegFF

/*------------------------------------------------------------------*/
/* DataWindow sur la saisie de la REGULARISATION.                   */
/*------------------------------------------------------------------*/
idw_RegulFF	= adw_RegulFF

/*------------------------------------------------------------------*/
/* DataWindow pour le stockage de la REGULARISATION. (MASTER)       */
/*------------------------------------------------------------------*/
idw_RegulMaster = adw_RegulMaster

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table PRODUIT.                                 */
/*------------------------------------------------------------------*/
idw_Produit	= adw_Norm[1]

/*------------------------------------------------------------------*/
/* DataWindow sur la table INTER.                                   */
/*------------------------------------------------------------------*/
idw_Inter	= adw_Norm[2]

/*------------------------------------------------------------------*/
/* DataWindow sur la table FRAIS.                                   */
/*------------------------------------------------------------------*/
idw_Frais	= adw_Norm[3]

/*------------------------------------------------------------------*/
/* DataWindow sur la table REG_GTI.                                 */
/*------------------------------------------------------------------*/
idw_RegGti	= adw_Norm[4]

end subroutine

private subroutine uf_armer_regroupement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Armer_Regroupement (Private)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: On va armer la zone ID_RGPT en fonction du type de régularisation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* JFF  17/10/2022 [202210171224]
//*-----------------------------------------------------------------

String sFiltre, sVal, sLib, sLibLu, sNom, sTab, sRech
Long lIdRgpt, lIdRgptLu, lTot, lCpt, lVal, lLig
Long lTotInter, lIdI, lIdRegBase 
Boolean bFin

Decimal {2} dcMtTotReg, dcMtReg

lVal	= 0
sTab	= "~t"
idw_RegulFF.ClearValues ( "ID_RGPT" )

// [202210171224]
lIdRegBase = idw_RegulFF.GetItemNumber ( 1, "ID_REG_BASE" ) 

Choose Case isTypeRegul
Case "2", "3"										// RM (Garantie) et RM (Frais)
	If	isTypeRegul = "2"	Then
/*------------------------------------------------------------------*/
/* Il faut armer ID_RGPT avec la liste des valeurs de REG_GTI       */
/* (sans les frais) pour lequels la somme de MT_REG > 0.            */
/*------------------------------------------------------------------*/
		sFiltre = "ID_GTI > 0"
	Else
/*------------------------------------------------------------------*/
/* Il faut armer ID_RGPT avec la liste des valeurs de REG_GTI       */
/* (sans les garanties) pour lequels la somme de MT_REG > 0.        */
/*------------------------------------------------------------------*/
		sFiltre = "ID_GTI < 0"
	End If

	// [202210171224]
	sFiltre += "AND ID_REG = " + String ( lIdRegBase )

	idw_RegGti.SetFilter ( sFiltre )
	idw_RegGti.Filter ()

	idw_RegGti.Sort ()
	lTot = idw_RegGti.RowCount ()
	

/*------------------------------------------------------------------*/
/* On va traiter la première ligne.                                 */
/*------------------------------------------------------------------*/
	If	lTot > 0 Then
		lIdRgpt		= idw_RegGti.GetItemNumber ( 1, "ID_RGPT" )
		dcMtTotReg	= idw_RegGti.GetItemDecimal ( 1, "MT_REG" )
		sLib			= idw_RegGti.GetItemString ( 1, "LIB_CODE" )
	End If

	// [202210171224]
	If lTot = 1 Then idw_RegulFF.SetItem ( 1, "ID_RGPT", lIdRgpt ) 


	For	lCpt = 2 To lTot
			lIdRgptLu	= idw_RegGti.GetItemNumber ( lCpt, "ID_RGPT" )
			dcMtReg		= idw_RegGti.GetItemDecimal ( lCpt, "MT_REG" )
			sLibLu		= idw_RegGti.GetItemString ( lCpt, "LIB_CODE" )
				
			If	lIdRgptLu <> lIdRgpt	And dcMtTotReg > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant réglé est > 0. On positionne la ligne.             */
/*------------------------------------------------------------------*/
				lVal ++

				sVal = sLib + sTab + String ( lIdRgpt ) 
				idw_RegulFF.SetValue ( "ID_RGPT", lVal, sVal )

				lIdRgpt 		= lIdRgptLu
				dcMtTotReg	= dcMtReg
				sLib			= sLibLu
					
			Else
				dcMtTotReg += dcMtReg
			End If
	Next

/*------------------------------------------------------------------*/
/* On insére la dernière ligne systématiquement.                    */
/*------------------------------------------------------------------*/
	If	lTot > 0 And dcMtTotReg > 0 Then
		lVal ++

		sVal = sLib + sTab + String ( lIdRgpt ) 
		idw_RegulFF.SetValue ( "ID_RGPT", lVal, sVal )

	End If

/*------------------------------------------------------------------*/
/* On s'occupe maintenant de la DDLB sur ID_I.                      */
/*------------------------------------------------------------------*/
	lTotInter = idw_Inter.RowCount ()
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sRech = "ID_I = " + String ( lIdI )
	lLig = idw_Inter.Find ( sRech, 1, lTotInter )
	sNom = idw_Inter.GetItemString ( lLig, "NOM" )
	sVal = sNom + sTab + String ( lIdI ) 
	idw_RegulFF.SetValue ( "ID_I", 1, sVal )

	If lTot > 1 Then

		Do While Not bFin
			stMessage.sTitre		= "RM sur plusieurs garanties"
			stMessage.Icon		= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "REGU290"		
			If F_Message ( stMessage ) = 1 Then bFin = TRUE
		Loop	
	
	End If 
	
	

Case "4"											// RP (Garantie)
	sFiltre = "ID_GTI > 0"
	
	// [202210171224]
	sFiltre += "AND ID_REG = " + String ( lIdRegBase )
	
	idw_RegGti.SetFilter ( sFiltre )
	idw_RegGti.Filter ()

	idw_RegGti.Sort ()
	lTot = idw_RegGti.RowCount ()

/*------------------------------------------------------------------*/
/* On va traiter la première ligne.                                 */
/*------------------------------------------------------------------*/
	If	lTot > 0 Then
		lIdRgpt		= idw_RegGti.GetItemNumber ( 1, "ID_RGPT" )
		sLib			= idw_RegGti.GetItemString ( 1, "LIB_CODE" )
	End If
	
	// [202210171224]
	If lTot = 1 Then idw_RegulFF.SetItem ( 1, "ID_RGPT", lIdRgpt ) 	

	For	lCpt = 2 To lTot
			lIdRgptLu	= idw_RegGti.GetItemNumber ( lCpt, "ID_RGPT" )
			sLibLu		= idw_RegGti.GetItemString ( lCpt, "LIB_CODE" )
				
			If	lIdRgptLu <> lIdRgpt	Then
				lVal ++

				sVal = sLib + sTab + String ( lIdRgpt ) 
				idw_RegulFF.SetValue ( "ID_RGPT", lVal, sVal )

				lIdRgpt 		= lIdRgptLu
				sLib			= sLibLu

			End If
	Next

/*------------------------------------------------------------------*/
/* On insére la dernière ligne systématiquement.                    */
/*------------------------------------------------------------------*/
	If	lTot > 0 Then
		lVal ++

		sVal = sLib + sTab + String ( lIdRgpt ) 
		idw_RegulFF.SetValue ( "ID_RGPT", lVal, sVal )

	End If

/*------------------------------------------------------------------*/
/* On insére la liste de tous les interlocuteurs.                   */
/*------------------------------------------------------------------*/
//	lTotInter = idw_Inter.RowCount ()
//	For	lCpt = 1 To lTotInter
//			sNom = idw_Inter.GetItemString ( lCpt, "NOM" )
//			lIdI = idw_Inter.GetItemNumber ( lCpt, "ID_I" )
//			sVal = sNom + sTab + String ( lIdI )
//			idw_RegulFF.SetValue ( "ID_I", lCpt, sVal )
//	Next
	lTotInter = idw_Inter.RowCount ()
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sRech = "ID_I = " + String ( lIdI )
	lLig = idw_Inter.Find ( sRech, 1, lTotInter )
	sNom = idw_Inter.GetItemString ( lLig, "NOM" )
	sVal = sNom + sTab + String ( lIdI ) 
	idw_RegulFF.SetValue ( "ID_I", 1, sVal )



Case "5"											// RP (Frais)
/*------------------------------------------------------------------*/
/* On insére les 2 types de frais en DUR. Aucun RETRIEVE n'est      */
/* effectué sur le moteur.                                          */
/*------------------------------------------------------------------*/
		sVal = "Frais Envoi" + sTab + "1"
		idw_RegulFF.SetValue ( "ID_RGPT", 1, sVal )

		sVal = "Frais de PV" + sTab + "2"
		idw_RegulFF.SetValue ( "ID_RGPT", 2, sVal )

/*------------------------------------------------------------------*/
/* On insére la liste de tous les interlocuteurs.                   */
/*------------------------------------------------------------------*/
//	lTotInter = idw_Inter.RowCount ()
//	For	lCpt = 1 To lTotInter
//			sNom = idw_Inter.GetItemString ( lCpt, "NOM" )
//			lIdI = idw_Inter.GetItemNumber ( lCpt, "ID_I" )
//			sVal = sNom + sTab + String ( lIdI )
//			idw_RegulFF.SetValue ( "ID_I", lCpt, sVal )
//	Next

	lTotInter = idw_Inter.RowCount ()
	lIdI			= idw_RegFF.GetItemNumber ( 1, "ID_I" )
	sRech = "ID_I = " + String ( lIdI )
	lLig = idw_Inter.Find ( sRech, 1, lTotInter )
	sNom = idw_Inter.GetItemString ( lLig, "NOM" )
	sVal = sNom + sTab + String ( lIdI ) 
	idw_RegulFF.SetValue ( "ID_I", 1, sVal )


End Choose


end subroutine

public subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de saisie d'une régularisation
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol [ 6 ], sErr [ 6 ], sVal [ 6 ]

String 		sNouvelleLigne, sText, sPos, sOng, sFiltre 
Long 			lCpt, lNbrCol, lIdRgpt, lIdI, lTotGti
Decimal {2}	dcMtTotReg, dcMtTotGti, dcRMmaxPossible
String sCodMod
Long lIdSin, lRet


sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne
sOng					= "01"

sCol[  1 ] = "LIB_REG"
sCol[  2 ] = "COD_MODE_REG"
sCol[  3 ] = "RIB_BQ"
sCol[  4 ] = "RIB_GUI"
sCol[  5 ] = "RIB_CPT"
sCol[  6 ] = "RIB_CLE"

sErr[  1 ] = " - Le libelle de la régularisation"
sErr[  2 ] = " - Le mode de règlement"
sErr[  3 ] = " - Le code banque"
sErr[  4 ] = " - Le code guichet"
sErr[  5 ] = " - Le numéro de compte"
sErr[  6 ] = " - La clé RIB"

For	lCpt = 1 To lNbrCol
		sVal[ lCpt ] = Trim ( idw_RegulFF.GetItemString ( 1, sCol[ lCpt ] ) )
Next

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To 2
		If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
			If sPos = "" Then sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If
Next


/*------------------------------------------------------------------*/
/* Si on commence à saisir un élément du RIB, il faut aller         */
/* jusqu'au bout.                                                   */
/*------------------------------------------------------------------*/
If	sVal [ 3 ] <> "" Or sVal [ 4 ] <> "" Or sVal [ 5 ] <> "" Or sVal [ 6 ] <> "" Then
	For	lCpt = 3 To 6
			If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
				If sPos = "" Then sPos = sCol[ lCpt ]
				sText = sText + sErr[ lCpt ] + sNouvelleLigne
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si COD_MODE_REG est à VA (Virement Automatique), alors la        */
/* saisie du RIB est obligatoire.                                   */
/*------------------------------------------------------------------*/
If	sVal[ 2 ] = "VA"	And IsNull ( sVal [ 3 ] )	Then
	If sPos = "" Then sPos = "RIB_BQ"
	sText = sText + sErr[ 3 ] + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Le montant de la régularisation est obligatoire.                 */
/*------------------------------------------------------------------*/
dcMtTotReg = idw_RegulFF.GetItemDecimal ( 1, "MT_TOT_REG" )
If	dcMtTotReg = 0 or IsNull ( dcMtTotReg )	Then
	If sPos = "" Then sPos = "MT_TOT_REG"
	sText = sText + " - le montant de la régularisation" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* La zone ID_RGPT est obligatoire sauf dans le cas d'un RI.        */
/*------------------------------------------------------------------*/
lIdRgpt = idw_RegulFF.GetItemNumber ( 1, "ID_RGPT" )
If	isTypeRegul <> "1"	Then
	If	IsNull ( lIdRgpt ) Then
		If sPos = "" Then sPos = "ID_RGPT"
		sText = sText + " - la garantie" + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* La zone ID_I est obligatoire.                                    */
/*------------------------------------------------------------------*/
lIdI = idw_RegulFF.GetItemNumber ( 1, "ID_I" )
If	IsNull ( lIdI ) Then
	If sPos = "" Then sPos = "ID_I"
	sText = sText + " - l'interlocuteur" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Dans le cas d'un RM (Garantie), le montant que l'on vient de     */
/* saisir ne peut être supérieur au montant réglé sur ID_RGPT pour  */
/* l'interlocuteur en cours.                                        */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
	If	isTypeRegul = "2"	Or isTypeRegul = "3" Then

		sFiltre = "ID_RGPT = " + String ( lIdRgpt )
	
		idw_RegGti.SetFilter ( sFiltre )
		idw_RegGti.Filter ()
	
		idw_RegGti.Sort ()


		dcMtTotReg = Abs ( dcMtTotReg )
		lTotGti = idw_RegGti.RowCount ()
		For	lCpt = 1 To lTotGti
				If	idw_RegGti.GetItemNumber ( lCpt, "ID_RGPT" ) = lIdRgpt	And	&
					idw_RegGti.GetItemNumber ( lCpt, "ID_I" ) 	= lIdI			Then
						dcMtTotGti = dcMtTotGti + idw_RegGti.GetItemdecimal ( lCpt, "MT_REG" )
				End If
		Next

		If	dcMtTotReg	> dcMtTotGti	Then
			sPos = "MT_TOT_REG"

			stMessage.sVar[1] 	= String ( dcMtTotGti )
			stMessage.bErreurG	= False
			stMessage.sCode		= "REGU130"
		End If

		
		// [202210171224]
		If sPos = "" Then
			dcRMmaxPossible = idw_RegFF.GetItemdecimal ( 1, "SOM_RM_RP" )
	
			If abs ( dcMtTotReg ) > abs ( dcRMmaxPossible ) Then
	
				sPos = "MT_TOT_REG"			
				stMessage.sVar[1] 	= String ( dcRMmaxPossible )
				stMessage.bErreurG	= False
				stMessage.sCode		= "REGU130"			
			End If 
			// /[202210171224]
		End If 		
	End If

Else

	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

End If

/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contrôle de saisie d'une régularisation"
	stMessage.Icon			= Information!

	f_Message ( stMessage )

End If

// [PM462-1][V3]
/*
If F_CLE_A_TRUE ( "PM462-1" ) Then
 	sCodMod = idw_RegulFF.GetItemString ( 1, "COD_MODE_REG" )	
	lIdSin = idw_Sin.GetItemNumber ( 1, "ID_SIN" )	
	lRet = SQLCA.PS_S_PRESENCE_FRANCHISE_CB ( lIdSin ) 

	If lRet > 0 And sCodMod = "FM" Then 
		stMessage.sTitre		= "Présence Franchise CB..."
		stMessage.Icon		= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "REGU260"		
		F_Message ( stMessage ) 
		sPos = "MT_TOT_REG"
	End If 
End If
*/


astPass.lTab [ 1 ] 	= 1
astPass.dwNorm [ 1 ] = idw_RegulFF
		
astPass.sTab [ 1 ] 	= sPos

end subroutine

private subroutine uf_zn_idrgpt ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdRgpt (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: On va populiser la liste des INTERS en fonction de la garantie choisie.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sText, sRech, sNom, sVal, sCodInter, sTab
Long lIdRgpt, lTotGti, lCpt, lIdRgptLu, lIdI, lTotIndice, lCptIndice
Long lTotInter, lLig, lRow
Boolean bInsertIdI
Long lInter[]

// JFF le 15/09/2005 : Plus nécessaire.
Return

sText 	= idw_RegulFF.GetText ()
sTab		= "~t"
lRow		= idw_RegFF.GetSelectedRow (0)

lIdRgpt	= Long ( sText )

/*------------------------------------------------------------------*/
/* On vient de choisir la garantie. Il faut populiser la zone       */
/* ID_I, en fonction de la DW REG_GTI. (Uniquement pour les RM)     */
/*------------------------------------------------------------------*/

Choose Case isTypeRegul
Case "2", "3"

	lTotGti	= idw_RegGti.RowCount ()
	For	lCpt = 1 To lTotGti
			lIdRgptLu = idw_RegGti.GetItemNumber ( lCpt, "ID_RGPT" )
			If	lIdRgptLu = lIdRgpt	Then
				lIdI = idw_RegGti.GetItemNumber ( lCpt, "ID_I" )
			
				bInsertIdI = True
				lTotIndice = UpperBound ( lInter )
				For	lCptIndice = 1 To lTotIndice
						If	lInter [ lCptIndice ] = lIdI	Then
							bInsertIdI = False
							Exit
						End If
				Next

				If	bInsertIdI	Then
					lTotIndice ++
					lInter [ lTotIndice ] = lIdI
				End If

			End If
	Next

/*------------------------------------------------------------------*/
/* Il existe au moins un interlocuteur trouvé.                      */
/*------------------------------------------------------------------*/
	lTotInter 	= idw_Inter.RowCount ()
	lCptIndice 	= 1

	For	lCpt = 1 To lTotIndice
			sRech = "ID_I = " + String ( lInter [ lCpt ] )
			lLig = idw_Inter.Find ( sRech, 1, lTotInter )
			sNom = idw_Inter.GetItemString ( lLig, "NOM" )

			sVal = sNom + sTab + String ( lInter [ lCpt ] )
			idw_RegulFF.SetValue ( "ID_I", lCptIndice, sVal )
			lCptIndice ++
	Next

/*------------------------------------------------------------------*/
/* S'il n'existe qu'un seul interlocuteur de concerné, on rend la   */
/* zone ID_I non saississable.                                      */
/*------------------------------------------------------------------*/
	If	UpperBound ( lInter ) = 1	Then
		sCodInter	= idw_Inter.GetItemString ( lLig, "COD_INTER" )
		idw_RegulFF.SetItem ( 1, "COD_INTER", sCodInter )

		idw_RegulFF.SetItem ( 1, "ID_I", lInter [ 1 ] )

		idw_RegulFF.Uf_Proteger ( { "ID_I"  }, "1" )
		idw_RegulFF.ilDernCol 	= 20		// ID_RGPT

	Else

		idw_RegulFF.Uf_Proteger ( { "ID_I"  }, "0" )
		idw_RegulFF.ilDernCol 	= 13		// ID_I

	End If
End Choose

end subroutine

private subroutine uf_preparervalider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une Régularisation
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdGti, lIdRgpt
String sIdGti


/*------------------------------------------------------------------*/
/* Modification RP/RM type FM en (Rmb Cie + Remb Fourn) ou (Rmb     */
/* Cie uniquement)                                                  */
/*------------------------------------------------------------------*/
This.uf_Modification_RM_RP_FM ()

/*------------------------------------------------------------------*/
/* On recopie le contenu de la DW idw_RegulFF dans la DW            */
/* idw_RegulMaster.                                                 */
/*------------------------------------------------------------------*/
idw_RegulMaster.Reset ()


/*------------------------------------------------------------------*/
/* S'il n'existe aucune ligne dans idw_RegFF (Cas d'un RP sur un    */
/* dossier refusé et jamais réglé). Il faut donc forcer             */
/* l'insertion d'une ligne dans idw_RegFF pour que les fonctions    */
/* de l'ancetre (RECOPIE DETAIL) puissent marcher.                  */
/*------------------------------------------------------------------*/
If	idw_RegFF.RowCount () = 0	Then
	idw_RegFF.InsertRow ( 0 )
End If

/*------------------------------------------------------------------*/
/* On arme la valeur de ID_GTI maintenant.                          */
/*------------------------------------------------------------------*/
Choose Case isTypeRegul

Case "2", "4"		// RM et RP (Garantie)

	lIdRgpt 	= idw_RegulFF.GetItemNumber ( 1, "ID_RGPT" )

  /*------------------------------------------------------------------*/
  /* DMDI6743 : IMPORTANT, actuellement DGA prend le 1er caractère    */
  /* du code de regroupement,														 */
  /* ex si id_rgpt = 720 alors Gti = 7											 */
  /* ex si id_rgpt = 5 alors Gti = 5											 */
  /* en revanche si id_rgpt = 10 alors Gti = 1 !!! et c'est faux !!   */
  /* 																						 */
  /* Je modifie donc de la sorte :												 */
  /* Si la longueur de id_rgpt >=3 alors on garde la méthode actuelle */
  /* Sinon id_gti = id_rgpt.														 */
  /*------------------------------------------------------------------*/
   If Len ( String ( lIdRgpt ) ) >= 3 Then
		sIdGti	= Left ( String ( lIdRgpt ), 1 )
	Else
		sIdGti	= String ( lIdRgpt )
	End If

	lIdGti	= Long ( sIdGti )
	idw_RegulFF.SetItem ( 1, "ID_GTI", lIdGti )


Case "3", "5"		// RM et RP (Frais)
	idw_RegulFF.SetItem ( 1, "ID_GTI", -1 )

End Choose

idw_RegulFF.RowsMove ( 1, 1, Primary!, idw_RegulMaster, 1, Primary! )





end subroutine

private subroutine uf_modification_rm_rp_fm ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_regul_detail::uf_Modification_Rm_Rp_Fm (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/08/2005 16:15:28
//* Libellé       : Modification du des RM/RP de Type FM afin de rembouser le Four+Cie ou bien que la Cie
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*		FPI	24/06/2014	[VDOC14621] Blocage avoir fourn si pas droit 208
// 		FPI	09/06/2015	[REGL_LBE]
//       JFF   18/03/2016  [VDOC20293]
//*-----------------------------------------------------------------

String sCodMotReg, sCodModeReg, sFour, sSql 
Boolean bCieETFrn

sCodMotReg = idw_RegulFF.GetItemString ( 1, "COD_MOT_REG" ) 
sCodModeReg = idw_RegulFF.GetItemString ( 1, "COD_MODE_REG" )

/*------------------------------------------------------------------*/
/* On ne traite que le cas des RM/FM et RP/FM                       */
/*------------------------------------------------------------------*/
If Not ( ( sCodMotReg = "RM" Or sCodMotReg ="RP" ) And sCodModeReg = "FM" ) Then Return

// [REGL_LBE]
sFour=""

sFour=idw_RegFF.Describe("Evaluate('LookUpDisplay(ID_I)', 1)")

if right(sFour,4) = "/LBE" Then  
	If  sCodMotReg = "RM" Then
		stMessage.sTitre		= "Choix Rembourser CIE"
		stMessage.sCode		= "REGU230"
	Else
		stMessage.sTitre		= "Choix Réclamer CIE"
		stMessage.sCode		= "REGU240"
	End if
	
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton = OK!
	
	f_message(stMessage)
	
	Return
End if
// :[REGL_LBE]


If sCodMotReg = "RM" Then
	stMessage.sTitre		= "Choix Rembourser CIE + Avoir SPB auprès du fournisseur"
	stMessage.sCode		= "REGU190"
End If

If sCodMotReg = "RP" Then
	stMessage.sTitre		= "Choix Réclamer CIE + Réclamer Fourn."
	stMessage.sCode		= "REGU200"
End If

stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YESNO!

// [VDOC14621]
bCieETFrn = F_Message ( stMessage ) = 1
If not uf_droit_factu( ) Then
	if bCieETFrn Then
		stMessage.sCode="REGU210"
		stMessage.Bouton		=OK!
		F_Message ( stMessage )
	End if
End if
// :[VDOC14621]

/*------------------------------------------------------------------*/
/* Remb ou Récl uniquement la CIE.                                  */
/*------------------------------------------------------------------*/
If Not bCieEtFrn Then
	idw_RegulFF.SetItem ( 1, "COD_MODE_REG", "C" )	
End If 


end subroutine

private function long uf_zn_rib ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Rib (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification du RIB
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------
//		JFF   31/10/2019	[VDOC28559]
//*-----------------------------------------------------------------

Integer iAction
String sRibBq, sRibGui, sRibCpt, sRibCle
long   dcIdProd, lIdCodeDP, lIdCodeNum, lValNum, lDeb, lFin, dcIdSin, dcIdRev, dcIdGti, lIdCie
string sIdTypCalc, sIdCodeCar, sValCar, sValCar2, sIdCie
n_cst_string lnvPFCString


dcIdProd = idw_Sin.GetItemNumber ( 1, "ID_PROD" )
iAction	= 2

Choose Case idw_RegulFF.isNomCol
Case "RIB_BQ"
	sRibBq	= String (  Dec ( idw_RegulFF.GetText () ), "00000" )
	idw_RegulFF.SetItem ( 1, "RIB_BQ", sRibBq )
	idw_RegulFF.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_GUI"
	sRibGui	= String ( Dec ( idw_RegulFF.GetText () ), "00000" )
	idw_RegulFF.SetItem ( 1, "RIB_GUI", sRibGui )
	idw_RegulFF.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_CPT"
	sRibCpt = Fill ( "0", 11 - Len ( idw_RegulFF.GetText () ) ) + idw_RegulFF.GetText ()
	idw_RegulFF.SetItem ( 1, "RIB_CPT", sRibCpt )
	idw_RegulFF.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_CLE"
	sRibBq	= idw_RegulFF.GetItemString ( 1, "RIB_BQ" )
	sRibGui	= idw_RegulFF.GetItemString ( 1, "RIB_GUI" )
	sRibCpt	= idw_RegulFF.GetItemString ( 1, "RIB_CPT" )

	sRibCle	= idw_RegulFF.GetText ()
			

	// [VDOC28559]
	lDeb = SQLCA.PS_S03_DET_PRO ( dcIdProd, 344, sIdTypCalc, lIdCodeNum, sIdCodeCar, lValNum, sValCar, sValCar2 ) 
	sValCar = sValCar + sValCar2

	If lDeb > 0 Then
		sIdCie = lnvPFCString.of_getkeyvalue (sValCar, "ID_CIE", ";")
		dcIdSin = idw_Sin.GetItemNumber ( 1, "ID_SIN" ) 
		dcIdRev = idw_Sin.GetItemNumber ( 1, "ID_REV" ) 
		SetNull ( dcIdGti )
		SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )
		
		If Pos ( sIdCie, "#" + String ( lIdCie ) + "#" ) > 0 Or IsNull ( lIdCie ) Or lIdCie = 0 Then
			iAction	= 1
			idw_RegulFF.iiErreur = 2
		End If 

	End If 
	
	// [VDOC28559]
	If	iAction = 2 And Not IsNull ( sRibBq + sRibGui + sRibCpt + sRibCle ) Then
		If	Not F_Rib ( sRibBq, sRibGui, sRibCpt, sRibCle ) Then
			iAction			= 1
			idw_RegulFF.iiErreur = 1
		End If
	End If

	If iAction <> 1 Then
		idw_RegulFF.SetItem ( 1, "RIB_CLE", sRibCle )
	End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
//idw_RegulFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 FM


end function

private function long uf_zn_codmodereg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_CodeModeReg (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification du Mode de Règlement
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If idw_RegulFF.GetItemString ( 1, "COD_MOT_REG" ) = "RI" And idw_RegulFF.GetText () = "FM" Then
	idw_RegulFF.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//	idw_RegulFF.SetActionCode (1)
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

If	idw_RegulFF.GetText () <> "VA"	Then

	idw_RegulFF.SetItem ( 1, "RIB_BQ", stNul.str )
	idw_RegulFF.SetItem ( 1, "RIB_GUI", stNul.str )
	idw_RegulFF.SetItem ( 1, "RIB_CPT", stNul.str )
	idw_RegulFF.SetItem ( 1, "RIB_CLE", stNul.str )

	idw_RegulFF.Uf_Proteger ( { "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

	idw_RegulFF.ilDernCol = 11	// COD_MODE_REG

Else

	idw_RegulFF.Uf_Proteger ( { "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )

	idw_RegulFF.ilDernCol = 9	// RIB_CLE

End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

private function long uf_zn_mttotreg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_MtTotReg (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification du montant
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------

String sText
Decimal {2} dcMtTotReg
Integer iAction

sText 		= idw_RegulFF.GetText ()
dcMtTotReg	= Dec ( sText )
iAction		= 2

Choose Case isTypeRegul
/*------------------------------------------------------------------*/
/* Dans le cas d'une régularisation (MOINS), le montant doit être   */
/* strictement négatif.                                             */
/*------------------------------------------------------------------*/
Case "2", "3"						// RM (Garantie) et RM (Frais)
	If	dcMtTotReg >= 0	Then
		iAction = 1
		idw_RegulFF.iiErreur = 1
	End If

/*------------------------------------------------------------------*/
/* Dans le cas d'une régularisation (PLUS), le montant doit être    */
/* strictement positif.                                             */
/*------------------------------------------------------------------*/
Case "4", "5"						// RP (Garantie) et RP (Frais)
	If	dcMtTotReg <= 0	Then
		iAction = 1
		idw_RegulFF.iiErreur = 2
	End If

End Choose

If	iAction = 2	Then
	idw_RegulFF.SetItem ( 1, "MT_TOT_REG", dcMtTotReg )
End If

//Migration PB8-WYNIWYG-03/2006 FM
//idw_RegulFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 FM


end function

private function long uf_zn_idi ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdI (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: On modifie le type d'interlocuteur, il faut armer la zone COD_INTER
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------

Long lIdI, lTotInter, lLig
String sText, sRech, sCodInter

sText = idw_RegulFF.GetText ()

lIdI	= Long ( sText )

/*------------------------------------------------------------------*/
/* L'interlocuteur doit être le même que celui du réglement         */
/* d'origine.                                                       */
/*------------------------------------------------------------------*/

If lIdI <> idw_RegFF.GetItemNumber ( 1, "ID_I" ) Then
	idw_RegulFF.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//	idw_RegulFF.SetActionCode ( 1 )
//	return
	Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

/*------------------------------------------------------------------*/
/* On vient de modifier la DDLB sur ID_I. Il faut armer le type de  */
/* l'interlocuteur. Pour cela, on le recherche dans la DW NTER.     */
/*------------------------------------------------------------------*/
lTotInter	= idw_Inter.RowCount ()
sRech			= "ID_I = " + sText
lLig			= idw_Inter.Find ( sRech, 1, lTotInter )

/*------------------------------------------------------------------*/
/* On doit forcément trouver la ligne dans INTER.                   */
/*------------------------------------------------------------------*/
sCodInter	= idw_Inter.GetItemString ( lLig, "COD_INTER" )
idw_RegulFF.SetItem ( 1, "COD_INTER", sCodInter )

//Migration PB8-WYNIWYG-03/2006 FM
Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_RegulFF
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0

Choose Case idw_RegulFF.isNomCol

Case "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE"
	ll_ret = Uf_Zn_Rib ()

Case "COD_MODE_REG" 
	ll_ret = Uf_Zn_CodModeReg ()

Case "MT_TOT_REG"
	ll_ret = Uf_Zn_MtTotReg ()

Case "ID_RGPT"
	Uf_Zn_IdRgpt ()

Case "ID_I"
	ll_ret = Uf_Zn_IdI ()

End Choose

Return ll_ret

//Choose Case idw_RegulFF.isNomCol
//
//Case "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE"
//	Uf_Zn_Rib ()
//
//Case "COD_MODE_REG" 
//	Uf_Zn_CodModeReg ()
//
//Case "MT_TOT_REG"
//	Uf_Zn_MtTotReg ()
//
//Case "ID_RGPT"
//	Uf_Zn_IdRgpt ()
//
//Case "ID_I"
//	Uf_Zn_IdI ()
//
//End Choose

//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function boolean uf_droit_factu ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_regul_detail::uf_droit_factu
//* Auteur			: F. Pinon
//* Date				: 24/06/2014
//* Libellé			: [VDoc14621]
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
/* La présence d'une ligne 208 pour l'opérateur */
/* connecté                                                           */   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 208		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;
 
 return (lTotLigne >0)
end function

on u_gs_sp_regul_detail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_regul_detail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

