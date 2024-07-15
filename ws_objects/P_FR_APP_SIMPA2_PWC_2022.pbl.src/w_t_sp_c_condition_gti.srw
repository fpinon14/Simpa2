HA$PBExportHeader$w_t_sp_c_condition_gti.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation du param$$HEX1$$e900$$ENDHEX$$trage des condition d'une garantie.
forward
global type w_t_sp_c_condition_gti from w_8_ancetre_consultation
end type
type uo_onglets from u_onglets within w_t_sp_c_condition_gti
end type
type dw_refus from datawindow within w_t_sp_c_condition_gti
end type
type dw_piece from datawindow within w_t_sp_c_condition_gti
end type
type dw_franchise from datawindow within w_t_sp_c_condition_gti
end type
type dw_delai from datawindow within w_t_sp_c_condition_gti
end type
type dw_plafond from datawindow within w_t_sp_c_condition_gti
end type
type uo_bord3d from u_bord3d within w_t_sp_c_condition_gti
end type
end forward

global type w_t_sp_c_condition_gti from w_8_ancetre_consultation
integer x = 471
integer y = 300
integer width = 2711
integer height = 1424
string title = "Consultation"
boolean controlmenu = false
boolean minbox = false
event ue_quitteronglet011 pbm_custom01
event ue_quitteronglet021 pbm_custom02
event ue_quitteronglet041 pbm_custom03
event ue_quitteronglet051 pbm_custom04
event ue_quitteronglet061 pbm_custom05
uo_onglets uo_onglets
dw_refus dw_refus
dw_piece dw_piece
dw_franchise dw_franchise
dw_delai dw_delai
dw_plafond dw_plafond
uo_bord3d uo_bord3d
end type
global w_t_sp_c_condition_gti w_t_sp_c_condition_gti

type variables
Public:

  Decimal{0}		iDcIdGti
  Decimal{0}		iDcIdProd
//Migration PB8-WYNIWYG-03/2006 FM
//  Decimal{0}		iDcIdRev		= stNul.dcm
  Decimal{0}		iDcIdRev
//Fin Migration PB8-WYNIWYG-03/2006 FM
  Decimal{0}		iDcIdCode
  Decimal{0}		iDcIdTypFra	= 0

  String			isIdTypCode
  String			isIdNivFra	= ""


  w_t_sp_c_garantie	iWappel

end variables

forward prototypes
public subroutine wf_initongletdelais ()
public subroutine wf_initongletfranchises ()
public subroutine wf_initongletpieces ()
public subroutine wf_initongletplafonds ()
public subroutine wf_initongletrefus ()
end prototypes

event ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Ue_QuitterOnglet011
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:02:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cache la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle
//*						est ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

event ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Ue_QuitterOnglet021
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:02:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cache la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle
//*						est ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

event ue_quitteronglet041;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Ue_QuitterOnglet041
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:02:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cache la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle
//*						est ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

event ue_quitteronglet051;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Ue_QuitterOnglet051
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:02:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cache la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle
//*						est ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

event ue_quitteronglet061;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Ue_QuitterOnglet061
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:02:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cache la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle
//*						est ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

public subroutine wf_initongletdelais ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletDelais
//* Auteur			:	V.Capelle
//* Date				:	15/12/1997 09:43:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise la datawindow des d$$HEX1$$e900$$ENDHEX$$lais.
//* Commentaires	:	
//* Arguments		:  Aucun
//* Retourne		:  Rien
//*
//*-----------------------------------------------------------------
String		sFiltre		// Filtre pour la datawindows


Dw_Delai.SetRedraw	( False )
/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_DEL = '" + isIdTypCode + "' AND ID_REF_DEL = " + String ( idcIdCode ) 

Dw_Delai.SetFilter	( sFiltre )
Dw_Delai.Filter 		( )

Dw_Delai.SetSort 		( "ID_TYP_DEL A" )
Dw_Delai.Sort 			( )


Dw_Delai.SetRedraw 	( True )
end subroutine

public subroutine wf_initongletfranchises ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletFranchises
//* Auteur			:	V.Capelle
//* Date				:	15/12/1997 11:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise la datawindow des franchises.
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
String 				sFiltre		// Filtre pour la datawindows

Dw_Franchise.SetRedraw 	( False )
/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_FRA = '" + isIdTypCode + "' AND ID_REF_FRA = " + String ( idcIdCode )
       
Dw_Franchise.SetFilter	( sFiltre )
Dw_Franchise.Filter 		( )
Dw_Franchise.SetSort 	( "DUR_MAX A, ID_CPT_FRA A, ID_TYP_FRA A, ID_PARA A" )
Dw_Franchise.Sort 		( )

Dw_Franchise.SetRedraw	( True )
end subroutine

public subroutine wf_initongletpieces ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_initongletpieces
//* Auteur			:	V.Capelle
//* Date				:	15/12/1997 10:11:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	: Populise la datawindow des pi$$HEX1$$e800$$ENDHEX$$ces.
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


Dw_Piece.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
Dw_Piece.SetSort ( "ID_PCE A" )
Dw_Piece.Sort ()

Dw_Piece.SetRedraw ( True )
end subroutine

public subroutine wf_initongletplafonds ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_InitOngletPlafonds
//* Auteur			:	V.Capelle
//* Date				:	15/12/1997 10:24:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Populise la datawindow des plafonds.
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
String 				sFiltre		// Filtre pour la datawindows


Dw_Plafond.SetRedraw 		( False )

/*------------------------------------------------------------------*/
/* Trie les informations dans la datawindow Source.                 */
/*--------------------------------------------------------- --------*/
sFiltre = "ID_NIV_PLAF = '" + isIdTypCode + "' AND ID_REF_PLAF = " + String ( idcIdCode ) 
Dw_Plafond.SetFilter	( sFiltre )
Dw_Plafond.Filter 	( )
Dw_Plafond.SetSort 	( "ID_TYP_PLAF A" )
Dw_Plafond.Sort 		( )

Dw_Plafond.SetRedraw ( True )
end subroutine

public subroutine wf_initongletrefus ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_initongletrefus
//* Auteur			:	V.Capelle
//* Date				:	15/12/1997 10:24:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Populise la datawindow des motifs de refus
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Dw_Refus.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* Filtre les informations dans la datawindow Source.               */
/*--------------------------------------------------------- --------*/
Dw_Refus.SetSort ( "ID_MOTIF A" )
Dw_Refus.Sort ()

Dw_Refus.SetRedraw ( True )
end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_Condition_Gti
//* Evenement 		:  Ue_Initialiser
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 16:48:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation
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

//Migration PB8-WYNIWYG-03/2006 FM
iDcIdRev = stNul.dcm
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Gestion du Passage $$HEX2$$e0002000$$ENDHEX$$l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_Franchise
dwPassageEuro [ 2 ] = dw_Plafond

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro


iDcIdProd 		= istPass.lTab [ 1 ] 
iDcIdGti			= istPass.lTab [ 2 ] 
iDcIdRev			= istPass.lTab [ 3 ] 
iDcIdCode		= istPass.lTab [ 4 ] 
idcIdTypFra		= istPass.lTab [ 5 ]

isIdTypCode		= istPass.sTab [ 1 ]
iwAppel 			= w_t_sp_c_garantie

/*------------------------------------------------------------------*/
/* Positionne le bon objet et le bon onglet                         */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 5, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Plafonds"       , "", Dw_Plafond   , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Franchises"     , "", Dw_Franchise , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "D$$HEX1$$e900$$ENDHEX$$lais"         , "", Dw_Delai 	  , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "Pi$$HEX1$$e800$$ENDHEX$$ces"         , "", Dw_Piece     , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Motifs Refus"   , "", Dw_Refus      , False )



/*----------------------------------------------------------------------------*/
/* Comme aucun InsertRow n'est r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$sur la Dw Source la DdDw des           */
/* paragraphes n'est pas renseign$$HEX1$$e900$$ENDHEX$$e automatiquement d'ou le Retrieve.         */
/*----------------------------------------------------------------------------*/
Dw_Piece.GetChild ( "ID_PARA", dwParaPce )

dwParaPce.SetTransObject ( itrTrans )
If ( 	dwParaPce.Retrieve ( ) <= 0 )	Then

		dwParaPce.InsertRow ( 0 )

End If


Dw_Refus.GetChild ( "ID_PARA", dwParaRef )

dwParaRef.SetTransObject ( itrTrans )

If ( 	dwParaRef.Retrieve ( ) <= 0 )	Then

		dwParaRef.InsertRow ( 0 )

End If


Dw_Plafond.GetChild ( "ID_PARA", dwParaPlaf )

dwParaPlaf.SetTransObject ( itrTrans )

If ( 	dwParaPlaf.Retrieve ( ) <= 0 )	Then

		dwParaPlaf.InsertRow ( 0 )

End If

Dw_Franchise.GetChild ( "ID_PARA", dwParaFran )

dwParaFran.SetTransObject ( itrTrans )

If ( 	dwParaFran.Retrieve ( ) <= 0 )	Then

		dwParaFran.InsertRow ( 0 )

End If


end event

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_c_condition_gti
//* Evenement 		: Ue_Retour( OverRide )
//* Auteur			: V.Capelle
//* Date				: 15/12/1997 10:55:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Long 			lNbFranchise	// Nombre de franchise param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Long 			lCodTypFra		// Type de franchise

lNbFranchise = Dw_Franchise.RowCount ()

If ( lNbFranchise > 0 ) Then 

	isIdNivFra = Dw_Franchise.GetItemString ( 1, "ID_NIV_FRA" )
   lCodTypFra = Dw_Franchise.GetItemNumber ( 1, "ID_TYP_FRA" )

	/*------------------------------------------------------------------*/
	/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des Franchises*/
	/*------------------------------------------------------------------*/
	Dw_Franchise.SetFilter 	( "" )
	Dw_Franchise.Filter 		( )

Else

	/*------------------------------------------------------------------*/
	/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des Franchises*/
	/*------------------------------------------------------------------*/
	Dw_Franchise.SetFilter 	( "" )
	Dw_Franchise.Filter 		( )

	lNbFranchise = Dw_Franchise.RowCount ()
	If ( lNbFranchise > 0 ) Then lCodTypFra = Dw_Franchise.GetItemNumber ( 1, "ID_TYP_FRA" )			

	If isIdNivFra = isIdTypCode Then 

		If ( lCodTypFra = 0 ) Then isIdNivFra = ""

	End If

End If


/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des plafonds. */
/*------------------------------------------------------------------*/
Dw_Plafond.SetFilter ( "" )
Dw_Plafond.Filter 	( )

/*------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des D$$HEX1$$e900$$ENDHEX$$lais    */
/*------------------------------------------------------------------*/
Dw_Delai.SetFilter	( "" )
Dw_Delai.Filter 		( )

/*----------------------------------------------------------------------------*/
/* Interrompt le partage des donn$$HEX1$$e900$$ENDHEX$$es avec la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.               */
/*----------------------------------------------------------------------------*/
Dw_Piece.ShareDataOff 		()
Dw_Refus.ShareDataOff 		()
Dw_Plafond.ShareDataOff 	()
Dw_Franchise.ShareDataOff	()
Dw_Delai.ShareDataOff    	()
Uo_Onglets.uf_ChangerOnglet( "01" )

/*------------------------------------------------------------------*/
/* Rend accessible la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.                            */
/*------------------------------------------------------------------*/
iwAppel.Enabled = True

This.Hide ()

/*------------------------------------------------------------------*/
/* Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si    */
/* elle est ouverte                                                 */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Chaud
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 17:23:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	R$$HEX1$$e900$$ENDHEX$$organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre en fonction de 
//*						l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment visualis$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
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
If ( isIdTypCode = "XX" )  Then
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
	iwAppel.Dw_Piece.ShareData 		( Dw_Piece   )
	iwAppel.Dw_Refus.ShareData 		( Dw_Refus   )
	wf_initongletrefus ( )
	wf_initongletpieces ( )

End If


/*----------------------------------------------------------------------------*/
/* L'onglet des plafonds doit $$HEX1$$ea00$$ENDHEX$$tre accessible quel que soit l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur     */
/* lequel on travaille ( garantie ou condition de garantie ), donc on         */
/* l'initialise et on le rend disponible $$HEX2$$e0002000$$ENDHEX$$chaque fois.                       */
/*----------------------------------------------------------------------------*/
iwAppel.Dw_Plafond.ShareData ( Dw_Plafond )
Wf_InitOngletPlafonds ( )


/*----------------------------------------------------------------------------*/
/* L'onglet des d$$HEX1$$e900$$ENDHEX$$lais doit $$HEX1$$ea00$$ENDHEX$$tre accessible quel que soit l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur       */
/* lequel on travaille ( garantie ou condition de garantie ), donc on         */
/* l'initialise et on le rend disponible $$HEX2$$e0002000$$ENDHEX$$chaque fois.                       */
/*----------------------------------------------------------------------------*/
iwAppel.Dw_Delai.ShareData ( Dw_Delai   )
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

iwAppel.Dw_Franchise.ShareData ( Dw_Franchise )
Wf_InitOngletFranchises ( )

/*------------------------------------------------------------------*/
/* On se positionne sur le premier onglet                           */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )


iwAppel.Enabled = False

This.SetRedraw ( True )


end event

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_condition_gti
//* Evenement 		:	Close
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 11:39:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Referme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si elle est  */
/* ouverte.                                                         */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	Close ( W_Consulter_Paragraphe )

End If
end event

on w_t_sp_c_condition_gti.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.dw_refus=create dw_refus
this.dw_piece=create dw_piece
this.dw_franchise=create dw_franchise
this.dw_delai=create dw_delai
this.dw_plafond=create dw_plafond
this.uo_bord3d=create uo_bord3d
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.dw_refus
this.Control[iCurrent+3]=this.dw_piece
this.Control[iCurrent+4]=this.dw_franchise
this.Control[iCurrent+5]=this.dw_delai
this.Control[iCurrent+6]=this.dw_plafond
this.Control[iCurrent+7]=this.uo_bord3d
end on

on w_t_sp_c_condition_gti.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.dw_refus)
destroy(this.dw_piece)
destroy(this.dw_franchise)
destroy(this.dw_delai)
destroy(this.dw_plafond)
destroy(this.uo_bord3d)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_t_sp_c_condition_gti
boolean visible = false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_t_sp_c_condition_gti
integer y = 36
integer taborder = 80
end type

type uo_onglets from u_onglets within w_t_sp_c_condition_gti
integer x = 27
integer y = 204
integer width = 2432
integer height = 108
integer taborder = 10
boolean border = false
end type

type dw_refus from datawindow within w_t_sp_c_condition_gti
integer x = 389
integer y = 444
integer width = 1911
integer height = 716
integer taborder = 60
string dataobject = "d_sp_c_gti_refus"
boolean vscrollbar = true
boolean livescroll = true
end type

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Refus
//* Evenement 		:	rButtonDown
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:17:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Visualisation des $$HEX2$$a7002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long			lLig		// Ligne sur laquelle on se trouve
s_Pass		stPass

lLig		=	This.GetSelectedRow ( 0 )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end event

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Refus
//* Evenement 		:	Clicked
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:19:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	S$$HEX1$$e900$$ENDHEX$$lection de la ligne click$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long		lLigClick		// Ligne Click$$HEX1$$e900$$ENDHEX$$e

lLigClick = This.GetClickedRow ()

If lLigClick > 0 Then

	This.SelectRow ( 0, False )
	This.SelectRow ( This.GetClickedRow (), True )

End If


end event

type dw_piece from datawindow within w_t_sp_c_condition_gti
integer x = 389
integer y = 444
integer width = 1911
integer height = 716
integer taborder = 50
string dataobject = "d_sp_c_gti_piece"
boolean vscrollbar = true
boolean livescroll = true
end type

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Piece
//* Evenement 		:	rButtonDown
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:17:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Visualisation des $$HEX2$$a7002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long			lLig		// Ligne sur laquelle on se trouve
s_Pass		stPass

lLig		=	This.GetSelectedRow ( 0 )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end event

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Piece
//* Evenement 		:	Clicked
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:19:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	S$$HEX1$$e900$$ENDHEX$$lection de la ligne click$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long		lLigClick		// Ligne Click$$HEX1$$e900$$ENDHEX$$e

lLigClick = This.GetClickedRow ()

If lLigClick > 0 Then

	This.SelectRow ( 0, False )
	This.SelectRow ( This.GetClickedRow (), True )

End If


end event

type dw_franchise from datawindow within w_t_sp_c_condition_gti
integer x = 389
integer y = 444
integer width = 1911
integer height = 716
integer taborder = 40
string dataobject = "d_sp_c_gti_franchise"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Franchise
//* Evenement 		:	Clicked
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:19:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	S$$HEX1$$e900$$ENDHEX$$lection de la ligne click$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long		lLigClick		// Ligne Click$$HEX1$$e900$$ENDHEX$$e

lLigClick = This.GetClickedRow ()

If lLigClick > 0 Then

	This.SelectRow ( 0, False )
	This.SelectRow ( This.GetClickedRow (), True )

End If



end event

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Franchise
//* Evenement 		:	rButtonDown
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:17:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Visualisation des $$HEX2$$a7002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long			lLig		// Ligne sur laquelle on se trouve
s_Pass		stPass

lLig		=	This.GetSelectedRow ( 0 )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then


			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end event

type dw_delai from datawindow within w_t_sp_c_condition_gti
integer x = 389
integer y = 444
integer width = 1911
integer height = 716
integer taborder = 30
string dataobject = "d_sp_c_gti_delai"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_plafond from datawindow within w_t_sp_c_condition_gti
integer x = 389
integer y = 444
integer width = 1911
integer height = 716
integer taborder = 70
string dataobject = "d_sp_c_gti_plafond"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Plafond
//* Evenement 		:	Clicked
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:19:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	S$$HEX1$$e900$$ENDHEX$$lection de la ligne click$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long		lLigClick		// Ligne Click$$HEX1$$e900$$ENDHEX$$e

lLigClick = This.GetClickedRow ()

If lLigClick > 0 Then

	This.SelectRow ( 0, False )
	This.SelectRow ( This.GetClickedRow (), True )

End If



end event

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Plafond
//* Evenement 		:	rButtonDown
//* Auteur			:	V.Capelle
//* Date				:	16/12/1997 10:17:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Visualisation des $$HEX2$$a7002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long			lLig		// Ligne sur laquelle on se trouve
s_Pass		stPass

lLig		=	This.GetSelectedRow ( 0 )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end event

type uo_bord3d from u_bord3d within w_t_sp_c_condition_gti
integer x = 37
integer y = 300
integer width = 2615
integer height = 1000
integer taborder = 20
boolean bringtotop = true
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

