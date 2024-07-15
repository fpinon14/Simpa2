HA$PBExportHeader$w_td_sp_code_condition.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des pi$$HEX1$$e800$$ENDHEX$$ces, refus, et $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nements d'une garantie.
forward
global type w_td_sp_code_condition from w_ancetre
end type
type uo_onglets from u_onglets within w_td_sp_code_condition
end type
type pb_1 from u_8_pbvalider within w_td_sp_code_condition
end type
type uo_pieces from u_spb_ajout_courtyp within w_td_sp_code_condition
end type
type uo_codcon from u_ajout within w_td_sp_code_condition
end type
type uo_refus from u_spb_ajout_courtyp within w_td_sp_code_condition
end type
type uo_bord3d from u_bord3d within w_td_sp_code_condition
end type
end forward

global type w_td_sp_code_condition from w_ancetre
integer x = 0
integer y = 60
integer width = 3598
integer height = 1512
boolean titlebar = true
string title = "Gestion des codes de garantie"
event ue_ouverture pbm_custom01
event ue_entreronglet011 pbm_custom02
event ue_entreronglet021 pbm_custom03
event ue_entreronglet031 pbm_custom04
event ue_entreronglet041 pbm_custom05
event ue_quitteronglet011 pbm_custom06
event ue_quitteronglet021 pbm_custom07
event ue_entreronglet051 pbm_custom08
event ue_entreronglet061 pbm_custom09
uo_onglets uo_onglets
pb_1 pb_1
uo_pieces uo_pieces
uo_codcon uo_codcon
uo_refus uo_refus
uo_bord3d uo_bord3d
end type
global w_td_sp_code_condition w_td_sp_code_condition

type variables
Public:

  Boolean			ibDejaOuvert = False
  Boolean			ibouverture    = False


  Decimal{0}		iDcIdGti
  Decimal{0}		iDcIdProd

  U_Sp_Zn_Pieces		iUoZnPieces
  U_Sp_Zn_Refus		iUoZnRefus

  w_tm_sp_produit		iWappel

  Boolean			ibDejaInitialiser[ 2 ]
end variables

forward prototypes
public function boolean wf_controlersaisie ()
public subroutine wf_initongletrefus ()
public subroutine wf_initongletpieces ()
public subroutine wf_initongletcondition (string asidtypcod, string astitrecible, string astitresource)
end prototypes

on ue_ouverture;call w_ancetre::ue_ouverture;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: ue_ouverture
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 04/02/97 16:56:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisations qui sont ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$CHAQUE ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: Ces lignes ne peuvent pas $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$es sur l'ACTIVATE car elles
//*					  seraient d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$es lors de l'affichage de messages d'erreur. 
//* 					  De m$$HEX1$$ea00$$ENDHEX$$me, sur l'UE_INITIALISER, elles ne seraient ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es qu'une fois.
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation du contenu des onglets.                           */
/*------------------------------------------------------------------*/
Uo_Pieces.Uf_DwRechercheRetrieve ( "", Uo_Pieces )

Uo_Refus.Uf_DwRechercheRetrieve ( "", Uo_Refus )

/*----------------------------------------------------------------------------*/
/* Permet de renseigner la colonne ID_GTI pour un bon fonctionnement du       */
/* chargement de la DW Cible par la m$$HEX1$$e900$$ENDHEX$$thode du RowsCopy. Ce retrieve est      */
/* $$HEX1$$e900$$ENDHEX$$galement fait lorsque l'on entre dans la fen$$HEX1$$ea00$$ENDHEX$$tre des codes conditions de  */
/* gar. pour les $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nements.                                                  */
/* On filtrera les codes en fonction du type de code $$HEX2$$e0002000$$ENDHEX$$l'entr$$HEX1$$e900$$ENDHEX$$e de chaque     */
/* onglet.                                                                    */
/*----------------------------------------------------------------------------*/
iwAppel.Dw_Code.ShareData ( Uo_CodCon.dw_Recherche )


iwAppel.Dw_Pieces.ShareData ( Uo_Pieces.dw_Source )
Uo_Pieces.Dw_Source.Sort ( )

iwAppel.Dw_Refus.ShareData ( Uo_Refus.dw_Source )
Uo_Refus.Dw_Source.Sort ( )

/*------------------------------------------------------------------*/
/* On se positionne sur le premier onglet                           */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

If ( istPass.bEnableParent = False ) Then

	iwAppel.Enabled = False

End If
end on

on ue_entreronglet011;call w_ancetre::ue_entreronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Ue_EnterOnglet011
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des pi$$HEX1$$e800$$ENDHEX$$ces.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

/*----------------------------------------------------------------------------*/
/* On n'initialise les pi$$HEX1$$e800$$ENDHEX$$ces qu'une seule fois, il n'est pas n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire de   */
/* refaire le Wf_InitOngletPieces () $$HEX2$$e0002000$$ENDHEX$$chaque fois que l'utilisateur zappe    */
/* d'un onglet $$HEX2$$e0002000$$ENDHEX$$un autre.                                                    */
/*----------------------------------------------------------------------------*/
If Not ibDejaInitialiser [ 1 ] Then

	Wf_InitOngletPieces ( )
	ibDejaInitialiser [ 1 ] = True

End If
end on

on ue_entreronglet021;call w_ancetre::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Ue_EntrerOnglet021
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 10:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des motif de refus.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

/*----------------------------------------------------------------------------*/
/* On n'initialise les pi$$HEX1$$e800$$ENDHEX$$ces qu'une seule fois, il n'est pas n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire de   */
/* refaire le Wf_InitOngletRefus () $$HEX2$$e0002000$$ENDHEX$$chaque fois que l'utilisateur zappe     */
/* d'un onglet $$HEX2$$e0002000$$ENDHEX$$un autre.                                                    */
/*----------------------------------------------------------------------------*/
If Not ibDejaInitialiser [ 2 ] Then

	Wf_InitOngletRefus ()
	ibDejaInitialiser [ 2 ] = True

End If


end on

on ue_entreronglet031;call w_ancetre::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Ue_EntrerOnglet031
//* Auteur			: YP
//* Date				: 10/11/1997 09:30:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des Ev$$HEX1$$e800$$ENDHEX$$nements
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Je populise les informations concernant les $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nements           */
/*------------------------------------------------------------------*/
Wf_InitOngletCondition ( "+EV",	"'Ev$$HEX1$$e800$$ENDHEX$$nements non affect$$HEX1$$e900$$ENDHEX$$s'", &
											"'Ev$$HEX1$$e800$$ENDHEX$$nements affect$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la garantie'" )
end on

on ue_quitteronglet011;call w_ancetre::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_code_condition
//* Evenement 		:	Ue_QuitterOnglet011
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/07/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

on ue_quitteronglet021;call w_ancetre::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_code_condition
//* Evenement 		:	Ue_QuitterOnglet021
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/07/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

public function boolean wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 15:16:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:
//* Commentaires	: Controle si la saisie des pieces et des motifs de refus
//*                 est correcte. 
//* Arguments		: Aucun
//*
//* Retourne		: Boolean 		= True  : tous les contr$$HEX1$$f400$$ENDHEX$$les sont OK
//*										= False : Un des contr$$HEX1$$f400$$ENDHEX$$les n'est pas OK
//*					
//*-----------------------------------------------------------------

Boolean		bRet			// Valeur de retour de la fonction
String		sCol			// Variable relative $$HEX2$$e0002000$$ENDHEX$$colonne en erreur

bRet = True
sCol = ""

If Uo_Pieces.Dw_Source.AcceptText ( ) > 0 Then

	/*------------------------------------------------------------------*/
	/* Controle de remplissage des zones obligatoires de la datawindow  */
	/* dw_Source de l'objet Uo_Pieces                                   */
	/*------------------------------------------------------------------*/
	sCol = iUoZnPieces.Uf_Zn_ControlerSaisie ( Uo_Pieces.Dw_Source )

	If ( sCol <> "" ) Then

		/*------------------------------------------------------------------*/
		/* On se positionne sur le premier onglet : Uo_Pieces               */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "01" )		
		Uo_Pieces.Dw_Source.SetRedraw ( False )
		Uo_Pieces.dw_Source.SetFocus	( )
		Uo_Pieces.dw_Source.SetColumn ( sCol )
		Uo_Pieces.dw_Source.SetRedraw ( True )
		bRet = False

	Else
	
		If Uo_Refus.Dw_Source.AcceptText ( ) > 0 Then

			/*------------------------------------------------------------------*/
			/* Controle de remplissage des zones obligatoires de la datawindow  */
			/* Dw_Source de l'objet Uo_Refus 											  */
			/*------------------------------------------------------------------*/
			sCol = iUoZnRefus.Uf_Zn_ControlerSaisie ( Uo_Refus.Dw_Source )

			If ( sCol <> "" ) Then

				/*------------------------------------------------------------------*/
				/* On se positionne sur le deuxieme onglet : Uo_Refus               */
				/*------------------------------------------------------------------*/
				Uo_Onglets.Uf_ChangerOnglet ( "02" )		
				Uo_Refus.Dw_Source.SetRedraw ( False )
				Uo_Refus.Dw_Source.SetFocus	( )
				Uo_Refus.Dw_Source.SetColumn ( sCol )
				Uo_Refus.Dw_Source.SetRedraw ( True )
				bRet = False

			End If
	
		Else

			bRet = False
			
		End If

	End If
	
Else

	bRet = False

End If

Return ( bRet )
end function

public subroutine wf_initongletrefus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_InitOngletRefus
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 10:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Populise les informations dans l'objet Contenu/contenant
//*					  des motifs de refus
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	JCA	21/11/2006	DCMP 060825
//*-----------------------------------------------------------------

String				sFiltre			// Filtre sur la DW de recherche.

Long					lCpt				// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc		// Nombre de ligne dans Dw_Source.



Uo_Refus.SetRedraw ( False )

Uo_Refus.Dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*--------------------------------------------------------- --------*/
Uo_Refus.Dw_Source.SetFilter ( "ID_GTI="+ String ( idcIdGti )  )
Uo_Refus.Dw_Source.Filter ()
Uo_Refus.Dw_Source.SetSort ( "CPT_TRI A" ) // #1 tri en fonction de cpt_tri
Uo_Refus.Dw_Source.Sort ()

lNbLigSrc = Uo_Refus.Dw_Source.RowCount ()

sFiltre = ""

If lNbLigSrc > 0 Then

	sFiltre = "ID_CODE <> " + String ( Uo_Refus.Dw_Source.GetItemNumber ( 1 , "ID_MOTIF" ) )

	For	lCpt = 2 To lNbLigSrc

		sFiltre = sFiltre + " AND ID_CODE <> " + String ( Uo_Refus.Dw_Source.GetItemNumber ( lCpt , "ID_MOTIF" ) )

	Next

End If

Uo_Refus.Dw_Recherche.SetFilter	( sFiltre )
Uo_Refus.Dw_Recherche.Filter		( )
Uo_Refus.Dw_Recherche.RowsCopy	( 1 , 	Uo_Refus.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Refus.Dw_Cible , 1 , PRIMARY!  )

Uo_Refus.Dw_Recherche.SetFilter ( "" )
Uo_Refus.Dw_Recherche.Filter ( )


Uo_Refus.Dw_Cible.Sort ()

If Uo_Refus.Dw_Cible.RowCount () > 0 then

	Uo_Refus.Dw_Cible.SelectRow ( 0 , False )	
	Uo_Refus.Dw_Cible.SetFocus  ()
	Uo_Refus.Dw_Cible.SelectRow ( 1 , True )

End If

Uo_Refus.SetRedraw ( True )
end subroutine

public subroutine wf_initongletpieces ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_InitOngletPieces
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 10:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Populise les informations dans l'objet Contenu/contenant
//*					  des pi$$HEX1$$e800$$ENDHEX$$ces.
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	JCA	21/11/2006	DCMP 060825
//*-----------------------------------------------------------------

String				sIdGti		//	Variable relative $$HEX2$$e0002000$$ENDHEX$$la colonne ID_GTI
String				sFiltre		// Filtre sur la DW de recherche.

Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.


Uo_Pieces.SetRedraw ( False )

Uo_Pieces.Dw_Cible.Reset ()


sIdGti = String ( iDcIdGti )

/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*--------------------------------------------------------- --------*/
Uo_Pieces.Dw_Source.SetFilter ( "ID_GTI=" + sIdGti  )
Uo_Pieces.Dw_Source.Filter ()
Uo_Pieces.Dw_Source.SetSort ( "CPT_TRI A" ) // #1 tri en fonction de cpt_tri
Uo_Pieces.Dw_Source.Sort ()

lNbLigSrc = Uo_Pieces.Dw_Source.RowCount ()

sFiltre = ""

If lNbLigSrc > 0 Then

	sFiltre = "ID_CODE <> " + String ( Uo_Pieces.Dw_Source.GetItemNumber ( 1 , "ID_PCE" ) )

	For	lCpt = 2 To lNbLigSrc

		sFiltre = sFiltre + " AND ID_CODE <> " + String ( Uo_Pieces.Dw_Source.GetItemNumber ( lCpt , "ID_PCE" ) )

	Next

End If

Uo_Pieces.Dw_Recherche.SetFilter	( sFiltre )
Uo_Pieces.Dw_Recherche.Filter		( )

Uo_Pieces.Dw_Recherche.RowsCopy	( 1 , 	Uo_Pieces.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Pieces.Dw_Cible , 1 , PRIMARY!  )

Uo_Pieces.Dw_Recherche.SetFilter ( "" )
Uo_Pieces.Dw_Recherche.Filter ( )

Uo_Pieces.Dw_Cible.Sort ()

If Uo_Pieces.Dw_Cible.RowCount () > 0 then

	Uo_Pieces.Dw_Cible.SelectRow ( 0 , False )	
	Uo_Pieces.Dw_Cible.SetFocus  ()
	Uo_Pieces.Dw_Cible.SelectRow ( 1 , True )

End If

Uo_Pieces.SetRedraw ( True )
end subroutine

public subroutine wf_initongletcondition (string asidtypcod, string astitrecible, string astitresource);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_InitOngletCondition
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 21/01/1997 14:28:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Populise les informations dans l'objet Contenu/contenant
//*					  des codes conditions.
//* Arguments		:	asIdTypCode		String	(Val) : le type de conditions.
//*						asTitreCible	String	(Val) : Titre de la DW Cible.
//*						asTitreSource	String	(Val) : Titre de la DW Source.

//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String				sFiltre		// Filtre sur la DW de recherche.
String				sMod			// Chaine de modification.
Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.

SetPointer ( HourGlass! )

//Uo_CodCon.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* On affecte le titre aux datawindows de l'objet                   */
/*------------------------------------------------------------------*/
sMod = "titre.Text=" + asTitreCible
Uo_CodCon.Uf_Modify ( Uo_CodCon.Dw_Cible, sMod )

sMod = "titre.Text=" + asTitreSource
Uo_CodCon.Uf_Modify ( Uo_CodCon.Dw_Source, sMod )


Uo_CodCon.Dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*--------------------------------------------------------- --------*/
Uo_CodCon.Dw_Source.SetFilter ( "ID_GTI="+ String ( idcIdGti ) + " AND ID_TYP_CODE='" + asIdTypCod + "'" )
Uo_CodCon.Dw_Source.Filter ( )
Uo_CodCon.Dw_Source.SetSort ( "id_code A" )
Uo_CodCon.Dw_Source.Sort ( )

lNbLigSrc = Uo_CodCon.Dw_Source.RowCount ( )

sFiltre = "ID_TYP_CODE='" + asIdTypCod + "'"

If lNbLigSrc > 0 Then

	For	lCpt = 1 To lNbLigSrc

		sFiltre = sFiltre + " AND ID_CODE <> " + String ( Uo_CodCon.Dw_Source.GetItemNumber ( lCpt , "ID_CODE" ) )

	Next

End If

Uo_CodCon.Dw_Recherche.SetFilter	( sFiltre )
Uo_Codcon.Dw_Recherche.Filter		( )
Uo_CodCon.Dw_Recherche.RowsCopy	( 1 , 	Uo_CodCon.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_CodCon.Dw_Cible , 1 , PRIMARY!  )

Uo_CodCon.Dw_Recherche.SetFilter ( "" )
Uo_CodCon.Dw_Recherche.Filter ( )


Uo_CodCon.Dw_Cible.SetSort ( "id_code A" )
Uo_CodCon.Dw_Cible.Sort ( )

/*------------------------------------------------------------------*/
/* On positionne le Focus sur  Dw_Cible afin d'$$HEX1$$e900$$ENDHEX$$viter que  la       */
/* premi$$HEX1$$e800$$ENDHEX$$re ligne de Dw_cible ET de Dw_Source qui soient            */
/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es simultan$$HEX1$$e900$$ENDHEX$$ment.S'il n'y a pas de ligne dans         */
/* Dw_Cible le focus est positionn$$HEX2$$e9002000$$ENDHEX$$sur Dw_Source.                  */
/*------------------------------------------------------------------*/
If Uo_CodCon.Dw_Cible.RowCount ( ) > 0 then

	Uo_CodCon.Dw_Cible.SelectRow ( 0 , False )	
	Uo_CodCon.Dw_Cible.SetFocus  ( )
	Uo_CodCon.Dw_Cible.SelectRow ( 1 , True )

Else

	Uo_CodCon.Dw_Source.SelectRow ( 0 , False )	
	Uo_CodCon.Dw_Source.SetFocus ( )
	Uo_CodCon.Dw_Source.SelectRow( 1 , True )

End If

Uo_CodCon.SetRedraw ( True )
end subroutine

on activate;call w_ancetre::activate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Activate
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 17/12/1996
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Declanche we_childactivate
//* Commentaires	: Declanch$$HEX2$$e9002000$$ENDHEX$$si la fen$$HEX1$$ea00$$ENDHEX$$tre est de type Popup!
//*					  
//* ----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//*
//*-----------------------------------------------------------------

TriggerEvent ( "we_childactivate" )
end on

on hide;call w_ancetre::hide;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: HIDE
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 17:49:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lors du Show de la Fen$$HEX1$$ea00$$ENDHEX$$tre il faut positionner le
//*					  focus sur l'onglet 1
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Indique pour la prochaine ouverture de fen$$HEX1$$ea00$$ENDHEX$$tre que l'User Event  */
/* ue_ouverture pourra $$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement              */
/* WE_CHILDACTIVATE.                                                */
/*------------------------------------------------------------------*/
ibOuverture = False


This.Enabled = False
end on

on close;call w_ancetre::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: CLose
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/02/97 16:25:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$truit les UO utilis$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DESTROY iUoZnPieces
DESTROY iUoZnRefus

If ( Not istPass.bEnableParent ) Then

	iwAppel.Enabled = True

End If

end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Ue_Initialiser
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 17:12:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//*-----------------------------------------------------------------


DataWindowChild	dwParaPce   // DDDW des Paragraphes des pieces.
DataWindowChild	dwParaRef   // DDDW des Paragraphes des motifs de refus.

iwAppel = w_tm_sp_produit

iUoZnPieces	= CREATE U_Sp_Zn_Pieces
iUoZnRefus	= CREATE U_Sp_Zn_Refus

/*------------------------------------------------------------------*/
/* Positionne le bon objet et le bon onglet                         */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 3, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Pi$$HEX1$$e800$$ENDHEX$$ces"         , "", Uo_Pieces, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Motifs Refus"   , "", Uo_Refus , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "Ev$$HEX1$$e800$$ENDHEX$$nements"     , "", Uo_CodCon, False )

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source,   */
/* cible.                                                           */
/*------------------------------------------------------------------*/
Uo_Pieces.Uf_Initialiser ( "d_sp_lst_pce_pro"    , "d_sp_prod_pce"   , "d_sp_lst_pce"    , itrTrans )
Uo_Refus.Uf_Initialiser  ( "d_sp_lst_ref_pro"    , "d_sp_prod_ref"   , "d_sp_lst_ref"    , itrTrans )
Uo_CodCon.Uf_Initialiser ( "d_sp_lst_cod_con_rch", "d_sp_prod_codcon", "d_sp_lst_cod_con", itrTrans )

/*------------------------------------------------------------------*/
/* Renseigne les Datawindows des l'objets contenus/contenants       */
/*------------------------------------------------------------------*/
iwAppel.dw_Code.ShareData   ( Uo_CodCon.dw_Recherche )
iwAppel.dw_CodCon.ShareData ( Uo_CodCon.dw_Source    )

/*----------------------------------------------------------------------------*/
/* Comme aucun InsertRow n'est r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$sur la Dw Source la DdDw des           */
/* paragraphes n'est pas renseign$$HEX1$$e900$$ENDHEX$$e automatiquement d'ou le Retrieve.         */
/*----------------------------------------------------------------------------*/
Uo_Pieces.dw_Source.GetChild ( "ID_PARA", dwParaPce )

dwParaPce.SetTransObject ( itrTrans )
If ( 	dwParaPce.Retrieve ( ) <= 0 )	Then
		dwParaPce.InsertRow ( 0 )

End If


Uo_Refus.dw_Source.GetChild ( "ID_PARA", dwParaRef )

dwParaRef.SetTransObject ( itrTrans )

If ( 	dwParaRef.Retrieve ( ) <= 0 )	Then
		dwParaRef.InsertRow ( 0 )

End If

end event

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Ue_Retour
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/06/1997 14:55:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fen$$HEX1$$ea00$$ENDHEX$$tre utilis$$HEX1$$e900$$ENDHEX$$e pour d$$HEX1$$e900$$ENDHEX$$finir une garantie.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Integer		i		// Compteur de boucle.

/*----------------------------------------------------------------------------*/
/* On remet les bool$$HEX1$$e900$$ENDHEX$$ens indiquant les onglets d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$initialis$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$False pour  */
/* la prochaine ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                      */
/*----------------------------------------------------------------------------*/
For i = 1 To UpperBound ( ibDejaInitialiser )

	ibDejaInitialiser [ i ] = False

Next

/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des pi$$HEX1$$e800$$ENDHEX$$ces.   */
/*------------------------------------------------------------------*/
Uo_Pieces.dw_Source.SetFilter ( "" )
Uo_Pieces.dw_Source.Filter ()

Uo_Pieces.dw_Recherche.SetFilter ( "" )
Uo_Pieces.dw_Recherche.Filter ()

/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des refus.   */
/*------------------------------------------------------------------*/
Uo_Refus.dw_Source.SetFilter ( "" )
Uo_Refus.dw_Source.Filter ()

Uo_Refus.dw_Recherche.SetFilter ( "" )
Uo_Refus.dw_Recherche.Filter ()

/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des codes     */
/* conditions.                                                      */
/*------------------------------------------------------------------*/
Uo_CodCon.dw_Source.SetFilter ( "" )
Uo_CodCon.dw_Source.Filter ()

Uo_CodCon.dw_Recherche.SetFilter ( "" )
Uo_CodCon.dw_Recherche.Filter ()

Uo_Pieces.dw_Source.ShareDataOff ()
Uo_Refus.dw_Source.ShareDataOff ()

/*------------------------------------------------------------------*/
/* Rend accessible la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.                            */
/*------------------------------------------------------------------*/
If ( Not istPass.bEnableParent ) Then

	iwAppel.Enabled = True

End If

This.Hide ()

/*------------------------------------------------------------------*/
/* Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si    */
/* elle est ouverte                                                 */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

on open;call w_ancetre::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: Open
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 30/01/1997 17:14:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Lors de l'ouverure de la fen$$HEX1$$ea00$$ENDHEX$$tre on arme ce boolean. La fen$$HEX1$$ea00$$ENDHEX$$tre  */
/* n'est ouverte qu'une fois, ensuite elle est cach$$HEX1$$e900$$ENDHEX$$e puis          */
/* visualis$$HEX1$$e900$$ENDHEX$$e.                                                      */
/*------------------------------------------------------------------*/

ibDejaOuvert = True



end on

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: We_ChildActivate
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 30/01/1997 17:17:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: S'execute lorsque la fen$$HEX1$$ea00$$ENDHEX$$tre est visualis$$HEX1$$e900$$ENDHEX$$e. 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If ibDejaOuvert Then

	istPass = Message.PowerObjectParm

	ibDejaOuvert  = False

	itrTrans			= istPass.trTrans			// Objet transaction de la fenetre appelante
	iwParent			= istPass.wParent			// Fenetre Appelante	
	iDcIdProd 		= Dec ( istPass.sTab [ 1 ] )
	iDcIdGti			= Dec ( istPass.sTab [ 2 ] )

	This.TriggerEvent ( "ue_Initialiser" )

End If

/*------------------------------------------------------------------*/
/* Rend inaccessible la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.                          */
/*------------------------------------------------------------------*/
If ( Not istPass.bEnableParent ) Then

	iwParent.TriggerEvent ( "ue_DisableFenetre" )

End If
/*------------------------------------------------------------------*/
/* A CHAQUE ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre, on d$$HEX1$$e900$$ENDHEX$$clenche l'User Event      */
/* ue_ouverture qui ex$$HEX1$$e900$$ENDHEX$$cute des initialisations pour les onglets.   */
/* le Bool$$HEX1$$e900$$ENDHEX$$en emp$$HEX1$$ea00$$ENDHEX$$che son d$$HEX1$$e900$$ENDHEX$$clenchement lorque le WE_CHILDACTIVATE  */
/* est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par l'affichage de messages d'erreur.              */
/*------------------------------------------------------------------*/

If Not ibOuverture Then

	/*------------------------------------------------------------------*/
	/* Indique que l'ouverture a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$faite. Donc dans le                */
	/* WE_CHILDACTIVATE, ce User Event ne sera plus d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$jusqu'$$HEX4$$e000200020002000$$ENDHEX$$*/
	/* la prochaine fermeture/ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.                  */
	/*------------------------------------------------------------------*/
	ibOuverture = True

	TriggerEvent ( "Ue_Ouverture" )

	This.Show ( )

	SetPointer ( Arrow! )

End If

end on

on show;call w_ancetre::show;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_code_condition
//* Evenement 		:	Show
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	03/07/1997 17:16:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  -
//*-----------------------------------------------------------------

This.Enabled = True
end on

on ue_controler;call w_ancetre::ue_controler;//*-----------------------------------------------------------------
//*
//* Objet 			: w_td_sp_code_condition
//* Evenement 		: UE_CONTROLER
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 14/01/1997 10:07:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle si la saisie des pi$$HEX1$$e800$$ENDHEX$$ces et des motifs de refus
//*                 est correcte.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If Wf_ControlerSaisie ( ) Then	This.PostEvent ( "Ue_Retour" )
end on

on w_td_sp_code_condition.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.pb_1=create pb_1
this.uo_pieces=create uo_pieces
this.uo_codcon=create uo_codcon
this.uo_refus=create uo_refus
this.uo_bord3d=create uo_bord3d
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.uo_pieces
this.Control[iCurrent+4]=this.uo_codcon
this.Control[iCurrent+5]=this.uo_refus
this.Control[iCurrent+6]=this.uo_bord3d
end on

on w_td_sp_code_condition.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.pb_1)
destroy(this.uo_pieces)
destroy(this.uo_codcon)
destroy(this.uo_refus)
destroy(this.uo_bord3d)
end on

type uo_onglets from u_onglets within w_td_sp_code_condition
integer x = 5
integer y = 184
integer width = 2939
integer height = 108
integer taborder = 0
boolean border = false
end type

type pb_1 from u_8_pbvalider within w_td_sp_code_condition
integer x = 23
integer y = 20
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -7
string facename = "Arial"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_1
//* Evenement 		: CLICKED - OVERRIDE
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 15:29:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle la saisie avant de fermer la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.Triggerevent ( "ue_controler" )
end on

type uo_pieces from u_spb_ajout_courtyp within w_td_sp_code_condition
integer x = 14
integer y = 280
integer width = 3561
integer height = 1120
integer taborder = 20
boolean border = false
end type

on ue_dwcible_supprime;call u_spb_ajout_courtyp::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_pieces
//* Evenement 		: ue_dwCibleSupprime
//* Auteur			: DBI
//* Date				: 12/02/1998 10:10:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionnement de cpt_tri $$HEX2$$e0002000$$ENDHEX$$la fin de dw_source
//*                 
//*						
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Decimal {0}	dcCptTri

dcCptTri	=	Dw_Source.RowCount ( ) + 1
Dw_Cible.SetItem ( ilLigSourceSupp, "CPT_TRI", dcCptTri )


end on

on ue_click_plus;call u_spb_ajout_courtyp::ue_click_plus;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_pieces
//* Evenement 		: ue_click_plus
//* Auteur			: DBI
//* Date				: 12/02/1998 16:39:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification ordre du compteur de tri
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcCptTriActuel
Decimal{0}	dcCptTriFutur

Long			lNbLig
Long			lLigCour

String 		sObjet

lNbLig	=	This.Dw_Source.RowCount ( )
lLigCour	=	This.Dw_Source.GetRow ( )
sObjet	=	This.Dw_Source.GetObjectAtPointer ( )

If Pos ( sObjet, "b_moins" ) > 0 Then

	If lLigCour < lNbLig Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour + 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour + 1, "CPT_TRI", dcCptTriActuel 	)
	End If	
ElseIf Pos ( sObjet, "b_plus" ) > 0 Then

	If lLigCour > 1 Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour - 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour - 1, "CPT_TRI", dcCptTriActuel 	)
	End If
End If

end on

event ue_dwsource_supprime;call super::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_pieces
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: Y. Picard
//* Date				: 16/04/97 10:10:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des pi$$HEX1$$e800$$ENDHEX$$ces
//*                 affect$$HEX1$$e900$$ENDHEX$$s, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	DBI		13/02/98	  Gestion du compteur de tri lors de la suppression d'une ligne
//*	PHG		30/05/2006	[MIGPB8COR] : Correction de la suppression
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat			//Statut de la ligne courante.
Decimal {0}		dcCptTri				// order de tri des pi$$HEX1$$e800$$ENDHEX$$ces dans la Dw

Long				lNbLigSource		// Nombre de lignes de la datawindow Source
Long				lCpt					// Compteur de boucle

integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/

If This.ilLigSourceSupp > 0 Then

	dcCptTri	  = Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "CPT_TRI" )

	dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then &
		// [MIGPB8COR]
//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
//		remplac$$HEX2$$e9002000$$ENDHEX$$par :
		li_Ligsup = Dw_Source.DeletedCount() + 1
		dw_source.object.data.Delete[li_Ligsup] = &
			dw_source.object.data.Primary[This.ilLigSourceSupp]
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)
	End If

	lNbLigSource	=	Dw_Source.RowCount ( )
	For lCpt = This.ilLigSourceSupp + 1 to lNbLigSource

		Dw_Source.SetItem ( lCpt, "CPT_TRI", dcCptTri )
		dcCptTri ++
	Next
End If

end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_PIECES
//* Evenement 		: CONSTRUCTOR
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/01/1997 14:40:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de l'objet
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
ibIndicateur = False
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
end event

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_piece
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	La recrue
//* Date				:	03/07/1997 15:39:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on g$$HEX1$$e900$$ENDHEX$$re un seul argument dans le retrieve.           */
/* Si cela ne convient pas, il suffit de mettre cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement en    */
/* overwrite                                                        */
/*------------------------------------------------------------------*/

ilLigRecherche = dw_Recherche.Retrieve ( idcIdProd, idcIdGti )
end on

on ue_dwsource_rbuttondown;call u_spb_ajout_courtyp::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_pieces
//* Evenement 		:	ue_dwsource_rbuttondown
//* Auteur			:	La Recrue
//* Date				:	02/07/97 13:48:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courant de la ligne courante.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sCol		// Colonne sur laquelle se trouve le curseur
Long			lLig		// Ligne sur laquelle se trouve le curseur

s_Pass		stPass

lLig	=	f_GetObjectAtPointer ( This.Dw_Source, sCol )

If lLig > 0 Then

	This.Dw_Source.ScrollToRow ( lLig )
	This.Dw_Source.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.Dw_Source.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.Dw_Source.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end on

on ue_dimensionner;call u_spb_ajout_courtyp::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_PIECES
//* Evenement 		: Ue_Dimensionner
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/01/1997 14:40:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_pieces.Pb_enlever_tout.Visible = False
uo_pieces.Pb_ajouter_tout.Visible = False
end on

on uo_pieces.destroy
call u_spb_ajout_courtyp::destroy
end on

event ue_dwsource_buttonclicked;call super::ue_dwsource_buttonclicked;// JCA 
// 16/11/2006
// DCMP 060825 
// Optimisation Param$$HEX1$$e900$$ENDHEX$$trage

integer iTotDwSource, iBoucle

iTotDwSource = Dw_Source.RowCount ( )

Dw_source.SetSort ( "ID_PCE A" )
Dw_source.Sort ( )

for iBoucle = 1 to iTotDwSource
	Dw_source.SetItem ( iBoucle, "CPT_TRI", iBoucle )
next

return 0

end event

type uo_codcon from u_ajout within w_td_sp_code_condition
integer x = 14
integer y = 280
integer width = 3561
integer height = 1120
integer taborder = 40
boolean border = false
end type

on ue_dwsource_dclick;call u_ajout::ue_dwsource_dclick;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_codcon
//* Evenement 		: ue_dwsource_dclick
//* Auteur			: dbi
//* Date				: 03/03/1998 17:11:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Saisie du libell$$HEX2$$e9002000$$ENDHEX$$par d$$HEX1$$e900$$ENDHEX$$faut de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sLibEvt		// Evenement Actuel
s_Pass	stPass		// Structure pour le passage de param$$HEX1$$e800$$ENDHEX$$tres

sLibEvt					= Dw_Source.GetItemString ( ilLigSourceClick, "LIB_EVT" )

stPass.sTab[1] 	= sLibEvt

OpenWithParm ( w_t_sp_saisie_libevt, stPass )

stPass	=	Message.PowerObjectParm

If ( stPass.sTab[2] = "ue_valider" ) Then

	Dw_Source.SetItem ( ilLigSourceClick, "LIB_EVT", stPass.sTab[1] )
End If

end on

on ue_dwcible_supprime;call u_ajout::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_codcon
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: DBI
//* Date				: 18/02/1998	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//*                 
//*						
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If This.ilLigSourceSupp > 0 Then

	/*------------------------------------------------------------------*/
	/* on le met $$HEX2$$e0002000$$ENDHEX$$id_gti car les codes sont charg$$HEX1$$e900$$ENDHEX$$s avec la r$$HEX1$$e900$$ENDHEX$$vision -1*/
	/*------------------------------------------------------------------*/

	This.Dw_Cible.SetItem ( This.ilLigSourceSupp, "ID_GTI", idcIdGti		)

End If

end on

on constructor;call u_ajout::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_CodCon
//* Evenement 		: Constructor
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/01/1997 16:58:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de l'objet
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
end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_codcon
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: Y. Picard
//* Date				: 16/04/97 10:10:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des codes condition
//*                 affect$$HEX1$$e900$$ENDHEX$$s, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* TEST0002          20/11/97          20/11/97				  YP
//* [MIGPB8COR]		 30/05/06 			 30/05/06				  PHG
//*
//*-----------------------------------------------------------------
Decimal{0}		dcIdGti					//Identifiant d'une garantie.
Decimal{0}		dcIdCode					//Identifiant d'un code.

String			sIdTypCode				//Identifiant du type de code.

Long				lNbCondition			//Nombre de condition existante.

dwItemStatus	dwItemStat				//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer


If This.ilLigSourceSupp > 0 Then

	/*------------------------------------------------------------------*/
	/* TEST0002 : On ne peut supprimer un code condition que s'il n'est */
	/* pas utilis$$HEX2$$e9002000$$ENDHEX$$comme condition d'une condition de garantie.         */
	/*------------------------------------------------------------------*/
	dcIdGti  	= This.Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_GTI" 		)
	dcIdCode		= This.Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_CODE" 		)
	sIdTypcode	= This.Dw_Source.GetItemString ( This.ilLigSourceSupp, "ID_TYP_CODE" )

	/*------------------------------------------------------------------*/
	/* Recherche s'il existe une condition pour les identifiants        */
	/*------------------------------------------------------------------*/
	itrTrans.IM_S01_CONDITION ( idcIdProd, dcIdGti, sIdTypcode, dcIdCode, lNbCondition )

	If ( lNbCondition <> 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S01_CONDITION" ) Then

		/*------------------------------------------------------------------*/
		/* On n'autorise pas la suppression de code condition pour ce       */
		/* produit.                                                         */
		/*------------------------------------------------------------------*/
		This.ibSupprime = False

		stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le de suppression des codes conditions"
		stMessage.sCode	= "REFU034"

		f_Message ( stMessage )

	Else

		dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

		If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then &
			// [MIGPB8COR]
	//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
	//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
	//		remplac$$HEX2$$e9002000$$ENDHEX$$par :
			li_Ligsup = Dw_Source.DeletedCount() + 1
			dw_source.object.data.Delete[li_Ligsup] = &
				dw_source.object.data.Primary[This.ilLigSourceSupp]
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)
		End If

	End If

End If

end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_CodCon
//* Evenement 		: Ue_Dimensionner
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 04/01/1997 12:03:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_CodCon.Pb_enlever_tout.Visible = False
Uo_CodCon.Pb_ajouter_tout.Visible = False
end on

on uo_codcon.destroy
call u_ajout::destroy
end on

type uo_refus from u_spb_ajout_courtyp within w_td_sp_code_condition
integer x = 14
integer y = 280
integer width = 3561
integer height = 1120
integer taborder = 30
boolean border = false
end type

on ue_dwcible_supprime;call u_spb_ajout_courtyp::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_refus
//* Evenement 		: ue_dwCibleSupprime
//* Auteur			: DBI
//* Date				: 12/02/1998 10:10:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionnement de cpt_tri $$HEX2$$e0002000$$ENDHEX$$la fin de dw_source
//*                 
//*						
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal {0}	dcCptTri

dcCptTri	=	Dw_Source.RowCount ( ) + 1
Dw_Cible.SetItem ( ilLigSourceSupp, "CPT_TRI", dcCptTri )
end on

on ue_click_plus;call u_spb_ajout_courtyp::ue_click_plus;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_refus
//* Evenement 		: ue_click_plus
//* Auteur			: DBI
//* Date				: 12/02/1998 16:39:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification ordre du compteur de tri
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcCptTriActuel
Decimal{0}	dcCptTriFutur

Long			lNbLig
Long			lLigCour

String 		sObjet

lNbLig	=	This.Dw_Source.RowCount ( )
lLigCour	=	This.Dw_Source.GetRow ( )
sObjet	=	This.Dw_Source.GetObjectAtPointer ( )

If Pos ( sObjet, "b_moins" ) > 0 Then

	If lLigCour < lNbLig Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour + 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour + 1, "CPT_TRI", dcCptTriActuel 	)
	End If	
ElseIf Pos ( sObjet, "b_plus" ) > 0 Then

	If lLigCour > 1 Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour - 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour - 1, "CPT_TRI", dcCptTriActuel 	)
	End If
End If

end on

event ue_dwsource_supprime;call super::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_refus
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: Y. Picard
//* Date				: 16/04/97 10:10:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des motifs de refus
//*                 affect$$HEX1$$e900$$ENDHEX$$s, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	DBI		13/02/98	  Gestion du compteur de tri lors de la suppression d'une ligne
//*	PHG		30/05/2006	[MIGPB8COR] : Correction de la suppression
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat			//Statut de la ligne courante.
Decimal {0}		dcCptTri				// order de tri des pi$$HEX1$$e800$$ENDHEX$$ces dans la Dw

Long				lNbLigSource		// Nombre de lignes de la datawindow Source
Long				lCpt					// Compteur de boucle

integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/

If This.ilLigSourceSupp > 0 Then

	dcCptTri	  = Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "CPT_TRI" )

	dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then &
		// [MIGPB8COR]
//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
//		remplac$$HEX2$$e9002000$$ENDHEX$$par :
		li_Ligsup = Dw_Source.DeletedCount() + 1
		dw_source.object.data.Delete[li_Ligsup] = &
			dw_source.object.data.Primary[This.ilLigSourceSupp]
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)
	End If

	lNbLigSource	=	Dw_Source.RowCount ( )
	For lCpt = This.ilLigSourceSupp + 1 to lNbLigSource

		Dw_Source.SetItem ( lCpt, "CPT_TRI", dcCptTri )
		dcCptTri ++
	Next
End If

end event

on constructor;call u_spb_ajout_courtyp::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_REFUS
//* Evenement 		: CONSTRUCTOR
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/01/1997 15:10:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de l'objet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Les datawindows sont c$$HEX1$$f400$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$c$$HEX1$$f400$$ENDHEX$$tes                               */
/*------------------------------------------------------------------*/
ibHorizontal = False

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
ibIndicateur = False
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
end on

on ue_dwsource_rbuttondown;call u_spb_ajout_courtyp::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_refus
//* Evenement 		:	ue_dwsource_rbuttondown
//* Auteur			:	La Recrue
//* Date				:	02/07/97 13:48:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courrant de la ligne courrante
//*						si ligne courrante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sCol		// Colonne sur laquelle se trouve le curseur
Long			lLig		// Ligne sur laquelle se trouve le curseur

s_Pass		stPass

lLig	=	f_GetObjectAtPointer ( This.Dw_Source, sCol )

If lLig > 0 Then

	This.Dw_Source.ScrollToRow ( lLig )
	This.Dw_Source.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.Dw_Source.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.Dw_Source.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end on

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_refus
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	La recrue
//* Date				:	03/07/1997 15:40:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on g$$HEX1$$e900$$ENDHEX$$re un seul argument dans le retrieve.           */
/* Si cela ne convient pas, il suffit de mettre cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement en    */
/* overwrite                                                        */
/*------------------------------------------------------------------*/

ilLigRecherche = dw_Recherche.Retrieve ( idcIdProd, idcIdGti )
end on

on ue_dimensionner;call u_spb_ajout_courtyp::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_REFUS
//* Evenement 		: Ue_Dimensionner
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 20/01/1997 15:13:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_refus.Pb_enlever_tout.Visible = False
uo_refus.Pb_ajouter_tout.Visible = False
end on

on uo_refus.destroy
call u_spb_ajout_courtyp::destroy
end on

event ue_dwsource_buttonclicked;call super::ue_dwsource_buttonclicked;// JCA 
// 16/11/2006
// DCMP 060825 
// Optimisation Param$$HEX1$$e900$$ENDHEX$$trage

integer iTotDwSource, iBoucle

iTotDwSource = Dw_Source.RowCount ( )

Dw_source.SetSort ( "ID_MOTIF A" )
Dw_source.Sort ( )

for iBoucle = 1 to iTotDwSource
	Dw_source.SetItem ( iBoucle, "CPT_TRI", iBoucle )
next

return 0
end event

type uo_bord3d from u_bord3d within w_td_sp_code_condition
integer x = 14
integer y = 280
integer width = 3561
integer height = 1120
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

