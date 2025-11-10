HA$PBExportHeader$w_t_sp_c_garantie.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation du param$$HEX1$$e900$$ENDHEX$$trage des garanties
forward
global type w_t_sp_c_garantie from w_8_ancetre_consultation
end type
type dw_plafond from datawindow within w_t_sp_c_garantie
end type
type dw_franchise from datawindow within w_t_sp_c_garantie
end type
type dw_delai from datawindow within w_t_sp_c_garantie
end type
type dw_piece from datawindow within w_t_sp_c_garantie
end type
type dw_refus from datawindow within w_t_sp_c_garantie
end type
type uo_onglets from u_onglets within w_t_sp_c_garantie
end type
type dw_1 from u_datawindow within w_t_sp_c_garantie
end type
type dw_affilier from datawindow within w_t_sp_c_garantie
end type
type uo_condition from u_ajout within w_t_sp_c_garantie
end type
type uo_bord3d from u_bord3d within w_t_sp_c_garantie
end type
end forward

global type w_t_sp_c_garantie from w_8_ancetre_consultation
integer x = 50
integer y = 200
integer width = 3543
integer height = 1540
boolean hscrollbar = true
event ue_entreronglet021 pbm_custom01
event ue_entreronglet031 pbm_custom02
event ue_entreronglet041 pbm_custom03
event ue_entreronglet051 pbm_custom04
dw_plafond dw_plafond
dw_franchise dw_franchise
dw_delai dw_delai
dw_piece dw_piece
dw_refus dw_refus
uo_onglets uo_onglets
dw_1 dw_1
dw_affilier dw_affilier
uo_condition uo_condition
uo_bord3d uo_bord3d
end type
global w_t_sp_c_garantie w_t_sp_c_garantie

type variables
String	isLibGti

Long	ilIdProd		// Identifiant du produit.
Long	ilIdRev		// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long	ilIdGti		// Identifiant de la garantie.
end variables

forward prototypes
public function boolean wf_preparerconsulter ()
public subroutine wf_modifier_Uo_condition (string asidtypcode)
end prototypes

on ue_entreronglet021;call w_8_ancetre_consultation::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_garantie
//* Evenement 		:	ue_EntrerOnglet021
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 15:19:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modifie la datawindow des Conditions de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					   ce qu'elle n'affiche que les informations relatives
//*					   aux Ev$$HEX1$$e800$$ENDHEX$$nements
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
String 	sIdTypCode 	= "+EV"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.Dw_Source.Modify ("titre.Text='Ev$$HEX1$$e900$$ENDHEX$$nements couverts par la garantie'"        )
Uo_Condition.Dw_Cible.Modify  ("titre.Text='Ev$$HEX1$$e900$$ENDHEX$$nements non couverts par la garantie'"    )

/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/
wf_Modifier_Uo_Condition ( sIdTypCode )



end on

on ue_entreronglet031;call w_8_ancetre_consultation::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_garantie
//* Evenement 		:	ue_EntrerOnglet031
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 15:30:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:  Modifie la datawindow des Conditions de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					   ce qu'elle n'affiche que les informations relatives
//*					   aux Natures de sinistre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


String 	sIdTypCode 	= "+NS"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.Dw_Source.Modify ("titre.Text='Natures de sinistre couvertes par la garantie'" )
Uo_Condition.Dw_Cible.Modify ("titre.Text='Natures de sinistre non couvertes par la garantie'" )



/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/
wf_Modifier_Uo_Condition ( sIdTypCode )


end on

on ue_entreronglet041;call w_8_ancetre_consultation::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_garantie
//* Evenement 		:	ue_EntrerOnglet041
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 15:31:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:  Modifie la datawindow des Conditions de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					   ce qu'elle n'affiche que les informations relatives
//*					   aux D$$HEX1$$e900$$ENDHEX$$tails de sinistre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


String 	sIdTypCode 	= "+DT"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.Dw_Source.Modify	("titre.Text='D$$HEX1$$e900$$ENDHEX$$tails de sinistre couverts par la garantie'"    )
Uo_Condition.Dw_Cible.Modify	("titre.Text='D$$HEX1$$e900$$ENDHEX$$tails de sinistre non couverts par la garantie'" )


/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/

wf_Modifier_Uo_Condition ( sIdTypCode )


end on

on ue_entreronglet051;call w_8_ancetre_consultation::ue_entreronglet051;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_garantie
//* Evenement 		:	ue_EntrerOnglet051
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 15:33:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:  Modifie la datawindow des Conditions de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					   ce qu'elle n'affiche que les informations relatives
//*					   aux Territorialit$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sIdTypCode 	= "+TR"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher


Uo_Condition.Dw_Source.Modify ("titre.Text='Territorialit$$HEX1$$e900$$ENDHEX$$s couvertes par la garantie'"    )
Uo_Condition.Dw_Source.Modify ("titre.Text='Territorialit$$HEX1$$e900$$ENDHEX$$s non couvertes par la garantie'"    )

/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/

wf_Modifier_Uo_Condition ( sIdTypCode )


end on

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerConsulter
//* Auteur			: YP
//* Date				: 16/09/1997 18:14:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les Dw
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------
Boolean 				bRet				// Valeur de retour de la fonction.

DataWindowChild	dwcRev			// DDDW sur la r$$HEX1$$e900$$ENDHEX$$vision.
DataWindowChild	dwcGti			// DDDW sur la garantie.
DataWindowChild	dwcProd			// DDDW sur le produit.

Long 					lNumProd			// Ligne pour le produit
Long 					lNumGti			// Ligne pour la garantie

SetPointer ( HourGlass! )

ilIdProd	=	istPass.lTab[ 1 ]
ilIdRev	=	istPass.lTab[ 2 ]
ilIdGti	=	istPass.lTab[ 3 ]

/*------------------------------------------------------------------*/
/* Initialise le contenu des DW.                                    */
/*------------------------------------------------------------------*/
bRet = ( Dw_1.Retrieve ( ilIdProd , ilIdRev, ilIdGti )  > 0 )

If bRet Then

	Dw_Affilier.Retrieve  		(	ilIdProd, ilIdRev, ilIdGti )
	Dw_Plafond.Retrieve  		(	ilIdProd, ilIdRev, ilIdGti )
	Dw_Franchise.Retrieve  		(	ilIdProd, ilIdRev, ilIdGti )
	Dw_Delai.Retrieve		  		(	ilIdProd, ilIdRev, ilIdGti )
	Dw_Piece.Retrieve		  		(	ilIdProd, ilIdRev, ilIdGti )
	Dw_Refus.Retrieve 	 		(	ilIdProd, ilIdRev, ilIdGti )


	/*------------------------------------------------------------------*/
	/* Populise les informations dans la Dw_Recherche.                  */
	/*------------------------------------------------------------------*/
	Uo_Condition.Uf_DwRechercheRetrieve ( "", Uo_Condition )
	Uo_Condition.Dw_Recherche.RowsCopy  ( 1 , Uo_Condition.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                				Uo_Condition.Dw_Cible , 1 , PRIMARY!  )

	/*------------------------------------------------------------------*/
	/* Populise les informations dans la Dw_Source.                     */
	/*------------------------------------------------------------------*/
	Uo_Condition.Uf_dwSourceRetrieve 	( "", Uo_Condition )


	/*------------------------------------------------------------------*/
	/* Positionne le 1er onglet, par d$$HEX1$$e900$$ENDHEX$$faut.                            */
	/*------------------------------------------------------------------*/
	Uo_Onglets.uf_ChangerOnglet( "01" )

	Dw_1.GetChild ( "ID_REV", dwcRev )
	dwcRev.SetTransObject ( itrTrans )
	dwcRev.Retrieve( ilIdProd )

	Dw_1.GetChild ( "ID_GTI", dwcGti )
	dwcGti.SetTransObject ( itrTrans )
	dwcGti.Retrieve( ilIdProd )

	Dw_1.GetChild ( "ID_Prod", dwcProd ) 


	lNumGti  = DwcGti.Find  ( "ID_GTI = " + String  ( ilIdGti  ) , 1 , DwcGti.RowCount ( ) )
	lNumProd = DwcProd.Find ( "ID_PROD = " + String ( ilIdProd ) , 1 , DwcProd.RowCount ( ) )

	isLibGti	= "Produit "  + DwcProd.GetItemString ( lNumProd , "LIB_LONG" ) + " - " + &
				  "R$$HEX1$$e900$$ENDHEX$$vision " + String ( ilIdRev ) + " - " 									   + &
				  "Garantie " + DwcGti.GetItemString ( lNumGti , "LIB_GTI"  ) + "."

	This.Title 	= "Consultation de garantie - " + isLibGti		


End If

Return ( bRet )
end function

public subroutine wf_modifier_Uo_condition (string asidtypcode);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_Modifier_Uo_Condition ()
//* Auteur			: V.Capelle
//* Date				: 10/11/1997 17:52:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modifie le contenu et l'apparence du user object
//*					  en fonction du type de code qu'il doit pr$$HEX1$$e900$$ENDHEX$$senter.
//*
//* Arguments		: String		asIdTypCode		Type de code $$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$senter
//*
//* Retourne		: Rien
//*					
//*
//*-----------------------------------------------------------------
String 		sFiltre

Long			lCpt								// Compteur pour le nombre de ligne $$HEX2$$e0002000$$ENDHEX$$importer.
Long 			lNbLigSrc						// Nombre de lignes dans Dw_Source.


Uo_Condition.dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* Source.                                                          */
/*------------------------------------------------------------------*/
sFiltre = "id_typ_code  ='" +  asIdTypCode 	         + "'"

Uo_Condition.dw_Source.SetRedraw ( False )

Uo_Condition.dw_Source.SetFilter ( sFiltre )
Uo_Condition.dw_Source.Filter ()
Uo_Condition.dw_Source.SetSort ( "ID_CODE A"  )
Uo_Condition.dw_Source.Sort ()

Uo_Condition.dw_Source.SetRedraw ( True )

lNbLigSrc = Uo_Condition.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche, puis renseigne la DW cible.                        */
/*------------------------------------------------------------------*/
sFiltre = "ID_TYP_CODE='" + asIdTypCode + "'"


If lNbLigSrc > 0 Then

	For lCpt = 1 to lNbLigSrc

		sFiltre = sFiltre + " AND ID_CODE <> " + String ( Uo_Condition.Dw_Source.GetItemNumber &
																      ( lCpt , "ID_CODE" ) )

	Next

End If

Uo_Condition.Dw_Recherche.SetFilter ( sFiltre )
Uo_Condition.Dw_Recherche.Filter    (         )

Uo_Condition.Dw_Recherche.RowsCopy  ( 1 ,	Uo_Condition.Dw_Recherche.RowCount ( ), PRIMARY!, &
														Uo_Condition.Dw_Cible, 1, PRIMARY! )

Uo_Condition.Dw_Recherche.SetFilter ( "" )
Uo_Condition.Dw_Recherche.Filter    (    )


Uo_condition.dw_Cible.SetSort ( "ID_CODE A" )
Uo_Condition.dw_Cible.Sort ()


/*------------------------------------------------------------------*/
/* On positionne le Focus sur  Dw_Cible afin d'$$HEX1$$e900$$ENDHEX$$viter que  la       */
/* premi$$HEX1$$e800$$ENDHEX$$re ligne de Dw_cible ET de Dw_Source qui soient            */
/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es simultan$$HEX1$$e900$$ENDHEX$$ment.S'il n'y a pas de ligne dans         */
/* Dw_Cible le focus est positionn$$HEX2$$e9002000$$ENDHEX$$sur Dw_Source.                  */
/*------------------------------------------------------------------*/
If Uo_condition.Dw_Cible.RowCount () > 0 then

	Uo_condition.Dw_Cible.SelectRow ( 0 , False )	
	Uo_condition.Dw_Cible.SelectRow ( 1 , True )
	Uo_condition.Dw_Cible.SetFocus  ()

Else

	Uo_condition.Dw_Source.SelectRow ( 0 , False )	
	Uo_condition.Dw_Source.SelectRow ( 1 , True )
	Uo_condition.Dw_Source.SetFocus  ()

End If

Uo_condition.SetRedraw ( True )


end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_c_garantie
//* Evenement 		:	Ue_Initialiser
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 14:47:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
// #1	JCA	5/5/2008	- [DCMP070914] - Gestion du prefixe assureur
//*-----------------------------------------------------------------

DataWindowChild	DwcProd			// DDDW des produits.
DatawindowChild	DwcRev			// DDDW des r$$HEX1$$e900$$ENDHEX$$visions du produit.
DataWindowChild	DwcGti			// DDDW des codes de garanties.
DataWindowChild	DwcPolice		// DDDW des polices.
DataWindowChild	DwcCodTypFra	// DDDW des codes de type de franchises.
DataWindowChild	DwcPrefixe		// #1 - DDDW des prefixes assureur 

String				sCol [ 6 ]		// Tableau contenant les champs dont 
											// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$
String				sMod				// Modify pour la datawindow

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow			dwPassageEuro[2]
DataWindow			dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Gestion du Passage $$HEX2$$e0002000$$ENDHEX$$l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_Franchise
dwPassageEuro [ 2 ] = dw_Plafond

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] 			= "ID_PROD"
sCol [ 2 ] 			= "ID_REV"
sCol [ 3 ] 			= "ID_GTI"
sCol [ 4 ] 			= "ID_POLICE"
sCol [ 5 ] 			= "COD_TYP_FRA"
sCol [ 6 ] 			= "ID_PREFIXE" // #1


Dw_1.Uf_InitialiserCouleur ( sCol )
Dw_1.Uf_Proteger ( sCol, "1" )

sMod = " #1.dddw.UseAsBorder =No #2.dddw.UseAsBorder =No #3.dddw.UseAsBorder =No" + &
		 " #4.dddw.UseAsBorder =No #5.dddw.UseAsBorder =No #6.dddw.UseAsBorder =No"

Dw_1.Modify ( sMod )

/*------------------------------------------------------------------*/
/* Initialisation des Datawindows simples                           */
/*------------------------------------------------------------------*/
Dw_1.uf_SetTransObject 			( iTrTrans )
Dw_Affilier.SetTransObject		( iTrTrans )
Dw_Piece.SetTransObject			( iTrTrans )
Dw_Refus.SetTransObject			( iTrTrans )
Dw_Plafond.SetTransObject		( iTrTrans )
Dw_Franchise.SetTransObject	( iTrTrans )
Dw_Delai.SetTransObject    	( iTrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des DDDW                                          */
/*------------------------------------------------------------------*/
Dw_1.GetChild ( "ID_PROD"  		, DwcProd  		)
Dw_1.GetChild ( "ID_REV"	 		, DwcRev 		)
Dw_1.GetChild ( "ID_GTI"			, DwcGti 		)
Dw_1.GetChild ( "ID_POLICE"		, DwcPolice	 	)
Dw_1.GetChild ( "COD_TYP_FRA"		, DwcCodTypFra )

Dw_1.GetChild ( "ID_PREFIXE"		, DwcPrefixe ) // #1 

DwcProd.SetTransObject 			( iTrTrans )
DwcRev.SetTransObject 			( iTrTrans )
DwcGti.SetTransObject 			( iTrTrans )
DwcPolice.SetTransObject 		( iTrTrans )
DwcCodTypFra.SetTransObject 	( iTrTrans )

DwcPrefixe.SetTransObject 	( iTrTrans ) // #1 

/*----------------------------------------------------------------------------*/
/* La r$$HEX1$$e900$$ENDHEX$$vision et la garantie du produit les DDDW correspondantes sont vides  */
/* et ne sont populis$$HEX1$$e900$$ENDHEX$$es qu'$$HEX2$$e0002000$$ENDHEX$$partir du moment o$$HEX2$$f9002000$$ENDHEX$$le produit est renseign$$HEX1$$e900$$ENDHEX$$.   */
/*----------------------------------------------------------------------------*/
DwcRev.InsertRow ( 0 )
DwcGti.InsertRow ( 0 )

/*----------------------------------------------------------------------------*/
/* Les DDDW pour le produit, la police et le type de franchise sont           */
/* populis$$HEX1$$e900$$ENDHEX$$es d$$HEX1$$e800$$ENDHEX$$s le d$$HEX1$$e900$$ENDHEX$$but.                                                   */
/*----------------------------------------------------------------------------*/
If ( DwcProd.Retrieve  (  ) <=0 ) Then
	DwcProd.InsertRow ( 0 )
End If


If ( DwcPolice.Retrieve ( ) <= 0 ) Then
	DwcPolice.InsertRow ( 0 )
End If


If ( 	DwcCodTypFra.Retrieve  ( "-FR" ) <=0 ) Then
	DwcCodTypFra.InsertRow ( 0 )
End If

If ( 	DwcPrefixe.Retrieve  ( "-PX" ) <=0 ) Then // #1
		DwcPrefixe.InsertRow ( 0 )
End If

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 6, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Garantie"        , "", Dw_1				, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Ev$$HEX1$$e900$$ENDHEX$$nements"		 , "", Uo_Condition	, False ) 
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "Natures"         , "", Uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "D$$HEX1$$e900$$ENDHEX$$tails"			 , "", Uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Territorialit$$HEX1$$e900$$ENDHEX$$s" , "", Uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "06", "Cartes"	   	 , "", Dw_Affilier 	, False )


/*------------------------------------------------------------------*/
/* Affection des Dataobjets aux Dw de l'objet concernant les        */
/* conditions de garantie.                                          */
/*------------------------------------------------------------------*/
Uo_Condition.Uf_Initialiser ( "d_sp_lst_condition_rch", "d_sp_c_gti_condition", "d_sp_lst_condition", itrTrans )


/*------------------------------------------------------------------*/
/* Le curseur pour Dw_1 et les conditions indique que l'on peut     */
/* appeler une fenetre par double click.                            */
/*------------------------------------------------------------------*/
sMod	=	"DataWindow.Pointer='K:\PB4OBJ\BMP\DBLCLICK.CUR'"
Dw_1.Modify ( sMod )
Uo_Condition.Dw_Source.Modify ( sMod )
end event

on w_t_sp_c_garantie.create
int iCurrent
call super::create
this.dw_plafond=create dw_plafond
this.dw_franchise=create dw_franchise
this.dw_delai=create dw_delai
this.dw_piece=create dw_piece
this.dw_refus=create dw_refus
this.uo_onglets=create uo_onglets
this.dw_1=create dw_1
this.dw_affilier=create dw_affilier
this.uo_condition=create uo_condition
this.uo_bord3d=create uo_bord3d
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_plafond
this.Control[iCurrent+2]=this.dw_franchise
this.Control[iCurrent+3]=this.dw_delai
this.Control[iCurrent+4]=this.dw_piece
this.Control[iCurrent+5]=this.dw_refus
this.Control[iCurrent+6]=this.uo_onglets
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_affilier
this.Control[iCurrent+9]=this.uo_condition
this.Control[iCurrent+10]=this.uo_bord3d
end on

on w_t_sp_c_garantie.destroy
call super::destroy
destroy(this.dw_plafond)
destroy(this.dw_franchise)
destroy(this.dw_delai)
destroy(this.dw_piece)
destroy(this.dw_refus)
destroy(this.uo_onglets)
destroy(this.dw_1)
destroy(this.dw_affilier)
destroy(this.uo_condition)
destroy(this.uo_bord3d)
end on

type cb_debug from w_8_ancetre_consultation`cb_debug within w_t_sp_c_garantie
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_t_sp_c_garantie
boolean visible = false
integer x = 2469
integer y = 64
integer width = 503
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_t_sp_c_garantie
integer y = 36
integer taborder = 60
end type

type dw_plafond from datawindow within w_t_sp_c_garantie
boolean visible = false
integer x = 3191
integer y = 160
integer width = 494
integer height = 188
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_sp_gti_plafond"
boolean livescroll = true
end type

type dw_franchise from datawindow within w_t_sp_c_garantie
boolean visible = false
integer x = 3195
integer y = 364
integer width = 494
integer height = 188
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_sp_gti_franchise"
boolean livescroll = true
end type

type dw_delai from datawindow within w_t_sp_c_garantie
boolean visible = false
integer x = 3200
integer y = 568
integer width = 494
integer height = 188
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_sp_gti_delai"
boolean livescroll = true
end type

type dw_piece from datawindow within w_t_sp_c_garantie
boolean visible = false
integer x = 3195
integer y = 772
integer width = 494
integer height = 188
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_sp_gti_piece"
boolean livescroll = true
end type

type dw_refus from datawindow within w_t_sp_c_garantie
boolean visible = false
integer x = 3195
integer y = 976
integer width = 494
integer height = 188
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_sp_gti_refus"
boolean livescroll = true
end type

type uo_onglets from u_onglets within w_t_sp_c_garantie
integer x = 37
integer y = 200
integer width = 2921
integer height = 108
integer taborder = 50
boolean border = false
end type

type dw_1 from u_datawindow within w_t_sp_c_garantie
integer x = 544
integer y = 392
integer width = 2395
integer height = 900
integer taborder = 10
string dataobject = "d_sp_garantie"
boolean border = false
end type

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_traitement_master::dw_1
//* Evenement 		:	DoubleClicked
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 11:01:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$lais, 
//*						plafonds, franchises, pi$$HEX1$$e800$$ENDHEX$$ces et refus pour la garantie
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
s_pass		stPass		// structure de passage pour l'appel de W_t_sp_Code_Condition.

SetPointer ( HourGlass! )

stPass.trTrans 		= istPass.trTrans
stPass.wParent			= Parent.Parentwindow()
stPass.bEnableParent	= False

stPass.lTab [ 1 ] = Dw_1.GetItemNumber ( 1, "ID_PROD" )
stPass.lTab [ 2 ] = Dw_1.GetItemNumber ( 1, "ID_GTI" )
stPass.lTab [ 3 ] = Dw_1.GetItemNumber ( 1, "ID_REV" ) 
stPass.lTab [ 4 ] = 0
stPass.lTab [ 5 ] = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )

stPass.sTab [ 1 ] = "XX"


/*----------------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre n'est pas encore ouverte on effectue son ouverture en lui    */
/* passant des param$$HEX1$$ea00$$ENDHEX$$tres pour instancier ses variables d'instance, sinon on  */
/* met directement $$HEX2$$e0002000$$ENDHEX$$jour celles-ci et on rend la fen$$HEX1$$ea00$$ENDHEX$$tre visible simplement. */
/*----------------------------------------------------------------------------*/
If isValid ( W_t_sp_c_Condition_Gti )	= False	Then

	OpenWithParm ( W_t_sp_c_Condition_Gti, stPass, stPass.wParent )

Else

	W_t_sp_c_Condition_Gti.idcIdProd    = Dw_1.GetItemNumber ( 1, "ID_PROD" )
	W_t_sp_c_Condition_Gti.idcIdGti     = Dw_1.GetItemNumber ( 1, "ID_GTI" )
	W_t_sp_c_Condition_Gti.idcIdRev     = Dw_1.GetItemNumber ( 1, "ID_REV"      )
	W_t_sp_c_Condition_Gti.idcIdCode    = 0
	W_t_sp_c_Condition_Gti.isIdTypCode  = "XX"
	W_t_sp_c_Condition_Gti.idcIdTypFra	= Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
	W_t_sp_c_Condition_Gti.Show ()

End If

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du titre si l'on conna$$HEX1$$ee00$$ENDHEX$$t la garantie.                          */
/*----------------------------------------------------------------------------*/
If isLibGti <> "" Then
	W_t_sp_c_Condition_Gti.Title =  "Consultation - " + isLibGti
Else
	W_t_sp_c_Condition_Gti.Title = "Consultation de garantie "
End If
end on

type dw_affilier from datawindow within w_t_sp_c_garantie
integer x = 786
integer y = 396
integer width = 1911
integer height = 796
integer taborder = 30
boolean enabled = false
string dataobject = "d_sp_c_gti_affilier"
boolean livescroll = true
end type

type uo_condition from u_ajout within w_t_sp_c_garantie
integer x = 64
integer y = 320
integer width = 3360
integer height = 1028
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on ue_dwsource_dclick;call u_ajout::ue_dwsource_dclick;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Source
//* Evenement 		:	DoubleClicked
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 11:01:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

s_pass		stPass		// structure de passage pour l'appel de W_t_sp_Code_Condition.

SetPointer ( HourGlass! )

stPass.trTrans 		= istPass.trTrans
stPass.wParent			= Parent.Parentwindow()
stPass.bEnableParent	= False

stPass.lTab [ 1 ] = ilIdProd
stPass.lTab [ 2 ] = ilIdGti
stPass.lTab [ 3 ] = ilIdRev
stPass.lTab [ 4 ] = Uo_Condition.Dw_Source.GetItemNumber ( Uo_Condition.illigsourceclick, "ID_CODE" )
stPass.lTab [ 5 ] = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )

stPass.sTab [ 1 ] = Uo_Condition.Dw_Source.GetItemString ( Uo_Condition.illigsourceclick, "ID_TYP_CODE" ) 



If isValid ( W_t_sp_c_Condition_Gti )	= False	Then

	OpenWithParm ( W_t_sp_c_Condition_Gti, stPass, stPass.wParent )

Else

	W_t_sp_c_Condition_Gti.idcIdProd    = ilIdProd
	W_t_sp_c_Condition_Gti.idcIdGti     = ilIdGti
	W_t_sp_c_Condition_Gti.idcIdRev     = ilIdRev
	W_t_sp_c_Condition_Gti.idcIdCode    = Uo_Condition.Dw_Source.GetItemNumber ( Uo_Condition.illigsourceclick, "ID_CODE" )
	W_t_sp_c_Condition_Gti.isIdTypCode  = Uo_Condition.Dw_Source.GetItemString ( Uo_Condition.illigsourceclick, "ID_TYP_CODE" ) 
	W_t_sp_c_Condition_Gti.idcIdTypFra	= Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
	W_t_sp_c_Condition_Gti.Show ()

End If

/*----------------------------------------------------------------------------*/
/* Modification du titre de la fen$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$tail.                                */
/*----------------------------------------------------------------------------*/
If isLibGti <> "" Then
	W_t_sp_c_Condition_Gti.Title =  "Consultation - " + isLibGti
Else
	W_t_sp_c_Condition_Gti.Title = "Consultation de garantie "
End If

end on

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_Condition
//* Evenement 		: Ue_dwRecherche_Retrieve ( OverRide )
//* Auteur			: V.Capelle
//* Date				: 10/11/1997 17:58:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On OverRide l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement car on a besoin de 2
//*                 arguments pour le retrieve
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
ilLigRecherche = Dw_Recherche.Retrieve ( ilIdProd, ilIdGti  )

end on

on ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_Condition
//* Evenement 		: Ue_dwSource_Retrieve ( OverRide )
//* Auteur			: V.Capelle
//* Date				: 10/11/1997 17:38:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On OverRide l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement car on a besoin de 3
//*                 arguments pour le retrieve
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
ilLigSource = dw_Source.Retrieve ( ilIdProd, ilIdRev, ilIdGti  )

end on

on constructor;call u_ajout::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Condition
//* Evenement 		:	Constructor ( Extend )
//* Auteur			:	V.Capelle
//* Date				:	10/11/1997 17:23:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
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

/*----------------------------------------------------------------------------*/
/* Pas d'effet 3D                                                             */
/*----------------------------------------------------------------------------*/
ibEffet3D		= False





end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Condition
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	10/11/1997 16:24:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter.
//*				  
//*-----------------------------------------------------------------
Uo_Condition.Pb_enlever_tout.Visible = False
Uo_Condition.Pb_ajouter_tout.Visible = False
Uo_Condition.Pb_enlever_1.Visible    = False
Uo_Condition.Pb_ajouter_1.Visible    = False
end on

on uo_condition.destroy
call u_ajout::destroy
end on

type uo_bord3d from u_bord3d within w_t_sp_c_garantie
integer x = 46
integer y = 296
integer width = 3456
integer height = 1084
integer taborder = 40
boolean bringtotop = true
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

