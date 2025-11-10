HA$PBExportHeader$w_td_sp_revision.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des r$$HEX1$$e900$$ENDHEX$$visions.
forward
global type w_td_sp_revision from w_8_traitement_detail
end type
type uo_onglets from u_onglets within w_td_sp_revision
end type
type uo_ets from u_ajout within w_td_sp_revision
end type
type dw_ets_sav from datawindow within w_td_sp_revision
end type
type uo_bord3d from u_bord3d within w_td_sp_revision
end type
type st_wait from statictext within w_td_sp_revision
end type
end forward

global type w_td_sp_revision from w_8_traitement_detail
integer x = 242
integer y = 440
integer width = 3141
integer height = 1220
string title = "Gestion des r$$HEX1$$e900$$ENDHEX$$visions"
event ue_quitteronglet021 pbm_custom01
uo_onglets uo_onglets
uo_ets uo_ets
dw_ets_sav dw_ets_sav
uo_bord3d uo_bord3d
st_wait st_wait
end type
global w_td_sp_revision w_td_sp_revision

type variables
u_sp_gs_revision	iuoGsRevision
u_sp_gs_ets	iuoGsEts

Decimal{0}	idcIdRevAnc    // N$$HEX2$$b0002000$$ENDHEX$$de revision N-1
Decimal{0}	idcIdProd
Decimal{0}	idcIdRev	        // N$$HEX2$$b0002000$$ENDHEX$$de Revision courrant

Boolean		ibDernier

Date		idDteEffOrigine	 

W_tm_sp_Produit	iwMaitre


end variables

forward prototypes
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
public function boolean wf_preparervalider ()
public function string wf_controlergestion ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
public function boolean wf_accepttext ()
private function string wf_controledateeffet ()
end prototypes

on ue_quitteronglet021;call w_8_traitement_detail::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Revision
//* Evenement 		:	Ue_QuitterOnglet021
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	25/07/97 16:35:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Accept Text pour les $$HEX1$$e900$$ENDHEX$$tablissements.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	Uo_ets.Dw_Source.AcceptText () < 0	Then

	Uo_Onglets.ibStop = True

End If
end on

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerInserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 10:35:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------

String		sMod				// Chaine utilis$$HEX2$$e9002000$$ENDHEX$$pour un modify


idDteEffOrigine 		= 1990-01-01

Dw_1.SetItem ( 1, "ALT_DUPLIC", "O" )

/*------------------------------------------------------------------*/
/* Identifiant du produit concern$$HEX1$$e900$$ENDHEX$$.                                 */
/*------------------------------------------------------------------*/
idcIdProd = Dec ( istPass.sTab [ 1 ] )
Dw_1.SetItem ( 1, "ID_PROD", iDcIdProd )

/*------------------------------------------------------------------*/
/* N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision en cours de cr$$HEX1$$e900$$ENDHEX$$ation.                             */
/*------------------------------------------------------------------*/
idcIdRev  = Dec ( istPass.sTab [ 3 ] )
Dw_1.SetItem ( 1, "ID_REV" , iDcIdRev  )

/*------------------------------------------------------------------*/
/* Nous sommes en cr$$HEX1$$e900$$ENDHEX$$ation d'une r$$HEX1$$e900$$ENDHEX$$vision donc le N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision    */
/* ant$$HEX1$$e800$$ENDHEX$$rieure est celui affect$$HEX2$$e9002000$$ENDHEX$$au produit ( COD_REV_SURV )         */
/*------------------------------------------------------------------*/
idcIdRevAnc = Dec ( istPass.sTab [ 2 ] )


/*------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation on travaille avec la derni$$HEX1$$e800$$ENDHEX$$re des R$$HEX1$$e900$$ENDHEX$$visions          */
/*------------------------------------------------------------------*/
ibDernier = True

Dw_1.Uf_Proteger ( { "COD_EFF_REV", "DTE_EFF" }, "0" )

/*------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation la zone d'effet est saisissable, on positionne la    */
/* fl$$HEX1$$e800$$ENDHEX$$che de la DDLB                                                */
/*------------------------------------------------------------------*/
sMod = "COD_EFF_REV.DDLB.UseAsBorder=Yes "

/*------------------------------------------------------------------*/
/* Si aucune r$$HEX1$$e900$$ENDHEX$$vision n'existe il est inutile d'autoriser la        */
/* duplication.                                                     */
/*------------------------------------------------------------------*/
If	idcIdRevAnc	 < 0 Then

	Dw_1.Uf_Proteger ( { "ALT_DUPLIC" }, "1" )

	sMod = sMod + "alt_duplic.visible='0'"

	/*------------------------------------------------------------------*/
	/* Pr$$HEX1$$e900$$ENDHEX$$cise la premi$$HEX1$$e800$$ENDHEX$$re et la derni$$HEX1$$e800$$ENDHEX$$re colonne                       */
	/*------------------------------------------------------------------*/
	Dw_1.ilPremCol = 3	// LIB_REV		libell$$HEX2$$e9002000$$ENDHEX$$de la r$$HEX1$$e900$$ENDHEX$$vision
	Dw_1.ilDernCol = 5	// DTE_EFF		Niveau de l'op$$HEX1$$e900$$ENDHEX$$rateur

Else

	Dw_1.Uf_Proteger ( { "ALT_DUPLIC" }, "0" )

	sMod = sMod + "alt_duplic.visible='1'"

	/*------------------------------------------------------------------*/
	/* Pr$$HEX1$$e900$$ENDHEX$$cise la premi$$HEX1$$e800$$ENDHEX$$re et la derni$$HEX1$$e800$$ENDHEX$$re colonne                       */
	/*------------------------------------------------------------------*/
	Dw_1.ilPremCol = 3	// LIB_REV		libell$$HEX2$$e9002000$$ENDHEX$$de la r$$HEX1$$e900$$ENDHEX$$vision
	Dw_1.ilDernCol = 10	// ALT_DUPLIC	flag cr$$HEX1$$e900$$ENDHEX$$ant une duplication des garanties

End If

Dw_1.Uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES ETABLISSEMENTS.               */
/*------------------------------------------------------------------*/

istPass.dwNorm[1].ShareData ( uo_Ets.Dw_Source )

iuoGsEts.Uf_AfficherEts ( 999 )	// on n'est pas pr$$HEX1$$e800$$ENDHEX$$s d'arriver 
											// $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$vision 

Dw_Ets_Sav.Reset ()

/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet des r$$HEX1$$e900$$ENDHEX$$visions                        */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerModifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/01/1997 10:37:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	Les possibilit$$HEX1$$e900$$ENDHEX$$s de modification change si on modifie la r$$HEX1$$e900$$ENDHEX$$vision
//*					 	actuellement associ$$HEX1$$e900$$ENDHEX$$e au produit ou une r$$HEX1$$e900$$ENDHEX$$vision ant$$HEX1$$e900$$ENDHEX$$rieure.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------

Boolean 		bRet				// Valeur de Retour
Decimal{0} 	dcIdRevProd		// Valeur de la r$$HEX1$$e900$$ENDHEX$$vision associ$$HEX1$$e900$$ENDHEX$$e au produit
String		sMod				// Chaine utilis$$HEX1$$e900$$ENDHEX$$e pour un modify de Dw_1

/*------------------------------------------------------------------*/
/* En modification il n'est pas possible de demander une            */
/* duplication des garanties. Il n'est pas possible de modifier la  */
/* zone d'effet.                                                    */
/*------------------------------------------------------------------*/
Dw_1.Uf_Proteger ( { "ALT_DUPLIC", "COD_EFF_REV" }, "1" )

sMod = "alt_duplic.visible='0'"

/*------------------------------------------------------------------*/
/* la zone d'effet n'est pas modifiable, pas de fl$$HEX1$$ea00$$ENDHEX$$che pour la DDLB */
/*------------------------------------------------------------------*/
sMod = sMod + " COD_EFF_REV.DDLB.UseAsBorder=No "

Dw_1.uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* Produit concern$$HEX1$$e900$$ENDHEX$$.                                                */
/*------------------------------------------------------------------*/
idcIdProd  = Dec ( istPass.sTab [ 1 ] )

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$vision que je veux modifier.                                   */
/*------------------------------------------------------------------*/
idcIdRev	  = Dec ( istPass.sTab [ 3 ] )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination du N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision ant$$HEX1$$e900$$ENDHEX$$rieur $$HEX2$$e0002000$$ENDHEX$$celui que je suis    */
/* entrain de modifier :                                            */
/*  - c'est le N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision -1.                                   */
/*------------------------------------------------------------------*/
idcIdRevAnc = idcIdRev - 1

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$vision associ$$HEX1$$e900$$ENDHEX$$e au produit.                                    */
/*------------------------------------------------------------------*/
dcIdRevProd = Dec ( istPass.sTab [ 2 ] )


bRet = Dw_1.uf_CopierLigne()

If bRet	Then

	/*------------------------------------------------------------------*/
	/* Pour certain test il faut conna$$HEX1$$ee00$$ENDHEX$$tre la date d'effet avant toute  */
	/* modification.                                                    */
	/*------------------------------------------------------------------*/
	idDteEffOrigine 		= Date(Dw_1.GetItemDateTime 	( 1, "DTE_EFF" 		)) // [PI056] getItemDate en GetItemDateTime

	Dw_1.SetItem ( 1, "ALT_DUPLIC", "N" )


	/*------------------------------------------------------------------*/
	/* PREPARER MODIFIER POUR L'ONGLET DES ETABLISSEMENTS.              */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* Populise les informations dans Dw_Source                         */
	/* Dans le cas de la modification il ne faut pas importer les       */
	/* de la r$$HEX1$$e900$$ENDHEX$$vision ant$$HEX1$$e800$$ENDHEX$$rieure.                                       */
	/*------------------------------------------------------------------*/

	istPass.dwNorm[1].ShareData ( uo_Ets.Dw_Source )

	iuoGsEts.Uf_AfficherEts ( idcIdRev )	

	Dw_Ets_Sav.Reset ()
	uo_Ets.Dw_Source.RowsCopy ( 1, Uo_Ets.Dw_Source.RowCount (), Primary!, Dw_Ets_Sav, 1, Primary!  )

	/*------------------------------------------------------------------*/
	/* Positionnement sur l'onglet des r$$HEX1$$e900$$ENDHEX$$visions.                       */
	/*------------------------------------------------------------------*/
	Uo_Onglets.Uf_ChangerOnglet ( "01" )

End If

If  bRet And Date(Dw_1.GetItemDateTime ( 1 , "DTE_FIN" )) = 3000-01-01  Then // [PI056] getItemDate en GetItemDateTime

	/*------------------------------------------------------------------*/
	/* Flag d$$HEX1$$e900$$ENDHEX$$terminant si c'est la derni$$HEX1$$e800$$ENDHEX$$re des r$$HEX1$$e900$$ENDHEX$$visions.             */
	/*------------------------------------------------------------------*/
	ibDernier = True

	/*------------------------------------------------------------------*/
	/* Si on modifie la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$vision pour une zone d'effet, il est */
	/* possible de modifier                                             */
	/* la date de d$$HEX1$$e900$$ENDHEX$$but.                                                */
	/*------------------------------------------------------------------*/
	Dw_1.Uf_Proteger ( { "DTE_EFF" }, "0" )

	Dw_1.ilPremCol = 3	// LIB_REV	dernier champ accessible.
	Dw_1.ilDernCol = 5	// DTE_EFF	dernier champ accessible.

	/*------------------------------------------------------------------*/
	/* Seule la derni$$HEX1$$e800$$ENDHEX$$re des r$$HEX1$$e900$$ENDHEX$$visions peut $$HEX1$$ea00$$ENDHEX$$tre supprimer.             */
	/*------------------------------------------------------------------*/
	pb_supprimer.Enabled = True

Else

	/*------------------------------------------------------------------*/
	/* Flag d$$HEX1$$e900$$ENDHEX$$terminant si c'est la derni$$HEX1$$e800$$ENDHEX$$re des r$$HEX1$$e900$$ENDHEX$$visions.             */
	/*------------------------------------------------------------------*/
	ibDernier = False

	/*------------------------------------------------------------------*/
	/* Si on modifie une r$$HEX1$$e900$$ENDHEX$$vision ant$$HEX1$$e900$$ENDHEX$$rieure il n'est pas possible de   */
	/* modifier la date de d$$HEX1$$e900$$ENDHEX$$but et la zone d'effet.                    */
	/*------------------------------------------------------------------*/
	Dw_1.Uf_Proteger ( { "DTE_EFF" }, "1" )

	Dw_1.ilPremCol = 3	// LIB_REV	dernier champ accessible.
	Dw_1.ilDernCol = 3	// LIB_REV	dernier champ accessible.

	/*------------------------------------------------------------------*/
	/* Seule la derni$$HEX1$$e800$$ENDHEX$$re des r$$HEX1$$e900$$ENDHEX$$visions peut $$HEX1$$ea00$$ENDHEX$$tre supprimer.             */
	/*------------------------------------------------------------------*/
	pb_supprimer.Enabled = False

End If

Return ( bRet )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/97 10:41:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			// Variable de retour de la fonction.
Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.
String 	sText 		// Variable de retour de la fonction de controle.


bRet = True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/

stMessage.sTitre 		= "Suppression d'une R$$HEX1$$e900$$ENDHEX$$vision"
stMessage.sVar[ 1 ] 	= "cette r$$HEX1$$e900$$ENDHEX$$vision"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	sText		= iuoGsRevision.uf_Gs_Sup_Revision ( idcIdProd, idcIdRev )

	If sText <> "" Then

		bRet = False

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'une R$$HEX1$$e900$$ENDHEX$$vision"
		stMessage.sVar[ 1 ] 	= "des r$$HEX1$$e900$$ENDHEX$$visions"  
		stMessage.sVar[ 2 ] 	= "cette r$$HEX1$$e900$$ENDHEX$$vision"
		stMessage.sCode		= "REFU002"

		f_Message ( stMessage )
		
	End If

End If

Return ( bRet )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ControlerSaisie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 10:45:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	REVISION.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 3 ]			// Erreur relative $$HEX2$$e0002000$$ENDHEX$$un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.

Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol[ 1 ]		= "LIB_REV"
sCol[ 2 ]		= "COD_EFF_REV"
sCol[ 3 ]		= "DTE_EFF"

sErr[ 1 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de la r$$HEX1$$e900$$ENDHEX$$vision"
sErr[ 2 ]		= " - La zone d'effet de la r$$HEX1$$e900$$ENDHEX$$vision"
sErr[ 3 ]		= " - La date de d$$HEX1$$e900$$ENDHEX$$but d'effet"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	Choose Case lCpt

		Case 1, 2

			sVal = dw_1.GetItemString ( 1, sCol [ lCpt ] )

		Case 3

			sVal = String ( dw_1.GetItemDateTime ( 1, sCol [ lCpt ] ) ) // [PI056] getItemDate en GetItemDateTime

	End Choose

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
		sText = sText + sErr [ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	/*------------------------------------------------------------------*/
	/* On se positionne sur le premier onglet : Dw_1                    */
	/*------------------------------------------------------------------*/
	Uo_Onglets.Uf_ChangerOnglet ( "01" )

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des R$$HEX1$$e900$$ENDHEX$$visions"
	stMessage.Icon			= Information!
	stMessage.sVar [ 1 ] = sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* Controle si au moins un $$HEX1$$e900$$ENDHEX$$tablissement a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$associ$$HEX4$$e9002000e0002000$$ENDHEX$$cette      */
/* r$$HEX1$$e900$$ENDHEX$$vision : NON bloquant.                                         */
/*------------------------------------------------------------------*/
If ( sPos = "" )	Then

//	iuoGsEts.Uf_PresenceEts ( )

End If

Return ( sPos )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerValider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/97 10:46:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Met $$HEX2$$e0002000$$ENDHEX$$jour la r$$HEX1$$e900$$ENDHEX$$vision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente pour la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		 TRUE = La validation peut continuer
//*
//*-----------------------------------------------------------------

String		sCodEffRev				// Zone d'effet de la r$$HEX1$$e900$$ENDHEX$$vision.
String		sIdRev					// R$$HEX1$$e900$$ENDHEX$$vision courante.
Long			lRet						// Valeur de retour.
Long			lNbrLig					// Nbr de ligne dans Dw_LstRev.
Date			dDteEff					// Date de d$$HEX1$$e900$$ENDHEX$$but d'effet de la r$$HEX1$$e900$$ENDHEX$$vision.

/*------------------------------------------------------------------*/
/* J'affecte la date de fin d'effet de r$$HEX1$$e900$$ENDHEX$$vision pour la r$$HEX1$$e900$$ENDHEX$$vision    */
/* pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente ayant la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet ( COD_EFF_REV ).           */
/* Dte_Eff de revision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente = Dte_Eff - 1J de la r$$HEX1$$e900$$ENDHEX$$vision n   */
/* A faire seulement si DTE_EFF de la r$$HEX1$$e900$$ENDHEX$$vision a chang$$HEX14$$e9002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/
dDteEff		= Date(Dw_1.GetItemDateTime ( 1, "DTE_EFF" )) // [PI056] getItemDate en GetItemDateTime

If dDteEff <> idDteEffOrigine	Then

	lNbrLig = Dw_1.iuDwDetailSource.RowCount ()

	If lNbrLig > 0	Then

		sCodEffRev 	= Dw_1.GetItemString ( 1, "COD_EFF_REV" )

		sIdRev		= String ( Dw_1.GetItemNumber ( 1 , "ID_REV" ) )

		lRet = Dw_1.iuDwDetailSource.Find ( "ID_REV <> " + sIdRev + " AND COD_EFF_REV='" + sCodEffRev + "'", lNbrLig, 1 )

		If lRet <> 0	Then

			Dw_1.iuDwDetailSource.SetItem ( lRet, "DTE_FIN", RelativeDate ( dDteEff, -1 ) )

		End If

	End If

End If

Return ( True )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ControlerGestion
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 10:52:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	REVISION.
//* Commentaires	:	Contr$$HEX1$$f400$$ENDHEX$$le que la date de d$$HEX1$$e900$$ENDHEX$$but d'effet de la r$$HEX1$$e900$$ENDHEX$$vision
//*                	est sup$$HEX1$$e800$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de d$$HEX1$$e900$$ENDHEX$$but d'effet de la r$$HEX1$$e900$$ENDHEX$$vision
//*                	pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente concernant la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//* [DCMP060153]-PHG-25/09/2006- Controle de la fermeture de la revision
//*-----------------------------------------------------------------
//* #1	FPI	[200101270951.FPI] Ajout du controle de date sur la date de d$$HEX1$$e900$$ENDHEX$$but de r$$HEX1$$e900$$ENDHEX$$vision
//* #2	FPI	[20100204.FPI] Ajout du contr$$HEX1$$f400$$ENDHEX$$le sur la date d'effet
//*-----------------------------------------------------------------


Boolean     bRet 				// Valeur de retour de la fonction Uf_Gs_DateDebut.
String		sCol 				// Nom du champ en erreur.
Date			dDteEff			// Date de debut d'effet saisie.
String		sCodMes			// [DCMP060153] Code du Message d'erreur

sCol = ""
/*------------------------------------------------------------------*/
/* Ce contr$$HEX1$$f400$$ENDHEX$$le n'est utile que lors d'une cr$$HEX1$$e900$$ENDHEX$$ation ou d'une         */
/* modification de la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$vision.                            */
/*------------------------------------------------------------------*/
If ibDernier  Then

	dDteEff = Date(Dw_1.GetItemDateTime ( 1, "DTE_EFF" )) // [PI056] getItemDate en GetItemDateTime

// [DCMP060153] On prends en retour le code du message d'erreur $$HEX2$$e0002000$$ENDHEX$$afficher
//	bRet =  iuoGsRevision.uf_Gs_DateDebut ( dDteEff, Dw_1.iuDwDetailSource )
	bRet =  iuoGsRevision.uf_Gs_DateDebut ( dDteEff, Dw_1.iuDwDetailSource, sCodMes )

	If Not ( bRet ) then

		/*------------------------------------------------------------------*/
		/* Repositionne le bon onglet : Dw_1                                */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "01" )

		sCol = "DTE_EFF"
		stMessage.sTitre   = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des R$$HEX1$$e900$$ENDHEX$$visions"
		stMessage.Icon     = Information!
		// [DCMP060153]
		//stMessage.scode    = 'REFU008'
		stMessage.berreurg = FALSE
		stMessage.scode    = sCodMes 

		f_Message( stMessage )

	End If

End If

/*------------------------------------------------------------------*/
/* Teste s'il y a des $$HEX1$$e900$$ENDHEX$$tablissement ou le code ets a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi.     */
/*------------------------------------------------------------------*/
If ( sCol = "" )	Then

	/*------------------------------------------------------------------*/
	/* Controle de saisie pour les $$HEX1$$e900$$ENDHEX$$tablissements.                      */
	/*------------------------------------------------------------------*/
//	sCol = iuoGsEts.Uf_ControlerSaisie ()

		If ( sCol <> "" ) Then

			/*------------------------------------------------------------------*/
			/* On se positionne sur le deuxi$$HEX1$$e800$$ENDHEX$$me onglet : Uo_Ets                 */
			/*------------------------------------------------------------------*/
			Uo_Onglets.Uf_ChangerOnglet ( "02" )		
			Wf_Changer_Controle ( Uo_Ets.Dw_Source )

		End If

End If

// #1 - Contr$$HEX1$$f400$$ENDHEX$$le date de d$$HEX1$$e900$$ENDHEX$$but > $$HEX2$$e0002000$$ENDHEX$$date du jour
// #2 - [20100204.FPI] - Mise en commentaire
/*If sCol = "" Then
	If dDteEff <= Today() Then
		sCol = "DTE_EFF"
		stMessage.sTitre   = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des R$$HEX1$$e900$$ENDHEX$$visions"
		stMessage.Icon     = Information!
		stMessage.scode    = "EWK0011"
		stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but"
		stMessage.sVar[2] = "date du jour"
		stMessage.berreurg = TRUE
		
		f_Message( stMessage )
	End if
End if*/

// #2 - [20100204.FPI]
If sCol = "" Then
	sCol=wf_controledateeffet()
End if

Return ( sCol )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_TerminerValider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 10:56:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Met $$HEX2$$e0002000$$ENDHEX$$jour la r$$HEX1$$e900$$ENDHEX$$vision associ$$HEX2$$e9002000$$ENDHEX$$au produit dans Dw_1
//*					 	de la fen$$HEX1$$ea00$$ENDHEX$$tre maitre d$$HEX1$$e900$$ENDHEX$$finissant le produit.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------
String		sColCodRev			// Nom de la colonne $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour.

/*------------------------------------------------------------------*/
/* Cette affectation ne doit se faire que si on cr$$HEX3$$e900e9002000$$ENDHEX$$une r$$HEX1$$e900$$ENDHEX$$vision.  */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then

	/*------------------------------------------------------------------*/
	/* Je met $$HEX2$$e0002000$$ENDHEX$$jour le N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision associ$$HEX2$$e9002000$$ENDHEX$$au produit dans la       */
	/* grille de d$$HEX1$$e900$$ENDHEX$$finition de ce dernier dans la fen$$HEX1$$ea00$$ENDHEX$$tre maitre.       */
	/* NB : Si COD_EFF_REV = 'dte_SURV' on renseigne cod_rev_SURV.      */
	/*      Si COD_EFF_REV = 'dte_SOUS' on renseigne cod_rev_SOUS.      */
	/*      Si COD_EFF_REV = 'dte_RNV'  on renseigne cod_rev_RNV.       */
	/*------------------------------------------------------------------*/
	sColCodRev	= "COD_REV_" + Mid ( Dw_1.GetItemString ( 1, "COD_EFF_REV" ), 5 )
	iwMaitre.Dw_1.SetItem ( 1 , sColCodRev , idcIdRev )

End If

/*------------------------------------------------------------------*/
/* Met $$HEX2$$e0002000$$ENDHEX$$jour la liste des Etablissement iwMaitre.dw_ProdEts        */
/*------------------------------------------------------------------*/
iuoGsEts.Uf_MajRev ( idcIdRev )

Return ( True )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_TerminerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 10:56:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Met $$HEX2$$e0002000$$ENDHEX$$jour la r$$HEX1$$e900$$ENDHEX$$vision associ$$HEX1$$e900$$ENDHEX$$e au produit dans Dw_1
//*					 	de la fen$$HEX1$$ea00$$ENDHEX$$tre maitre d$$HEX1$$e900$$ENDHEX$$finissant le produit.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la suppression peut se poursuivre.
//*
//*-----------------------------------------------------------------

Decimal{0}	dcIdRevProd	// N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision $$HEX2$$e0002000$$ENDHEX$$affecter au produit.

String		sIdRevProd	// N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision $$HEX2$$e0002000$$ENDHEX$$affecter au produit.
String		sCodEffRev	// Zone d'effet de la r$$HEX1$$e900$$ENDHEX$$vision.
String		sIdRev		// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
String		sColCodRev	// Nom de la colonne $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour : COD_REV_XXXX

Long			lNbrLig		// Nbre de revision pour le produit.
Long			lRet			// R$$HEX1$$e900$$ENDHEX$$sultat du find.


/*------------------------------------------------------------------*/
/* J'affecte la date de fin d'effet de r$$HEX1$$e900$$ENDHEX$$vision pour la r$$HEX1$$e900$$ENDHEX$$vision    */
/* n-1 ayant la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet ( COD_EFF_REV ).                  */
/* DTE_FIN : 01/01/3000                                             */
/*------------------------------------------------------------------*/
sIdRevProd	= String ( dcIdRevProd )
lNbrLig		= Dw_1.iuDwDetailSource.RowCount ()

If lNbrLig > 0	Then

	sIdRev		= String ( Dw_1.GetItemNumber ( 1 , "ID_REV" ) )
	sCodEffRev  = Dw_1.GetItemString ( 1, "COD_EFF_REV" )

	lRet = Dw_1.iuDwDetailSource.Find ( "ID_REV <> " + sIdRev + "And COD_EFF_REV='" + sCodEffRev + "'", lNbrLig, 1 )

	If lRet <> 0	Then

		Dw_1.iuDwDetailSource.SetItem ( lRet, "DTE_FIN", 3000-01-01 )

		/*------------------------------------------------------------------*/
		/* Je met $$HEX2$$e0002000$$ENDHEX$$jour le N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision associ$$HEX2$$e9002000$$ENDHEX$$au produit dans la       */
		/* grille de d$$HEX1$$e900$$ENDHEX$$finition de ce dernier dans la fen$$HEX1$$ea00$$ENDHEX$$tre maitre.       */
		/* NB : Si COD_EFF_REV = 'dte_SURV' on renseigne cod_rev_SURV.      */
		/*      Si COD_EFF_REV = 'dte_SOUS' on renseigne cod_rev_SOUS.      */
		/*      Si COD_EFF_REV = 'dte_RNV'  on renseigne cod_rev_RNV.       */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* J'affecte au produit :  N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision de la r$$HEX1$$e900$$ENDHEX$$vision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente */
		/* pour la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet (point$$HEX2$$e9002000$$ENDHEX$$par la variable lRet.          */
		/*------------------------------------------------------------------*/
		dcIdRevProd = Dw_1.iuDwDetailSource.GetItemNumber ( lRet, "ID_REV" )

		sColCodRev	= "COD_REV_" + Mid ( Dw_1.GetItemString ( 1, "COD_EFF_REV" ), 5 )
		iwMaitre.Dw_1.SetItem ( 1 , sColCodRev , dcIdRevProd )

	Else

		/*----------------------------------------------------------------------------*/
		/* Il n'y a pas de r$$HEX1$$e900$$ENDHEX$$vision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente pour cette zone d'effet, donc on met   */
		/* -1 dans le COD_EFF_XXXX du produit.                                        */
		/*----------------------------------------------------------------------------*/
		dcIdRevProd = -1

		sColCodRev	= "COD_REV_" + Mid ( Dw_1.GetItemString ( 1, "COD_EFF_REV" ), 5 )
		iwMaitre.Dw_1.SetItem ( 1 , sColCodRev , dcIdRevProd )

	End If

Else

	/*----------------------------------------------------------------------------*/
	/* Il n'y a plus de r$$HEX1$$e900$$ENDHEX$$vision du tout, donc on met -1 dans le COD_EFF_XXXX du  */
	/* produit.                                                                   */
	/*----------------------------------------------------------------------------*/
	dcIdRevProd = -1

	sColCodRev	= "COD_REV_" + Mid ( Dw_1.GetItemString ( 1, "COD_EFF_REV" ), 5 )
	iwMaitre.Dw_1.SetItem ( 1 , sColCodRev , dcIdRevProd )

End If

/*------------------------------------------------------------------*/
/* Met $$HEX2$$e0002000$$ENDHEX$$jour la liste des Etablissement iwMaitre.dw_ProdEts        */
/*------------------------------------------------------------------*/
//iuoGsEts.Uf_SupEts ( iwMaitre.Dw_ProdEts, idcIdRev )

Return ( TRUE )
end function

public function boolean wf_accepttext ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_acceptText
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	25/07/97 09:30:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	d$$HEX1$$e900$$ENDHEX$$clenche les AcceptText sur toutes les DW pour valider les saisies.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		True = OK on peut continuer les contr$$HEX1$$f400$$ENDHEX$$les.
//*										False Sinon
//*
//*-----------------------------------------------------------------

Boolean 		bRet		= True			//Valeur de retour de la fonction.

If Uo_Ets.Dw_Source.AcceptText () < 0 then

	bRet = False
	Uo_Onglets.Uf_ChangerOnglet ( "02" )

End If

Return ( bRet )
end function

private function string wf_controledateeffet ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_td_sp_revision::wf_controledateeffet
//* Auteur			: F. Pinon
//* Date				: 04/02/2010 14:44:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [20100204.FPI]
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCol, sCodEffRev
DateTime dDteEff
DateTime dDteMinPropo
Decimal dcIdProd
Long lRet

sCol=""

dDteEff = Dw_1.GetItemDateTime ( 1, "DTE_EFF" ) // [PI056] getItemDate en GetItemDateTime
sCodEffRev=dw_1.GetItemString( 1, "COD_EFF_REV")

stMessage.sTitre   = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des R$$HEX1$$e900$$ENDHEX$$visions"
stMessage.Icon     = Information!
stMessage.berreurg = FALSE

st_wait.Visible = TRUE

lRet=SQLCA.ps_s01_ctrl_rev(  idcidprod, sCodEffRev, ddteeff, dDteMinPropo)

st_wait.Visible = FALSE

Choose case lRet
	Case -1 
		sCol = "DTE_EFF"
		stMessage.scode    = "GENE165"
		f_Message( stMessage )
	Case 1
		If date(dDteMinPropo) > Date(ddteEff) Then
			stMessage.scode    = "GENE166"
			
			Choose case sCodEffRev
				Case "DTE_SURV"
					stMessage.sVar[1] = "date de survenance"
				Case "DTE_SOUS"
					stMessage.sVar[1] = "date de souscription"
				Case "DTE_RNV"
					stMessage.sVar[1] = "date de renouvellement"
			End Choose
			
			stMessage.sVar[2] = String(ddteMinPropo,"dd/mm/yyyy")
			stMessage.bouton =OK!

			f_Message( stMessage )
			dw_1.setitem(1,"dte_eff",ddteMinPropo)
			
		End if	
End Choose

Return sCol




end function

on ue_initialiser;call w_8_traitement_detail::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_revision
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/97 10:23:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	r$$HEX1$$e900$$ENDHEX$$visions.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String					sCol [ 2 ]	//	Tableau contenant les champs
											// dont l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.
String					sMod			// Chaine de modification de DW.


/*------------------------------------------------------------------*/
/* Initialisation d'User Object de contr$$HEX1$$f400$$ENDHEX$$les de gestion             */
/*------------------------------------------------------------------*/
iuoGsRevision = Create u_sp_gs_Revision
iuoGsRevision.uf_initialisation ( itrTrans, Dw_1 )

iuoGsEts = Create u_sp_gs_Ets


/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet concernant les Ets     */
/* du produit.                                                      */
/*------------------------------------------------------------------*/
Uo_Ets.Uf_Initialiser ( "d_sp_lst_ets_rch", "d_sp_prod_ets", "d_sp_lst_ets", itrTrans )

iuoGsEts.uf_Initialisation ( istPass.dwNorm[1], uo_Ets.Dw_Cible, istPass.dwNorm[3], itrTrans   )

/*------------------------------------------------------------------*/
/* Initialisation de la transaction de DW_1                         */
/*------------------------------------------------------------------*/
Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "COD_EFF_REV"
sCol [ 2 ] = "DTE_EFF"

Dw_1.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* J'ai besoin de certaines informations : dte_eff concernant       */
/* l'ancienne r$$HEX1$$e900$$ENDHEX$$vision valide du produit.                           */
/*------------------------------------------------------------------*/
iwMaitre = iwParent


/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 2, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "R$$HEX1$$e900$$ENDHEX$$vision"      , "", dw_1  , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Etablissement", "", Uo_Ets, False )

sMod = "id_ets.protect=1 ets_t.text='Etablissements couverts par la r$$HEX1$$e900$$ENDHEX$$vision'"
Uo_Ets.Uf_Modify ( Uo_Ets.Dw_Source, sMod )

sMod = "ets_t.text='Etablissements non couverts'"
Uo_Ets.Uf_Modify ( Uo_Ets.Dw_Cible, sMod )

/*------------------------------------------------------------------*/
/* Initialisation de la Dw li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la gestion des Ets du produit     */
/*------------------------------------------------------------------*/


end on

on close;call w_8_traitement_detail::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_revision
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 11:01:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des revisions                                */
/*------------------------------------------------------------------*/
Destroy	iuoGsRevision
Destroy	iuoGsEts


end on

on w_td_sp_revision.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.uo_ets=create uo_ets
this.dw_ets_sav=create dw_ets_sav
this.uo_bord3d=create uo_bord3d
this.st_wait=create st_wait
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.uo_ets
this.Control[iCurrent+3]=this.dw_ets_sav
this.Control[iCurrent+4]=this.uo_bord3d
this.Control[iCurrent+5]=this.st_wait
end on

on w_td_sp_revision.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.uo_ets)
destroy(this.dw_ets_sav)
destroy(this.uo_bord3d)
destroy(this.st_wait)
end on

type cb_debug from w_8_traitement_detail`cb_debug within w_td_sp_revision
end type

type dw_1 from w_8_traitement_detail`dw_1 within w_td_sp_revision
integer x = 46
integer y = 284
integer width = 3040
integer height = 800
string dataobject = "d_sp_revision"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend 
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 11:03:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	L'Erreur de type GENE002/003 sont d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$es par les r$$HEX1$$e800$$ENDHEX$$gles de validation.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des R$$HEX1$$e900$$ENDHEX$$visions"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "LIB_REV"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$de la r$$HEX1$$e900$$ENDHEX$$vision"
			stMessage.sCode	= "GENE003"

		Case "DTE_EFF"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but d'effet"
					stMessage.sCode	= "GENE002"

				Case 1
					stMessage.sCode	= "GENE009"

			End Choose

		Case "DTE_FIN"
			stMessage.sVar[1] = "date de fin d'effet"
			stMessage.sCode	= "GENE002"

	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement_detail`st_titre within w_td_sp_revision
boolean visible = false
integer x = 4306
integer y = 32
end type

type pb_retour from w_8_traitement_detail`pb_retour within w_td_sp_revision
integer x = 23
integer y = 16
integer width = 242
integer height = 144
integer taborder = 30
end type

on pb_retour::clicked;call w_8_traitement_detail`pb_retour::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_revision::pb_retour
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 24/02/1998 14:10:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On remet les anciennes valeurs d'ets
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


uo_Ets.Dw_Source.RowsDiscard ( 1, uo_Ets.Dw_Source.RowCount (), Primary! )
Dw_Ets_Sav.RowsCopy ( 1, Dw_Ets_Sav.RowCount (), Primary!, uo_Ets.Dw_Source, 1, Primary!  )
end on

type pb_valider from w_8_traitement_detail`pb_valider within w_td_sp_revision
integer x = 517
integer y = 16
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_traitement_detail`pb_imprimer within w_td_sp_revision
boolean visible = false
integer x = 4032
integer y = 36
integer width = 242
integer height = 144
integer taborder = 0
end type

type pb_controler from w_8_traitement_detail`pb_controler within w_td_sp_revision
integer x = 270
integer y = 16
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_supprimer from w_8_traitement_detail`pb_supprimer within w_td_sp_revision
integer x = 763
integer y = 16
integer width = 242
integer height = 144
integer taborder = 60
end type

type uo_onglets from u_onglets within w_td_sp_revision
integer x = 18
integer y = 172
integer width = 983
integer height = 108
integer taborder = 0
boolean border = false
end type

type uo_ets from u_ajout within w_td_sp_revision
integer x = 27
integer y = 268
integer width = 3081
integer height = 832
integer taborder = 20
boolean border = false
end type

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Ets
//* Evenement 		:	UE_DWSOURCE_ITEMERROR
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	23/07/1997 14:48:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "ID_ETS"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Etablissements"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "le code de l'$$HEX1$$e900$$ENDHEX$$tablissement"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_ets
//* Evenement 		:	Constructor
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/97 13:53:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet d$$HEX1$$e900$$ENDHEX$$finissant les $$HEX1$$e900$$ENDHEX$$tablissements
//*						du produit.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e800$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fen$$HEX1$$ea00$$ENDHEX$$tre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur                              */
/*------------------------------------------------------------------*/
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Ets
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/97 13:55:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Pb_enlever_tout.Visible = False
This.Pb_ajouter_tout.Visible = False
end on

on uo_ets.destroy
call u_ajout::destroy
end on

type dw_ets_sav from datawindow within w_td_sp_revision
boolean visible = false
integer x = 1906
integer y = 32
integer width = 1115
integer height = 208
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_sp_prod_ets"
boolean livescroll = true
end type

type uo_bord3d from u_bord3d within w_td_sp_revision
integer x = 27
integer y = 268
integer width = 3081
integer height = 832
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type st_wait from statictext within w_td_sp_revision
boolean visible = false
integer x = 535
integer y = 900
integer width = 2062
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Recherche en cours - Merci de patienter un instant..."
alignment alignment = center!
boolean focusrectangle = false
end type

