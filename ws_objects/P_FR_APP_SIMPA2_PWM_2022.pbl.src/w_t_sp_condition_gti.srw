HA$PBExportHeader$w_t_sp_condition_gti.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des pi$$HEX1$$e800$$ENDHEX$$ces, refus, delais, plafonds et franchise d'une garantie.
forward
global type w_t_sp_condition_gti from w_ancetre
end type
type uo_onglets from u_onglets within w_t_sp_condition_gti
end type
type pb_1 from u_8_pbvalider within w_t_sp_condition_gti
end type
type uo_franchises from u_ajout within w_t_sp_condition_gti
end type
type uo_plafonds from u_ajout within w_t_sp_condition_gti
end type
type uo_refus from u_spb_ajout_courtyp within w_t_sp_condition_gti
end type
type uo_pieces from u_spb_ajout_courtyp within w_t_sp_condition_gti
end type
type uo_bord3d from u_bord3d within w_t_sp_condition_gti
end type
type uo_delais from u_ajout within w_t_sp_condition_gti
end type
end forward

global type w_t_sp_condition_gti from w_ancetre
integer x = 0
integer y = 200
integer width = 3593
integer height = 1512
boolean titlebar = true
string title = "Gestion des codes de garantie"
event ue_ouverture pbm_custom01
event ue_quitteronglet011 pbm_custom02
event ue_quitteronglet021 pbm_custom03
event ue_quitteronglet041 pbm_custom04
event ue_quitteronglet051 pbm_custom05
uo_onglets uo_onglets
pb_1 pb_1
uo_franchises uo_franchises
uo_plafonds uo_plafonds
uo_refus uo_refus
uo_pieces uo_pieces
uo_bord3d uo_bord3d
uo_delais uo_delais
end type
global w_t_sp_condition_gti w_t_sp_condition_gti

type variables
Public:

  Boolean			ibDejaOuvert  	= False
  Boolean			ibouverture    	= False


  Decimal{0}		iDcIdGti
  Decimal{0}		iDcIdProd
  Decimal{0}		iDcIdRev	
  Decimal{0}		iDcIdCode
  Decimal{0}		iDcIdTypFra	

  Long			ilLigMaster

  String			isIdTypCode
  String			isIdNivFra	= ""



  U_Sp_Zn_Delais		iUoZnDelais
  U_Sp_Zn_Pieces		iUoZnPieces
  U_Sp_Zn_Refus		iUoZnRefus
  U_Sp_Zn_Plafonds	iUoZnPlafonds
  U_Sp_Zn_Franchises	iUoZnfranchises

  w_tm_sp_garantie		iWappel

  


end variables

forward prototypes
public function boolean wf_controlersaisie ()
public subroutine wf_initongletrefus ()
public subroutine wf_initongletpieces ()
public subroutine wf_initongletplafonds ()
public subroutine wf_initongletfranchises ()
public subroutine wf_initongletdelais ()
end prototypes

on ue_ouverture;call w_ancetre::ue_ouverture;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	ue_ouverture
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 17:02:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:  Initialisations qui sont ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$CHAQUE ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:  Ces lignes ne peuvent pas $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$es sur l'ACTIVATE car elles
//*					   seraient d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$es lors de l'affichage de messages d'erreur. 
//* 					   De m$$HEX1$$ea00$$ENDHEX$$me, sur l'UE_INITIALISER, elles ne seraient ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es qu'une fois.
//*				  
//*-----------------------------------------------------------------
Long		lNbFranchise		// Nombre de franchises d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Boolean	bOngletFranchise	// Permet d'activer ou non l'onglet des franchises
Boolean	bOngletPceRef		// Permet d'activer ou non les onglets des pi$$HEX1$$e800$$ENDHEX$$ces et refus

/*----------------------------------------------------------------------------*/
/* Si la r$$HEX1$$e900$$ENDHEX$$vision est renseign$$HEX1$$e900$$ENDHEX$$e et que la fen$$HEX1$$ea00$$ENDHEX$$tre a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte $$HEX2$$e0002000$$ENDHEX$$partir de  */
/* la garantie on active les onglets de pi$$HEX1$$e800$$ENDHEX$$ces et refus et on instancie les   */
/* valeurs des datawindows $$HEX2$$e0002000$$ENDHEX$$l'int$$HEX1$$e900$$ENDHEX$$rieur.                                     */
/*----------------------------------------------------------------------------*/
If (  ( isIdTypCode = "-GA" ) AND Not ( isNull ( idcidrev ) ) ) Then
	bOngletPceRef = True 
Else
	bOngletPceRef = False
End If 

Uo_Onglets.Uf_ActiverOnglet ( "04" , bOngletPceRef )
Uo_Onglets.Uf_ActiverOnglet ( "05" , bOngletPceRef )

If ( bOngletPceRef ) Then

	/*------------------------------------------------------------------*/
	/* Initialisation du contenu des onglets.                           */
	/*------------------------------------------------------------------*/
	Uo_Pieces.Uf_DwRechercheRetrieve ( "", Uo_Pieces )
	Uo_Refus.Uf_DwRechercheRetrieve  ( "", Uo_Refus )

	iwAppel.Dw_Piece.ShareData 		( Uo_Pieces.dw_Source   )
	iwAppel.Dw_Refus.ShareData 		( Uo_Refus.dw_Source    )
	wf_initongletrefus ( )
	wf_initongletpieces ( )

End If


/*----------------------------------------------------------------------------*/
/* L'onglet des plafonds doit $$HEX1$$ea00$$ENDHEX$$tre accessible quel que soit l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur     */
/* lequel on travaille ( garantie ou condition de garantie ), donc on         */
/* l'initialise et on le rend disponible $$HEX2$$e0002000$$ENDHEX$$chaque fois.                       */
/*----------------------------------------------------------------------------*/
Uo_Plafonds.Uf_DwRechercheRetrieve ( "", Uo_Plafonds )
iwAppel.Dw_Plafond.ShareData ( Uo_Plafonds.dw_Source   )
Wf_InitOngletPlafonds ( )


/*----------------------------------------------------------------------------*/
/* L'onglet des delais doit $$HEX1$$ea00$$ENDHEX$$tre accessible quel que soit l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur       */
/* lequel on travaille ( garantie ou condition de garantie ), donc on         */
/* l'initialise et on le rend disponible $$HEX2$$e0002000$$ENDHEX$$chaque fois.                       */
/*----------------------------------------------------------------------------*/
Uo_Delais.Uf_DwRechercheRetrieve ( "", Uo_Delais )
iwAppel.Dw_Delai.ShareData ( Uo_Delais.dw_Source   )
Wf_InitOngletDelais ( )


/*----------------------------------------------------------------------------*/
/* L'onglet des franchises n'est disponible que si l'on se trouve sur         */
/* l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur lequel on a d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$une franchise ou si aucune        */
/* franchise n'a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$encore param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e.                                       */
/*----------------------------------------------------------------------------*/
lNbFranchise = iwAppel.Dw_Franchise.RowCount ()

If ( lNbFranchise > 0 ) Then
	
	If ( isIdNivFra = "" ) Then

		isIdNivFra = iwAppel.Dw_Franchise.GetItemString ( 1, "ID_NIV_FRA" )

	End If

End If

If ( ( isIdTypCode = isIdNivFra ) OR ( lNbFranchise = 0 ) ) Then

	bOngletFranchise = True 

Else

	bOngletFranchise = False

End If 

Uo_Onglets.Uf_ActiverOnglet ( "02" , bOngletFranchise )


If ( bOngletFranchise ) Then

	/*------------------------------------------------------------------*/
	/* Initialisation du contenu de l'onglet des franchises.            */
	/*------------------------------------------------------------------*/
	Uo_Franchises.Uf_DwRechercheRetrieve ( "", Uo_Franchises       )

End If

iwAppel.Dw_Franchise.ShareData 		 ( Uo_Franchises.dw_Source )
Wf_InitOngletFranchises ( )

/*------------------------------------------------------------------*/
/* On se positionne sur le premier onglet                           */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

If ( istPass.bEnableParent = False ) Then

	iwAppel.Enabled = False

End If
end on

on ue_quitteronglet011;call w_ancetre::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_condition_gti
//* Evenement 		:	Ue_QuitterOnglet011
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

on ue_quitteronglet021;call w_ancetre::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_condition_gti
//* Evenement 		:	Ue_QuitterOnglet021
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If

end on

on ue_quitteronglet041;call w_ancetre::ue_quitteronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_condition_gti
//* Evenement 		:	Ue_QuitterOnglet041
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

on ue_quitteronglet051;call w_ancetre::ue_quitteronglet051;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_condition_gti
//* Evenement 		:	Ue_QuitterOnglet051
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 11:38:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des
//*						paragraphes si elle a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end on

public function boolean wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlersaisie
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 09:59:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour les pi$$HEX1$$e800$$ENDHEX$$ces et les refus
//* Commentaires	:	
//*
//* Arguments		:	
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
		/* On se positionne sur le Quatri$$HEX1$$e800$$ENDHEX$$me onglet : Uo_Pieces             */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "04" )		
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
				/* On se positionne sur le Cinqi$$HEX1$$e800$$ENDHEX$$me onglet : Uo_Refus               */
				/*------------------------------------------------------------------*/
				Uo_Onglets.Uf_ChangerOnglet ( "05" )		
				Uo_Refus.Dw_Source.SetRedraw ( False )
				Uo_Refus.Dw_Source.SetFocus	( )
				Uo_Refus.Dw_Source.SetColumn ( sCol )
				Uo_Refus.Dw_Source.SetRedraw ( True )
				bRet = False

			Else

				If Uo_Plafonds.Dw_Source.AcceptText ( ) > 0 Then

					/*------------------------------------------------------------------*/
					/* Controle de remplissage des zones obligatoires de la datawindow  */
					/* Dw_Source de l'objet Uo_Plafonds    									  */
					/*------------------------------------------------------------------*/
					sCol = iUoZnPlafonds.Uf_Zn_ControlerSaisie ( Uo_Plafonds.Dw_Source )

					If ( sCol <> "" ) Then

						/*------------------------------------------------------------------*/
						/* On se positionne sur le premier onglet : Uo_Plafonds             */
						/*------------------------------------------------------------------*/
  						Uo_Onglets.Uf_ChangerOnglet ( "01" )		
						Uo_Plafonds.Dw_Source.SetRedraw ( False )
						Uo_Plafonds.Dw_Source.SetFocus	( )
						Uo_Plafonds.Dw_Source.SetColumn ( sCol )
						Uo_Plafonds.Dw_Source.SetRedraw ( True )
						bRet = False

					Else

						If Uo_Franchises.Dw_Source.AcceptText ( ) > 0 Then

							/*------------------------------------------------------------------*/
							/* Controle de remplissage des zones obligatoires de la datawindow  */
							/* Dw_Source de l'objet Uo_Franchises    									  */
							/*------------------------------------------------------------------*/
							sCol = iUoZnFranchises.Uf_Zn_ControlerSaisie ( Uo_Franchises.Dw_Source )

							If ( sCol <> "" ) Then

								/*------------------------------------------------------------------*/
								/* On se positionne sur le premier onglet : Uo_Franchises           */
								/*------------------------------------------------------------------*/
		  						Uo_Onglets.Uf_ChangerOnglet ( "02" )		
								Uo_Franchises.Dw_Source.SetRedraw ( False )
								Uo_Franchises.Dw_Source.SetFocus	( )
								Uo_Franchises.Dw_Source.SetColumn ( sCol )
								Uo_Franchises.Dw_Source.SetRedraw ( True )
								bRet = False

							Else

								If Uo_Delais.Dw_Source.AcceptText ( ) > 0 Then

									/*------------------------------------------------------------------*/
									/* Controle de remplissage des zones obligatoires de la datawindow  */
									/* Dw_Source de l'objet Uo_Delais      									  */
									/*------------------------------------------------------------------*/
  									sCol = iUoZnDelais.Uf_Zn_ControlerSaisie ( Uo_Delais.Dw_Source )

									If ( sCol <> "" ) Then

										/*------------------------------------------------------------------*/
										/* On se positionne sur le Troisi$$HEX1$$e800$$ENDHEX$$me onglet : Uo_Delais             */
										/*------------------------------------------------------------------*/
				  						Uo_Onglets.Uf_ChangerOnglet ( "03" )		
										Uo_Delais.Dw_Source.SetRedraw ( False )
										Uo_Delais.Dw_Source.SetFocus	( )
										Uo_Delais.Dw_Source.SetColumn ( sCol )
										Uo_Delais.Dw_Source.SetRedraw ( True )
										bRet = False

									End If

								Else

									Uo_Onglets.Uf_ChangerOnglet ( "03" )
									bRet = False

								End If				

							End If

						Else

							Uo_Onglets.Uf_ChangerOnglet ( "02" )
							bRet = False

						End If				

					End If

				Else

					Uo_Onglets.Uf_ChangerOnglet ( "01" )
					bRet = False

				End If				
		
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
//* Fonction		:	wf_initongletrefus
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:01:06
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
/* Filtre les informations dans la datawindow Source.               */
/*--------------------------------------------------------- --------*/
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


Uo_Refus.Dw_Cible.SetSort ( "ID_CODE A" )
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
//* Fonction		:	wf_initongletpieces
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:00:30
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

Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.

String 				sFiltre		// Filtre pour la datawindows

Uo_Pieces.SetRedraw ( False )

Uo_Pieces.Dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
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


Uo_Pieces.Dw_Cible.SetSort ( "ID_CODE A" )
Uo_Pieces.Dw_Cible.Sort ()

If Uo_Pieces.Dw_Cible.RowCount () > 0 then

	Uo_Pieces.Dw_Cible.SelectRow ( 0 , False )	
	Uo_Pieces.Dw_Cible.SetFocus  ()
	Uo_Pieces.Dw_Cible.SelectRow ( 1 , True )

End If

Uo_Pieces.SetRedraw ( True )
end subroutine

public subroutine wf_initongletplafonds ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletPlafonds
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 09:59:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise les informations dans l'objet Contenu/contenant
//*					   des plafonds.
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.
Long					lNbLigRech	// Nombre de ligne dans Dw_Recherche.
String 				sFiltre		// Filtre pour la datawindows


Uo_Plafonds.SetRedraw 		( False )

Uo_Plafonds.Dw_Cible.Reset	( )




/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_PLAF = '" + isIdTypCode + "' AND ID_REF_PLAF = " + String ( idcIdCode ) 
Uo_Plafonds.Dw_Source.SetFilter	( sFiltre )
Uo_Plafonds.Dw_Source.Filter 		( )
Uo_Plafonds.Dw_Source.SetSort 	( "ID_TYP_PLAF A" )
Uo_Plafonds.Dw_Source.Sort 		( )

lNbLigSrc = Uo_Plafonds.Dw_Source.RowCount ()

sFiltre = ""

If lNbLigSrc > 0 Then

	
	sFiltre = "ID_CODE <> '" + Uo_Plafonds.Dw_Source.GetItemString ( 1 ,"ID_TYP_PLAF") 

	For	lCpt = 2 To lNbLigSrc

		sFiltre = sFiltre + "' AND ID_CODE <> '" + &
									 Uo_Plafonds.Dw_Source.GetItemString ( lCpt , "ID_TYP_PLAF" )


	Next

	sFiltre = sFiltre + "'"	

End If

Uo_Plafonds.Dw_Recherche.SetFilter	( sFiltre )
Uo_Plafonds.Dw_Recherche.Filter		( )

lNbLigRech = Uo_Plafonds.Dw_Recherche.RowCount ()

For lCpt = 1 To lNbLigRech

		/*----------------------------------------------------------------------------*/
		/* Renseigne le niveau du plafond et la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour les enregistrements $$HEX3$$e00020002000$$ENDHEX$$*/
		/* proposer $$HEX2$$e0002000$$ENDHEX$$partir du type de code et du code pass$$HEX2$$e9002000$$ENDHEX$$par la fen$$HEX1$$ea00$$ENDHEX$$tre appelante*/
		/*----------------------------------------------------------------------------*/
		Uo_Plafonds.Dw_Recherche.SetItem ( lCpt, "ID_NIV_PLAF", isIdTypCode )
		Uo_Plafonds.Dw_Recherche.SetItem ( lCpt, "ID_REF_PLAF", iDcIdCode )

Next

Uo_Plafonds.Dw_Recherche.RowsCopy	( 1 ,	Uo_Plafonds.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Plafonds.Dw_Cible , 1 , PRIMARY!  )

Uo_Plafonds.Dw_Recherche.SetFilter  ( "" )
Uo_Plafonds.Dw_Recherche.Filter     ( )


Uo_Plafonds.Dw_Cible.SetSort 			( "ID_CODE A" )
Uo_Plafonds.Dw_Cible.Sort 				( )

If Uo_Plafonds.Dw_Cible.RowCount  	( ) > 0 then

	Uo_Plafonds.Dw_Cible.SelectRow 	( 0 , False )	
	Uo_Plafonds.Dw_Cible.SetFocus  	( )
	Uo_Plafonds.Dw_Cible.SelectRow 	( 1 , True )

End If

Uo_Plafonds.SetRedraw ( True )
end subroutine

public subroutine wf_initongletfranchises ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletFranchises
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise les informations dans l'objet Contenu/contenant
//*					   des franchises.
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.
Long					lNbLigRech	// Nombre de ligne dans Dw_Recherche.
String 				sFiltre		// Filtre pour la datawindows


Uo_Franchises.SetRedraw 		( False )

Uo_Franchises.Dw_Cible.Reset	( )


/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_FRA = '" + isIdTypCode + "' AND ID_REF_FRA = " + String ( idcIdCode )
       
Uo_Franchises.Dw_Source.SetFilter	( sFiltre )
Uo_Franchises.Dw_Source.Filter 		( )
Uo_Franchises.Dw_Source.SetSort 		( "DUR_MAX A, ID_CPT_FRA A, ID_TYP_FRA A, ID_PARA A" )
Uo_Franchises.Dw_Source.Sort 			( )

lNbLigSrc = Uo_Franchises.Dw_Source.RowCount ()

sFiltre = ""

/*----------------------------------------------------------------------------*/
/* Si il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$au moins une franchise et qu'elle n'est pas d'un type    */
/* pour lequel on a une notion de d$$HEX1$$e900$$ENDHEX$$lai, on supprime alors la franchise d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e00020002000$$ENDHEX$$*/
/* param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e de la liste des franchises param$$HEX1$$e900$$ENDHEX$$trables.                       */
/*----------------------------------------------------------------------------*/
If ( lNbLigSrc > 0 ) Then

	If ( Uo_Franchises.Dw_Source.GetItemNumber ( 1, "ID_TYP_FRA" ) <> 1 ) Then
	
		sFiltre = "ID_CODE<> " + String ( Uo_Franchises.Dw_Source.GetItemNumber ( 1 ,"ID_TYP_FRA") )

	End If

End If

/*----------------------------------------------------------------------------*/
/* Limite le choix des franchise $$HEX2$$e0002000$$ENDHEX$$celui qui $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$choisi au niveau de la     */
/* garantie si choix il y a eu.                                               */
/*----------------------------------------------------------------------------*/
If ( iDcIdTypFra	<> 0 ) Then 

	If sFiltre = "" Then 

		sFiltre = "ID_CODE = " + String ( iDcIdTypFra )

	Else

		sFiltre = sFiltre + " AND ID_CODE = " + String ( iDcIdTypFra )

	End If

End If


Uo_Franchises.Dw_Recherche.SetFilter	( sFiltre )
Uo_Franchises.Dw_Recherche.Filter		( )

lNbLigRech = Uo_Franchises.Dw_Recherche.RowCount ()

For lCpt = 1 To lNbLigRech

		/*----------------------------------------------------------------------------*/
		/* Renseigne le niveau du plafond et la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour les enregistrements $$HEX3$$e00020002000$$ENDHEX$$*/
		/* proposer $$HEX2$$e0002000$$ENDHEX$$partir du type de code et du code pass$$HEX2$$e9002000$$ENDHEX$$par la fen$$HEX1$$ea00$$ENDHEX$$tre appelante*/
		/*----------------------------------------------------------------------------*/
		Uo_Franchises.Dw_Recherche.SetItem ( lCpt, "ID_NIV_FRA", isIdTypCode )
		Uo_Franchises.Dw_Recherche.SetItem ( lCpt, "ID_REF_FRA", iDcIdCode )

Next

Uo_Franchises.Dw_Recherche.RowsCopy	( 1 ,	Uo_Franchises.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Franchises.Dw_Cible , 1 , PRIMARY!  )

Uo_Franchises.Dw_Recherche.SetFilter  ( "" )
Uo_Franchises.Dw_Recherche.Filter     ( )


Uo_Franchises.Dw_Cible.SetSort 			( "ID_CODE A" )
Uo_Franchises.Dw_Cible.Sort 				( )

If Uo_Franchises.Dw_Cible.RowCount  	( ) > 0 then

	Uo_Franchises.Dw_Cible.SelectRow 	( 0 , False )	
	Uo_Franchises.Dw_Cible.SetFocus  	( )
	Uo_Franchises.Dw_Cible.SelectRow 	( 1 , True )

End If

Uo_Franchises.SetRedraw ( True )
end subroutine

public subroutine wf_initongletdelais ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletDelais
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 10:59:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise les informations dans l'objet Contenu/contenant
//*					   des d$$HEX1$$e900$$ENDHEX$$lais.
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
Long					lCpt			// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.
Long					lNbLigRech	// Nombre de ligne dans Dw_Recherche.
String 				sFiltre		// Filtre pour la datawindows


Uo_Delais.SetRedraw 		( False )

Uo_Delais.Dw_Cible.Reset	( )




/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_DEL = '" + isIdTypCode + "' AND ID_REF_DEL = " + String ( idcIdCode ) 
Uo_Delais.Dw_Source.SetFilter	( sFiltre )
Uo_Delais.Dw_Source.Filter 	( )
Uo_Delais.Dw_Source.SetSort 	( "ID_TYP_DEL A" )
Uo_Delais.Dw_Source.Sort 		( )

lNbLigSrc = Uo_Delais.Dw_Source.RowCount ()

sFiltre = ""

If lNbLigSrc > 0 Then

	
	sFiltre = "ID_CODE <> '" + Uo_Delais.Dw_Source.GetItemString ( 1 ,"ID_TYP_DEL") 

	For	lCpt = 2 To lNbLigSrc

		sFiltre = sFiltre + "' AND ID_CODE <> '" + &
									 Uo_Delais.Dw_Source.GetItemString ( lCpt , "ID_TYP_DEL" )


	Next

	sFiltre = sFiltre + "'"	

End If

Uo_Delais.Dw_Recherche.SetFilter	( sFiltre )
Uo_Delais.Dw_Recherche.Filter		( )

lNbLigRech = Uo_Delais.Dw_Recherche.RowCount ()

For lCpt = 1 To lNbLigRech

	/*----------------------------------------------------------------------------*/
	/* Renseigne le niveau du d$$HEX1$$e900$$ENDHEX$$lai et la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour les enregistrements $$HEX5$$e0002000200020002000$$ENDHEX$$*/
	/* proposer $$HEX2$$e0002000$$ENDHEX$$partir du type de code et du code pass$$HEX2$$e9002000$$ENDHEX$$par la fen$$HEX1$$ea00$$ENDHEX$$tre appelante*/
	/*----------------------------------------------------------------------------*/
	Uo_Delais.Dw_Recherche.SetItem ( lCpt, "ID_NIV_DEL", isIdTypCode )
	Uo_Delais.Dw_Recherche.SetItem ( lCpt, "ID_REF_DEL", iDcIdCode   )

Next

Uo_Delais.Dw_Recherche.RowsCopy 	 ( 1 ,	Uo_Delais.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                     		Uo_Delais.Dw_Cible , 1 , PRIMARY!  )

Uo_Delais.Dw_Recherche.SetFilter  ( "" )
Uo_Delais.Dw_Recherche.Filter     ( )


Uo_Delais.Dw_Cible.SetSort 		 ( "ID_CODE A" )
Uo_Delais.Dw_Cible.Sort 			 ( )

If Uo_Delais.Dw_Cible.RowCount  	 ( ) > 0 then

	Uo_Delais.Dw_Cible.SelectRow 	 ( 0 , False )	
	Uo_Delais.Dw_Cible.SetFocus  	 ( )
	Uo_Delais.Dw_Cible.SelectRow 	 ( 1 , True )

End If

Uo_Delais.SetRedraw ( True )
end subroutine

on ue_initialiser;call w_ancetre::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_condition_gti
//* Evenement 		: Ue_Initialiser
//* Auteur			: V.Capelle
//* Date				: 18/11/1997 17:12:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


DataWindowChild	dwParaPce   // DDDW des Paragraphes des pieces.
DataWindowChild	dwParaRef   // DDDW des Paragraphes des motifs de refus.
DataWindowChild	dwParaPlaf  // DDDW des Paragraphes des plafonds.
DataWindowChild	dwParaFran  // DDDW des Paragraphes des Franchises.

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow			dwPassageEuro[2]
DataWindow			dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

iwAppel = w_tm_sp_garantie

iUoZnPieces			= CREATE U_Sp_Zn_Pieces
iUoZnRefus			= CREATE U_Sp_Zn_Refus
iUoZnPlafonds		= CREATE U_Sp_Zn_Plafonds
iUoZnFranchises	= CREATE U_Sp_Zn_Franchises
iUoZnDelais			= CREATE U_Sp_Zn_Delais

/*------------------------------------------------------------------*/
/* Positionne le bon objet et le bon onglet                         */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 5, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Plafonds"       , "", Uo_Plafonds   , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Franchises"     , "", Uo_Franchises , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "D$$HEX1$$e900$$ENDHEX$$lais"         , "", Uo_Delais 	  , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "Pi$$HEX1$$e800$$ENDHEX$$ces"         , "", Uo_Pieces     , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Motifs Refus"   , "", Uo_Refus      , False )


/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source,   */
/* cible.                                                           */
/*------------------------------------------------------------------*/
Uo_Pieces.Uf_Initialiser 	 ( "d_sp_lst_piece_rch"    , "d_sp_gti_piece"    , "d_sp_lst_piece_gti"    , itrTrans )
Uo_Refus.Uf_Initialiser  	 ( "d_sp_lst_refus_rch"    , "d_sp_gti_refus"    , "d_sp_lst_refus_gti"    , itrTrans )
Uo_Plafonds.Uf_Initialiser	 ( "d_sp_lst_plafond_rch"  , "d_sp_gti_plafond"  , "d_sp_lst_plafond_gti"  , itrTrans )
Uo_Franchises.Uf_Initialiser( "d_sp_lst_franchise_rch", "d_sp_gti_franchise", "d_sp_lst_franchise_gti", itrTrans )
Uo_Delais.Uf_Initialiser	 ( "d_sp_lst_delai_rch"    , "d_sp_gti_delai"    , "d_sp_lst_delai_gti"    , itrTrans )

/*------------------------------------------------------------------*/
/* Gestion du Passage $$HEX2$$e0002000$$ENDHEX$$l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = uo_Franchises.dw_Source
dwPassageEuro [ 2 ] = uo_Plafonds.dw_Source

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro

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


Uo_Plafonds.dw_Source.GetChild ( "ID_PARA", dwParaPlaf )

dwParaPlaf.SetTransObject ( itrTrans )

If ( 	dwParaPlaf.Retrieve ( ) <= 0 )	Then

		dwParaPlaf.InsertRow ( 0 )

End If

Uo_Franchises.dw_Source.GetChild ( "ID_PARA", dwParaFran )

dwParaFran.SetTransObject ( itrTrans )

If ( 	dwParaFran.Retrieve ( ) <= 0 )	Then

		dwParaFran.InsertRow ( 0 )

End If

end on

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_condition_gti
//* Evenement 		: Ue_Retour
//* Auteur			: V.Capelle
//* Date				: 20/11/1997 14:55:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fen$$HEX1$$ea00$$ENDHEX$$tre utilis$$HEX1$$e900$$ENDHEX$$e pour d$$HEX1$$e900$$ENDHEX$$finir une garantie.
//*				  
//*-----------------------------------------------------------------

Long 			lNbPlafond		// Nombre de plafonds param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
Long 			lNbDelai			// Nombre de d$$HEX1$$e900$$ENDHEX$$lais param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
Long 			lNbFranchise	// Nombre de franchise param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Long 			lCodTypFra		// Type de franchise
String		sAltPlaf			// Plafond ou Non ( O/N )
String		sAltDel			// D$$HEX1$$e900$$ENDHEX$$lai ou Non ( O/N )
String		sAltFra			// Franchise ou Non ( O/N )

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du AltPlaf sur l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$.                            */
/*----------------------------------------------------------------------------*/

lNbPlafond = Uo_Plafonds.Dw_Source.RowCount ()

If ( lNbPlafond > 0 ) Then 

	sAltPlaf    = "O"

Else

	sAltPlaf    = "N"

End If

lNbDelai = Uo_Delais.Dw_Source.RowCount ()

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du Alt Del sur l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$.                            */
/*----------------------------------------------------------------------------*/
If ( lNbDelai > 0 ) Then 

	sAltDel    = "O"

Else

	sAltDel    = "N"

End If

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du code type de franchise sur l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$.             */
/*----------------------------------------------------------------------------*/
lNbFranchise = Uo_Franchises.Dw_Source.RowCount ()

If ( lNbFranchise > 0 ) Then 

	isIdNivFra = Uo_Franchises.Dw_Source.GetItemString ( 1, "ID_NIV_FRA" )
	lCodTypFra = Uo_Franchises.Dw_Source.GetItemNumber ( 1, "ID_TYP_FRA" )
	sAltFra    = "O"

	/*------------------------------------------------------------------*/
	/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des Franchises*/
	/*------------------------------------------------------------------*/
	Uo_Franchises.Dw_Source.SetFilter ( "" )
	Uo_Franchises.Dw_Source.Filter ( )
	Uo_Franchises.Dw_Recherche.SetFilter ( "" )
	Uo_Franchises.Dw_Recherche.Filter ( )

Else

	/*------------------------------------------------------------------*/
	/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des Franchises*/
	/*------------------------------------------------------------------*/
	Uo_Franchises.Dw_Source.SetFilter ( "" )
	Uo_Franchises.Dw_Source.Filter ( )
	Uo_Franchises.Dw_Recherche.SetFilter ( "" )
	Uo_Franchises.Dw_Recherche.Filter ( )

	lNbFranchise = Uo_Franchises.Dw_Source.RowCount ()
	If ( lNbFranchise > 0 ) Then lCodTypFra = Uo_Franchises.Dw_Source.GetItemNumber ( 1, "ID_TYP_FRA" )			

	If isIdNivFra = isIdTypCode Then 

		If ( lCodTypFra = 0 ) Then isIdNivFra = ""

	End If

	sAltFra    = "N"

End If

Choose Case isIdTypCode

	Case "-GA"

		iWAppel.Dw_1.SetItem ( 1, "ALT_PLAF", sAltPlaf )	
		iWAppel.Dw_1.SetItem ( 1, "ALT_DEL", sAltDel )	
		iWAppel.Dw_1.SetItem ( 1, "ALT_FRAN", sAltFra )	
		iWAppel.Dw_1.SetItem ( 1, "COD_TYP_FRA", lCodTypFra )
			
	Case Else

		iWAppel.Uo_condition.Dw_Source.SetItem ( ilLigMaster, "ALT_PLAF", sAltPlaf )
		iWAppel.Uo_condition.Dw_Source.SetItem ( ilLigMaster, "ALT_DEL", sAltDel )
		iWAppel.Uo_condition.Dw_Source.SetItem ( ilLigMaster, "ALT_FRAN", sAltFra )
		iWAppel.Dw_1.SetItem ( 1, "COD_TYP_FRA", lCodTypFra )

End Choose



/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des plafonds. */
/*------------------------------------------------------------------*/
Uo_Plafonds.Dw_Source.SetFilter ( "" )
Uo_Plafonds.Dw_Source.Filter ( )

Uo_Plafonds.Dw_Recherche.SetFilter ( "" )
Uo_Plafonds.Dw_Recherche.Filter ( )


/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des D$$HEX1$$e900$$ENDHEX$$lais    */
/*------------------------------------------------------------------*/
Uo_Delais.Dw_Source.SetFilter ( "" )
Uo_Delais.Dw_Source.Filter ( )

Uo_Delais.Dw_Recherche.SetFilter ( "" )
Uo_Delais.Dw_Recherche.Filter ( )


/*----------------------------------------------------------------------------*/
/* Interrompt le partage des donn$$HEX1$$e900$$ENDHEX$$es avec la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.               */
/*----------------------------------------------------------------------------*/
Uo_Pieces.dw_Source.ShareDataOff 	()
Uo_Refus.dw_Source.ShareDataOff 		()
Uo_Plafonds.dw_Source.ShareDataOff 	()
Uo_Franchises.dw_Source.ShareDataOff()
Uo_Delais.dw_Source.ShareDataOff    ()
Uo_Onglets.uf_ChangerOnglet ( "01" )

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

on hide;call w_ancetre::hide;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	HIDE
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:03:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
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

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_condition_gti
//* Evenement 		: We_ChildActivate
//* Auteur			: V.Capelle
//* Date				: 20/11/1997 17:17:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If ibDejaOuvert Then

	istPass        = Message.PowerObjectParm

	ibDejaOuvert   = False

	itrTrans			= istPass.trTrans			// Objet transaction de la fenetre appelante
	iwParent			= istPass.wParent			// Fenetre Appelante	
	iDcIdProd 		= istPass.lTab [ 1 ] 
	iDcIdGti			= istPass.lTab [ 2 ] 
	iDcIdRev			= istPass.lTab [ 3 ] 
	iDcIdCode		= istPass.lTab [ 4 ] 
	ilLigMaster		= istPass.lTab [ 5 ] 
	idcIdTypFra		= istPass.lTab [ 6 ]

	isIdTypCode		= istPass.sTab [ 1 ]


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

on close;call w_ancetre::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	Close
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:02:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Destruction des user objects utilis$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
DESTROY iUoZnPieces
DESTROY iUoZnRefus
DESTROY iUoZnPlafonds
DESTROY iUoZnFranchises
DESTROY iUoZnDelais

If ( Not istPass.bEnableParent ) Then

	iwAppel.Enabled = True

End If

end on

on show;call w_ancetre::show;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_condition_gti
//* Evenement 		:	Show
//* Auteur			:	V.Capelle
//* Date				:	18/11/1997 17:16:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


This.Enabled = True
end on

on ue_controler;call w_ancetre::ue_controler;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	UE_CONTROLER
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:11:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle si la saisie des pi$$HEX1$$e800$$ENDHEX$$ces et des motifs de refus
//*                  est correcte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If Wf_ControlerSaisie ( ) Then	This.PostEvent ( "Ue_Retour" )
end on

on open;call w_ancetre::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	Open
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:04:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre et instanciation du bool$$HEX1$$e900$$ENDHEX$$en 
//*						ibDejaOuvert
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

ibDejaOuvert = True



end on

on w_t_sp_condition_gti.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.pb_1=create pb_1
this.uo_franchises=create uo_franchises
this.uo_plafonds=create uo_plafonds
this.uo_refus=create uo_refus
this.uo_pieces=create uo_pieces
this.uo_bord3d=create uo_bord3d
this.uo_delais=create uo_delais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.uo_franchises
this.Control[iCurrent+4]=this.uo_plafonds
this.Control[iCurrent+5]=this.uo_refus
this.Control[iCurrent+6]=this.uo_pieces
this.Control[iCurrent+7]=this.uo_bord3d
this.Control[iCurrent+8]=this.uo_delais
end on

on w_t_sp_condition_gti.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.pb_1)
destroy(this.uo_franchises)
destroy(this.uo_plafonds)
destroy(this.uo_refus)
destroy(this.uo_pieces)
destroy(this.uo_bord3d)
destroy(this.uo_delais)
end on

on activate;call w_ancetre::activate;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_condition_gti
//* Evenement 		:	Activate
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 10:01:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Declanche we_childactivate
//* Commentaires	: Declanch$$HEX2$$e9002000$$ENDHEX$$si la fen$$HEX1$$ea00$$ENDHEX$$tre est de type Popup!
//*				  
//*-----------------------------------------------------------------

TriggerEvent ( "we_childactivate" )
end on

type uo_onglets from u_onglets within w_t_sp_condition_gti
integer x = 18
integer y = 184
integer width = 2939
integer height = 108
integer taborder = 0
boolean border = false
end type

type pb_1 from u_8_pbvalider within w_t_sp_condition_gti
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

type uo_franchises from u_ajout within w_t_sp_condition_gti
integer x = 27
integer y = 280
integer width = 3543
integer height = 1120
integer taborder = 50
boolean border = false
end type

on ue_dwcible_supprime;call u_ajout::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	UE_DWCIBLE_SUPPRIME
//* Auteur			:	V.Capelle
//* Date				:	08/12/1997 17:54:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Si on est dans le cas d'une franchise li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$un d$$HEX1$$e900$$ENDHEX$$lai
//*						on duplique la ligne avant qu'elle soit pass$$HEX1$$e900$$ENDHEX$$e dans la 
//*						Dw_Source de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$la garder en disponibilit$$HEX2$$e9002000$$ENDHEX$$et on 
//*						la d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionne.
//*						
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If ( dw_Cible.GetItemNumber ( ilLigSourceSupp, "ID_CODE" ) = 2 ) Then

	dw_Cible.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Cible, &
							  Dw_Cible.RowCount ( ) + 1, Primary! 	)
	dw_Cible.SelectRow ( ilLigSourceSupp, False )	

	dw_Cible.Sort ()

End If


end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	ue_dwSourceSupprime
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:03:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie de l'enregistrement dans le buffer de 
//*                  suppression s'il $$HEX1$$e900$$ENDHEX$$tait pr$$HEX1$$e900$$ENDHEX$$sent lors du retrieve 
//*                  de la datawindow 
//* Commentaires	:	
//*
//* Modif
//* Projet			Qui	Date
//* [MIGPB8COR]	PHG	30/05/2006: Correction de la suppression
//*-----------------------------------------------------------------
dwItemStatus	dwItemStat			//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/
If This.ilLigSourceSupp > 0 Then

	Dw_Source.SetItem ( ilLigSourceSupp, "MT_FRA", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "ID_PARA", stNul.str 	)
	Dw_Source.SetItem ( ilLigSourceSupp, "DUR_MIN", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "DUR_MAX", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "UNT_DEL", "J" 			)

	dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then 
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


	/*----------------------------------------------------------------------------*/
	/* Si on traite une franchise li$$HEX1$$e900$$ENDHEX$$e au d$$HEX1$$e900$$ENDHEX$$lai on ne la passe pas dans Dw_Cible  */
	/* ( ibSupprime = False ), on l'efface simplement du buffer primaire de la    */
	/* datawindow.                                                                */
	/*----------------------------------------------------------------------------*/

	If ( dw_Source.GetItemNumber ( ilLigSourceSupp, "ID_TYP_FRA" ) = 2 ) Then 
		
		ibSupprime = False
		dw_Source.RowsDiscard ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary! )

	End If
			

End If

end on

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	Dw_Source_ItemError
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:04:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur 
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------



Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "MT_FRA"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des franchises"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "montant de la franchise"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

	Case "DUR_MIN"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des franchises"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "borne inf$$HEX1$$e900$$ENDHEX$$rieure du d$$HEX1$$e900$$ENDHEX$$lai"
		stMessage.sCode	= "GENE002"

		f_Message ( stMessage )

	Case "DUR_MAX"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des franchises"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "borne sup$$HEX1$$e900$$ENDHEX$$rieure du d$$HEX1$$e900$$ENDHEX$$lai"
		stMessage.sCode	= "GENE002"

		f_Message ( stMessage )

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwsource_rbuttondown;call u_ajout::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	ue_dwsource_rbuttondown
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:07:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courrant de la ligne courrante
//*						si ligne courrante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
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
//* Objet			:	uo_franchises
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:02:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	R$$HEX2$$e900e900$$ENDHEX$$criture de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement car au niveau de 
//*                  l'anc$$HEX1$$ea00$$ENDHEX$$tre on effectue un retrieve avec un 
//*                  argument, alors que dans ce cas, aucun 
//*                  argument n'est n$$HEX1$$e900$$ENDHEX$$cessaire.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
ilLigRecherche = dw_Recherche.Retrieve (  )
end on

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	CONSTRUCTOR
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:01:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	:	
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
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_franchises
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	26/11/1997 11:01:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible les boutons permettant de supprimer ou 
//*					   d'ajouter tout.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
uo_Franchises.Pb_enlever_tout.Visible = False
uo_Franchises.Pb_ajouter_tout.Visible = False
end on

on uo_franchises.destroy
call u_ajout::destroy
end on

type uo_plafonds from u_ajout within w_t_sp_condition_gti
integer x = 27
integer y = 280
integer width = 3543
integer height = 1120
integer taborder = 40
boolean border = false
end type

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_plafonds
//* Evenement 		:	Dw_Source_ItemError
//* Auteur			:	V.Capelle
//* Date				:	25/11/1997 10:57:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Message d'erreur pour le montant du plafond
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "MT_PLAF"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des plafonds"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "montant du plafond"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_plafonds
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 09:45:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	R$$HEX2$$e900e900$$ENDHEX$$criture de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement car au niveau de 
//*                  l'anc$$HEX1$$ea00$$ENDHEX$$tre on effectue un retrieve avec un 
//*                  argument, alors que dans ce cas, aucun 
//*                  argument n'est n$$HEX1$$e900$$ENDHEX$$cessaire.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
ilLigRecherche = dw_Recherche.Retrieve (  )
end on

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_plafonds
//* Evenement 		:	CONSTRUCTOR
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 09:43:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	:	
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
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwsource_rbuttondown;call u_ajout::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
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

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_plafonds
//* Evenement 		:	ue_dwSourceSupprime
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 09:49:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie de l'enregistrement dans le buffer de 
//*                  suppression s'il $$HEX1$$e900$$ENDHEX$$tait pr$$HEX1$$e900$$ENDHEX$$sent lors du retrieve 
//*                  de la datawindow 
//* Commentaires	:	
//*				  
//* Modif
//* Projet			Qui	Date
//* [MIGPB8COR]	PHG	30/05/2006 : Correction de la suppression
//*-----------------------------------------------------------------
dwItemStatus	dwItemStat			//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/


If This.ilLigSourceSupp > 0 Then

	Dw_Source.SetItem ( ilLigSourceSupp, "MT_PLAF", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "ID_PARA", stNul.str 	)

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

end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_plafonds
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 09:44:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible les boutons permettant de supprimer ou 
//*					   d'ajouter tout.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
uo_Plafonds.Pb_enlever_tout.Visible = False
uo_Plafonds.Pb_ajouter_tout.Visible = False
end on

on uo_plafonds.destroy
call u_ajout::destroy
end on

type uo_refus from u_spb_ajout_courtyp within w_t_sp_condition_gti
integer x = 27
integer y = 280
integer width = 3543
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des refus
//*                 affect$$HEX1$$e900$$ENDHEX$$s, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	DBI		13/02/98	  Gestion du compteur de tri lors de la suppression d'une ligne
//* [MIGPB8COR]	JCA	14/06/2006 : Correction de la suppression
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

	Dw_Source.SetItem ( ilLigSourceSupp, "ID_PARA"      , stNul.str 	)
	Dw_Source.SetItem ( ilLigSourceSupp, "COD_TYP_MOTIF", "G"      	)
	Dw_Source.SetItem ( ilLigSourceSupp, "COD_NAT_MOTIF", "R"      	)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then &
		// [MIGPB8COR]
	//	dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
	//								Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
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

type uo_pieces from u_spb_ajout_courtyp within w_t_sp_condition_gti
event type long ue_dwsource_buttonclicked ( long row,  long actionreturncode,  dwobject dwo )
integer x = 27
integer y = 280
integer width = 3543
integer height = 1120
integer taborder = 20
boolean border = false
end type

event ue_dwsource_buttonclicked;// JCA 
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

on constructor;call u_spb_ajout_courtyp::constructor;//*-----------------------------------------------------------------
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
//* [MIGPB8COR]	JCA	14/06/2006 : Correction de la suppression
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

	Dw_Source.SetItem ( ilLigSourceSupp, "ID_PARA"      , stNul.str 	)
	Dw_Source.SetItem ( ilLigSourceSupp, "COD_TYP_PCE", "G"         	)

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

	End if

	lNbLigSource	=	Dw_Source.RowCount ( )
	For lCpt = This.ilLigSourceSupp + 1 to lNbLigSource

		Dw_Source.SetItem ( lCpt, "CPT_TRI", dcCptTri )
		dcCptTri ++
	Next
End If

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

type uo_bord3d from u_bord3d within w_t_sp_condition_gti
integer x = 27
integer y = 280
integer width = 3543
integer height = 1120
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type uo_delais from u_ajout within w_t_sp_condition_gti
integer x = 27
integer y = 280
integer width = 3543
integer height = 1120
integer taborder = 60
boolean border = false
end type

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_delais
//* Evenement 		:	CONSTRUCTOR
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 11:14:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	:	
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
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Delais
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 11:15:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible les boutons permettant de supprimer ou 
//*					   d'ajouter tout.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
uo_Delais.Pb_enlever_tout.Visible = False
uo_Delais.Pb_ajouter_tout.Visible = False
end on

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Delais
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 11:15:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	R$$HEX2$$e900e900$$ENDHEX$$criture de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement car au niveau de 
//*                  l'anc$$HEX1$$ea00$$ENDHEX$$tre on effectue un retrieve avec un 
//*                  argument, alors que dans ce cas, aucun 
//*                  argument n'est n$$HEX1$$e900$$ENDHEX$$cessaire.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
ilLigRecherche = dw_Recherche.Retrieve (  )
end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Delais
//* Evenement 		:	ue_dwSourceSupprime
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 11:16:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie de l'enregistrement dans le buffer de 
//*                  suppression s'il $$HEX1$$e900$$ENDHEX$$tait pr$$HEX1$$e900$$ENDHEX$$sent lors du retrieve 
//*                  de la datawindow 
//* Commentaires	:	
//*				  
//* Modif
//* Projet			Qui	Date
//* [MIGPB8COR]	PHG	30/05/2006 : Correction de la suppression
//*-----------------------------------------------------------------
dwItemStatus	dwItemStat			//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer


/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/
If This.ilLigSourceSupp > 0 Then

	Dw_Source.SetItem ( ilLigSourceSupp, "DUR_MIN", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "DUR_MAX", 0 				)
	Dw_Source.SetItem ( ilLigSourceSupp, "UNT_DEL", "J" 			)

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

end on

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Delais
//* Evenement 		:	Dw_Source_ItemError
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 11:17:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur 
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------



Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "DUR_MIN"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$lais"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "borne inf$$HEX1$$e900$$ENDHEX$$rieure du d$$HEX1$$e900$$ENDHEX$$lai"
		stMessage.sCode	= "GENE002"

		f_Message ( stMessage )

	Case "DUR_MAX"

		stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$lais"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "borne sup$$HEX1$$e900$$ENDHEX$$rieure du d$$HEX1$$e900$$ENDHEX$$lai"
		stMessage.sCode	= "GENE002"

		f_Message ( stMessage )

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on uo_delais.destroy
call u_ajout::destroy
end on

