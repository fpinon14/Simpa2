HA$PBExportHeader$u_gs_sp_regul.sru
$PBExportComments$---} User Object pour la gestion des r$$HEX1$$e900$$ENDHEX$$gularisations.
forward
global type u_gs_sp_regul from nonvisualobject
end type
end forward

global type u_gs_sp_regul from nonvisualobject
end type
global u_gs_sp_regul u_gs_sp_regul

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow		idw_Sin
	u_DataWindow		idw_RegulMaster

	u_DataWindow_Detail	idw_LstReg

	DataWindow		idw_Produit
	DataWindow		idw_Inter
	DataWindow		idw_W_Queue
	DataWindow		idw_W_A_Virer
	DataWindow		idw_Frais
	DataWindow		idw_RegGti

	u_Onglets		iUoOng

	Long			ilDernierIdProd = -9




end variables

forward prototypes
public subroutine uf_initialisation (ref U_DataWindow adw_Sin, ref U_Transaction atrTrans, ref U_Onglets auOnglet)
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparermodifier (ref s_pass astpass)
private function string uf_titre ()
private function long uf_existencetravail ()
private function long uf_existencevirement ()
public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_reg, ref u_DataWindow adw_RegulMaster, ref datawindow adw_norm[6])
private subroutine uf_affichermaster (ref s_pass astpass)
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_valider (ref s_pass astpass)
public function boolean uf_controle_suppl_rm_rp (integer altypregul, long alrow)
public function integer uf_preparervalider (ref s_pass astpassfranxregulretour)
end prototypes

public subroutine uf_initialisation (ref U_DataWindow adw_Sin, ref U_Transaction atrTrans, ref U_Onglets auOnglet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du sinistre
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*					  u_Onglets					auOnglet			(R$$HEX1$$e900$$ENDHEX$$f)	Onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_Sin		= adw_Sin
itrTrans		= atrTrans
iuoOng		= auOnglet

end subroutine

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fen$$HEX1$$ea00$$ENDHEX$$tre)
	Uf_InitialiserFenetre ()

Case 2					// MODIFICATION		(Wf_PreparerModifier)
	Uf_PreparerModifier ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )

Case 7					// VALIDER	(Wf_Valider) ( La fonction anc$$HEX1$$ea00$$ENDHEX$$tre est totalement r$$HEX2$$e900e900$$ENDHEX$$crite. )
	Uf_Valider ( astPass )

Case 8					// On se trouve sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_EnableFene
							// On vient de la fen$$HEX1$$ea00$$ENDHEX$$tre de saisie de la R$$HEX1$$e900$$ENDHEX$$gularisation.

	Uf_AfficherMaster ( astPass )


End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre des r$$HEX1$$e900$$ENDHEX$$gularisations
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1
String sCol [9]

/*------------------------------------------------------------------*/
/* On initialise l'objet de transaction de dw_Sin.                  */
/*------------------------------------------------------------------*/
idw_Sin.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes COD_CIV, COD_ETAT.                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* SINISTRE                                                         */
/*------------------------------------------------------------------*/
idw_Sin.GetChild ( "COD_CIV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CI", "-CL" )

idw_Sin.GetChild ( "COD_ETAT", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-ET" )

/*------------------------------------------------------------------*/
/* INTERLOCUTEURS                                                   */
/*------------------------------------------------------------------*/
idw_Inter.GetChild ( "COD_MODE_REG", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-MR" )

idw_Inter.GetChild ( "COD_INTER", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-IN" )

idw_Sin.GetChild ( "COD_CIV", dwChild )
idw_Inter.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* REGLEMENTS                                                       */
/*------------------------------------------------------------------*/
idw_LstReg.GetChild ( "ID_I", dwChild)
idw_Inter.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* REGULARISATIONS                                                  */
/*------------------------------------------------------------------*/
idw_Inter.GetChild ( "COD_INTER", dwChild )
idw_RegulMaster.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Inter.GetChild ( "COD_MODE_REG", dwChild )
idw_RegulMaster.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On s'occupe maintenant des r$$HEX1$$e800$$ENDHEX$$glements.                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
idw_LstReg.isTri = "ID_SIN A, ID_REG A"
idw_LstReg.Uf_Activer_Selection ( True )

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur.         */
/*------------------------------------------------------------------*/
sCol [  1 ] = "COD_MODE_REG"
sCol [  2 ] = "RIB_BQ"
sCol [  3 ] = "RIB_GUI"
sCol [  4 ] = "RIB_CPT"
sCol [  5 ] = "RIB_CLE"
sCol [  6 ] = "MT_TOT_REG"
sCol [  7 ] = "ID_I"
sCol [  8 ] = "ID_RGPT"
sCol [  9 ] = "LIB_REG"

idw_RegulMaster.Uf_InitialiserCouleur ( sCol )
idw_RegulMaster.Uf_Proteger ( sCol, "1" )


end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification d'une r$$HEX1$$e900$$ENDHEX$$gularisation.
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdProd

Boolean bRet

bRet = True

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'enregistrement.                                    */
/*------------------------------------------------------------------*/
If	idw_Sin.Retrieve ( Dec ( astPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

If	bRet	Then
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le produit.                                          */
/*------------------------------------------------------------------*/
	lIdProd = idw_Sin.GetItemNumber ( 1, "ID_PROD" )
	If	lIdProd <> ilDernierIdProd	Then
		idw_Produit.Retrieve ( lIdProd )
		ilDernierIdProd = lIdProd
	End If

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des interlocuteurs.                         */
/*------------------------------------------------------------------*/
	idw_Inter.Retrieve ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des r$$HEX1$$e800$$ENDHEX$$glements.                             */
/*------------------------------------------------------------------*/
	idw_LstReg.Retrieve ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les frais.                                           */
/*------------------------------------------------------------------*/
	idw_Frais.Retrieve ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les regroupements par garantie.                      */
/*------------------------------------------------------------------*/
	idw_RegGti.Retrieve ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On arme la cha$$HEX1$$ee00$$ENDHEX$$ne de retour pour le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre.         */
/*------------------------------------------------------------------*/
	astPass.sTab [ 1 ] = Uf_Titre ()

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe un travail en cours pour le dossier de    */
/* sinistre.                                                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si on donne acc$$HEX1$$e900$$ENDHEX$$s au bouton CONTROLE de la fen$$HEX1$$ea00$$ENDHEX$$tre.   */
/* Le bouton sera rendu inactif dans la fonction                    */
/* Wf_PreparerModifier de la fen$$HEX1$$ea00$$ENDHEX$$tre.                               */
/*------------------------------------------------------------------*/
	If	Uf_ExistenceTravail () < 0	Then
		astPass.lTab[1] = 0			// Il faut d$$HEX1$$e900$$ENDHEX$$sactiver le bouton
	Else
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe un virement en cours pour ce dossier.     */
/*------------------------------------------------------------------*/
		If	Uf_ExistenceVirement () < 0 Then
			astPass.lTab[1] = 0			// Il faut d$$HEX1$$e900$$ENDHEX$$sactiver le bouton
		Else
			astPass.lTab[1] = 1			// Il faut activer le bouton
		End If
	End If

/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet (DataWindow de SINISTRE)   */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/
	iuoOng.Uf_ChangerOnglet ( "01" )

/*------------------------------------------------------------------*/
/* Il faut rendre la DW idw_RegulMaster invisible.                  */
/*------------------------------------------------------------------*/
	idw_RegulMaster.Reset ()
	idw_RegulMaster.Visible = FALSE

End If
		
astPass.bRetour = bRet

end subroutine

private function string uf_titre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Titre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 12/01/1998 22:30:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Mettre un titre dans la fen$$HEX1$$ea00$$ENDHEX$$tre MASTER
//*
//* Arguments		: ucun
//*
//* Retourne		: String			Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre se d$$HEX1$$e900$$ENDHEX$$compose ainsi :                      */
/* LIB_COURT (ID_PROD) (R$$HEX1$$e900$$ENDHEX$$v : ID_REV) / Sinistre N$$HEX2$$b0002000$$ENDHEX$$ID_SIN / COD_CIV NOM PRENOM    */
/*------------------------------------------------------------------*/

String sRet, sCodCiv, sNom, sPrenom

sCodCiv	= idw_Sin.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )
sNom		= idw_Sin.GetItemString ( 1, "NOM" )
sPrenom	= idw_Sin.GetItemString ( 1, "PRENOM" )

If	IsNull ( sNom ) 		Then sNom = ""
If	IsNull ( sPrenom )	Then sPrenom = ""

sRet =	idw_Produit.GetItemString ( 1, "LIB_COURT" )									+ " ("					+ &
			String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ) ) 					+ ") (R$$HEX1$$e900$$ENDHEX$$v : "			+ &
			String ( idw_Sin.GetItemNumber ( 1, "ID_REV" ) ) 							+ ") / Sinistre N$$HEX2$$b0002000$$ENDHEX$$"	+ &
			String ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )							+ " / " 					+ &
			sCodCiv																					+ " " 					+ &
			sNom																						+ " " 					+ &
			sPrenom

Return ( sRet )
end function

private function long uf_existencetravail ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Regul::Uf_ExistenceTravail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 11/03/1999 17:09:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe un travail en cours pour le dossier de sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long			 1 = Pas de travail en cours
//*										-1	= Existence d'un travail
//*
//*-----------------------------------------------------------------

Long lRet, lTot
String sIdSin

sIdSin 	= String ( idw_Sin.GetItemNumber ( 1, "ID_SIN" ) )
lRet		= 1

lTot = idw_w_Queue.Retrieve ( sIdSin )

If	lTot >= 1	Then
	lRet = -1

/*------------------------------------------------------------------*/
/* On affiche imm$$HEX1$$e900$$ENDHEX$$diatement le message.                             */
/*------------------------------------------------------------------*/
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "REGU100"
	stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
	stMessage.Icon			= StopSign!

	F_Message ( stMessage )

End If

Return ( lRet )
end function

private function long uf_existencevirement ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Regul::Uf_ExistenceVirement (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 11/03/1999 17:09:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe un virement en cours pour le dossier de sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long			 1 = Pas de virement en cours
//*										-1	= Existence d'un virement
//*
//*-----------------------------------------------------------------

Long lRet, lTot, lIdSin

lIdSin 	= idw_Sin.GetItemNumber ( 1, "ID_SIN" )
lRet		= 1

lTot = idw_W_A_Virer.Retrieve ( lIdSin )

If	lTot >= 1	Then
	lRet = -1

/*------------------------------------------------------------------*/
/* On affiche imm$$HEX1$$e900$$ENDHEX$$diatement le message.                             */
/*------------------------------------------------------------------*/
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "REGU110"
	stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
	stMessage.Icon			= StopSign!

	F_Message ( stMessage )

End If

Return ( lRet )
end function

public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_reg, ref u_DataWindow adw_RegulMaster, ref datawindow adw_norm[6]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_Reg				(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow sur les r$$HEX1$$e800$$ENDHEX$$glements
//*					  U_DataWindow				adw_RegulMaster	(R$$HEX1$$e900$$ENDHEX$$f)	U_DataWindow pour le stockage de la r$$HEX1$$e900$$ENDHEX$$gul
//*					  DataWindow				adw_Norm[6]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les REGLEMENTS. Liste => U_DataWindow_Detail.     */
/*------------------------------------------------------------------*/
idw_LstReg	= adw_Reg
idw_LStReg.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow servant au stockage de la r$$HEX1$$e900$$ENDHEX$$gularisation.             */
/*------------------------------------------------------------------*/
idw_RegulMaster	= adw_RegulMaster

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table PRODUIT.                                 */
/*------------------------------------------------------------------*/
idw_Produit	= adw_Norm[1]
idw_Produit.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table INTER.                                   */
/*------------------------------------------------------------------*/
idw_Inter	= adw_Norm[2]
idw_Inter.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_QUEUE.                                 */
/*------------------------------------------------------------------*/
idw_W_Queue	= adw_Norm[3]
idw_W_Queue.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_A_VIRER.                               */
/*------------------------------------------------------------------*/
idw_W_A_Virer	= adw_Norm[4]
idw_W_A_Virer.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table FRAIS.                                   */
/*------------------------------------------------------------------*/
idw_Frais	= adw_Norm[5]
idw_Frais.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table REG_GTI.                                 */
/*------------------------------------------------------------------*/
idw_RegGti	= adw_Norm[6]
idw_RegGti.SetTransObject ( This.itrTrans )


end subroutine

private subroutine uf_affichermaster (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_AfficherMaster (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage de la DW idw_RegulMaster
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTypeRegul, sTitre, sMod, sRech, sVal, sTab
Long lIdRgpt, lIdI, lTotRegGti, lTotInter, lLig

sTab = "~t"

/*------------------------------------------------------------------*/
/* S'il existe une ligne dans la DW c'est que l'on vient de         */
/* valider une r$$HEX1$$e900$$ENDHEX$$gularisation. On positionne la DW de mani$$HEX1$$e800$$ENDHEX$$re       */
/* visible.                                                         */
/*------------------------------------------------------------------*/
If	idw_RegulMaster.RowCount ()	> 0	Then
	idw_RegulMaster.Visible	= TRUE

	sTypeRegul = astPass.sTab[1]

	Choose Case sTypeRegul
	Case "1"		// RI 
		sTitre = "Repr$$HEX1$$e900$$ENDHEX$$sentation Impay$$HEX2$$e9002000$$ENDHEX$$(RI)"

	Case "2"		// RM (Garantie)
		sTitre = "RM $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$duire sur garantie"

	Case "3"		// RM (Frais)
		sTitre = "RM $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$duire sur frais"

	Case "4"		// RP (Garantie)
		sTitre = "RP $$HEX2$$e0002000$$ENDHEX$$ajouter sur garantie"

	Case "5"		// RP (Frais)
		sTitre = "RP $$HEX2$$e0002000$$ENDHEX$$ajouter sur frais"
	End Choose

/*------------------------------------------------------------------*/
/* On modifie le titre de la DW pour la consultation de la          */
/* r$$HEX1$$e900$$ENDHEX$$gularisation.                                                  */
/*------------------------------------------------------------------*/
	sMod = "s_Titre.Text='" + sTitre + "'"
	idw_RegulMaster.Uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* On s'occupe des deux zones au format DDLB. (ID_RGPT, ID_).       */
/*------------------------------------------------------------------*/
	If	sTypeRegul = "5"	Then
/*------------------------------------------------------------------*/
/* Dans le cas d'un RM sur frais, on autorise les deux types de     */
/* frais qui ne se trouvent pas forc$$HEX1$$e900$$ENDHEX$$ment - actuellement - dans la  */
/* table REG_GTI. Il faut donc populiser la DDLB $$HEX2$$e0002000$$ENDHEX$$la main.         */
/*------------------------------------------------------------------*/
		sVal = "Frais Envoi" + sTab + "1"
		idw_RegulMaster.SetValue ( "ID_RGPT", 1, sVal )

		sVal = "Frais de PV" + sTab + "2"
		idw_RegulMaster.SetValue ( "ID_RGPT", 2, sVal )

	Else
		lIdRgpt		= idw_RegulMaster.GetItemNumber ( 1, "ID_RGPT" )
		lTotRegGti	= idw_RegGti.RowCount ()
		sRech 		= "ID_RGPT = " + String ( lIdRgpt )
		lLig			= idw_RegGti.Find ( sRech, 1, lTotRegGti )
		sVal			= idw_RegGti.GetItemString ( lLig, "LIB_CODE" ) + sTab + String ( lIdRgpt )

		idw_RegulMaster.SetValue ( "ID_RGPT", 1, sVal )
	End If
	

	lIdI			= idw_RegulMaster.GetItemNumber ( 1, "ID_I" )
	lTotInter	= idw_Inter.RowCount ()
	sRech 		= "ID_I = " + String ( lIdI )
	lLig			= idw_Inter.Find ( sRech, 1, lTotInter )
	sVal			= idw_Inter.GetItemString ( lLig, "NOM" ) + sTab + String ( lIdI )

	idw_RegulMaster.SetValue ( "ID_I", 1, sVal )

End If



end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Regul::Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'une r$$HEX1$$e900$$ENDHEX$$gularisation
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sPos
Long lRet

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si un travail ne vient pas d'$$HEX1$$ea00$$ENDHEX$$tre cr$$HEX2$$e900e900$$ENDHEX$$. Ce test est   */
/* fait sur la Uf_PrepareModifier (), mais il est indispensable de  */
/* le refaire $$HEX2$$e0002000$$ENDHEX$$la fin.                                             */
/*------------------------------------------------------------------*/

lRet = Uf_ExistenceTravail ()

If	lRet < 0 Then
/*------------------------------------------------------------------*/
/* Le message d'erreur est affich$$HEX2$$e9002000$$ENDHEX$$dans la fonction.                */
/*------------------------------------------------------------------*/
	sPos = "ID_SIN"
End If
		
astPass.sTab [ 1 ] 	= sPos


end subroutine

private subroutine uf_valider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Regul::Uf_Valider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Enregistrement des informations correspondant $$HEX2$$e0002000$$ENDHEX$$la saisie
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

Boolean bRet

Decimal {2} dcMtTotReg
Int iRet 

Decimal {0}	dcIdSin, dcIdRegBase, dcIdI, dcIdRgpt, dcIdGti, dcCptReg
String sLibReg, sCodModeReg, sCodMotReg, sRibBq, sRibGui, sRibCpt, sRibCle, sCodInter, sCodOper, sProc

DateTime dtDteReg, dtCreeLe
s_Pass stPassFrAnxRegulRetour 

bRet = True

sProc			= Space ( 60 )

// [PM80_FA12_FRANEX]
iRet = This.Uf_PreparerValider ( stPassFrAnxRegulRetour )
If iRet < 0 Then
	astPass.bRetour = False
	Return
End If 

/*------------------------------------------------------------------*/
/* On arme les variables dont on a besoin dans la proc$$HEX1$$e900$$ENDHEX$$dure.        */
/*------------------------------------------------------------------*/
dcIdSin		= idw_Sin.GetItemNumber ( 1, "ID_SIN" )
dcCptReg		= idw_Sin.GetItemNumber ( 1, "CPT_REG" )

dcIdRegBase	= idw_RegulMaster.GetItemNumber ( 1, "ID_REG_BASE" )
dcIdI			= idw_RegulMaster.GetItemNumber ( 1, "ID_I" )
dcIdRgpt		= idw_RegulMaster.GetItemNumber ( 1, "ID_RGPT" )
dcIdGti		= idw_RegulMaster.GetItemNumber ( 1, "ID_GTI" )

sLibReg		= idw_RegulMaster.GetItemString ( 1, "LIB_REG" )
sCodModeReg	= idw_RegulMaster.GetItemString ( 1, "COD_MODE_REG" )
sCodMotReg	= idw_RegulMaster.GetItemString ( 1, "COD_MOT_REG" )

sRibBq		= F_GetString ( idw_RegulMaster, 1, "RIB_BQ" )
sRibGui		= F_GetString ( idw_RegulMaster, 1, "RIB_GUI" )
sRibCpt		= F_GetString ( idw_RegulMaster, 1, "RIB_CPT" )
sRibCle		= F_GetString ( idw_RegulMaster, 1, "RIB_CLE" )

dcMtTotReg	= idw_RegulMaster.GetItemDecimal ( 1, "MT_TOT_REG" )

sCodInter	= idw_RegulMaster.GetItemString ( 1, "COD_INTER" )
sCodOper		= stGLB.sCodOper

dtDteReg		= idw_RegulMaster.GetItemDateTime ( 1, "DTE_REG" ) // [PI056] Date->datetime
dtCreeLe		= idw_RegulMaster.GetItemDateTime ( 1, "CREE_LE" )

itrTrans.PS_VAL_REGUL		 (	sLibReg,				&
										sCodModeReg,		&
										sRibBq,				&
										sRibGui,				&
										sRibCpt,				&
										sRibCle,				&
										dtDteReg,			&
										dcMtTotReg,			&
										sCodMotReg,			&
										dcIdRegBase,		&
										dcIdSin,				&
										dcIdI,				&
										dcCptReg,			&
										sCodInter,			&
										dcIdRgpt,			&
										dcIdGti,				&
										dtCreeLe,			&
										sCodOper,			&
										sProc )

/*------------------------------------------------------------------*/
/* La zone sProc est pass$$HEX1$$e900$$ENDHEX$$e par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence. Elle est arm$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$''      */
/* dans la proc$$HEX1$$e900$$ENDHEX$$dure. Si une erreur survient, on arme cette cha$$HEX1$$ee00$$ENDHEX$$ne  */
/* pour expliquer ou est survenue l'erreur.                         */
/*------------------------------------------------------------------*/
sProc = Trim ( sProc )
If	sProc <> "" Then bRet = False

/*------------------------------------------------------------------*/
/* Si SqlDbCode est arm$$HEX1$$e900$$ENDHEX$$, on part du principe qu'il y a eu une      */
/* erreur, et ce quel que soit la valeur de sProc.                  */
/*------------------------------------------------------------------*/
If itrTrans.SqlCode <> 0 Then bRet = False

// [PM80_FA12_FRANEX]
If Not bRet Then
	/*------------------------------------------------------------------*/
	/* On charge les valeurs de la structure Message avec les valeurs   */
	/* de itrTrans, avant de faire un ROLLBACK.                         */
	/*------------------------------------------------------------------*/
	
		stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.sVar[1] 	= sProc
		stMessage.sVar[2] 	= String ( itrTrans.SqlDbCode )
		stMessage.sVar[3] 	= itrTrans.SqlErrText
		stMessage.sCode		= "WORK220"
		stMessage.bTrace  	= True
	
	/*------------------------------------------------------------------*/
	/* On peut envoyer le ROLLBACK.                                     */
	/*------------------------------------------------------------------*/
		F_Commit ( itrTrans, False )
	/*------------------------------------------------------------------*/
	/* On peut afficher le message sans risques.                        */
	/*------------------------------------------------------------------*/
		F_Message ( stMessage )
		astPass.bRetour = bRet
		Return 
	
End If 

If iRet = 1 Then
	itrTrans.PS_I_REG_FRAIS_ANNEXE_FRN_V01 ( &
												dcIdSin, &
												dcCptReg + 1, &
												dcIdI, &
												dcIdGti, &
												-1, &
												stPassFrAnxRegulRetour.dcTab [1], &  
												stPassFrAnxRegulRetour.dcTab [2], &  
												stPassFrAnxRegulRetour.dcTab [3], &  
												stPassFrAnxRegulRetour.dcTab [4], &  
												stPassFrAnxRegulRetour.dcTab [5], &  
												stPassFrAnxRegulRetour.dcTab [6], &  
												stPassFrAnxRegulRetour.dcTab [7], &  
												stPassFrAnxRegulRetour.dcTab [8], &  
												stPassFrAnxRegulRetour.dcTab [9], &  
												stPassFrAnxRegulRetour.dcTab [10], &  
												stPassFrAnxRegulRetour.dcTab [11], &  
												sCodOper )

	If itrTrans.SqlCode <> 0 Then bRet = False
	
End If 

/*------------------------------------------------------------------*/
/* On s'occupe maintenant du COMMIT, ou du ROLLBACK.                */
/*------------------------------------------------------------------*/
If	bRet	Then
	F_Commit ( itrTrans, True )

Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/

	stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sVar[1] 	= sProc
	stMessage.sVar[2] 	= String ( itrTrans.SqlDbCode )
	stMessage.sVar[3] 	= itrTrans.SqlErrText
	stMessage.sCode		= "WORK220"
   stMessage.bTrace  	= True

/*------------------------------------------------------------------*/
/* On peut envoyer le ROLLBACK.                                     */
/*------------------------------------------------------------------*/
	F_Commit ( itrTrans, False )
/*------------------------------------------------------------------*/
/* On peut afficher le message sans risques.                        */
/*------------------------------------------------------------------*/
	F_Message ( stMessage )
End If

astPass.bRetour = bRet

end subroutine

public function boolean uf_controle_suppl_rm_rp (integer altypregul, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_regul::uf_Controle_Suppl_RM_RP (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 01/08/2005 16:17:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le Suppl$$HEX1$$e900$$ENDHEX$$mentaire pour les RM
//* Commentaires  : 
//*
//* Arguments     :  Long		alTypRegul	(Val)		// Type r$$HEX1$$e900$$ENDHEX$$gul
//*						Long		alRow			(Val)		// Ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*		FPI	09/06/2015	[REGL_LBE]
//*-----------------------------------------------------------------

Boolean bOk
Long lIdReg, lIdSin
String	sCodInter, sCodModeReg, sCodMotReg, sNom
DataWindowChild ddwc

bOk = TRUE

If alRow <=0 Then return TRUE

sCodInter	= Upper ( Trim ( idw_LstReg.GetItemString ( alRow, "COD_INTER" ) ) )
sCodModeReg	= Upper ( Trim ( idw_LstReg.GetItemString ( alRow, "COD_MODE_REG" ) ) )
sCodMotReg	= Upper ( Trim ( idw_LstReg.GetItemString ( alRow, "COD_MOT_REG" ) ) )
lIdSin = idw_LstReg.GetItemNumber ( alRow, "ID_SIN" ) 
lIdReg = idw_LstReg.GetItemNumber ( alRow, "ID_REG" ) 

// [REGL_LBE]
if sCodModeReg = "XA" or  sCodModeReg = "XX" Then
	stMessage.sTitre		= "Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "REGU220"
	If sCodModeReg = "XX" Then stMessage.sCode = "REGU250"
	stMessage.Bouton		= OK!
	f_message(stMessage)
	
	Return FALSE
End if
// :[REGL_LBE]
/*------------------------------------------------------------------*/
/* Ce contr$$HEX1$$f400$$ENDHEX$$le ne concerne que les RN/FM/ASSURE                     */
/*------------------------------------------------------------------*/
If sCodInter <> "A" Or sCodModeReg	<> "FM" Or  sCodMotReg <> "RN" Then Return TRUE

bOk = False

stMessage.sTitre		= "Proc$$HEX1$$e900$$ENDHEX$$dure RM/FM/ASSURE"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= OK!
Choose Case alTypRegul
	Case 2  // RM
		stMessage.sCode		= "REGU140"
	Case 4  // RP
		stMessage.sCode		= "REGU170"
End Choose
stMessage.sVar[1]		= String ( lIdSin )
stMessage.sVar[2]		= String ( lIdReg )

F_Message  ( stMessage )

Return bOk
end function

public function integer uf_preparervalider (ref s_pass astpassfranxregulretour);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Regul::Uf_PreparerValider (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/10/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM80_FA12_FRANEX]
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long dcIdSin, lTotInter, lLig
Integer dcIdRegBase, iRet, dcIdGti, dcIdI	
DateTime dtDteRegBase, dtDtePivotMepPM80
String sResult, sCodMotReg, sCodInter, sLibFour, sRech
s_Pass stPassFrAnxRegul 
Decimal {2} dcMtTotReg

dcIdSin		= idw_Sin.GetItemNumber ( 1, "ID_SIN" )
dcIdRegBase	= idw_RegulMaster.GetItemNumber ( 1, "ID_REG_BASE" )
sCodMotReg	= idw_RegulMaster.GetItemString ( 1, "COD_MOT_REG" )
dcIdGti		= idw_RegulMaster.GetItemNumber ( 1, "ID_GTI" )
dcIdI			= idw_RegulMaster.GetItemNumber ( 1, "ID_I" )
dcMtTotReg	= idw_RegulMaster.GetItemDecimal ( 1, "MT_TOT_REG" )
sCodInter	= idw_RegulMaster.GetItemString ( 1, "COD_INTER" )

lTotInter	= idw_Inter.RowCount ()
sRech 		= "ID_I = " + String ( dcIdI )
lLig			= idw_Inter.Find ( sRech, 1, lTotInter )
sLibFour		= idw_Inter.GetItemString ( lLig, "NOM" ) 


// On ouvre la fen$$HEX1$$ea00$$ENDHEX$$tre que sur un RN d'origine li$$HEX4$$e9002000e0002000$$ENDHEX$$un Fournisseur.
If sCodInter <> "F" Then Return 2

// Contr$$HEX1$$f400$$ENDHEX$$le que le r$$HEX1$$e800$$ENDHEX$$glement de base ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s la MEP du PM80, si c'est avant, interdiction de ventiler.
iRet = SQLCA.PS_S_PM80_CTRLE_VENTIL_REG_BASE ( dcIdSin, dcIdRegBase, -1, dtDteRegBase, dtDtePivotMepPM80, sResult ) 

If iRet < 0 Then
	stMessage.sCode		= "REGU270"		
	stMessage.sTitre		= "Pas de ventilation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sVar[1]    = sResult
	
	F_Message ( stMessage )
	
	Return -1
	
End IF 

If dtDteRegBase < dtDtePivotMepPM80 Then

	stMessage.sCode		= "REGU265"		
	stMessage.sTitre		= "Pas de ventilation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sVar[1]    = sCodMotReg
	stMessage.sVar[2]    = String ( dtDteRegBase, "dd/mm/yyyy hh:mm:ss")
	stMessage.sVar[3]    = String ( dtDtePivotMepPM80, "dd/mm/yyyy hh:mm:ss")
	stMessage.sVar[4]    = sCodMotReg	
	
	F_Message ( stMessage )
	
	Return 2
	
End If 



// Ouverture fen$$HEX1$$ea00$$ENDHEX$$tre
stPassFrAnxRegul.lTab[1]		= dcIdSin
stPassFrAnxRegul.lTab[2]		= dcIdI
stPassFrAnxRegul.lTab[3]		= dcIdGti
stPassFrAnxRegul.lTab[4]		= -1 // lIdDetail

stPassFrAnxRegul.sTab[1]		= sCodInter	
stPassFrAnxRegul.sTab[2]		= sCodMotReg	
stPassFrAnxRegul.sTab[3]		= sLibFour

stPassFrAnxRegul.dcTab[1]		= dcMtTotReg
stPassFrAnxRegul.dcTab[2]		= dcIdRegBase

OpenWithParm ( W_t_sp_frais_annexe_frn_regul, stPassFrAnxRegul ) 

astPassFrAnxRegulRetour = Message.PowerObjectParm


Return 1
end function

on u_gs_sp_regul.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_regul.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

