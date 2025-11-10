HA$PBExportHeader$u_gs_sp_cas_id_adh.sru
forward
global type u_gs_sp_cas_id_adh from nonvisualobject
end type
end forward

global type u_gs_sp_cas_id_adh from nonvisualobject
end type
global u_gs_sp_cas_id_adh u_gs_sp_cas_id_adh

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow		idw_wSin

	String			isSysadm = "sysadm."
	String			isTypeTrt = ""
	String			isFicTrace = ""

	DataWindow		idw_Produit
	DataWindow		idw_SinLie
	DataWindow		idw_IdOrdreLie
	DataWindow		idw_SinLie_Nouveau
	DataWindow		idw_wDetail

	u_Onglets		iUoOng




end variables

forward prototypes
public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet, string astypetrt)
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparermodifier (ref s_pass astpass)
private function string uf_titre (integer aiType)
private function boolean uf_sinistre_lie ()
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_valider (ref s_pass astpass)
private function boolean uf_sinistre_lie_nouveau ()
public subroutine uf_initialiser_dw (ref datawindow adw_norm[5])
private subroutine uf_ecriretrace ()
private function long uf_zn_idadh (ref s_pass astpass)
public function long uf_zn_trt (ref s_pass astpass)
end prototypes

public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet, string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_ADh::Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du sinistre
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*					  u_Onglets					auOnglet			(R$$HEX1$$e900$$ENDHEX$$f)	Onglet
//*					  String						asTypeTrt		(Val)	Type de traitement (Saisie/Consultation/Validation)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_wSin		= adw_Sin
itrTrans		= atrTrans
iuoOng		= auOnglet
isTypeTrt	= asTypeTrt
end subroutine

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Traitement (PUBLIC)
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

End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion des cas particuliers
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

String sRep

/*------------------------------------------------------------------*/
/* On initialise l'objet de transaction de dw_wSIn.                 */
/*------------------------------------------------------------------*/
idw_wSin.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes COD_CIV, ID_TYPE_CARTE.                                 */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "COD_CIV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CI", "-CL" )

idw_wSin.GetChild ( "ID_TYPE_CARTE", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-TC" )

idw_wSin.GetChild ( "COD_CIV", dwChild )
idw_SinLie.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "ID_TYPE_CARTE", dwChild )
idw_wSin.GetChild ( "ID_TYPE_CARTE_NOUVEAU", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_CIV", dwChild )
idw_SinLie_Nouveau.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_CAS", "" )
isFicTrace = sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )




end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdProd, lIdSin, lTotDetail, lLig

Boolean bRet

DataWindowChild	dwChild

Decimal {2} dcMtReg

String	sRech

bRet = True

/*------------------------------------------------------------------*/
/* On initialise la DDDW $$HEX2$$e0002000$$ENDHEX$$vide sur ID_ETS maintenant, car elle     */
/* peut changer de valeur en fonction du COD_ADH.                   */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "ID_ETS", dwChild )
dwChild.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'enregistrement.                                    */
/*------------------------------------------------------------------*/
If	idw_wSin.Retrieve ( Dec ( astPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

/*------------------------------------------------------------------*/
/* On charge les informations pour le PRODUIT.                      */
/*------------------------------------------------------------------*/
If	bRet Then
	lIdProd	= idw_wSin.GetItemNumber ( 1, "ID_PROD" )

	If	idw_Produit.Retrieve ( lIdProd ) <= 0 Then 
		bRet = False
	Else
/*------------------------------------------------------------------*/
/* On s'occupe de populiser les etablissements en fonction du       */
/* COD_ADH de la table PRODUIT. Si COD_ADH = 2,4,5.                 */
/*------------------------------------------------------------------*/
		idw_wSin.GetChild ( "ID_ETS", dwChild )
		dwChild.SetTransObject ( This.itrTrans )
		dwChild.Retrieve ( lIdProd, -1 )

	End If
End If

If	bRet Then
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des d$$HEX1$$e900$$ENDHEX$$tails.                                */
/*------------------------------------------------------------------*/
//	idw_wDetail.Retrieve ( idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On arme la cha$$HEX1$$ee00$$ENDHEX$$ne de retour pour le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre.         */
/*------------------------------------------------------------------*/
	astPass.sTab [ 1 ] = Uf_Titre ( 1 )

/*------------------------------------------------------------------*/
/* Il y a deux colonnes de saisissable. (ID_ADH_NOUVEAU et          */
/* PRENOM). Une seule de ces colonnes est modifiable.               */
/* (ID_ADH_NOUVEAU). On est oblig$$HEX2$$e9002000$$ENDHEX$$de faire de cette mani$$HEX1$$e800$$ENDHEX$$re avec   */
/* le ph$$HEX1$$e900$$ENDHEX$$nom$$HEX1$$e900$$ENDHEX$$ne de bouclage sur la DW.                              */
/*------------------------------------------------------------------*/
	idw_wSin.ilPremCol	= 24
	idw_wSin.ilDernCol	= 9
	idw_wSin.isNomCol		= "ID_ADH_NOUVEAU"

	idw_wSin.SetColumn ( idw_wSin.ilPremCol )


	If	Uf_Sinistre_Lie ()	Then
		astPass.lTab[1] = 1				// Le bouton CTL est accessible
	Else
		astPass.lTab[1] = 0				// Le bouton CTL n'est pas accessible. 
	End If

/*------------------------------------------------------------------*/
/* Si le sinistre a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$gl$$HEX1$$e900$$ENDHEX$$, on interdit toute modification. */
/*------------------------------------------------------------------*/
	If	astPass.lTab[1] = 1	Then
		dcMtReg = idw_wSin.GetItemNumber ( 1, "MT_REG" )

		If	dcMtReg > 0	Then 	
			astPass.lTab[1] = 0				// Le bouton CTL n'est pas accessible. 

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les cas particuliers"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.sCode		= "CASP100"
			stMessage.bTrace		= True

			F_Message ( stMessage )
		End If
	End If

/*------------------------------------------------------------------*/
/* S'il existe des d$$HEX1$$e900$$ENDHEX$$tails pour la garantie UF, on interdit toute   */
/* modification.                                                    */
/*------------------------------------------------------------------*/
	If	astPass.lTab[1] = 1	Then
		lIdSin = idw_wSin.GetItemNumber ( 1, "ID_SIN" )		
		idw_wDetail.Retrieve ( lIdSin )
		lTotDetail = idw_wDetail.RowCount ()
	
		sRech = "ID_GTI = 2 Or ( ID_GTI = 7 And ID_EVT >= 700 And ID_EVT <= 719 )"
		lLig	= idw_wDetail.Find ( sRech, 1, lTotDetail )
		If	lLig > 0 Then

			astPass.lTab[1] = 0				// Le bouton CTL n'est pas accessible. 

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les cas particuliers"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.sCode		= "CASP200"
			stMessage.bTrace		= True

			F_Message ( stMessage )
		End If
	End If

/*------------------------------------------------------------------*/
/* On arme les zones ID_ETS_NOUVEAU, ID_TYPE_CARTE_NOUVEAU,         */
/* ID_CARTE avec des valeurs NULL.                                  */
/*------------------------------------------------------------------*/
	If	astPass.lTab[1] = 1	Then
		idw_wSin.SetItem ( 1, "ID_ETS_NOUVEAU", 0 )
		idw_wSin.SetItem ( 1, "ID_TYPE_CARTE_NOUVEAU", "00" )
		idw_wSin.SetItem ( 1, "ID_CARTE_NOUVEAU", 0 )
		idw_wSin.SetItem ( 1, "ID_ORDRE_NOUVEAU", stNul.dcm )
	End If	

/*------------------------------------------------------------------*/
/* L'onglet sur les sinistres li$$HEX1$$e900$$ENDHEX$$s APRES modification est rendu     */
/* inactif.                                                         */
/*------------------------------------------------------------------*/
	idw_SinLie_Nouveau.Reset ()
	idw_IdOrdreLie.Reset ()
	iuoOng.Uf_ActiverOnglet ( "03", False )

/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet (DataWindow de SINISTRE)   */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/
	iuoOng.Uf_ChangerOnglet ( "01" )

End If

astPass.bRetour	= bRet

end subroutine

private function string uf_titre (integer aiType);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Titre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 12/01/1998 22:30:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Mettre un titre dans la fen$$HEX1$$ea00$$ENDHEX$$tre MASTER
//*
//* Arguments		: Integer		aiType			(Val)	Type de choix
//*
//* Retourne		: String			Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre se d$$HEX1$$e900$$ENDHEX$$compose ainsi :                      */
/* LIB_COURT (ID_PROD) (R$$HEX1$$e900$$ENDHEX$$v : ID_REV) / Sinistre N$$HEX2$$b0002000$$ENDHEX$$ID_SIN / COD_CIV NOM PRENOM    */
/*------------------------------------------------------------------*/

String sRet, sCodCiv, sNom, sPrenom

Choose Case aiType
Case 1
	sCodCiv	= idw_wSin.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )
	sNom		= idw_wSin.GetItemString ( 1, "NOM" )
	sPrenom	= idw_wSin.GetItemString ( 1, "PRENOM" )

End Choose

If	IsNull ( sNom ) 		Then sNom = ""
If	IsNull ( sPrenom )	Then sPrenom = ""

sRet =	idw_Produit.GetItemString ( 1, "LIB_COURT" )									+ " ("					+ &
			String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ) ) 					+ ") (R$$HEX1$$e900$$ENDHEX$$v : "			+ &
			String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 							+ ") / Sinistre N$$HEX2$$b0002000$$ENDHEX$$"	+ &
			String ( idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )							+ " / " 					+ &
			sCodCiv																					+ " " 					+ &
			sNom																						+ " " 					+ &
			sPrenom

Return ( sRet )
end function

private function boolean uf_sinistre_lie ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Sinistre_Lie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 01/02/1999 16:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient d'ouvrir la fen$$HEX1$$ea00$$ENDHEX$$tre, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des sinistre li$$HEX1$$e900$$ENDHEX$$s.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True	= On peut continuer
//*										False = Il existe plusieurs N$$HEX2$$b0002000$$ENDHEX$$d'ordre
//*
//       JFF   20/01/2014 [PM208]
//*-----------------------------------------------------------------

String sIdAdh, sRech
Long lTotSin, lIdOrdreSin, lIdOrdreLu, lCpt, lIdSin, lLig
Boolean bRet

/*------------------------------------------------------------------*/
/* On vient d'ouvrir la fen$$HEX1$$ea00$$ENDHEX$$tre. On va v$$HEX1$$e900$$ENDHEX$$rifier - si la zone        */
/* ID_ADH n'est pas NULL - s'il existe des sinistres li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$celui   */
/* en cours de traitement. S'il existe des ID_ORDRE diff$$HEX1$$e900$$ENDHEX$$rents, on  */
/* interdit la modification. Il faudra d'abord intervenir sur ces   */
/* dossiers avant toute chose.                                      */
/*------------------------------------------------------------------*/

bRet		= True
sIdAdh	= idw_wSin.GetItemString ( 1, "ID_ADH" )

/*------------------------------------------------------------------*/
/* On interdit l'utilisation de l'onglet sur les sinistres li$$HEX1$$e900$$ENDHEX$$s.    */
/*------------------------------------------------------------------*/
iuoOng.Uf_ActiverOnglet ( "02", False )

If	IsNull ( sIdAdh ) Or sIdAdh = "" Then Return ( True )
idw_SinLie.Retrieve ( sIdAdh, 0, 0, 0, "XXX" )

/*------------------------------------------------------------------*/
/* On doit forc$$HEX1$$e900$$ENDHEX$$ment retrouver le sinistre courant. Il faut le      */
/* supprimer de la liste.                                           */
/*------------------------------------------------------------------*/
lTotSin	= idw_SinLie.RowCount ()

lIdSin	= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
sRech		= "ID_SIN = " + String ( lIdSin )

lLig		= idw_SinLie.Find ( sRech, 1, lTotSin )
idw_SinLie.DeleteRow ( lLig )
lTotSin --

/*------------------------------------------------------------------*/
/* Il existe des sinistres li$$HEX1$$e900$$ENDHEX$$s, on autorise l'utilisation de       */
/* l'onglet.                                                        */
/*------------------------------------------------------------------*/
If	lTotSin > 0 Then 
	iuoOng.Uf_ActiverOnglet ( "02", True )
End If

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la zone ID_ORDRE du sinistre. Si cette zone est      */
/* NULL et qu'il existe des sinistres li$$HEX1$$e900$$ENDHEX$$s, on interdit toute       */
/* modification. S'il existe des ID_ORDRE diff$$HEX1$$e900$$ENDHEX$$rents dans les       */
/* sinistres li$$HEX1$$e900$$ENDHEX$$s, on interdit toute modification. Si le ID_ORDRE   */
/* du sinistre est diff$$HEX1$$e900$$ENDHEX$$rent de celui des sinistres li$$HEX1$$e900$$ENDHEX$$s, on        */
/* interdit toute modification.                                     */
/*------------------------------------------------------------------*/
lIdOrdreSin = idw_WSin.GetItemNumber ( 1, "ID_ORDRE" )

If	IsNull ( lIdOrdreSin ) And lTotSin > 0 Then 
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sCode		= "CASP310"
	stMessage.bTrace		= False

	F_Message ( stMessage )
	bRet = False
End If


// [PM208]
/* Shunt$$HEX2$$e9002000$$ENDHEX$$suite PM208
	If	bRet	And lTotSin > 0 Then
		lIdOrdreLu = idw_SinLie.GetItemNumber ( 1, "ID_ORDRE" )
		For	lCpt = 2 To lTotSin
				If	idw_SinLie.GetItemNumber ( lCpt, "ID_ORDRE" ) <> lIdOrdreLu	Then
					bRet = False
	
					stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
					stMessage.Icon			= StopSign!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WORK180"
					stMessage.bTrace		= False
	
					F_Message ( stMessage )
					Exit
				End If
		Next
	End If


// [PM208]
// Shunt$$HEX2$$e9002000$$ENDHEX$$suite PM208

	If	bRet	Then
		For	lCpt = 1 To lTotSin
				If	idw_SinLie.GetItemNumber ( lCpt, "ID_ORDRE" ) <> lIdOrdreSin	Then
					bRet = False
	
					stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
					stMessage.Icon			= StopSign!
					stMessage.bErreurG	= False
					stMessage.sCode		= "CASP320"
					stMessage.bTrace		= False
	
					F_Message ( stMessage )
					Exit
				End If
		Next
	End If
*/

Return ( bRet )


end function

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie du cas particulier
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sIdAdh, sIdAdhNouveau, sOng, sPos
Integer iRet

sOng	= "01"
sPos	= ""

sIdAdhNouveau	= idw_wSin.GetItemString ( 1, "ID_ADH_NOUVEAU" )
sIdAdh			= idw_wSin.GetItemString ( 1, "ID_ADH" )

iuoOng.Uf_ActiverOnglet ( "03", False )

If	Trim ( sIdAdhNouveau ) = ""	Then sIdAdhNouveau	= stNul.str 
If	Trim ( sIdAdh ) 			= ""	Then sIdAdh 			= stNul.str 
/*------------------------------------------------------------------*/
/* Si la zone ID_ADH est NULL, on demande confirmation $$HEX2$$e0002000$$ENDHEX$$la         */
/* personne.                                                        */
/*------------------------------------------------------------------*/

If	IsNull ( sIdAdhNouveau ) And Not IsNull ( sIdAdh ) Then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la modification d'un N$$HEX2$$b0002000$$ENDHEX$$de carte"
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "CASP300"
	stMessage.Icon			= Question!
	stMessage.Bouton		= YesNo!

	iRet = F_Message ( stMessage )

	If	iRet = 2	Then	
		sPos = "ID_ADH_NOUVEAU"
	Else
		idw_wSin.SetItem ( 1, "ID_ETS_NOUVEAU", 0 )
		idw_wSin.SetItem ( 1, "ID_TYPE_CARTE_NOUVEAU", "00" )
		idw_wSin.SetItem ( 1, "ID_CARTE_NOUVEAU", 0 )
	End If
End If

/*------------------------------------------------------------------*/
/* Si la personne vient de saisir le m$$HEX1$$ea00$$ENDHEX$$me N$$HEX2$$b0002000$$ENDHEX$$de carte, on interdit  */
/* la validation. Sinon on va effectuer des UPDATES pour rien.      */
/*------------------------------------------------------------------*/

If	sPos = ""	Then
	If	sIdAdhNouveau = sIdAdh	Or ( IsNull ( sIdAdh ) And IsNull ( sIdAdhNouveau ) ) Then

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la modification d'un N$$HEX2$$b0002000$$ENDHEX$$de carte"
		stMessage.bErreurG	= False
		stMessage.bTrace		= False
		stMessage.sCode		= "CASP330"
		stMessage.Icon			= Information!

		F_Message ( stMessage )
		sPos = "ID_ADH_NOUVEAU"
	End If
End If

If	sPos = ""	Then
	If	Not	Uf_Sinistre_Lie_Nouveau ()	Then
		sPos = "ID_ADH_NOUVEAU"
	End If
End If

If	sPos <> ""	Then
	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
	End If
End If

astPass.sTab [ 1 ] 	= sPos

end subroutine

private subroutine uf_valider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Valider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification du N$$HEX2$$b0002000$$ENDHEX$$de carte
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bRet

bRet = True

String sIdAdh, sIdTypeCarte, sIdEts, sIdOrdre, sIdSin, sSql, sIdCarte
Decimal {0} dcIdOrdre

sIdSin			= String ( idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
sIdAdh			= idw_wSin.GetItemString ( 1, "ID_ADH_NOUVEAU" )
sIdTypeCarte	= "'" + idw_wSin.GetItemString ( 1, "ID_TYPE_CARTE_NOUVEAU" ) + "'"

sIdEts			= String ( idw_wSin.GetItemNumber ( 1, "ID_ETS_NOUVEAU" ) )
sIdCarte			= String ( idw_wSin.GetItemNumber ( 1, "ID_CARTE_NOUVEAU" ) )
dcIdOrdre		= idw_wSin.GetItemNumber ( 1, "ID_ORDRE_NOUVEAU" )

If	IsNull ( sIdAdh )		Then	
	sIdAdh 	= ""
Else
	sIdAdh	= "'" + sIdAdh + "'"
End If

If IsNull ( dcIdOrdre )	Then	
	sIdOrdre = "NULL"
Else
	sIdOrdre = String ( dcIdOrdre )
End If

sSql = 'sysadm.PS_U01_W_SIN_CAS1 ' 												+	&
				sIdSin 											+ ', '				+ 	&
				sIdEts 											+ ', '				+ 	&
				sIdAdh 											+ ', '				+ 	&
				sIdTypeCarte									+ ', '				+ 	&
				sIdCarte											+ ', '				+ 	&
				sIdOrdre

// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
//EXECUTE IMMEDIATE :sSql USING	itrTrans	;
f_execute( sSql, itrTrans )
// [MIGPB11] [EMD] : Fin Migration

/*------------------------------------------------------------------*/
/* Si SqlDbCode ou SqlCode sont arm$$HEX1$$e900$$ENDHEX$$s, on part du principe qu'il y  */
/* a eu une erreur.                                                 */
/*------------------------------------------------------------------*/
If itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0 Then	bRet = False

/*------------------------------------------------------------------*/
/* On s'occupe maintenant du COMMIT, ou du ROLLBACK.                */
/*------------------------------------------------------------------*/
If	bRet	Then
	F_Commit ( itrTrans, True )

/*------------------------------------------------------------------*/
/* Ecriture de la fameuse TRACE.                                    */
/*------------------------------------------------------------------*/
	Uf_EcrireTrace ()

Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/

	stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sVar[1] 	= "PS_U01_W_SIN_CAS1"
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

private function boolean uf_sinistre_lie_nouveau ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Sinistre_Lie_Nouveau (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 01/02/1999 16:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de modifier le N$$HEX2$$b0002000$$ENDHEX$$d'adh$$HEX1$$e900$$ENDHEX$$sion, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des sinistre li$$HEX1$$e900$$ENDHEX$$s.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True	= On peut continuer
//*										False = Il existe plusieurs N$$HEX2$$b0002000$$ENDHEX$$d'ordre
//*
//       JFF   20/01/2014 [PM208]
//*-----------------------------------------------------------------

String sIdAdh, sAltQueue
Long lTotSin, lIdOrdre, lCpt, lIdSin, lTotIdOrdre, lIdOrdreLie
Boolean bRet, bErreur

/*

On vient de modifier la zone ID_ADH. Plusieurs cas peuvent se produire :
1$$HEX2$$b0002000$$ENDHEX$$La zone ID_ORDRE est NULL (Dossier jamais valid$$HEX1$$e900$$ENDHEX$$). On va d$$HEX1$$e900$$ENDHEX$$clencher une autre recherche avec le nouveau ID_ADH. 
	2 Cas possibles.
		A	Il n'existe pas de sinistres li$$HEX1$$e900$$ENDHEX$$s. 
			La modification est autoris$$HEX1$$e900$$ENDHEX$$e.
		B	Il existe des sinistres li$$HEX1$$e900$$ENDHEX$$s. On v$$HEX1$$e900$$ENDHEX$$rifie que ces sinistres poss$$HEX1$$e900$$ENDHEX$$dent tous le m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE. 
			Si c'est le cas la modification est autoris$$HEX1$$e900$$ENDHEX$$e. 
			Sinon on interdit la modification.

2$$HEX2$$b0000900$$ENDHEX$$La zone ID_ORDRE est renseign$$HEX1$$e900$$ENDHEX$$e. (Dossier valid$$HEX2$$e9002000$$ENDHEX$$au moins une fois). On va d$$HEX1$$e900$$ENDHEX$$clencher une autre recherche avec le nouveau ID_ADH. 
	2 Cas possibles.
		A	Il n'existe pas de sinistres li$$HEX1$$e900$$ENDHEX$$s.
			La modification est autoris$$HEX1$$e900$$ENDHEX$$e.
		B	Il existe des sinistres li$$HEX1$$e900$$ENDHEX$$s. On v$$HEX1$$e900$$ENDHEX$$rifie que ces sinistres poss$$HEX1$$e900$$ENDHEX$$dent tous le m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE.
			Si ce n'est pas le cas, on interdit la modification.
			Si c'est la cas, on v$$HEX1$$e900$$ENDHEX$$rifie combien de sinistres (W_SIN et SINISTRE) poss$$HEX1$$e900$$ENDHEX$$dent le m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE que celui sur lequel on travaille.
			Soit il existe d'autres sinistres avec cet ID_ORDRE et dans ce cas on interdit la modification.
			Soit il n'existe pas d'autres sinistres avec cet ID_ORDRE, on va supprimer cet ID_ORDRE et modifier le sinistre avec le nouveau ID_ORDRE.
*/


bRet		= True
sIdAdh	= idw_wSin.GetItemString ( 1, "ID_ADH_NOUVEAU" )
iuoOng.Uf_ActiverOnglet ( "03", False )

If	IsNull ( sIdAdh ) Or sIdAdh = "" Then Return ( True )
idw_SinLie_Nouveau.Retrieve ( sIdAdh, 0, 0, 0, "XXX" )

lTotSin	= idw_SinLie_Nouveau.RowCount ()


/*------------------------------------------------------------------*/
/* On positionne la zone ID_ORDRE_NOUVEAU $$HEX2$$e0002000$$ENDHEX$$NULL.                   */
/*------------------------------------------------------------------*/
idw_wSin.SetItem ( 1, "ID_ORDRE_NOUVEAU", stNul.dcm )
bErreur = False

lIdOrdre		= idw_wSin.GetItemNumber ( 1, "ID_ORDRE" )
lIdSin 		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si tous les sinistres li$$HEX1$$e900$$ENDHEX$$s que l'on vient de          */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer poss$$HEX1$$e900$$ENDHEX$$dent le m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE.                            */
/*------------------------------------------------------------------*/

// [PM208]
/* Shunt$$HEX2$$e9002000$$ENDHEX$$suite PM208
	If	lTotSin > 0	Then
		iuoOng.Uf_ActiverOnglet ( "03", True )
		lIdOrdreLie = idw_SinLie_Nouveau.GetItemNumber ( 1, "ID_ORDRE" )
		
		For	lCpt = 2	To lTotSin
				If	idw_SinLie_Nouveau.GetItemNumber ( lCpt, "ID_ORDRE" ) <> lIdOrdreLie	Then
					bErreur = True
					Exit
				End If
		Next
	End If
*/ 

If	bErreur	Then
/*------------------------------------------------------------------*/
/* Les ID_ORDRE des sinistres li$$HEX1$$e900$$ENDHEX$$s ne sont pas identiques.          */
/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sCode		= "WORK180"
	stMessage.bTrace		= False

	F_Message ( stMessage )
	bRet = False
Else
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'existe pas de sinistre en cours de            */
/* traitement. Si c'est le cas, il faut d'abord valider ce sinistre.*/
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotSin
			sAltQueue = idw_SinLie_Nouveau.GetItemString ( lCpt, "ALT_QUEUE" )
			If	sAltQueue = "O"	Then

				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
				stMessage.Icon			= StopSign!
				stMessage.bErreurG	= False
				stMessage.bTrace		= False
				stMessage.sVar[1]		= String ( idw_SinLie_Nouveau.GetItemNumber ( lCpt, "ID_SIN" ) )
				stMessage.sCode		= "CASP350"

				F_Message ( stMessage )
				bErreur = True
				Exit
			End If
	Next
End If


If	Not bErreur	Then
	If	IsNull ( lIdOrdre ) And lTotSin > 0 Then
		idw_wSin.SetItem ( 1, "ID_ORDRE_NOUVEAU", lIdOrdreLie )
	End If

	If	Not IsNull ( lIdOrdre )	And lTotSin > 0 Then
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie combien il existe de sinistres diff$$HEX1$$e900$$ENDHEX$$rents ( W_SIN,    */
/* SINISTRE ) avec le m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE.                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* JFF le 11/03/2002 : Ce controle n'a plus pas vraiment de sens,   */
/* en effet un m$$HEX1$$ea00$$ENDHEX$$me n$$HEX2$$b0002000$$ENDHEX$$d'ordre peut se retrouver sur plusieurs      */
/* sinistre, un client peut poss$$HEX1$$e800$$ENDHEX$$der plusieurs carte bancaire.      */
/*------------------------------------------------------------------*/
//		lTotIdOrdre = idw_IdOrdreLie.Retrieve ( lIdOrdre, lIdSin )
//
//		If	lTotIdOrdre = 0	Then
//			idw_wSin.SetItem ( 1, "ID_ORDRE_NOUVEAU", lIdOrdreLie )
//		Else
//			
//			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
//			stMessage.Icon			= StopSign!
//			stMessage.bErreurG	= False
//			stMessage.sCode		= "CASP340"
//			stMessage.bTrace		= False
//			stMessage.sVar[1]		= String ( lIdOrdre )
//
//			F_Message ( stMessage )
//			bRet = False
//		End If
	End If

Else
	bRet = False
End If

Return ( bRet )


end function

public subroutine uf_initialiser_dw (ref datawindow adw_norm[5]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: DataWindow				adw_Norm[5]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


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
/* DataWindow pour les SINISTRES LIES.                              */
/*------------------------------------------------------------------*/
idw_SinLie	= adw_Norm[2]
idw_SinLie.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_DETAIL.                                */
/*------------------------------------------------------------------*/
idw_wDetail	= adw_Norm[3]
idw_wDetail.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow pour les SINISTRES LIES. (Nouvel ID_ADH)              */
/*------------------------------------------------------------------*/
idw_SinLie_Nouveau	= adw_Norm[4]
idw_SinLie_Nouveau.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow pour les SINISTRES avec m$$HEX1$$ea00$$ENDHEX$$me ID_ORDRE                 */
/*------------------------------------------------------------------*/
idw_IdOrdreLie	= adw_Norm[5]
idw_IdOrdreLie.SetTransObject ( This.itrTrans )
end subroutine

private subroutine uf_ecriretrace ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_EcrireTrace ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTot, lCpt

String sTrace[10]
String sLigne, sTab

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* ID_SIN							01                                    */
/* ID_PROD 							02                                    */
/* ID_ETS (Ancien)				03                                    */
/* ID_ADH (Ancien)				04                                    */
/* ID_ORDRE (Ancien)				05                                    */
/* ID_ETS (Nouveau)				06                                    */
/* ID_ADH (Nouveau)				07                                    */
/* ID_ORDRE (Nouveau)			08                                    */
/* DOS_MAJ_LE (Fin)				09                                    */
/* DOS_MAJ_PAR (Fin)				10                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

sTrace[  1 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
sTrace[  2 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) )

sTrace[  3 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_ETS" ) )
sTrace[  4 ]  = idw_wSin.GetItemString ( 1, "ID_ADH" )
sTrace[  5 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_ORDRE" ) )

sTrace[  6 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_ETS_NOUVEAU" ) )
sTrace[  7 ]  = idw_wSin.GetItemString ( 1, "ID_ADH_NOUVEAU" )
sTrace[  8 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_ORDRE_NOUVEAU" ) )


sTrace[  9 ]  = String ( DateTime ( Today (), Now () ), "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 10 ]  = stGLB.sCodOper

sLigne	= ""
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

F_EcrireFichierText ( isFicTrace, sLigne )

end subroutine

private function long uf_zn_idadh (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Zn_IdAdh (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_ADH
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*      JFF   20/01/2014 [PM208]
//*      JFF   15/12/2021 [RS1465]
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Integer iAction

Long dcIdCarte, dcIdGrp, lNbAffilier, lIdProd, lIdSin
String sIdAdh, sCodAdh, sIdTypeCarte, sLes6PremiersCB, sLe7et8EnRetourCB 

lIdProd			= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
sCodAdh			= idw_Produit.GetItemString ( 1, "COD_ADH" )

sIdTypeCarte	= Space ( 3 )
sIdAdh			= idw_wSin.GetText ()
lIdSin 		   = idw_wSin.GetItemNumber ( 1, "ID_SIN" ) 

// [RS1465]
If Not IsNumber ( sIdAdh ) Then
	sLes6PremiersCB = Left ( sIdAdh, 6 )
	sLe7et8EnRetourCB = Space ( 2 ) 
	SQLCA.PS_S_MODIF_NUM_CARTE_EN_X (lIdSin, sLes6PremiersCB, sLe7et8EnRetourCB ) 
	If IsNull ( sLe7et8EnRetourCB ) Then sLe7et8EnRetourCB = ""
	If Trim ( sLe7et8EnRetourCB ) <> "" And len ( sLe7et8EnRetourCB ) = 2 Then
		sIdAdh = sLes6PremiersCB + sLe7et8EnRetourCB + right ( sIdAdh, Len ( sIdAdh ) - 8 ) 
	End If 
End If 

sIdAdh = Upper ( sIdAdh ) 
SQLCA.PS_DECRYPTE_NUM_CARTE ( sIdAdh, "X" ) 
idw_wSin.SetText ( sIdAdh )

iAction				= 2

/*------------------------------------------------------------------*/
/* On va v$$HEX1$$e900$$ENDHEX$$rifier si le N$$HEX2$$b0002000$$ENDHEX$$de carte est valide.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le gestionnaire vient d'effacer le contenu de la zone. Gestion   */
/* du iiCarNul standard avec r$$HEX1$$e900$$ENDHEX$$initialisation d'un certain nombre   */
/* de zones $$HEX2$$e0002000$$ENDHEX$$la fin du script.                                     */
/*------------------------------------------------------------------*/
If	sIdAdh = ""	Then
	iAction 	= 1

	idw_wSin.SetItem ( 1, "ID_ETS_NOUVEAU", 0 )
	idw_wSin.SetItem ( 1, "ID_CARTE_NOUVEAU", 0 )
	idw_wSin.SetItem ( 1, "ID_TYPE_CARTE_NOUVEAU", "00" )

Else
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie le N$$HEX2$$b0002000$$ENDHEX$$de carte.                                       */
/*------------------------------------------------------------------*/
	If	F_Carte ( sIdAdh, "111" )	Then
/*------------------------------------------------------------------*/
/* On recherche le type de la carte ainsi que son l'identifiant.    */
/* Cette recherche va s'effectuer dans la table CARTE. Si on ne     */
/* trouve rien, cela signifie que la carte est non couverte. On     */
/* interdit la modification. Si la carte est couverte, on v$$HEX1$$e900$$ENDHEX$$rifie   */
/* l'affiliation de la carte au produit. Si cette  affiliation      */
/* n'est pas trouv$$HEX1$$e900$$ENDHEX$$e, on affiche un message d'erreur non bloquant.  */
/* Le sinistre sera refus$$HEX2$$e9002000$$ENDHEX$$sur la grille.                           */
/*------------------------------------------------------------------*/
		itrTrans.PS_S01_CARTE_SINISTRE ( sIdAdh, lIdProd, dcIdCarte, sIdTypeCarte, dcIdGrp, lNbAffilier )
		If	F_Procedure ( stMessage, itrTrans, "PS_S01_CARTE_SINISTRE" )	Then

			If	sIdTypeCarte = "   " Then

				iAction 						= 1
				idw_wSin.iiErreur			= 3

			Else
/*------------------------------------------------------------------*/
/* Cette carte ne semble pas $$HEX1$$ea00$$ENDHEX$$tre affili$$HEX1$$e900$$ENDHEX$$e au produit. On affiche   */
/* un message non bloquant.                                         */
/*------------------------------------------------------------------*/
				If	lNbAffilier = 0 Then
					stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les cas particuliers"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WORK140"

					F_Message ( stMessage )
				End If
/*------------------------------------------------------------------*/
/* On arme maintenant les valeurs pour ID_TYPE_CARTE et ID_CARTE.   */
/*------------------------------------------------------------------*/
				idw_wSin.SetItem ( 1, "ID_ETS_NOUVEAU", dcIdGrp )
				idw_wSin.SetItem ( 1, "ID_CARTE_NOUVEAU", dcIdCarte )
				idw_wSin.SetItem ( 1, "ID_TYPE_CARTE_NOUVEAU", sIdTypeCarte )
			
			End If
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure, la structure     */
/* stMessage vient d'$$HEX1$$ea00$$ENDHEX$$tre arm$$HEX1$$e900$$ENDHEX$$e, on d$$HEX1$$e900$$ENDHEX$$clenche un ItemError.         */
/*------------------------------------------------------------------*/
		Else
			iAction 				= 1
			idw_wSin.iiErreur	= 2
		End If
	Else
/*------------------------------------------------------------------*/
/* Il y a une erreur de saisie sur le N$$HEX2$$b0002000$$ENDHEX$$de carte.                  */
/*------------------------------------------------------------------*/
		iAction 				= 1
		idw_wSin.iiErreur	= 1
	End If
End If

//Migration PB8-WYNIWYG-03/2006 FM
//idw_wSin.SetActionCode ( iAction )
ll_ret = iAction
//Fin Migration PB8-WYNIWYG-03/2006 FM

///*------------------------------------------------------------------*/
///* Il est important de faire un ActionCode $$HEX2$$e0002000$$ENDHEX$$2. En effet la         */
///* fonction SetActionCode n'est pas imm$$HEX1$$e900$$ENDHEX$$diate. Il faut attendre la  */
///* fin de la fonction appelante.                                    */
///*------------------------------------------------------------------*/
If	iAction = 2 Then
	If	sIdAdh = "" Then SetNull ( sIdAdh )
	
	// [PM208]
	sIdAdh = Left ( sIdAdh,6 ) + Fill ("X", Len ( sIdAdh ) - 10) + Right (sIdAdh, 4)
	
	idw_wSin.SetItem ( 1, "ID_ADH_NOUVEAU", sIdAdh )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM


end function

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement sur les zones de dw_wSin. (On vient de ItemChanged)
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case idw_wSin.isNomCol
Case "ID_ADH_NOUVEAU"
//Migration PB8-WYNIWYG-03/2006 FM
//	Uf_Zn_IdAdh ( astPass )
	ll_ret = Uf_Zn_IdAdh ( astPass )
//Fin Migration PB8-WYNIWYG-03/2006 FM
End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

on u_gs_sp_cas_id_adh.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_cas_id_adh.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

