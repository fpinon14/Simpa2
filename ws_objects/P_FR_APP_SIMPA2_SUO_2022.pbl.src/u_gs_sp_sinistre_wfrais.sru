HA$PBExportHeader$u_gs_sp_sinistre_wfrais.sru
$PBExportComments$---} User Object pour la gestion des frais. (W_FRAIS)
forward
global type u_gs_sp_sinistre_wfrais from u_gs_sp_sinistre_anc
end type
end forward

global type u_gs_sp_sinistre_wfrais from u_gs_sp_sinistre_anc
end type
global u_gs_sp_sinistre_wfrais u_gs_sp_sinistre_wfrais

type variables
Private :
	u_DataWindow		idw_wFraisFF

	u_DataWindow		idw_wInter

	u_DataWindow_Detail	idw_LstInter, idwDivSin, idw_LstCommande, idwLstFrais

	DataWindow		idw_wFraisSupp
	Datawindow			idw_cmdtypefrn

	Decimal {2}		idcMtPlafInitial
	String			isAltBlocInitial

end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_tb_validation ()
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_tb_frais ()
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_preparersupprimer (ref s_pass astpass)
private subroutine uf_gestion_str2nul ()
public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstinter, ref u_datawindow adw_wfraisff, ref u_datawindow adw_winter, ref u_datawindow_detail adw_divsin, ref datawindow adw_norm[])
private function boolean uf_get_param_frais (long alrowcmde, ref decimal adcmontant, ref integer aityprbt)
public function integer uf_zn_trt (ref s_pass astpass)
private function integer uf_zn_libfrais ()
private function integer uf_zn_typfrais ()
end prototypes

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

Case 3					// INSERTION			(Wf_PreparerInserer)
	Uf_PreparerInserer ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )

Case 6					// PREPARER VALIDER	(Wf_PreparerValider)

Case 9					// CAS PARTICULIER	(Appel sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Banque)

Case 10					// SUPPRESSION			(Wf_PreparerSupprimer)
	Uf_PreparerSupprimer ( astPass )

End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre (FREEFORM) d'un frais
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

String sCol[3] 

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes ID_TYP_FRAIS, COD_ETAT.                                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec idw_wSin.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec             */
/* idw_wFraisFF.iudwDetailSource                                    */
/*------------------------------------------------------------------*/
idw_wFraisFF.iudwDetailSource.GetChild ( "ID_TYP_FRAIS", dwChild )
idw_wFraisFF.GetChild ( "ID_TYP_FRAIS", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wFraisFF.iudwDetailSource.GetChild ( "COD_ETAT", dwChild )
idw_wFraisFF.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_TYP_FRAIS"
sCol [  2 ] = "LIB_FRAIS"
sCol [  3 ] = "MT_FRAIS"

idw_wFraisFF.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation, on va initialiser les      */
/* zones en protect une seule fois.                                 */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C" Or isTypeTrt = "V" Then
	Uf_Tb_Validation ()
End If

end subroutine

private subroutine uf_tb_validation ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Adhesion (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des TabOrder en consultaion/Validation.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 4 ]

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_TYP_FRAIS"
sCol [  2 ] = "MT_FRAIS"
sCol [  3 ] = "LIB_FRAIS"
sCol [  4 ] = "ALT_COUR"

idw_wFraisFF.Uf_Proteger ( sCol, "1" )

end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerInserer (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de l'insertion d'un frais
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdSin, lIdInter, lTotFrais, lIdFrais

lTotFrais = 0

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'ID_SIN et l'ID_GTI.                                */
/*------------------------------------------------------------------*/
lIdSin		= idw_wInter.GetItemNumber ( 1, "ID_SIN" )
lIdInter		= idw_wInter.GetItemNumber ( 1, "ID_I" )

idw_wFraisFF.SetItem ( 1, "ID_SIN", lIdSin )
idw_wFraisFF.SetItem ( 1, "ID_I", lIdInter )

/*------------------------------------------------------------------*/
/* On incr$$HEX1$$e900$$ENDHEX$$mente le N$$HEX2$$b0002000$$ENDHEX$$du frais.                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le N$$HEX2$$b0002000$$ENDHEX$$de frais commence $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro.                                  */
/*------------------------------------------------------------------*/
lTotFrais = idw_wFraisFF.iudwDetailSource.RowCount ()
If	lTotFrais = 0 Then
	lIdFrais = 0
Else
	lIdFrais = idw_wFraisFF.iudwDetailSource.GetItemNumber ( lTotFrais, "ID_FRAIS" )
	lIdFrais ++
End If

idw_wFraisFF.SetItem ( 1, "ID_FRAIS", lIdFrais )

/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$re les TabOrder.                                            */
/*------------------------------------------------------------------*/
Uf_Tb_Frais ()

astPass.bRetour = True

end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification d'un frais
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean	bSupprime

bSupprime = True

String sBitMap

sBitMap = ""

/*------------------------------------------------------------------*/
/* On recopie la ligne du frais de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans           */
/* dw_wFraisFF de W_FRAIS.                                          */
/*------------------------------------------------------------------*/
idw_wFraisFF.Uf_CopierLigne ()

/*------------------------------------------------------------------*/
/* On autorise ou non l'utilisation du bouton SUPPRIMER de la       */
/* fen$$HEX1$$ea00$$ENDHEX$$tre.                                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si le frais est r$$HEX1$$e900$$ENDHEX$$gl$$HEX1$$e900$$ENDHEX$$, on interdit la suppression.               */
/*------------------------------------------------------------------*/
If	idw_wFraisFF.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then
	bSupprime = False
	astPass.lTab[1] = 0			// Il faut d$$HEX1$$e900$$ENDHEX$$sactiver le bouton CONTROLE
Else
	astPass.lTab[1] = 1			// Il faut activer le bouton 
End If

/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$re les TabOrder uniquement en saisie.                       */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	Uf_Tb_Frais ()
End If

astPass.bSupprime	= bSupprime		
astPass.bRetour	= True

end subroutine

private subroutine uf_tb_frais ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Frais (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des TabOrder en saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 4 ]

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_TYP_FRAIS"
sCol [  2 ] = "MT_FRAIS"
sCol [  3 ] = "LIB_FRAIS"
sCol [  4 ] = "ALT_COUR"

/*------------------------------------------------------------------*/
/* Si le frais est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$gl$$HEX1$$e900$$ENDHEX$$, aucune zone n'est accessible.        */
/*------------------------------------------------------------------*/
If	idw_wFraisFF.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then
	idw_wFraisFF.Uf_Proteger ( sCol, "1" )
Else
	idw_wFraisFF.Uf_Proteger ( sCol, "0" )
End If
end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un frais
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	 JFF     18/09/2007 [ALAPAGE]
//*			FPI	27/07/2010 [PM72] Frais d'envoi O2M
//*       JFF     28/06/2011 [PM72][ITSM72668]
//*       JFF     30/06/2011 [PM72].[DP176]
//		FPI		18/08/2011	[PM72.2]
//		FPI		18/10/2011 [PM72][Point13] Ajout du message pas de 2$$HEX1$$e800$$ENDHEX$$me frais d'envoi
//*			FPI	26/12/2011	[PM72_DOMCOM] - VDoc 6404
//			FPI	03/01/2012	[PM72_ES] R$$HEX1$$e900$$ENDHEX$$vision du PM72 t
// 		FPI	27/02/2015	[VDOC16821] On se base sur le cp de l'assur$$HEX2$$e9002000$$ENDHEX$$ald la caisse
//*-----------------------------------------------------------------

String sCol [ 1 ], sErr [ 1 ], sVal [ 1 ]
String 		sNouvelleLigne, sText, sPos, StypApp
Long 			lCpt, lNbrCol, lDeb, lFin, lRow
Boolean 		bMessPart
Decimal 		dcmontant	// [PM72]
Integer		ityprbt		// [PM72]
String sIdFrais, sCp
Long   lTypeRbt, lRet
Decimal dcMtRbt
Long lCaisse, lIdSin

sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne

bMessPart=FALSE

sCol[ 1 ] = "ID_TYP_FRAIS"

sErr[ 1 ] = " - Le type de frais"

/*------------------------------------------------------------------*/
/* On transforme toutes les chaines vides en NULL avant de          */
/* commencer.                                                       */
/*------------------------------------------------------------------*/
Uf_Gestion_Str2Nul ()

/*------------------------------------------------------------------*/
/* Il faut faire un TRIM pour toutes les zones.                     */
/*------------------------------------------------------------------*/
sVal[ 1 ] = String ( idw_wFraisFF.GetItemNumber ( 1, sCol[ 1 ] ) )
lIdSin = idw_wFraisFF.GetItemNumber ( 1, "ID_SIN" )

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lNbrCol
		If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
			If sPos = "" Then sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If
Next

/*------------------------------------------------------------------*/
/* Le montant du frais doit $$HEX1$$ea00$$ENDHEX$$tre saisi.                             */
/*------------------------------------------------------------------*/
If	idw_wFraisFF.GetItemNumber ( 1, "MT_FRAIS" ) <= 0	Or &
	IsNull ( idw_wFraisFF.GetItemNumber ( 1, "MT_FRAIS" ) ) Then
	If sPos = "" Then sPos = "MT_FRAIS"
	sText = sText + " - le montant du frais" + sNouvelleLigne
End If

// #1 ALAPAGE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 89 )
If lDeb > 0 Then
	lRow = idwDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwDivSin.RowCount () ) 
	If lRow >0 Then 
		sTypApp = Upper ( idwDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )

		Choose Case sTypApp

			Case "TLC", "TPS", "TTC"
					// Pour les t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$viseurs, le d$$HEX1$$e900$$ENDHEX$$passement de 15E est autoris$$HEX1$$e900$$ENDHEX$$
				
			Case Else 
					If idw_wFraisFF.GetItemNumber ( 1, "MT_FRAIS" ) > 15 Then

						If sPos = "" Then sPos = "MT_FRAIS"
						sText = sText + " - le montant des frais (ne d$$HEX1$$e900$$ENDHEX$$passant pas 15$$HEX1$$ac20$$ENDHEX$$)" + sNouvelleLigne
					End If				
		End Choose
		
	End If

End If
// :#1

// [PM72]
If sPos = ""  And idw_wFraisFF.GetItemDecimal(1,"ID_TYP_FRAIS") = 1 Then
	
	If SQLCA.PS_S_CTRLE_EXISTS_RGLT ( lIdSin ) > 0 Then

		stMessage.sCode = "WFRA019" 
		bMessPart=TRUE
		stMessage.Bouton = YESNO!	
		stMessage.Icon	= Exclamation!
		If f_Message ( stMessage )	= 2 Then
			sPos = "ID_TYP_FRAIS"
			stMessage.sCode = "WFRA020" 
			bMessPart=TRUE
			stMessage.Bouton = Ok!	
			stMessage.Icon	= Information!
		End If 
		
	End If 
	
	// [PM72.1] Un seul frais d'envoi possible vers O2M
	If idwlstfrais.RowCount() > 0 Then
		
		sIdFrais=String( idw_wFraisFF.GetItemNumber(1,"ID_FRAIS"))
		
		If idwlstfrais.find( "ID_TYP_FRAIS=1 and ID_FRAIS <>" + sIdFrais,1,idwlstfrais.RowCount()) > 0 Then
			// Il y a au moins un frais d'envoi
			If idw_cmdtypefrn.Find("ID_CODE_FRN='O2M'",1,idw_cmdtypefrn.RowCount()) > 0 Then
				sPos = "ID_TYP_FRAIS"
				stMessage.sCode = "WFRA008" 
				bMessPart=TRUE
			End If
		End if
	End if
	// :[PM72.1]
	
	// Remboursement de frais d'envoi
	lRow=idw_lstcommande.find("id_four='O2M' and id_ref_four='A_DIAGNOSTIQUER' and cod_etat<>'ANN'",1,idw_lstcommande.RowCount())			
	if lRow > 0 Then
		// Une prestation diagnostic O2M non-annul$$HEX1$$e900$$ENDHEX$$e est pr$$HEX1$$e900$$ENDHEX$$sente sur le dossier 
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP",142 )
		If lDeb > 0 Then
			// Interdit de saisir des frais d'envoi sur ce produit
			If sPos = "" Then sPos = "ID_TYP_FRAIS"
			stMessage.sCode		= "WFRA001" 
			bMessPart=TRUE
		Else
			// [PM72.2]
			if uf_get_param_frais( lRow, dcmontant, ityprbt) Then
				// [VDOC16821]
				f_rechdetpro(lDeb, lFin, idw_detpro, idw_wsin.GetItemNumber(1,"ID_PROD"),"-DP",138)
				If lDeb > 0 Then
					sCP=idw_wInter.GetItemString(1,"ADR_CP")
					if Len(trim(sCP)) = 5 Then sCP=Left(sCP,3)
	
					Choose case sCP
						Case "971","972","973","974"
							//(971) Guadeloupe 
							// (972) Martinique 
							// (973) Guyane 
							// (974) La R$$HEX1$$e900$$ENDHEX$$union 
							// ON contredit le process alors 
							stMessage.bErreurG	= FALSE
							stMessage.sCode		= "WFRA014"
							F_Message ( stMessage )
							astPass.sTab [ 1 ] =  "ID_TYP_FRAIS"
							Return
					End Choose
				End if
				// :[VDOC16821]
			
				// [PM72_ES]
				stMessage.berreurg=FALSE
				sPos = "ID_TYP_FRAIS"
				stMessage.sCode		= "WFRA014" 
				bMessPart=TRUE		
				lRet = SQLCA.PS_VERIF_SIN_PARAM_FRAIS( idw_WSin.GetItemNumber ( 1, "ID_SIN" ), lTypeRbt , dcMtRbt)
				If lRet = -1 Then stMessage.sCode		= "WFRA008" 				// un frais vers O2M d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pass$$HEX1$$e900$$ENDHEX$$
			Else
				// Absence de param$$HEX1$$e900$$ENDHEX$$trage de frais
				// [PM72].[DP176]
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP",176 )
				// [PM103]
				If lDeb <= 0 And Not gbModeReprise_223 Then
					stMessage.berreurg=FALSE
					sPos = "ID_TYP_FRAIS"
					stMessage.sCode		= "WFRA007" 
					bMessPart=TRUE
				End If
			End if
			// :[PM72.2]
		End if
	End if
End if
// : [PM72]


/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	idw_wFraisFF.SetItem ( 1, "COD_ETAT", 0 )

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie du frais"
	stMessage.Icon			= Information!
	
	if bMessPart Then // [PM72]
		stMessage.bErreurG	= FALSE
	Else
		stMessage.sVar[1] 	= sText
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "GENE001"
	End if
	
	f_Message ( stMessage )

Else
/*------------------------------------------------------------------*/
/* On arme le COD_ETAT pour le frais.                               */
/*------------------------------------------------------------------*/
	idw_wFraisFF.SetItem ( 1, "COD_ETAT", 500 )
End If
		
astPass.sTab [ 1 ] = sPos


end subroutine

private subroutine uf_preparersupprimer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_wDetail::Uf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:42:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut supprimer un frais
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iRet
Long lLig, lIdFrais

/*------------------------------------------------------------------*/
/* On affiche un message qui demande si on veut supprimer le frais  */
/* courant.                                                         */
/*------------------------------------------------------------------*/
stMessage.sTitre		= "Suppression d'un frais"
stMessage.Icon			= Information!
stMessage.sVar[1] 	= "le frais "
stMessage.bouton	 	= YesNo!
stMessage.bErreurG	= FALSE
stMessage.sCode		= "GENE020"

iRet = F_Message ( stMessage )
/*------------------------------------------------------------------*/
/* Si on ne veut pas supprimer l'enregistrement, on s'arrete.       */
/*------------------------------------------------------------------*/
If	iRet = 2 Then
	astPass.bRetour = False
Else
/*------------------------------------------------------------------*/
/* FRAIS_SUPP                                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re une ligne pour le frais dans une DataWindow            */
/* external. En effet la liste des frais ne poss$$HEX1$$e900$$ENDHEX$$de pas d'objet     */
/* de transaction, donc il n'y a pas de buffer de suppression.      */
/*------------------------------------------------------------------*/
	lLig = idw_wFraisSupp.InsertRow ( 0 )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Probl$$HEX1$$e800$$ENDHEX$$me de    */
/* pr$$HEX1$$e900$$ENDHEX$$cision). Il faut passer dans une variable interm$$HEX1$$e900$$ENDHEX$$diaire.      */
/*------------------------------------------------------------------*/
	lIdFrais = idw_wFraisFF.GetItemNumber ( 1, "ID_FRAIS" )
	idw_wFraisSupp.SetItem ( lLig, "ID_FRAIS", lIdFrais )
	astPass.bRetour = True
End If	


end subroutine

private subroutine uf_gestion_str2nul ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wFrais::Uf_Gestion_Str2Nul (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 17/10/1998 18:05:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction transforme les chaines vides en NULL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 1 ]
String sVal
Long lCpt, lNbrCol

/*------------------------------------------------------------------*/
/* Le but de cette fonction est de transformer toutes les zones au  */
/* format STRING dans la DW courante en NULL. Cela $$HEX1$$e900$$ENDHEX$$vitera d'avoir  */
/* sur le moteurs des zones avec des blancs. Cette fonction doit    */
/* $$HEX1$$ea00$$ENDHEX$$tre appel$$HEX1$$e900$$ENDHEX$$e avant la fonction Uf_ControlerSaisie ().            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* De plus si le gestionnaire saisi des blancs DEVANT la zone,      */
/* ces caract$$HEX1$$e800$$ENDHEX$$res sont automatiquement enlev$$HEX1$$e900$$ENDHEX$$s.                     */
/*------------------------------------------------------------------*/

lNbrCol				= UpperBound ( sCol )

sCol[  1 ] = "LIB_FRAIS"

For	lCpt = 1 To lNbrCol
		sVal = Trim ( idw_wFraisFF.GetItemString ( 1, sCol[ lCpt ] ) )
		If Len ( sVal ) = 0 Then
			idw_wFraisFF.SetItem ( 1, sCol[ lCpt ], stNul.str )
			idw_wFraisFF.setItem ( 1, "ALT_COUR", "N" )
		Else
			idw_wFraisFF.SetItem ( 1, sCol[ lCpt ], sVal )
		End If
Next
end subroutine

public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstinter, ref u_datawindow adw_wfraisff, ref u_datawindow adw_winter, ref u_datawindow_detail adw_divsin, ref datawindow adw_norm[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstInter		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow sur la liste des interlocuteurs
//*					  U_DataWindow				adw_wFraisFF		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow sur le frais en cours de saisie
//*					  U_DataWindow				adw_wInter			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow sur l'interlocuteur en cours de saisie
//*					  U_DataWindow_Detail	adw_DivSin			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow 
//*					  DataWindow				adw_Norm[1]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//		FPI	27/07/2010	[PM72]
//		FPI	18/10/2010	[PM72.1]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les INTERLOCUTEURS. Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstInter	= adw_LstInter

/*------------------------------------------------------------------*/
/* DataWindow sur le FRAIS.          Saisie => U_DataWindow.        */
/*------------------------------------------------------------------*/
idw_wFraisFF	= adw_wFraisFF

/*------------------------------------------------------------------*/
/* DataWindow sur l'INTERLOCUTEUR.   Saisie => U_DataWindow.        */
/*------------------------------------------------------------------*/
idw_wInter	= adw_wInter

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow external permettant de garder les frais supprim$$HEX1$$e900$$ENDHEX$$s     */
/*------------------------------------------------------------------*/
idw_wFraisSupp	= adw_Norm[1]
idw_LstCommande = adw_Norm[2] // [PM72]
idw_cmdtypefrn = adw_Norm[3] // [PM72.1]
idwLstFrais = adw_Norm[4] // [PM72.1]

idwDivSin		= adw_DivSin		

end subroutine

private function boolean uf_get_param_frais (long alrowcmde, ref decimal adcmontant, ref integer aityprbt);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wfrais::uf_get_param_frais
//* Auteur			: F. Pinon
//* Date				: 27/07/2010 15:07:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM72]
//*
//* Arguments		: value long alrowcmde	 */
/* 	ref decimal adcmontant	 */
/* 	ref integer aityprbt	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long 			lIdProcess, lIdSeq
String 		sIdFour
Decimal 		dcIdGti, dcIdProd
Boolean bRet

bRet=TRUE

SetNull(adcMontant)
SetNull(aiTypRbt)

dcIdProd = idw_wsin.GetItemNumber(1,"ID_PROD")
dcIdGti = idw_lstcommande.GetItemDecimal(alRowcmde,"ID_GTI")
lIdProcess = idw_lstcommande.GetItemNumber(alRowcmde,"INFO_SPB_FRN")
sIdFour = idw_lstcommande.GetItemString(alRowcmde,"ID_FOUR")

SQLCA.PS_GET_PARAM_FRAIS( dcIdProd, sIdFour, dcIdGti, lIdProcess, lIdSeq, adcMontant, aiTypRbt)

If SQLCA.sqlcode <> 0 or SQLCA.sqlDbcode <> 0 Then bRet=FALSE

If isnull(adcmontant) or isnull(aiTypRbt) Then bRet=FALSE

Return bRet
end function

public function integer uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement sur les zones de dw_wFraisFF (On vient de ItemChanged)
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iRet

Choose Case idw_wFraisFF.isNomCol
Case "LIB_FRAIS"
	iRet = Uf_Zn_LibFrais ()
CASE "ID_TYP_FRAIS"
	iRet = Uf_Zn_TypFrais ()
End Choose


Return iRet


end function

private function integer uf_zn_libfrais ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_LibFrais (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de LIB_FRAIS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sVal, sLibFrais

sVal = idw_wFraisFF.GetText ()

/*------------------------------------------------------------------*/
/* Il faut remettre le libell$$HEX4$$e9002000e0002000$$ENDHEX$$NULL car on n'utilise pas le       */
/* principe de l'anc$$HEX1$$ea00$$ENDHEX$$tre U_DataWindow avec iiCarNul. (Impossible $$HEX3$$e00020002000$$ENDHEX$$*/
/* faire puisqu'il faut s'occuper de la zone ALT_COUR)              */
/*------------------------------------------------------------------*/
If	IsNull ( sVal ) Or sVal = ""	Then
	idw_wFraisFF.SetItem ( 1, "LIB_FRAIS", stNul.str )
	idw_wFraisFF.SetItem ( 1, "ALT_COUR", "N" )
Else
/*------------------------------------------------------------------*/
/* Si on vient 'ajouter' des caract$$HEX1$$e800$$ENDHEX$$res au libell$$HEX1$$e900$$ENDHEX$$, on v$$HEX1$$e900$$ENDHEX$$rifie si   */
/* la personne voulait d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$faire appara$$HEX1$$ee00$$ENDHEX$$tre ce libell$$HEX2$$e9002000$$ENDHEX$$sur le      */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
	sLibFrais = idw_wFraisFF.GetItemString ( 1, "LIB_FRAIS" )
	If	IsNull ( sLibFrais ) Or sLibFrais = ""	Then
		idw_wFraisFF.SetItem ( 1, "ALT_COUR", "O" )
	End If
End If

Return 0

end function

private function integer uf_zn_typfrais ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_TypFrais (PRIVATE)
//* Auteur			: FPI
//* Date				: 27/07/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM72]
//* Commentaires	: Controle de TYP_FRAIS - R$$HEX1$$e900$$ENDHEX$$cup du montant de frais dans param_frais
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*	 JFF    05/01/2011  [PC202].[DOM_COM]
//*	 JFF    18/02/2015  [VDOC15964]
//*	 JFF    19/02/2015  [VDOC15553]
// 	 FPI	  27/02/2015  [VDOC16821] On se base sur le cp de l'assur$$HEX2$$e9002000$$ENDHEX$$ald la caisse
//     JFF    01/06/2018  [PC151425-1]
//     JFF    23/08/2021  [RS919_FRAIS_DIVERS]
//     JFF    29/08/2023  [RS5545_FRAIS_DP]
//*-----------------------------------------------------------------

String sVal, sMod, sValDP
Decimal dcMt
Long lRow, lCaisse, lDeb, lFin, lIdProd, lTrouve
Integer iTypRbt, iRet
n_cst_string	lnvString // #21 [DCMP080625]

iRet = 0
sVal = idw_wFraisFF.GetText ()
lIdProd = idw_WSin.GetItemNumber ( 1, "ID_PROD" )

sMod="mt_frais.protect=0"
iTypRbt=0

// [RS5545_FRAIS_DP]
If F_CLE_A_TRUE ( "RS5545_FRAIS_DP" ) Then
	// [VDOC15553]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 369 )
	If lDeb > 0 Then
		
		sValDP = lnvString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "ID_TYP_FRAIS", ";") 
		
		If Pos ( sValDP, "#" + sVal + "#" ) > 0 Then
			idw_wFraisFF.iiErreur = 4
			Return 1  // Erreur, rejet.
		End If 
	End If
End If

If sVal="1" Then
	lRow=idw_lstcommande.find("id_four='O2M' and id_ref_four='A_DIAGNOSTIQUER' and cod_etat<>'ANN'",1,idw_lstcommande.RowCount())			
	if lRow > 0 Then
		if uf_get_param_frais( lRow,dcMt, ityprbt) and ityprbt = 2 Then
			if stGlb.sTypOper < "3" Then  sMod="mt_frais.protect=1"
			idw_wFraisFF.SetItem(1,"MT_FRAIS",dcMt)
			
			// [VDOC16821]
			f_rechdetpro(lDeb, lFin, idw_detpro, lIdProd,"-DP",138)
			If lDeb > 0 Then
				sVal=idw_wInter.GetItemString(1,"ADR_CP")
				if Len(trim(sVal)) = 5 Then 
					sVal=Left(sVal,3)
				Else 
					sVal=""
				End if

				Choose case sVal
					Case "971","972","973","974","975","976","984","986","987","988"
						//(971) Guadeloupe 
						// (972) Martinique 
						// (973) Guyane 
						// (974) La R$$HEX1$$e900$$ENDHEX$$union 
						// (975) Saint-Pierre-et-Miquelon 
						// (976) Mayotte 
						// (984) Terres Australes et Antarctiques 
						// (986) Wallis et Futuna 
						// (987) Polyn$$HEX1$$e900$$ENDHEX$$sie Fran$$HEX1$$e700$$ENDHEX$$aise 
						// (988) Nouvelle-Cal$$HEX1$$e900$$ENDHEX$$donie 
						// ON contredit le process alors 
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "WFRA009"
						F_Message ( stMessage )
				End Choose
			End if
			// :[VDOC16821]
		End if
	End if
End if

// [VDOC15964]
Choose Case sVal
	Case "3", "4", "5", "6"
		
		// [VDOC15553]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 270 )
		If lDeb <= 0 Then
			idw_wFraisFF.iiErreur = 1
			Return 1  // Erreur, rejet.
		End If
		
		idw_wFraisFF.SetItem ( 1, "MT_FRAIS", 10 )
		idw_wFraisFF.SetItem ( 1, "LIB_FRAIS", "Frais de compensation")

	// [PC151425-1]
	Case "7"

		idw_wFraisFF.iiErreur = 2
		Return 1  // Erreur, rejet.

	// [RS919_FRAIS_DIVERS]	
	Case "8"

		// [RS919_FRAIS_DIVERS]
		SQLCA.PS_S01_AUTORISATION (9, stGlb.sCodOper, lIdProd, lTrouve)
		If lTrouve <= 0 Then		
			idw_wFraisFF.iiErreur = 3
			Return 1  // Erreur, rejet.			
		End If 
		
End Choose 			

idw_wfraisff.modify(sMod)

Return iRet




end function

on u_gs_sp_sinistre_wfrais.create
call super::create
end on

on u_gs_sp_sinistre_wfrais.destroy
call super::destroy
end on

