HA$PBExportHeader$w_tm_sp_garantie.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des garanties
forward
global type w_tm_sp_garantie from w_8_traitement_master
end type
type dw_piece from datawindow within w_tm_sp_garantie
end type
type dw_refus from datawindow within w_tm_sp_garantie
end type
type dw_plafond from datawindow within w_tm_sp_garantie
end type
type dw_franchise from datawindow within w_tm_sp_garantie
end type
type dw_delai from datawindow within w_tm_sp_garantie
end type
type uo_bord3d from u_bord3d within w_tm_sp_garantie
end type
type uo_condition from u_ajout within w_tm_sp_garantie
end type
type uo_affilier from u_ajout within w_tm_sp_garantie
end type
type uo_onglets from u_onglets within w_tm_sp_garantie
end type
end forward

global type w_tm_sp_garantie from w_8_traitement_master
integer x = 73
integer y = 0
integer width = 3438
integer height = 1760
string title = "Gestion des garanties"
event ue_entreronglet021 pbm_custom01
event ue_entreronglet031 pbm_custom02
event ue_entreronglet041 pbm_custom03
event ue_entreronglet051 pbm_custom04
event ue_quitteronglet061 pbm_custom05
event ue_quitteronglet011 pbm_custom06
event ue_entreronglet011 pbm_custom07
event ue_droitecriture pbm_custom08
dw_piece dw_piece
dw_refus dw_refus
dw_plafond dw_plafond
dw_franchise dw_franchise
dw_delai dw_delai
uo_bord3d uo_bord3d
uo_condition uo_condition
uo_affilier uo_affilier
uo_onglets uo_onglets
end type
global w_tm_sp_garantie w_tm_sp_garantie

type variables
Boolean			ibOngletutilise [ 6 ]

u_sp_Zn_Garantie		iuoZnGarantie
u_sp_Gs_Affilier		iuoGsAffilier
u_sp_Gs_Garantie		iuoGsGarantie
u_sp_Gs_Condition		iuoGsCondition 

Long			ilIdProd
Long			ilIdRev = -2
Long			ilIdGti

Integer			iiErreurAffilier

String			isLibGti
Long		ilIdProdEntree
Long		ilIdProdSortie
Long		ilIdGtiEntree
Long		ilIdGtiSortie
Long		ilIdFraEntree
Long		ilIdFraSortie
end variables

forward prototypes
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerabandonner ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
public function boolean wf_terminervalider ()
public subroutine wf_modifier_uo_condition (string asidtypcode)
public subroutine wf_reinitialiser_parametre ()
public function boolean wf_valider_detail ()
public subroutine wf_populise_onglet ()
public function boolean wf_accepttext ()
public subroutine wf_reinitialiser_franchise ()
public subroutine wf_reinitialiser_franchise (long alcodtypfra)
end prototypes

on ue_entreronglet021;call w_8_traitement_master::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_Garantie
//* Evenement 		: ue_EntrerOnglet021
//* Auteur			: V.Capelle
//* Date				: 12/11/1997 09:35:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modifie le User Object U_Condition de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					  ce qu'il n'affiche que les informations relatives
//*					  aux Ev$$HEX1$$e800$$ENDHEX$$nements
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
String 	sIdTypCode 	= "+EV"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.dw_Cible.Modify ("titre.Text='Ev$$HEX1$$e900$$ENDHEX$$nements non couverts par la garantie'")
Uo_Condition.dw_Source.Modify("titre.Text='Ev$$HEX1$$e900$$ENDHEX$$nements couverts par la garantie'"    )

/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/
wf_Modifier_Uo_Condition ( sIdTypCode )
end on

on ue_entreronglet031;call w_8_traitement_master::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_Garantie
//* Evenement 		: ue_EntrerOnglet031
//* Auteur			: V.Capelle
//* Date				: 12/11/1997 09:38:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modifie le User Object U_Condition de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					  ce qu'il n'affiche que les informations relatives
//*					  aux Natures de sinistre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


String 	sIdTypCode 	= "+NS"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.dw_Cible.Modify ("titre.Text='Natures de sinistre non couvertes par la garantie'")
Uo_Condition.dw_Source.Modify("titre.Text='Natures de sinistre couvertes par la garantie'"    )



/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/

wf_Modifier_Uo_Condition ( sIdTypCode )


end on

on ue_entreronglet041;call w_8_traitement_master::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_Garantie
//* Evenement 		: ue_EntrerOnglet041
//* Auteur			: V.Capelle
//* Date				: 12/11/1997 09:20:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modifie le User Object U_Condition de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					  ce qu'il n'affiche que les informations relatives
//*					  aux D$$HEX1$$e900$$ENDHEX$$tails de sinistre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


String 	sIdTypCode 	= "+DT"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher

Uo_Condition.dw_Cible.Modify	("titre.Text='D$$HEX1$$e900$$ENDHEX$$tails de sinistre non couverts par la garantie'")
Uo_Condition.dw_Source.Modify	("titre.Text='D$$HEX1$$e900$$ENDHEX$$tails de sinistre couverts par la garantie'"    )



/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/

wf_Modifier_Uo_Condition ( sIdTypCode )


end on

on ue_entreronglet051;call w_8_traitement_master::ue_entreronglet051;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_Garantie
//* Evenement 		: ue_EntrerOnglet051
//* Auteur			: V.Capelle
//* Date				: 12/11/1997 09:15:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modifie le User Object U_Condition de mani$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e000$$ENDHEX$$
//*					  ce qu'il n'affiche que les informations relatives
//*					  aux Territorialit$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sIdTypCode 	= "+TR"		//Type de code $$HEX2$$e0002000$$ENDHEX$$afficher


Uo_Condition.dw_Cible.Modify ("titre.Text='Territorialit$$HEX1$$e900$$ENDHEX$$s non couvertes par la garantie'")
Uo_Condition.dw_Source.Modify("titre.Text='Territorialit$$HEX1$$e900$$ENDHEX$$s couvertes par la garantie'"    )



/*------------------------------------------------------------------*/
/* Filtre suivant le type de code les informations de la Datawindow */
/* de Recherche.                                                    */
/*------------------------------------------------------------------*/

wf_Modifier_Uo_Condition ( sIdTypCode )


end on

on ue_quitteronglet061;call w_8_traitement_master::ue_quitteronglet061;//*-----------------------------------------------------------------
//*
//* Objet			:	w_tm_sp_garantie
//* Evenement 		:	Ue_QuitterOnglet061
//* Auteur			:	V.Capelle
//* Date				:	12/11/1997 10:06:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Provoque l'acceptText pour la saisie de la derni$$HEX1$$e800$$ENDHEX$$re date
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
uo_Affilier.Dw_Source.AcceptText ()



end on

on ue_quitteronglet011;call w_8_traitement_master::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_garantie
//* Evenement 		: UE_QUITTERONGLET011
//* Auteur			: V.Capelle
//* Date				: 10/12/1997 16:13:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie le dernier champs saisi et d$$HEX1$$e900$$ENDHEX$$clenche 
//*					  l'ItemFocusChanged de Dw_1 si la colonne 
//*					  correspond au produit $$HEX2$$e0002000$$ENDHEX$$la garantie ou au type de 
//*					  franchise et que l'un de ces champs $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$modifi$$HEX1$$e900$$ENDHEX$$,
//*					  de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour les conditions de 
//*					  garantie.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
Dw_1.AcceptText ()

Choose Case  Dw_1.isNomCol 
	Case "ID_PROD", "ID_GTI", "COD_TYP_FRA"

		ilIdProdSortie = dw_1.GetItemNumber ( 1, "ID_PROD" )
		If isNull ( ilIdProdSortie ) Then  ilIdProdSortie = 0

		ilIdGtiSortie 	= dw_1.GetItemNumber ( 1, "ID_GTI" )
		If isNull ( ilIdGtiSortie ) Then  ilIdGtiSortie = 0

		ilIdFraSortie 	= dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
		If isNull ( ilIdFraSortie ) Then  ilIdFraSortie = -1

		If ( ilIdProdSortie <> ilIdProdEntree ) OR ( ilIdGtiSortie <> ilIdGtiEntree ) OR &
			( ilIdFraSortie <> ilIdFraEntree ) Then

			Dw_1.TriggerEvent ( "ITEMFOCUSCHANGED" )

		End If

End Choose





end on

on ue_entreronglet011;call w_8_traitement_master::ue_entreronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sa_condition_gar
//* Evenement 		: UE_ENTRERONGLET011
//* Auteur			: V.Capelle
//* Date				: 07/02/1997 09:47:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lecture des valeur de produit de garantie et du 
//*                 type de franchise $$HEX2$$e0002000$$ENDHEX$$l'ouverture de l'onglet 
//*					  garantie 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
ilIdProdEntree = dw_1.GetItemNumber ( 1, "ID_PROD" )
If isNull ( ilIdProdEntree ) Then  ilIdProdEntree = 0

ilIdGtiEntree 	= dw_1.GetItemNumber ( 1, "ID_GTI" )
If isNull ( ilIdGtiEntree ) Then  ilIdGtiEntree = 0

ilIdFraEntree = dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
If isNull ( ilIdFraEntree ) Then  ilIdFraEntree = -1
end on

on ue_droitecriture;call w_8_traitement_master::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_garantie
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
//* Commentaires  : 
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

PictureButton TbPict []

TbPict[1] = pb_controler
TbPict[2] = pb_supprimer

F_Droit_Ecriture_Param ( tbPict, "" )


end on

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerInserer
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 16:41:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------
Boolean		bRet		//Valeur de retour de la fonction

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


bRet = iUoGsGarantie.uf_PreparerInserer ()

This.Title = "Cr$$HEX1$$e900$$ENDHEX$$ation d'une garantie."

ilIdProd = 0
ilIdRev  = -2
ilIdGti  = 0

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise les DW de d$$HEX1$$e900$$ENDHEX$$lais, plafonds, franchises refus et  */
/* pi$$HEX1$$e900$$ENDHEX$$ces.                                                          */
/*------------------------------------------------------------------*/
Dw_Piece.Reset ()
Dw_Refus.Reset ()
Dw_Plafond.Reset ()
Dw_Franchise.Reset ()
Dw_Delai.Reset ()




/*------------------------------------------------------------------*/
/* Initialisation des cartes affili$$HEX1$$e900$$ENDHEX$$es                              */
/*------------------------------------------------------------------*/
iUoGsAffilier.Uf_InitCartes ()

/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR LES CONDITIONS POUR LA GARANTIE.          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans la Dw_Recherche.                  */
/*------------------------------------------------------------------*/
Uo_Condition.Uf_DwRechercheRetrieve ( "", Uo_Condition )

Uo_Condition.Dw_Recherche.RowsCopy  ( 1 , Uo_Condition.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                				Uo_Condition.Dw_Cible , 1 , PRIMARY!  )

/*------------------------------------------------------------------*/
/* Populise les informations dans la Dw_Source.                     */
/*------------------------------------------------------------------*/
Uo_Condition.uf_dwSourceRetrieve ( "", Uo_Condition )

uo_Onglets.uf_ChangerOnglet ( "01" )	

Dw_1.SetItem ( 1, "COD_TYP_FRA", 0 )

Return ( bRet )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 10:02:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la modification d'une garantie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
Boolean				bRet					//Valeur de retour
Long					lNumGti				//N$$HEX2$$b0002000$$ENDHEX$$de ligne o$$HEX2$$f9002000$$ENDHEX$$est positionn$$HEX1$$e900$$ENDHEX$$e la garantie 			
Long					lNumProd				//N$$HEX2$$b0002000$$ENDHEX$$de ligne o$$HEX2$$f9002000$$ENDHEX$$est positionn$$HEX1$$e900$$ENDHEX$$e le produit 			

DataWindowChild	DwcGarantie			// DDDW de la garantie
DataWindowChild	DwcProduit			// DDDW du produit

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

ilIdProd = istPass.lTab[1]
ilIdRev  = istPass.lTab[2]
ilIdGti  = istPass.lTab[3]

SetPointer ( HourGlass! )

bRet = iUoGsGarantie.uf_PreparerModifier ( ilIdProd, ilIdRev, ilIdGti )

/*----------------------------------------------------------------------------*/
/* Si tout est ok on change le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre en fonction de la          */
/* garantie.                                                                  */
/*----------------------------------------------------------------------------*/
If istPass.bInsert Then

		isLibGti = ""

Else

		Dw_1.GetChild ( "ID_GTI", DwcGarantie  )
		lNumGti  = DwcGarantie.Find  ( "ID_GTI = " + String  ( ilIdGti  ) , 1 , DwcGarantie.RowCount ( ) )
		Dw_1.GetChild ( "ID_PROD", DwcProduit  )
		lNumProd = DwcProduit.Find   ( "ID_PROD = " + String ( ilIdProd ) , 1 , DwcProduit.RowCount ( ) )


		isLibGti	= "Produit "  + DwcProduit.GetItemString ( lNumProd , "LIB_LONG" ) + " - " + &
					  "R$$HEX1$$e900$$ENDHEX$$vision " + String ( ilIdrev ) + " - " 										  + &
					  "Garantie " + DwcGarantie.GetItemString ( lNumGti , "LIB_GTI"  ) + "."

		This.Title 	= "Modification de garantie - " + isLibGti		

End If

/*------------------------------------------------------------------*/
/* Initialisation des cartes affili$$HEX1$$e900$$ENDHEX$$es                              */
/*------------------------------------------------------------------*/
iuoGsAffilier.Uf_InitCartes ( )

/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR LES CONDITIONS POUR LA GARANTIE.          */
/*------------------------------------------------------------------*/
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
/* Pr$$HEX1$$e900$$ENDHEX$$pare les datawindows relatives aux pi$$HEX1$$e800$$ENDHEX$$ces, aux motifs de      */
/* refus, $$HEX2$$e0002000$$ENDHEX$$la v$$HEX1$$e900$$ENDHEX$$tust$$HEX1$$e900$$ENDHEX$$, aux d$$HEX1$$e900$$ENDHEX$$lais, aux franchises et aux plafonds  */
/* d'une garantie.                                                  */
/*------------------------------------------------------------------*/
Dw_Piece.Retrieve    	( istPass.lTab[1], istPass.lTab[2], istPass.lTab[3] )
Dw_Refus.Retrieve 		( istPass.lTab[1], istPass.lTab[2], istPass.lTab[3] )
Dw_Plafond.Retrieve  	( istPass.lTab[1], istPass.lTab[2], istPass.lTab[3] )
Dw_Franchise.Retrieve	( istPass.lTab[1], istPass.lTab[2], istPass.lTab[3] )
Dw_Delai.Retrieve    	( istPass.lTab[1], istPass.lTab[2], istPass.lTab[3] )

uo_Onglets.uf_ChangerOnglet ( "01" )	

SetPointer ( Arrow! )

Return ( bRet )
end function

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerabandonner
//* Auteur			:	La Recrue
//* Date				:	15/07/97 15:09:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de demander la confirmation d'abandon de saisie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	True, ue_retour peut continuer.
//*
//*-----------------------------------------------------------------

stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des garanties"
stMessage.Bouton	= YesNo!
stMessage.Icon		= Exclamation!
stMessage.sVar[1] = "de la garantie"
stMessage.sCode	= "CONF002"

Return ( f_Message ( stMessage ) = 1 )

end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_ControlerSaisie
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 15:43:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la gestion des garanties
//* Commentaires	:	
//*
//* Arguments		:	Aucun 
//*
//* Retourne		:	String	"" Si contr$$HEX1$$f400$$ENDHEX$$les Ok 
//*									Nom de la colonne manquante sinon
//*															  	
//*
//*-----------------------------------------------------------------
String		sPos	= ""		//Valeur de retour de la fonction

/*----------------------------------------------------------------------------*/
/* Appel de la fonction wf_AcceptText dans le cas o$$HEX2$$f9002000$$ENDHEX$$l'on est sur un onglet   */
/* comportant une zon saisissable.                                            */
/*----------------------------------------------------------------------------*/
wf_AcceptText()

/*----------------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la garantie.                                       */
/*----------------------------------------------------------------------------*/
sPos = iuoZnGarantie.uf_Zn_ControlerSaisie ()

If sPos = "" Then

	/*----------------------------------------------------------------------------*/
	/* Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour les cartes affili$$HEX1$$e900$$ENDHEX$$es.                              */
	/*----------------------------------------------------------------------------*/
	sPos = iuoGsAffilier.uf_ControlerSaisie ()

	If sPos = "" Then

	Else
	
		uo_Onglets.uf_ChangerOnglet ( "06" )
		wf_Changer_Controle ( uo_Affilier.Dw_Source ) 

	End If

Else 

	uo_Onglets.uf_ChangerOnglet ( "01" )		

End If

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 15:34:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion des garanties
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------
Boolean		bRet		//Valeur de retour de la fonction de contr$$HEX1$$f400$$ENDHEX$$le de gestion

String		sPos		//Valeur de retour de la fonction
Long			lIdProd	//Identifiant du produit
Long			lIdRev	//Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision
Long			lIdGti	//Identifiant de la garantie


/*----------------------------------------------------------------------------*/
/* Si on est en insertion on v$$HEX1$$e900$$ENDHEX$$rifie que l'identifiant n'existe pas d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.     */
/*----------------------------------------------------------------------------*/
If istPass.bInsert Then

	lIdProd	=	Dw_1.GetItemNumber ( 1, "ID_PROD" )
	lIdRev	=	Dw_1.GetItemNumber ( 1, "ID_REV"  )
	lIdGti	=	Dw_1.GetItemNumber ( 1, "ID_GTI"  )

	bRet = iUoGsGarantie.uf_Gs_Id_Garantie ( lIdProd, lIdRev, lIdGti )

	If ( bRet = False ) Then sPos = "ID_GTI"
	Uo_Onglets.uf_ChangerOnglet ( "01" )

End If
sPos = iUoGsGarantie.uf_Gs_Id_Prefixe()
if sPos <> "" then Uo_Onglets.uf_ChangerOnglet ( "01" ) // [DCMP070914]

Uo_Condition.Dw_Source.SetFilter ( "" )
Uo_Condition.Dw_Source.Filter    (  )

Return ( sPos )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 17:07:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression d'une
//*						garantie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en		Vrai si la suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean		bRet		//Valeur de retour
		
bRet = iuoGsGarantie.uf_PreparerSupprimer ()

Return ( bRet )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_TerminerValider
//* Auteur			:	V.Capelle
//* Date				:	07/11/1997 10:29:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Mise $$HEX2$$e0002000$$ENDHEX$$jour des datawindows portant sur les 
//*						tables d$$HEX1$$e900$$ENDHEX$$pendant de la table garantie et validation 
//*						ou non de la trace suivant le r$$HEX1$$e900$$ENDHEX$$sultat final.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
Boolean	bRet 				// Valeur de retour

Long 		lIdProd 			// Produit pour la garantie
Long 		lIdPolice 		// Police pour la garantie

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour de la table AFFILIER.                                          */
/*----------------------------------------------------------------------------*/
bRet = iuoGsAffilier.uf_TerminerValider ()

If ( bRet ) Then

	/*----------------------------------------------------------------------------*/
	/* Mise $$HEX2$$e0002000$$ENDHEX$$jour de la table CONDITION.                                         */
	/*----------------------------------------------------------------------------*/
	bRet = iuoGsCondition.uf_TerminerValider ()

	If bRet  Then		

		/*----------------------------------------------------------------------------*/
		/* Mise $$HEX2$$e0002000$$ENDHEX$$jour des tables PLAFOND, DELAI et FRANCHISE.                        */
		/*----------------------------------------------------------------------------*/
		bRet = wf_Valider_Detail ()


		/*----------------------------------------------------------------------------*/
		/* Mise $$HEX2$$e0002000$$ENDHEX$$jour de la table PRODUIT pour la police.                            */
		/*----------------------------------------------------------------------------*/
		If bRet Then

			lIdProd 		= Dw_1.GetItemNumber ( 1, "ID_PROD" )
			lIdPolice 	= Dw_1.GetItemNumber ( 1, "ID_POLICE" )

			itrTrans.IM_U01_PRODUIT ( lIdProd, lIdPolice )

			If itrTrans.SQLCode <> 0 Then bRet = False

		End If
	
	End If  

End If



/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$sactive le mode d'incr$$HEX1$$e900$$ENDHEX$$mentation autonome de la trace.         */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_ModeIncAutonome 	( FALSE )

/*------------------------------------------------------------------*/
/* Si tout est OK, on peut Valider la trace, sinon on l'annule.     */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace 		( bRet  )

Return ( bRet )

end function

public subroutine wf_modifier_uo_condition (string asidtypcode);//*-----------------------------------------------------------------
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

public subroutine wf_reinitialiser_parametre ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_Reinitialiser_Parametre
//* Auteur			:	V.Capelle
//* Date				:	14/11/1997 16:49:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	R$$HEX1$$e900$$ENDHEX$$initialise toutes les conditions de garantie
//*						suite $$HEX2$$e0002000$$ENDHEX$$une modification de la garantie ou du produit.
//* Commentaires	:	
//*
//* Arguments		:	
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$initialisation des datawindows li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail.             */
/*----------------------------------------------------------------------------*/
Dw_Plafond.Reset 		()
Dw_Delai.Reset 		()
Dw_Franchise.Reset 	()
Dw_Piece.Reset 		()
Dw_Refus.Reset 		()

/*----------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$initialisation des datawindows li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre des garanties          */
/*----------------------------------------------------------------------------*/

Dw_1.SetItem ( 1, "ALT_FRAN", "N" )
Dw_1.SetItem ( 1, "ALT_PLAF", "N" )
Dw_1.SetItem ( 1, "ALT_DEL", "N" )

wf_populise_onglet ()
end subroutine

public function boolean wf_valider_detail ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_valider_detail
//* Auteur			:	V.Capelle
//* Date				:	21/11/1997 11:46:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Validation des d$$HEX1$$e900$$ENDHEX$$lais, plafonds, franchise, pi$$HEX1$$e800$$ENDHEX$$ces
//*						et refus.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
Boolean	bRet = True


If ( Dw_Piece.Update() <> -1 ) Then

	If ( Dw_Refus.Update() <> -1 ) Then

			If ( Dw_Plafond.Update() <> -1 ) Then 

				If ( Dw_Franchise.Update() <> -1 ) Then 

					If ( Dw_Delai.Update() = -1 ) Then  bRet = False

				Else

					bRet = False

				End If
 
			Else

				bRet = False

			End If
	Else

		bRet = False

	End If

Else 

	bRet = False

End If

Return ( bRet )
	

end function

public subroutine wf_populise_onglet ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_populise_onglet
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 14:30:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Instanciation des datatawindows des diff$$HEX1$$e900$$ENDHEX$$rents 
//*						onglets 
//* 
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Les datawindows relatives aux conditions de garantie $$HEX1$$e900$$ENDHEX$$tant       */
/* populis$$HEX1$$e900$$ENDHEX$$es en fonction du produit, de la r$$HEX1$$e900$$ENDHEX$$vision et de la       */
/* garantie les variables d'instances correspondantes doivent       */
/* toujours $$HEX1$$ea00$$ENDHEX$$tre renseign$$HEX1$$e900$$ENDHEX$$es:                                       */
/* - dans le cas d'une modification, par les valeurs pass$$HEX1$$e900$$ENDHEX$$es        */
/*   en param$$HEX1$$e800$$ENDHEX$$tres.                                                 */
/* - dans le cas d'une cr$$HEX1$$e900$$ENDHEX$$ation, par les valeurs:                   */
/*              .  0      pour le produit                           */
/*              . -2      pour la r$$HEX1$$e900$$ENDHEX$$vision                          */
/*              . -1      pour la garantie                          */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then
	
	ilIdRev			= -2


Else

	ilIdProd			= istPass.lTab [ 1 ]
	ilIdRev			= istPass.lTab [ 2 ]
	ilIdGti			= istPass.lTab [ 3 ]

End If

/*----------------------------------------------------------------------------*/
/* Permet de populiser les informations des Datawindows de Recherche et de    */
/* source pour les conditions de garantie.                                    */
/*----------------------------------------------------------------------------*/
Uo_Condition.Uf_dwRechercheRetrieve ( "", Uo_Condition )
Uo_Condition.Uf_dwSourceRetrieve 	( "", Uo_Condition )



end subroutine

public function boolean wf_accepttext ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_acceptText
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/97 14:30:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$clenche les AcceptText sur toutes les DW pour valider les saisies.
//* Commentaires	:  Cette fonction existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$dans l'anc$$HEX1$$ea00$$ENDHEX$$tre.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Le ChangerOnglet 01 d$$HEX1$$e900$$ENDHEX$$clenchera le "quitteronglet", de l'onglet courant.   */
/* Ainsi si on se trouve par exemple sur l'onglet des Ets, le                 */
/* quitteronglet051 se d$$HEX1$$e900$$ENDHEX$$clenchera et un AccepText partira pour les Ets.      */
/* Idem pour les courriers, les garanties.                                    */
/*----------------------------------------------------------------------------*/

Uo_Onglets.Uf_ChangerOnglet ( "01" )
Dw_1.AcceptText ()
Return ( True )

end function

public subroutine wf_reinitialiser_franchise ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_Reinitialiser_Franchise
//* Auteur			:	V.Capelle
//* Date				:	03/12/1997 14:16:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Supprime les franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es dans le cas o$$HEX1$$f900$$ENDHEX$$
//*						l'on modifie le code type franchise au niveau de 
//*						la garantie et qu'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$des franchises 
//*						diff$$HEX1$$e900$$ENDHEX$$rentes param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es pour la garantie ou un type 
//*						de condition de garantie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
Decimal {0} 	dcIdFranchiseExistante	// Type de franchise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e pour la garantie
Long 				lNbFranchise				// Nombre de franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Long				lNbCondition				// Nombre de conditions avec franchise.
Long				lCpt							// Compteur pour la suppression des franchise
String			sIdNivFra					// Type d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur lequel sont param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es les 
													// franchises
String			sFiltre						// Filtre utilis$$HEX2$$e9002000$$ENDHEX$$pour les conditions de garanties.

lNbFranchise = Dw_Franchise.RowCount ()

If lNbFranchise > 0 Then

	dcIdFranchiseExistante = Dw_Franchise.GetItemNumber ( 1, "ID_TYP_FRA" )

	/*----------------------------------------------------------------------------*/
	/* Si le type de franchise saisi est diff$$HEX1$$e900$$ENDHEX$$rents du type de celle(s) d$$HEX1$$e900$$ENDHEX$$j$$HEX7$$e000200020002000200020002000$$ENDHEX$$*/
	/* param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e(s), on demande la confirmation avant de supprimer les           */
	/* franchises d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                                */
	/*----------------------------------------------------------------------------*/
 	If Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" ) <> dcIdFranchiseExistante Then
		stMessage.sTitre = "Modification du type de franchise."
		stMessage.Bouton = OkCancel!
		stMessage.Icon   = Question!
		stMessage.sCode  = "CONF006"

		/*----------------------------------------------------------------------------*/
		/* Si on a la confirmation pour la modification, on remet les champs ALT_FRA  */
		/* $$HEX2$$e0002000$$ENDHEX$$non pour les conditions ou la garantie suivant le cas, puis on supprime  */
		/* les franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                                */
		/*----------------------------------------------------------------------------*/
		If ( f_Message ( stMessage ) = 1 ) Then

			sIdNivFra = Dw_Franchise.GetItemString ( 1, "ID_NIV_FRA" )
			
			Choose Case sIdNivFra

				Case "XX"

					Dw_1.SetItem ( 1, "ALT_FRAN", 'N' )				

	
				Case Else

					sFiltre	 = "ALT_FRAN = 'O' AND ID_TYP_CODE = '" + sIdNivFra + "'"
					uo_condition.Dw_Source.SetFilter ( sFiltre )
					uo_condition.Dw_Source.Filter ( )
					lNbCondition = uo_condition.Dw_Source.RowCount ( )

					For lCpt = 1 To lNbCondition

						uo_condition.Dw_Source.SetItem ( lCpt, "ALT_FRAN", 'N' )				

					Next
					
					sFiltre = ""
					uo_condition.Dw_Source.SetFilter ( sFiltre )
					uo_condition.Dw_Source.Filter ( )

			End Choose

	
			/*----------------------------------------------------------------------------*/
			/* Suppression des franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                    */
			/*----------------------------------------------------------------------------*/
			For lCpt = 1 To lNbFranchise
	
				Dw_Franchise.DeleteRow ( 0 )				
							
			Next

		/*----------------------------------------------------------------------------*/
		/* Si l'op$$HEX1$$e900$$ENDHEX$$ration n'est pas confirm$$HEX1$$e900$$ENDHEX$$e on replace au niveau de la garantie,    */
		/* le type de franchise correspondant aux franchises d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.        */
		/*----------------------------------------------------------------------------*/
		Else

			Dw_1.SetItem ( 1, "COD_TYP_FRA", dcIdFranchiseExistante )

		End If
	
	End If

End If
end subroutine

public subroutine wf_reinitialiser_franchise (long alcodtypfra);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_Reinitialiser_Franchise
//* Auteur			:	V.Capelle
//* Date				:	03/12/1997 14:16:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Supprime les franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es dans le cas o$$HEX1$$f900$$ENDHEX$$
//*						l'on modifie le code type franchise au niveau de 
//*						la garantie et qu'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$des franchises 
//*						diff$$HEX1$$e900$$ENDHEX$$rentes param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es pour la garantie ou un type 
//*						de condition de garantie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
Decimal {0} 	dcIdFranchiseExistante	// Type de franchise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e pour la garantie
Long 				lNbFranchise				// Nombre de franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Long				lNbCondition				// Nombre de conditions avec franchise.
Long				lCpt							// Compteur pour la suppression des franchise
String			sIdNivFra					// Type d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment sur lequel sont param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es les 
													// franchises
String			sFiltre						// Filtre utilis$$HEX2$$e9002000$$ENDHEX$$pour les conditions de garanties.

lNbFranchise = Dw_Franchise.RowCount ()

If lNbFranchise > 0 Then

	dcIdFranchiseExistante = Dw_Franchise.GetItemNumber ( 1, "ID_TYP_FRA" )

	/*----------------------------------------------------------------------------*/
	/* Si le type de franchise saisi est diff$$HEX1$$e900$$ENDHEX$$rents du type de celle(s) d$$HEX1$$e900$$ENDHEX$$j$$HEX7$$e000200020002000200020002000$$ENDHEX$$*/
	/* param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e(s), on demande la confirmation avant de supprimer les           */
	/* franchises d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                                */
	/*----------------------------------------------------------------------------*/
 	If alCodTypFra <> dcIdFranchiseExistante Then
		stMessage.sTitre = "Modification du type de franchise."
		stMessage.Bouton = OkCancel!
		stMessage.Icon   = Question!
		stMessage.sCode  = "CONF006"

		/*----------------------------------------------------------------------------*/
		/* Si on a la confirmation pour la modification, on remet les champs ALT_FRA  */
		/* $$HEX2$$e0002000$$ENDHEX$$non pour les conditions ou la garantie suivant le cas, puis on supprime  */
		/* les franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                                */
		/*----------------------------------------------------------------------------*/
		If ( f_Message ( stMessage ) = 1 ) Then

			sIdNivFra = Dw_Franchise.GetItemString ( 1, "ID_NIV_FRA" )
			
			Choose Case sIdNivFra

				Case "XX"

					Dw_1.SetItem ( 1, "ALT_FRAN", 'N' )				

	
				Case Else

					sFiltre	 = "ALT_FRAN = 'O' AND ID_TYP_CODE = '" + sIdNivFra + "'"
					uo_condition.Dw_Source.SetFilter ( sFiltre )
					uo_condition.Dw_Source.Filter ( )
					lNbCondition = uo_condition.Dw_Source.RowCount ( )

					For lCpt = 1 To lNbCondition

						uo_condition.Dw_Source.SetItem ( lCpt, "ALT_FRAN", 'N' )				

					Next
					
					sFiltre = ""
					uo_condition.Dw_Source.SetFilter ( sFiltre )
					uo_condition.Dw_Source.Filter ( )

			End Choose

	
			/*----------------------------------------------------------------------------*/
			/* Suppression des franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.                                    */
			/*----------------------------------------------------------------------------*/
			For lCpt = 1 To lNbFranchise
	
				Dw_Franchise.DeleteRow ( 0 )				
							
			Next

		/*----------------------------------------------------------------------------*/
		/* Si l'op$$HEX1$$e900$$ENDHEX$$ration n'est pas confirm$$HEX1$$e900$$ENDHEX$$e on replace au niveau de la garantie,    */
		/* le type de franchise correspondant aux franchises d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es.        */
		/*----------------------------------------------------------------------------*/
		Else

			Dw_1.SetItem ( 1, "COD_TYP_FRA", dcIdFranchiseExistante )

		End If
	
	End If

End If
end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_tm_sp_garantie
//* Evenement 		:	Ue_Initialiser
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 14:14:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion des 
//*						garanties
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
// #1	JCA	5/5/2008	- DCMP 70914 - Gestion du prefixe assureur
//*-----------------------------------------------------------------

DataWindowChild	DwcProd			// DDDW des produits.
DatawindowChild	DwcRev			// DDDW des r$$HEX1$$e900$$ENDHEX$$visions du produit.
DataWindowChild	DwcGti			// DDDW des codes de garanties.
DataWindowChild	DwcPolice		// DDDW des polices.
DataWindowChild	DwcCodTypFra	// DDDW des codes de type de franchises.
DataWindowChild	DwcPrefixe		// #1 - DDDW des prefixes assureur 

String				sCol [ 6 ]		// Tableau contenant les champs dont 
											// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$

String 				sMod				// Chaine pour le modify

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

DESTROY nvPassageEuro

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] 			= "ID_PROD"
sCol [ 2 ] 			= "ID_REV"
sCol [ 3 ] 			= "ID_GTI"
sCol [ 4 ] 			= "ID_POLICE"
sCol [ 5 ] 			= "COD_RADICAL"
sCol [ 6 ] 			= "ID_PREFIXE" // #1


Dw_1.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Initialisation des Datawindows simples                           */
/*------------------------------------------------------------------*/
Dw_1.uf_SetTransObject 		( iTrTrans )
Dw_Piece.SetTransObject		( iTrTrans )
Dw_Refus.SetTransObject		( iTrTrans )
Dw_Plafond.SetTransObject	( iTrTrans )
Dw_Franchise.SetTransObject( iTrTrans )
Dw_Delai.SetTransObject    ( iTrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des DDDW                                          */
/*------------------------------------------------------------------*/
Dw_1.GetChild ( "ID_PROD"  		, DwcProd  		)
Dw_1.GetChild ( "ID_REV"	 		, DwcRev 		)
Dw_1.GetChild ( "ID_GTI"			, DwcGti 		)
Dw_1.GetChild ( "ID_POLICE"		, DwcPolice	 	)
Dw_1.GetChild ( "COD_TYP_FRA"		, DwcCodTypFra )

DwcProd.SetTransObject 			( iTrTrans )
DwcRev.SetTransObject 			( iTrTrans )
DwcGti.SetTransObject 			( iTrTrans )
DwcPolice.SetTransObject 		( iTrTrans )
DwcCodTypFra.SetTransObject 	( iTrTrans )

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



/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 6, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Garantie"        , "", Dw_1				, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Ev$$HEX1$$e900$$ENDHEX$$nements"		 , "", uo_Condition	, False ) 
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "Natures"         , "", uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "D$$HEX1$$e900$$ENDHEX$$tails"			 , "", uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Territorialit$$HEX1$$e900$$ENDHEX$$s" , "", uo_Condition	, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "06", "Cartes"	   	 , "", uo_Affilier 	, False )


/*----------------------------------------------------------------------------*/
/* Initialisation des users objects de contr$$HEX1$$f400$$ENDHEX$$les de saisie et de gestion.     */
/*----------------------------------------------------------------------------*/
iuoZnGarantie	= CREATE u_sp_Zn_Garantie
iuoGsGarantie	= CREATE u_sp_Gs_Garantie
iuoGsAffilier  = CREATE u_sp_Gs_Affilier		
iuoGsCondition = CREATE u_sp_Gs_Condition		

iuoZnGarantie.uf_Initialisation 	( itrTrans, Dw_1 				)
iuoGsAffilier.uf_Initialisation 	( itrTrans, uo_Affilier 	)
iuoGsGarantie.uf_Initialisation 	( itrTrans, Dw_1 				)
iuoGsCondition.uf_Initialisation ( itrTrans, uo_Condition 	) 

/*------------------------------------------------------------------*/
/* Affection des Dataobjets aux Dw de l'objet concernant les        */
/* cartes affili$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la garantie.                                  */
/*------------------------------------------------------------------*/
Uo_Affilier.Uf_Initialiser ( "d_sp_lst_affilier_rch", "d_sp_gti_affilier", "d_sp_lst_affilier", itrTrans )

/*------------------------------------------------------------------*/
/* Affection des Dataobjets aux Dw de l'objet concernant les        */
/* conditions de garantie.                                          */
/*------------------------------------------------------------------*/
Uo_Condition.Uf_Initialiser ( "d_sp_lst_condition_rch", "d_sp_gti_condition", "d_sp_lst_condition", itrTrans )



/*------------------------------------------------------------------*/
/* Le curseur pour Dw_1 et les conditions indique que l'on peut     */
/* appeler une fenetre par double click.                            */
/*------------------------------------------------------------------*/
sMod	=	"DataWindow.Pointer='K:\PB4OBJ\BMP\DBLCLICK.CUR'"
Dw_1.Modify ( sMod )
Uo_Condition.Dw_Source.Modify ( sMod )
end event

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_tm_sp_garantie
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 14:16:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
String 				sTab			  	// Code tabulation
String				sMajLe		  	// Variable tampon pour MAJ_LE
String				sIdProd		  	// Variable tampon pour ID_PROD
String   			sLibGti      	// Libell$$HEX2$$e9002000$$ENDHEX$$de la garantie
String            sIdGti       	// Variable tampon pour la garantie
String            sIdRev       	// Variable tampon pour la r$$HEX1$$e900$$ENDHEX$$vision

Long              lNumLigneGti 	// No de ligne de la garantie dans la DDDW

DatawindowChild 	dwIdGti		  	// DataWindowChild de la garantie


sTab				=	"~t"

sMajLe			=	String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy hh:mm:ss" )
sIdProd			=	String ( dw_1.GetItemNumber   ( 1, "ID_PROD" ) )
sIdRev			=	String ( dw_1.GetItemNumber   ( 1, "ID_REV"  ) )
sIdGti			=	String ( dw_1.GetItemNumber   ( 1, "ID_GTI"  ) )

/*------------------------------------------------------------------*/
/* Recherche du libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement dans la DDDW.                */
/*------------------------------------------------------------------*/

Dw_1.GetChild ( "ID_GTI", dwIdGti )



lNumLigneGti  =	dwIdGti.Find 				( "ID_GTI = " + sIdGti , 1, dwIdGti.RowCount() )

sLibGti       =	dwIdGti.GetItemString 	( lNumLigneGti, "LIB_GTI" )


isMajAccueil 	=	sIdProd 											+ sTab + &
						sIdRev 											+ sTab + &
						sIdGti 											+ sTab + &
 						sLibGti											+ sTab + &
						sMajLe								 			+ sTab + &
						Dw_1.GetItemString ( 1, "MAJ_PAR"  )

end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_tm_sp_garantie
//* Evenement 		:	Close
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 15:41:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Destruction des users objects de contr$$HEX1$$f400$$ENDHEX$$le de 
//*						saisie et de gestion utilis$$HEX1$$e900$$ENDHEX$$s et fermeture de 
//*						la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes si
//*						besoin.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//DesTroy	iuoZnGarantie
//DesTroy	iuoGsGarantie
//DesTroy	iuoGsAffilier
//DesTroy	iuoGsCondition
If IsValid(iuoZnGarantie) Then DesTroy	iuoZnGarantie
If IsValid(iuoGsGarantie) Then DesTroy	iuoGsGarantie
If IsValid(iuoGsAffilier) Then DesTroy	iuoGsAffilier
If IsValid(iuoGsCondition) Then DesTroy	iuoGsCondition
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si elle est    */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	Close ( W_Consulter_Paragraphe )

End If

/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si elle est    */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_t_sp_Condition_Gti )	Then

	Close ( W_t_sp_Condition_Gti )

End If
end event

on ue_retour;call w_8_traitement_master::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			:	w_tm_sp_garantie
//* Evenement 		:	Ue_Retour
//* Auteur			:	V.Capelle
//* Date				:	10/12/1997 11:14:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX2$$a7002000$$ENDHEX$$si elle 
//*						est toujours ouverte.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si elle est    */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	Close ( W_Consulter_Paragraphe )

End If

end on

on w_tm_sp_garantie.create
int iCurrent
call super::create
this.dw_piece=create dw_piece
this.dw_refus=create dw_refus
this.dw_plafond=create dw_plafond
this.dw_franchise=create dw_franchise
this.dw_delai=create dw_delai
this.uo_bord3d=create uo_bord3d
this.uo_condition=create uo_condition
this.uo_affilier=create uo_affilier
this.uo_onglets=create uo_onglets
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_piece
this.Control[iCurrent+2]=this.dw_refus
this.Control[iCurrent+3]=this.dw_plafond
this.Control[iCurrent+4]=this.dw_franchise
this.Control[iCurrent+5]=this.dw_delai
this.Control[iCurrent+6]=this.uo_bord3d
this.Control[iCurrent+7]=this.uo_condition
this.Control[iCurrent+8]=this.uo_affilier
this.Control[iCurrent+9]=this.uo_onglets
end on

on w_tm_sp_garantie.destroy
call super::destroy
destroy(this.dw_piece)
destroy(this.dw_refus)
destroy(this.dw_plafond)
destroy(this.dw_franchise)
destroy(this.dw_delai)
destroy(this.uo_bord3d)
destroy(this.uo_condition)
destroy(this.uo_affilier)
destroy(this.uo_onglets)
end on

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_garantie
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_garantie
integer x = 498
integer y = 520
integer width = 2395
integer height = 896
string dataobject = "d_sp_garantie"
boolean border = false
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemFocuschanged
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 15:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Met $$HEX2$$e0002000$$ENDHEX$$jour la r$$HEX1$$e900$$ENDHEX$$vision et la garantie quand on modifie le produit.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* [DCMP070914] => Je subodore l'erreur d'impl$$HEX1$$e900$$ENDHEX$$mentation de
//* [DCMP070914] => controle sur saisie. Script g$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$dans
//* [DCMP070914] => l'itemFocusChanged au lieu de l'itemchanged
//* [DCMP070914] => Donc : Essai de d$$HEX1$$e900$$ENDHEX$$port du script dans l'itemchanged
//Long						iVal								//Valeur saisie
//DataWindowChild		dwcRevision						//DDDW de la revision
//DataWindowChild		dwcGarantie						//DDDW de la garantie
//
//SetPointer ( HourGlass! )
//
//Choose Case isNomCol
//
//	Case "ID_PROD"
//		
//		iVal 		= This.GetItemNumber ( 1, isNomCol )
//		ilIdProd = iVal
//		
//		/*------------------------------------------------------------------*/
//		/* le produit $$HEX1$$e900$$ENDHEX$$tant modifi$$HEX1$$e900$$ENDHEX$$, on r$$HEX1$$e900$$ENDHEX$$initialise la r$$HEX1$$e900$$ENDHEX$$vision et la      */
//		/* garantie $$HEX2$$e0002000$$ENDHEX$$null                                                  */
//		/*------------------------------------------------------------------*/
//		SetItem ( 1 , "ID_REV" , stnul.dcm )
//		SetItem ( 1 , "ID_GTI" , stnul.dcm )
//
//
//		/*------------------------------------------------------------------*/
//		/* Initialisation des DDDW pour la revision et la garantie en       */
//		/* fonction du code produit.                                        */
//		/*------------------------------------------------------------------*/
//		GetChild ( "id_rev", dwcRevision )
//		GetChild ( "id_gti", dwcGarantie )
//
//		dwcRevision.SetTransObject ( iTrTrans )
//		dwcRevision.Retrieve ( iVal )
//
//		If dwcRevision.RowCount ( ) < 1 then
//			
//			dwcRevision.InsertRow ( 0 )
//	
//		End if
//
//		dwcGarantie.SetTransObject ( iTrTrans )
//		dwcGarantie.Retrieve ( iVal )
//
//		If dwcGarantie.RowCount ( ) < 1 then
//			
//			dwcGarantie.InsertRow ( 0 )
//	
//		End if
//
//		ilIdGti			= -1
//		wf_Reinitialiser_Parametre ( )
//		Dw_1.isNomCol = ""
//
//	Case "ID_GTI"
//		
//		ilIdGti			= This.GetItemNumber ( 1, isNomCol )
//		wf_Reinitialiser_Parametre ( )
//		Dw_1.isNomCol = ""
//
//	Case "COD_TYP_FRA"
//
//		wf_Reinitialiser_Franchise ()
//		Dw_1.isNomCol = ""
//		
//
//End Choose
//
//SetPointer ( Arrow! )
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_traitement_master::dw_1
//* Evenement 		:	ItemError
//* Auteur			:	JFF
//* Date				:	20/01/1999 17:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des erreurs sur la Dw de Cr$$HEX1$$e900$$ENDHEX$$ation d'une Garantie
//*						
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------


If ibErreur Then

	stMessage.sTitre  = "Cr$$HEX1$$e900$$ENDHEX$$ation d'une Garantie - SIMPA2"
	stMessage.Icon	   = Information!


	Choose Case	isErrCol

		// Gestion d'une erreur sur le code radical
		Case "COD_RADICAL"

			Choose Case iiErreur

				Case 0				// Cas o$$HEX2$$f9002000$$ENDHEX$$l'on ne passe pas la r$$HEX1$$e800$$ENDHEX$$gle de validation
										// (Le code radical doit $$HEX1$$ea00$$ENDHEX$$tre positif )
										
			
					iiReset = 0    // On remet la valeur initiale pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente

					stMessage.sVar[1] = "code radical"
					stMessage.sCode	= "GENE003"

				// #1
				Case 1
		
					iiReset = 0    // On remet la valeur initiale pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
					stMessage.sCode	= "GENE090"
	
			End Choose
			
		// [20161130.FPI]
		Case "ID_PROD"
			iiReset = 0    // On remet la valeur initiale pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
			stMessage.sVar[1] = "produit"
			stMessage.sCode	= "GENE003"
			
	End Choose


	F_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser()
	Return This.Uf_Reinitialiser()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 11:38:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	
//* Commentaires	:	
//*				  
//* MAJ	LE 			PAR	Description
//* 		18/01/1999	JFF	Rajout de la zone Cod Radical
//* #1	11/08/2008	PHG	Correction Bug Id_Prefixe AIG
//*-----------------------------------------------------------------
String		sSqlPreview			// SqlPreview de la datawindow Dw_1.
String		sAltPlaf				// Valeur du champ ALT_PLAF
String		sAltDel				// Valeur du champ ALT_DEL
String		sAltFran				// Valeur du champ ALT_FRAN
String		sMajPar				// Auteur de la mise $$HEX2$$e0002000$$ENDHEX$$jour.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectu$$HEX2$$e9002000$$ENDHEX$$sur la table.
String		sCle [ 3 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			lIdProd				// Identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long			lIdPolice			// Identifiant de la police.
Long			lCodtypFra			// Identifiant du type de franchise.
Long			lCodRadical			// Identifiant du code radical

DateTime		dtCreeLe				// Valeur pour le champs CREE_LE
DateTime		dtMajLe				// Valeur pour le champs MAJ_LE
string		sIdPrefixe			// #1


//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview	= This.GetSQLPreview ()
sSqlPreview	= SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "GARANTIE"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE" 

		lIdProd			= Dw_1.GetItemNumber   ( 1, "ID_PROD"        )
		lIdRev			= Dw_1.GetItemNumber   ( 1, "ID_REV"         )
		lIdGti			= Dw_1.GetItemNumber   ( 1, "ID_GTI"		   )
		lIdPolice		= Dw_1.GetItemNumber   ( 1, "ID_POLICE"	   )
		lCodTypFra		= Dw_1.GetItemNumber   ( 1, "COD_TYP_FRA"    )
		lCodRadical		= Dw_1.GetItemNumber   ( 1, "COD_RADICAL"    )	
		sAltPlaf			= Dw_1.GetItemString   ( 1, "ALT_PLAF"       )
		sAltDel			= Dw_1.GetItemString   ( 1, "ALT_DEL"        )
		sAltFran			= Dw_1.GetItemString   ( 1, "ALT_FRAN"       )
		dtCreeLe			= Dw_1.GetItemDateTime ( 1, "CREE_LE"        )
		dtMajLe			= Dw_1.GetItemDateTime ( 1, "MAJ_LE"         )
		sMajPar			= Dw_1.GetItemString   ( 1, "MAJ_PAR"        )
		sIdPrefixe		= Dw_1.GetItemString   ( 1, "ID_PREFIXE"     ) // #1
		itrTrans.DW_I01_GARANTIE ( lIdProd, 		&
											lIdRev,			& 
											lIdGti, 		   &
											lIdPolice, 	   &
											lCodTypFra, 	&
											lCodRadical,	&
											sAltPlaf,      &
											sAltDel,	      &
											sAltFran,      &
											dtCreeLe, 		&
											dtMajLe, 		&
											sMajPar,			&
											sIdPrefixe ) // #1

		If itrTrans.SqlCode <> 0	Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol  = { "ID_PROD", "ID_REV", "ID_GTI", "ID_POLICE", "COD_TYP_FRA", "COD_RADICAL", "ALT_PLAF", &
                   "ALT_DEL", "ALT_FRAN" }


			sVal [ 1 ]  = "'" + String ( lIdProd       )  + "'"
			sVal [ 2 ]  = "'" + String ( lIdRev        )  + "'"
			sVal [ 3 ]  = "'" + String ( lIdGti        )  + "'"
			sVal [ 4 ]  = "'" + String ( lIdPolice     )  + "'"
			sVal [ 5 ]  = "'" + String ( lCodTypFra    )  + "'"
			sVal [ 6 ]  = "'" + String ( lCodRadical    )  + "'"
			sVal [ 7 ]  = "'" + sAltPlaf + "'"
			sVal [ 8 ]  = "'" + sAltDel  + "'"
			sVal [ 9 ]  = "'" + sAltFran + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA"

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) + "'"
		sCle [ 2 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_REV"  ) ) + "'"
		sCle [ 3 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_GTI"  ) ) + "'"

		sType = 'U'


		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_1.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		lIdProd			= Dw_1.GetItemNumber ( 1, "ID_PROD", DELETE!, False 	)
		lIdRev			= Dw_1.GetItemNumber ( 1, "ID_REV" , DELETE!, False	)
		lIdGti			= Dw_1.GetItemNumber ( 1, "ID_GTI" , DELETE!, False	)

		itrTrans.dw_d01_garantie ( lIdProd, lIdRev, lIdGti )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"

			sType = 'D'
	
			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::doubleclicked;call w_8_traitement_master`dw_1::doubleclicked;//*-----------------------------------------------------------------
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

TriggerEvent ( Parent, "Ue_QuitterOnglet011" )


stPass.trTrans 		= istPass.trTrans
stPass.wParent			= Parent.Parentwindow()
stPass.bEnableParent	= False

stPass.lTab [ 1 ] = ilIdProd 
stPass.lTab [ 2 ] = ilIdGti  
stPass.lTab [ 3 ] = Dw_1.GetItemNumber ( 1, "ID_REV" ) 
stPass.lTab [ 4 ] = -1
stPass.lTab [ 5 ] = 1
stPass.lTab [ 6 ] = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )

stPass.sTab [ 1 ] = "-GA"


/*----------------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre n'est pas encore ouverte on effectue son ouverture en lui    */
/* passant des param$$HEX1$$ea00$$ENDHEX$$tres pour instancier ses variables d'instance, sinon on  */
/* met directement $$HEX2$$e0002000$$ENDHEX$$jour celles-ci et on rend la fen$$HEX1$$ea00$$ENDHEX$$tre visible simplement. */
/*----------------------------------------------------------------------------*/
If isValid ( W_t_sp_Condition_Gti )	= False	Then

	OpenWithParm ( W_t_sp_Condition_Gti, stPass, stPass.wParent )

Else

	W_t_sp_Condition_Gti.idcIdProd    = ilIdProd
	W_t_sp_Condition_Gti.idcIdGti     = ilIdGti
	W_t_sp_Condition_Gti.idcIdRev     = Dw_1.GetItemNumber ( 1, "ID_REV"      )
	W_t_sp_Condition_Gti.idcIdCode    = -1
	W_t_sp_Condition_Gti.isIdTypCode  = "-GA"
	W_t_sp_Condition_Gti.ilLigMaster  = 1
	W_t_sp_Condition_Gti.idcIdTypFra	 = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
	W_t_sp_Condition_Gti.Show ()

End If

/*----------------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du titre si l'on conna$$HEX1$$ee00$$ENDHEX$$t la garantie.                          */
/*----------------------------------------------------------------------------*/
If isLibGti <> "" Then

	W_t_sp_Condition_Gti.Title = "Gestion de la garantie " + isLibGti

Else

	W_t_sp_Condition_Gti.Title = "Gestion de garantie "

End If


end on

on dw_1::dberror;call w_8_traitement_master`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1
//* Evenement 		: dberror
//* Auteur			: V.Capelle
//* Date				: 20/11/97 14:29:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: En cas d'erreur base, on ne valide pas la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
UoGsTrace.Uf_ModeIncAutonome 	( False )
UoGsTrace.Uf_CommitTrace 		( False )
end on

event dw_1::buttonclicking;call super::buttonclicking;
//*-----------------------------------------------------------------
//* Objet 			: w_tm_sp_garantie::dw_1
//* Evenement 		: buttonclicking
//* Auteur			: JCA
//* Date				: 30/04/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: DCMP 70914 - Prefixe assureur
//*-----------------------------------------------------------------

integer iAction

iAction = 0

choose case dwo.name 
	case "b_aide_aig"
		stMessage.sTitre	= "Aide - Pr$$HEX1$$e900$$ENDHEX$$fixe assureur"
		stMessage.sCode 	= n_cst_protocole_aig_param_gti.k_msg_boutonaide
		stMessage.icon 	= Information!
		stMessage.bErreurg= TRUE

		F_Message ( stMessage )

end choose

return iAction


end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemChaned => Reprise de l'ItemFocuschanged
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 15:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Met $$HEX2$$e0002000$$ENDHEX$$jour la r$$HEX1$$e900$$ENDHEX$$vision et la garantie quand on modifie le produit.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* [DCMP070914] => Reprise de l'itemFocusChanged
// 	FPI	30/11/2016		[20161030.FPI] Am$$HEX1$$e900$$ENDHEX$$lioration saisie produit
//*-----------------------------------------------------------------

//Long						iVal								//Valeur saisie
DataWindowChild		dwcRevision						//DDDW de la revision
DataWindowChild		dwcGarantie						//DDDW de la garantie
DataWindowChild		dwChild							// [20161030.FPI] 
SetPointer ( HourGlass! )

Choose Case upper(dwo.name)

	Case "ID_PROD"
		
		ilIdProd = long(data)
		
		// [20161030.FPI] 
		this.getchild("id_prod",dwChild)
		if dwChild.find( "id_prod=" + string(ilIdProd), 1,dwChild.RowCount()) <=0 Then
			// Erreur
			Return 1
		end if
		
		/*------------------------------------------------------------------*/
		/* le produit $$HEX1$$e900$$ENDHEX$$tant modifi$$HEX1$$e900$$ENDHEX$$, on r$$HEX1$$e900$$ENDHEX$$initialise la r$$HEX1$$e900$$ENDHEX$$vision et la      */
		/* garantie $$HEX2$$e0002000$$ENDHEX$$null                                                  */
		/*------------------------------------------------------------------*/
		SetItem ( 1 , "ID_REV" , stnul.dcm )
		SetItem ( 1 , "ID_GTI" , stnul.dcm )


		/*------------------------------------------------------------------*/
		/* Initialisation des DDDW pour la revision et la garantie en       */
		/* fonction du code produit.                                        */
		/*------------------------------------------------------------------*/
		GetChild ( "id_rev", dwcRevision )
		GetChild ( "id_gti", dwcGarantie )

		dwcRevision.SetTransObject ( iTrTrans )
		dwcRevision.Retrieve ( ilIdProd )

		If dwcRevision.RowCount ( ) < 1 then
			
			dwcRevision.InsertRow ( 0 )
	
		End if

		dwcGarantie.SetTransObject ( iTrTrans )
		dwcGarantie.Retrieve ( ilIdProd )

		If dwcGarantie.RowCount ( ) < 1 then
			
			dwcGarantie.InsertRow ( 0 )
	
		End if

		ilIdGti			= -1
		wf_Reinitialiser_Parametre ( )
		Dw_1.isNomCol = ""

	Case "ID_GTI"
		
		ilIdGti			= long(data)
		wf_Reinitialiser_Parametre ( )
		Dw_1.isNomCol = ""

	Case "COD_TYP_FRA"

		wf_Reinitialiser_Franchise (long(data))
		Dw_1.isNomCol = ""

	Case "ID_POLICE" // [DCMP070914]
		Dw_1.object.id_prefixe[row] = stnul.str
		iuogsgarantie.uf_synchro_prefixe( long(data), row)
		

End Choose

SetPointer ( Arrow! )
end event

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_garantie
boolean visible = false
integer x = 2199
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_garantie
integer x = 27
integer y = 20
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_garantie
integer y = 20
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_garantie
boolean visible = false
integer y = 32
integer width = 242
integer height = 144
integer taborder = 0
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_garantie
integer y = 20
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_garantie
integer y = 20
integer width = 242
integer height = 144
integer taborder = 110
end type

type dw_piece from datawindow within w_tm_sp_garantie
boolean visible = false
integer x = 3072
integer width = 1815
integer height = 276
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_sp_gti_piece"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Piece
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	19/11/1997 11:07:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions et modification
//*                  dans la table PIECE.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long 			lIdPce				// Identifiant de la pi$$HEX1$$e800$$ENDHEX$$ce

Decimal{0}	dcCptTri				// Compteur de tri

dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sIdPara				// Paragraphe associ$$HEX4$$e9002000e0002000$$ENDHEX$$la pi$$HEX1$$e800$$ENDHEX$$ce
String		sCodTypPce			// Type de pi$$HEX1$$e800$$ENDHEX$$ce
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 7 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 7 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM

DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql 	  = Dw_Piece.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable  = "PIECE"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Piece.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		lIdPce 		= Dw_Piece.GetItemNumber ( lLig , "ID_PCE"  		)
		sIdPara	 	= Dw_Piece.GetItemString ( lLig , "ID_PARA"		)
		sCodTypPce	= Dw_Piece.GetItemString ( lLig , "COD_TYP_PCE"	)
		dcCptTri		= Dw_Piece.GetItemNumber ( lLig , "CPT_TRI" 		)

		itrTrans.DW_I01_PIECE ( 	lIdProd, 	&
											lIdRev,  	&
											lIdGti,  	&
											lIdPce,		&
											sIdPara, 	&
											sCodTypPce, &
											dtMajLe, 	&
											dtMajLe, 	&
										 	stGlb.sCodOper, &
											dcCptTri )			


		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_PCE", "ID_PARA", "COD_TYP_PCE", "CPT_TRI"   }

			sVal[ 1 ]   = "'" + String ( lIdProd ) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  ) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti  ) + "'"
	      sVal[ 4 ]   = "'" + String ( lIdPce  ) + "'"
   	   sVal[ 5 ]   = "'" + sIdPara + "'"
			sVal[ 6 ]   = "'" + sCodTypPce + "'"
			sVal[ 7 ]   = "'" + String ( dcCptTri ) + "'"


			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		lIdPce 		= Dw_Piece.GetItemNumber ( lLig , "ID_PCE"  		)
		sIdPara	 	= Dw_Piece.GetItemString ( lLig , "ID_PARA"		)
		sCodTypPce	= Dw_Piece.GetItemString ( lLig , "COD_TYP_PCE"	)
		dcCptTri		= Dw_Piece.GetItemNumber ( lLig , "CPT_TRI" 		)

		itrTrans.DW_U01_PIECE ( 	lIdProd, 	&
											lIdRev,  	&
											lIdGti,  	&
											lIdPce,		&
											sIdPara, 	&
											sCodTypPce, &
											dtMajLe, 	&
										 	stGlb.sCodOper, &
											dcCptTri )			

		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
			sCle [ 4 ]	= "'" + String ( lIdPce  ) + "'"


			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer ( Dw_Piece, lLig, "ID_PCE", dwBuf, False	)


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Piece.SetActionCode ( iActionCode )
ll_ret = iActionCode
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_refus from datawindow within w_tm_sp_garantie
boolean visible = false
integer x = 3072
integer y = 304
integer width = 1815
integer height = 252
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_sp_gti_refus"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Refus
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	20/11/1997 14:07:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions et modification
//*                  dans la table REFUS.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long 			lIdMotif				// Identifiant du motif

Decimal{0}	dcCptTri				// Compteur de tri

dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sIdPara				// Paragraphe associ$$HEX4$$e9002000e0002000$$ENDHEX$$la pi$$HEX1$$e800$$ENDHEX$$ce
String		sCodTypMotif		// Type de motif
String		sCodNatMotif		// Nature du motif
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 8 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 8 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM

DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Dw_Refus.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "MOTIF"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Refus.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		lIdMotif 	 = Dw_Refus.GetItemNumber ( lLig , "ID_MOTIF"		)
		sIdPara	 	 = Dw_Refus.GetItemString ( lLig , "ID_PARA"		   )
		sCodTypMotif = Dw_Refus.GetItemString ( lLig , "COD_TYP_MOTIF"	)
		sCodNatMotif = Dw_Refus.GetItemString ( lLig , "COD_NAT_MOTIF"	)
		dcCptTri		 = Dw_Refus.GetItemNumber ( lLig , "CPT_TRI"			)

		itrTrans.DW_I01_MOTIF ( 	lIdProd, 	  &
											lIdRev,  	  &
											lIdGti,  	  &
											lIdMotif,	  &
											sIdPara, 	  &
											sCodTypMotif, &
											sCodNatMotif, &
											dtMajLe,      &
											dtMajLe, 	  &
										 	stGlb.sCodOper, &
											dcCptTri )			


		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_MOTIF", "ID_PARA", "COD_TYP_MOTIF", &
                  "COD_NAT_MOTIF", "CPT_TRI"   }

			sVal[ 1 ]   = "'" + String ( lIdProd 	) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  	) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti    ) + "'"
	      sVal[ 4 ]   = "'" + String ( lIdMotif  ) + "'"
   	   sVal[ 5 ]   = "'" + sIdPara + "'"
			sVal[ 6 ]   = "'" + sCodTypMotif + "'"
			sVal[ 7 ]   = "'" + sCodNatMotif + "'"
			sVal[ 8 ]   = "'" + String ( dcCptTri ) + "'"


			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		lIdMotif			= Dw_Refus.GetItemNumber ( lLig , "ID_MOTIF"			)
		sIdPara	 		= Dw_Refus.GetItemString ( lLig , "ID_PARA"			)
		sCodTypMotif	= Dw_Refus.GetItemString ( lLig , "COD_TYP_MOTIF"	)
		sCodNatMotif	= Dw_Refus.GetItemString ( lLig , "COD_NAT_MOTIF"	)
		dcCptTri			= Dw_Refus.GetItemNumber ( lLig , "CPT_TRI"			)

		itrTrans.DW_U01_MOTIF ( 	lIdProd, 	  &
											lIdRev,  	  &
											lIdGti,  	  &
											lIdMotif,	  &
											sIdPara, 	  &
											sCodTypMotif, &
											sCodNatMotif, &
											dtMajLe, 	  &
										 	stGlb.sCodOper, &
											dcCptTri )			

		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd   ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev    ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti    ) + "'"
			sCle [ 4 ]	= "'" + String ( lIdMotif  ) + "'"


			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer    ( Dw_Refus, lLig, "ID_MOTIF", dwBuf, False	)


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Refus.SetActionCode ( iActionCode )
ll_ret = iActionCode
Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_plafond from datawindow within w_tm_sp_garantie
boolean visible = false
integer x = 3072
integer y = 584
integer width = 1815
integer height = 288
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sp_gti_plafond"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_plafond
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	24/11/1997 14:09:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions et modification
//*                  dans la table PLAFOND
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long			lIdRefPlaf			// R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence du plafond
Long			lIdCptPlaf			// Compteur du plafond


Decimal{2}  dcMtPlaf				// Montant du plafond 			


dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sIdPara				// Paragraphe associ$$HEX4$$e9002000e0002000$$ENDHEX$$la pi$$HEX1$$e800$$ENDHEX$$ce
String		sIdNivPlaf			// Niveau du plafond
String		sIdTypPlaf			// Type de plafond


String		sType					// Type d'action effectuer sur la table.
String		sCle [ 7 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Dw_Plafond.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "PLAFOND"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Plafond.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM
Choose Case Left ( sSql, 4 )

	Case "INSE"

		sIdNivPlaf 	 = Dw_Plafond.GetItemString ( lLig , "ID_NIV_PLAF"	)
		lIdRefPlaf 	 = Dw_Plafond.GetItemNumber ( lLig , "ID_REF_PLAF"	)
		sIdTypPlaf 	 = Dw_Plafond.GetItemString ( lLig , "ID_TYP_PLAF"	)
		lIdCptPlaf	 = Dw_Plafond.GetItemNumber ( lLig , "ID_CPT_PLAF"	)
		dcMtPlaf	 	 = Dw_Plafond.GetItemNumber ( lLig , "MT_PLAF"	   )
		sIdPara	 	 = Dw_Plafond.GetItemString ( lLig , "ID_PARA"	   )


		itrTrans.DW_I01_PLAFOND ( 	lIdProd, 	  &
											lIdRev,  	  &
											lIdGti,  	  &
											sIdNivPlaf,	  &
											lIdRefPlaf,	  &
											sIdTypPlaf,	  &
											lIdCptPlaf,	  &
											dcMtPlaf,     &
											sIdPara, 	  &
											dtMajLe,      &
											dtMajLe, 	  &
										 	stGlb.sCodOper )	




		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActioncode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_NIV_PLAF", "ID_REF_PLAF", "ID_TYP_PLAF", &
                  "ID_CPT_PLAF", "MT_PLAF", "ID_PARA"   }

			sVal[ 1 ]   = "'" + String ( lIdProd 	) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  	) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti    ) + "'"
	      sVal[ 4 ]   = "'" + sIdNivPlaf + "'"
			sVal[ 5 ]   = "'" + String ( lIdRefPlaf) + "'"
			sVal[ 6 ]   = "'" + sIdTypPlaf + "'"
			sVal[ 7 ]   = "'" + String ( lIdCptPlaf) + "'"
			sVal[ 8 ]   = "'" + String ( dcMtPlaf) + "'"
   	   sVal[ 9 ]   = "'" + sIdPara + "'"


			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]
			sCle [ 5 ]	= sVal [ 5 ]
			sCle [ 6 ]	= sVal [ 6 ]
			sCle [ 7 ]	= sVal [ 7 ]


			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		sIdNivPlaf 	 = Dw_Plafond.GetItemString ( lLig , "ID_NIV_PLAF"	)
		lIdRefPlaf 	 = Dw_Plafond.GetItemNumber ( lLig , "ID_REF_PLAF"	)
		sIdTypPlaf 	 = Dw_Plafond.GetItemString ( lLig , "ID_TYP_PLAF"	)
		lIdCptPlaf	 = Dw_Plafond.GetItemNumber ( lLig , "ID_CPT_PLAF"	)
		dcMtPlaf	 	 = Dw_Plafond.GetItemNumber ( lLig , "MT_PLAF"	   )
		sIdPara	 	 = Dw_Plafond.GetItemString ( lLig , "ID_PARA"	   )


		itrTrans.DW_U01_PLAFOND ( 	lIdProd, 	  &
											lIdRev,  	  &
											lIdGti,  	  &
											sIdNivPlaf,	  &
											lIdRefPlaf,	  &
											sIdTypPlaf,	  &
											lIdCptPlaf,	  &
											dcMtPlaf,     &
											sIdPara, 	  &
											dtMajLe, 	  &
										 	stGlb.sCodOper )				


		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActioncode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd   ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev    ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti    ) + "'"
	      sCle [ 4 ]  = "'" + sIdNivPlaf + "'"
			sCle [ 5 ]  = "'" + String ( lIdRefPlaf) + "'"
			sCle [ 6 ]  = "'" + sIdTypPlaf + "'"
			sCle [ 7 ]  = "'" + String ( lIdCptPlaf) + "'"
			

			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer    ( Dw_Plafond, lLig, "ID_NIV_PLAF", dwBuf, False	) 
		sCle [ 5 ]	= f_GetItemBuffer    ( Dw_Plafond, lLig, "ID_REF_PLAF", dwBuf, False	) 
		sCle [ 6 ]	= f_GetItemBuffer    ( Dw_Plafond, lLig, "ID_TYP_PLAF", dwBuf, False	) 
		sCle [ 7 ]	= f_GetItemBuffer    ( Dw_Plafond, lLig, "ID_CPT_PLAF", dwBuf, False	) 


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Plafond.SetActionCode ( iActionCode )
ll_ret = iActionCode
Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_franchise from datawindow within w_tm_sp_garantie
boolean visible = false
integer x = 3072
integer y = 888
integer width = 1047
integer height = 300
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sp_gti_franchise"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_franchise
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	27/11/1997 10:40:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions et modification
//*                  dans la table FRANCHISE
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long			lIdRefFra			// R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la franchise
Long			lIdCptFra			// Compteur de la franchise
Long			lIdTypFra			// Type de franchise
Long			lDurMin				// Dur$$HEX1$$e900$$ENDHEX$$e minimum
Long			lDurMax				// Dur$$HEX1$$e900$$ENDHEX$$e maximum

Decimal{2}  dcMtFra				// Montant du plafond 			

dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sIdPara				// Paragraphe associ$$HEX4$$e9002000e0002000$$ENDHEX$$la franchise
String		sIdNivFra			// Niveau de la franchise
String		sUntDel				// Unit$$HEX2$$e9002000$$ENDHEX$$pour le delai

String		sType					// Type d'action effectuer sur la table.
String		sCle [ 7 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 12 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 12 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Dw_Franchise.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "FRANCHISE"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Franchise.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		sIdNivFra 	 = Dw_Franchise.GetItemString ( lLig , "ID_NIV_FRA"	)
		lIdRefFra 	 = Dw_Franchise.GetItemNumber ( lLig , "ID_REF_FRA"	)
		lIdTypFra 	 = Dw_Franchise.GetItemNumber ( lLig , "ID_TYP_FRA"	)
		lIdCptFra	 = Dw_Franchise.GetItemNumber ( lLig , "ID_CPT_FRA"	)
		dcMtFra	 	 = Dw_Franchise.GetItemNumber ( lLig , "MT_FRA"		   )
		sIdPara	 	 = Dw_Franchise.GetItemString ( lLig , "ID_PARA"	   )
		lDurMin		 = Dw_Franchise.GetItemNumber ( lLig , "DUR_MIN"	   )	
		lDurMax		 = Dw_Franchise.GetItemNumber ( lLig , "DUR_MAX"	   )	
		sUntDel		 = Dw_Franchise.GetItemString ( lLig , "UNT_DEL"	   )	

		itrTrans.DW_I01_FRANCHISE ( 	lIdProd, 	  &
												lIdRev,  	  &
												lIdGti,  	  &
												sIdNivFra,	  &
												lIdRefFra,	  &
												lIdTypFra,	  &
												lIdCptFra,	  &
												dcMtFra,	     &
												sIdPara, 	  &
												lDurMin,		  &
												lDurMax,		  &
												sUntDel,		  &
												dtMajLe,      &
												dtMajLe, 	  &
										 		stGlb.sCodOper )	




		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_NIV_FRA", "ID_REF_FRA", "ID_TYP_FRA", &
                  "ID_CPT_FRA", "MT_FRA", "ID_PARA", "DUR_MIN", "DUR_MAX", "UNT_DEL"   }

			sVal[ 1 ]   = "'" + String ( lIdProd 	) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  	) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti    ) + "'"
	      sVal[ 4 ]   = "'" + sIdNivFra + "'"
			sVal[ 5 ]   = "'" + String ( lIdRefFra ) + "'"
			sVal[ 6 ]   = "'" + String ( lIdTypFra ) + "'"
			sVal[ 7 ]   = "'" + String ( lIdCptFra ) + "'"
			sVal[ 8 ]   = "'" + String ( dcMtFra   ) + "'"
   	   sVal[ 9 ]   = "'" + sIdPara + "'"
			sVal[ 10 ]  = "'" + String ( lDurMin   ) + "'"
			sVal[ 11 ]  = "'" + String ( lDurMax   ) + "'"
   	   sVal[ 12 ]  = "'" + sUntDel + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]
			sCle [ 5 ]	= sVal [ 5 ]
			sCle [ 6 ]	= sVal [ 6 ]
			sCle [ 7 ]	= sVal [ 7 ]


			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		sIdNivFra 	 = Dw_Franchise.GetItemString ( lLig , "ID_NIV_FRA"	)
		lIdRefFra 	 = Dw_Franchise.GetItemNumber ( lLig , "ID_REF_FRA"	)
		lIdTypFra 	 = Dw_Franchise.GetItemNumber ( lLig , "ID_TYP_FRA"	)
		lIdCptFra	 = Dw_Franchise.GetItemNumber ( lLig , "ID_CPT_FRA"	)
		dcMtFra	 	 = Dw_Franchise.GetItemNumber ( lLig , "MT_FRA"		   )
		sIdPara	 	 = Dw_Franchise.GetItemString ( lLig , "ID_PARA"	   )
		lDurMin		 = Dw_Franchise.GetItemNumber ( lLig , "DUR_MIN"	   )	
		lDurMax		 = Dw_Franchise.GetItemNumber ( lLig , "DUR_MAX"	   )	
		sUntDel		 = Dw_Franchise.GetItemString ( lLig , "UNT_DEL"	   )



		itrTrans.DW_U01_FRANCHISE ( 	lIdProd, 	  &
												lIdRev,  	  &
												lIdGti,  	  &
												sIdNivFra,	  &
												lIdRefFra,	  &
												lIdTypFra,	  &
												lIdCptFra,	  &
												dcMtFra,      &
												sIdPara, 	  &
												lDurMin, 	  &
												lDurMax, 	  &
												sUntDel, 	  &
												dtMajLe, 	  &
										 		stGlb.sCodOper )				

		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd   ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev    ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti    ) + "'"
	      sCle [ 4 ]  = "'" + sIdNivFra + "'"
			sCle [ 5 ]  = "'" + String ( lIdRefFra ) + "'"
			sCle [ 6 ]  = "'" + String	( lIdTypFra ) + "'"
			sCle [ 7 ]  = "'" + String ( lIdCptFra ) + "'"
			

			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer    ( Dw_Franchise, lLig, "ID_NIV_FRA", dwBuf, False	)
		sCle [ 5 ]	= f_GetItemBuffer    ( Dw_Franchise, lLig, "ID_REF_FRA", dwBuf, False	)
		sCle [ 6 ]	= f_GetItemBuffer    ( Dw_Franchise, lLig, "ID_TYP_FRA", dwBuf, False	)
		sCle [ 7 ]	= f_GetItemBuffer    ( Dw_Franchise, lLig, "ID_CPT_FRA", dwBuf, False	)


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Franchise.SetActionCode ( iActionCode )
ll_ret = iActionCode
Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_delai from datawindow within w_tm_sp_garantie
boolean visible = false
integer x = 3077
integer y = 1204
integer width = 1047
integer height = 360
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sp_gti_delai"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_Delai
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	28/11/1997 10:40:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions et modification
//*                  dans la table DELAI
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long			lIdRefDel			// R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la delai
Long			lIdCptDel			// Compteur de la delai
Long			lDurMin				// Dur$$HEX1$$e900$$ENDHEX$$e minimum
Long			lDurMax				// Dur$$HEX1$$e900$$ENDHEX$$e maximum


dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sIdNivDel			// Niveau du D$$HEX1$$e900$$ENDHEX$$lai
String		sUntDel				// Unit$$HEX2$$e9002000$$ENDHEX$$pour le delai
String		sIdTypDel			// Type de delai

String		sType					// Type d'action effectuer sur la table.
String		sCle [ 7 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 10 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 10 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Dw_Delai.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "DELAI"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Delai.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM
Choose Case Left ( sSql, 4 )

	Case "INSE"

		sIdNivDel 	 = Dw_Delai.GetItemString ( lLig , "ID_NIV_DEL"	)
		lIdRefDel 	 = Dw_Delai.GetItemNumber ( lLig , "ID_REF_DEL"	)
		sIdTypDel 	 = Dw_Delai.GetItemString ( lLig , "ID_TYP_DEL"	)
		lIdCptDel	 = Dw_Delai.GetItemNumber ( lLig , "ID_CPT_DEL"	)
		lDurMin		 = Dw_Delai.GetItemNumber ( lLig , "DUR_MIN"	   )	
		lDurMax		 = Dw_Delai.GetItemNumber ( lLig , "DUR_MAX"	   )	
		sUntDel		 = Dw_Delai.GetItemString ( lLig , "UNT_DEL"	   )	

		itrTrans.DW_I01_DELAI    ( 	lIdProd, 	  &
												lIdRev,  	  &
												lIdGti,  	  &
												sIdNivDel,	  &
												lIdRefDel,	  &
												sIdTypDel,	  &
												lIdCptDel,	  &
												lDurMin,		  &
												lDurMax,		  &
												sUntDel,		  &
												dtMajLe,      &
												dtMajLe, 	  &
										 		stGlb.sCodOper )	




		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_NIV_DEL", "ID_REF_DEL", "ID_TYP_DEL", &
                  "ID_CPT_DEL", "DUR_MIN", "DUR_MAX", "UNT_DEL"   }

			sVal[ 1 ]   = "'" + String ( lIdProd 	) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  	) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti    ) + "'"
	      sVal[ 4 ]   = "'" + sIdNivDel + "'"
			sVal[ 5 ]   = "'" + String ( lIdRefDel ) + "'"
			sVal[ 6 ]   = "'" + sIdTypDel + "'"
			sVal[ 7 ]   = "'" + String ( lIdCptDel ) + "'"
			sVal[ 8 ]   = "'" + String ( lDurMin   ) + "'"
			sVal[ 9 ]   = "'" + String ( lDurMax   ) + "'"
   	   sVal[ 10 ]  = "'" + sUntDel + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]
			sCle [ 5 ]	= sVal [ 5 ]
			sCle [ 6 ]	= sVal [ 6 ]
			sCle [ 7 ]	= sVal [ 7 ]


			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		sIdNivDel 	 = Dw_Delai.GetItemString ( lLig , "ID_NIV_DEL"	)
		lIdRefDel 	 = Dw_Delai.GetItemNumber ( lLig , "ID_REF_DEL"	)
		sIdTypDel 	 = Dw_Delai.GetItemString ( lLig , "ID_TYP_DEL"	)
		lIdCptDel	 = Dw_Delai.GetItemNumber ( lLig , "ID_CPT_DEL"	)
		lDurMin		 = Dw_Delai.GetItemNumber ( lLig , "DUR_MIN"	   )	
		lDurMax		 = Dw_Delai.GetItemNumber ( lLig , "DUR_MAX"	   )	
		sUntDel		 = Dw_Delai.GetItemString ( lLig , "UNT_DEL"	   )



		itrTrans.DW_U01_DELAI    ( 	lIdProd, 	  &
												lIdRev,  	  &
												lIdGti,  	  &
												sIdNivDel,	  &
												lIdRefDel,	  &
												sIdTypDel,	  &
												lIdCptDel,	  &
												lDurMin, 	  &
												lDurMax, 	  &
												sUntDel, 	  &
												dtMajLe, 	  &
										 		stGlb.sCodOper )				

		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd   ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev    ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti    ) + "'"
	      sCle [ 4 ]  = "'" + sIdNivDel + "'"
			sCle [ 5 ]  = "'" + String ( lIdRefDel ) + "'"
			sCle [ 6 ]  = "'" + sIdTypDel + "'"
			sCle [ 7 ]  = "'" + String ( lIdCptDel ) + "'"
			

			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer    ( Dw_Delai, lLig, "ID_NIV_FRA", dwBuf, False	)
		sCle [ 5 ]	= f_GetItemBuffer    ( Dw_Delai, lLig, "ID_REF_FRA", dwBuf, False	)
		sCle [ 6 ]	= f_GetItemBuffer    ( Dw_Delai, lLig, "ID_TYP_FRA", dwBuf, False	)
		sCle [ 7 ]	= f_GetItemBuffer    ( Dw_Delai, lLig, "ID_CPT_FRA", dwBuf, False	)


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Delai.SetActionCode ( iActionCode )
ll_ret = iActionCode
Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type uo_bord3d from u_bord3d within w_tm_sp_garantie
integer x = 27
integer y = 280
integer width = 3387
integer height = 1376
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type uo_condition from u_ajout within w_tm_sp_garantie
integer x = 41
integer y = 292
integer width = 3351
integer height = 1352
integer taborder = 60
boolean border = false
end type

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Condition
//* Evenement 		:	UE_DWSOURCE_SQLPREVIEW
//* Auteur			:	V.Capelle
//* Date				:	12/11/1997 11:07:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Trace des modifications et utilisation d'une 
//*						proc$$HEX1$$e900$$ENDHEX$$dure pour les insertions dans la table
//*						CONDITION
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode	= 0	// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement

Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne du buffer utilis$$HEX1$$e900$$ENDHEX$$.
Long			lIdProd				// identifiant du produit.
Long			lIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long			lIdGti				// Identifiant de la garantie.
Long 			lIdCode				// Identifiant du code

dwBuffer		dwBuf					// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

String		sSql					// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 5 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
String		sIdTypCode			// Type de code
String		sAltReg				// Champs ALT_REG
String		sAltPlaf				// Champs ALT_PLAF
String		sAltDel				// Champs ALT_DEL
String		sAltFran				// Champs ALT_FRAN

DateTime		dtMajLe				// Date de MAJ.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Uo_condition.dw_Source.GetSqlPreview ()
sSql = sql_syntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "CONDITION"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Uo_condition.dw_Source.GetUpdateStatus ( lLig, dwBuf )
lLig = ligne
dwBuf = buffer_dw
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		lIdCode 		= Uo_condition.dw_Source.GetItemNumber ( lLig , "ID_CODE"  		)
		sIdTypCode 	= Uo_condition.dw_Source.GetItemString ( lLig , "ID_TYP_CODE"  )
		sAltReg	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_REG"  		)
		sAltPlaf	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_PLAF" 		)
		sAltDel	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_DEL"  		)
		sAltFran	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_FRAN" 		)

		itrTrans.DW_I01_CONDITION ( 	lIdProd,    &
												lIdRev,     &
												lIdGti,     &
												lIdCode,	   &
												sIdTypCode, &
												sAltReg,    &
												sAltPlaf,   &
												sAltDel,    &
												sAltFran,   &
												dtMajLe,    &
												dtMajLe,    &
											 	stGlb.sCodOper )			


		If itrTrans.SQLCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV",   "ID_GTI",  "ID_TYP_CODE", "ID_CODE", &
						"ALT_REG", "ALT_PLAF", "ALT_DEL", "ALT_FRAN" }

			sVal[ 1 ]   = "'" + String ( lIdProd ) + "'"
			sVal[ 2 ]   = "'" + String ( lIdRev  ) + "'"
			sVal[ 3 ]   = "'" + String ( lIdGti  ) + "'"
	      sVal[ 4 ]   = "'" + String ( lIdCode ) + "'"
   	   sVal[ 5 ]   = "'" + sIdTypCode + "'"
	      sVal[ 6 ]   = "'" + sAltReg  + "'"
	      sVal[ 7 ]   = "'" + sAltPlaf + "'"
	      sVal[ 8 ]   = "'" + sAltDel  + "'"
	      sVal[ 9 ]   = "'" + sAltFran + "'"


			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]
			sCle [ 5 ]	= sVal [ 5 ]
			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
				iActionCode = 1

			Else

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		lIdCode 		= Uo_condition.dw_Source.GetItemNumber ( lLig , "ID_CODE"  		)
		sIdTypCode 	= Uo_condition.dw_Source.GetItemString ( lLig , "ID_TYP_CODE"  )
		sAltReg	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_REG"  		)
		sAltPlaf	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_PLAF" 		)
		sAltDel	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_DEL"  		)
		sAltFran	 	= Uo_condition.dw_Source.GetItemString ( lLig , "ALT_FRAN" 		)

		itrTrans.DW_U01_CONDITION ( 	lIdProd,    &
												lIdRev,     &
												lIdGti,     &
												lIdCode,	   &
												sIdTypCode, &
												sAltReg,    &
												sAltPlaf,   &
												sAltDel,    &
												sAltFran,   &
												dtMajLe,    &
											 	stGlb.sCodOper )			

		If itrTrans.SQLCode <> 0 Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else


			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
			sCle [ 4 ]	= "'" + String ( lIdCode ) + "'"
			sCle [ 5 ]	= "'" + sIdTypCode + "'"

			sType = 'U'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			Else

				iActionCode = 2

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev  ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti  ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer    ( Dw_Source, lLig, "ID_CODE"    , dwBuf, False	)
		sCle [ 5 ]	= f_GetItemBuffer    ( Dw_Source, lLig, "ID_TYP_CODE", dwBuf, False	)

		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1 

		End If


End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( iActionCode )
ll_ret = iActionCode
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

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

on ue_dwsource_dclick;call u_ajout::ue_dwsource_dclick;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_traitement_master::dw_1
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
stPass.lTab [ 3 ] = Dw_1.GetItemNumber ( 1, "ID_REV" ) 
stPass.lTab [ 4 ] = Uo_Condition.Dw_Source.GetItemNumber ( Uo_Condition.illigsourceclick, "ID_CODE" ) 
stPass.lTab [ 5 ] = Uo_Condition.illigsourceclick
stPass.lTab [ 6 ] = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )

stPass.sTab [ 1 ] = Uo_Condition.Dw_Source.GetItemString ( Uo_Condition.illigsourceclick, "ID_TYP_CODE" ) 




If isValid ( W_t_sp_Condition_Gti )	= False	Then

	OpenWithParm ( W_t_sp_Condition_Gti, stPass, stPass.wParent )

Else

	W_t_sp_Condition_Gti.idcIdProd    = ilIdProd
	W_t_sp_Condition_Gti.idcIdGti     = ilIdGti
	W_t_sp_Condition_Gti.idcIdRev     = Dw_1.GetItemNumber ( 1, "ID_REV" )
	W_t_sp_Condition_Gti.idcIdCode    = Uo_Condition.Dw_Source.GetItemNumber ( Uo_Condition.illigsourceclick, "ID_CODE" ) 
	W_t_sp_Condition_Gti.isIdTypCode  = Uo_Condition.Dw_Source.GetItemString ( Uo_Condition.illigsourceclick, "ID_TYP_CODE" ) 
	W_t_sp_Condition_Gti.ilLigMaster  = Uo_Condition.illigsourceclick
	W_t_sp_Condition_Gti.idcIdTypFra	 = Dw_1.GetItemNumber ( 1, "COD_TYP_FRA" )
	W_t_sp_Condition_Gti.Show ()

End If

If isLibGti <> "" Then
	W_t_sp_Condition_Gti.Title = "Gestion de la garantie " + isLibGti
Else
	W_t_sp_Condition_Gti.Title = "Gestion de garantie "
End If


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

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_Condition
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: V. Capelle
//* Date				: 10/11/97 18:04:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des conditions
//*					  on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*					  ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//* Modif
//* Projet			Qui	Date
//* [MIGPB8COR]	PHG	30/05/2006 : Correction de la suppression
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat		//Statut de la ligne courante.
String			sIdTypCode		// Variable tampon pour le type de code $$HEX2$$e0002000$$ENDHEX$$supprimer
String			sFiltre			// Filtre $$HEX2$$e0002000$$ENDHEX$$appliquer pour selectionner les $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments relatifs 
										// $$HEX2$$e0002000$$ENDHEX$$la condition de garantie $$HEX2$$e0002000$$ENDHEX$$supprimer
String			sAltFran			// Valeur du champ ALT_FRAN de la condition
Long				lNbLigne			// Nombre d'enregistrements rattach$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la condition 
                        		// ( Delai, Plafond puis Franchise )
Long				lIdCode			// Variable tampon pour le code $$HEX2$$e0002000$$ENDHEX$$supprimer
Long 				lCptligne		// Compteur pour la suppression
integer			li_Ligsup		// [MIGPB8COR] : indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer


If ilLigSourceSupp > 0 Then


	sAltFran 	= Dw_Source.GetItemString ( ilLigSourceSupp, "ALT_FRAN"	)

	/*------------------------------------------------------------------*/
	/* Lecture du type de code et du code caract$$HEX1$$e900$$ENDHEX$$risant la condition de */
	/* garantie $$HEX2$$e0002000$$ENDHEX$$supprimer                                             */
	/*------------------------------------------------------------------*/
	sIdTypCode	=	Dw_Source.GetItemString ( ilLigSourceSupp, "ID_TYP_CODE"	)
	lIdCode		=	Dw_Source.GetItemNumber ( ilLigSourceSupp, "ID_CODE" 		)	

	/*------------------------------------------------------------------*/
	/* Suppression des franchises rattach$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la condition.            */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_NIV_FRA = '" + sIdTypCode + "' AND ID_REF_FRA = " + String ( lIdCode ) 

	Dw_Franchise.SetFilter ( sFiltre )
	Dw_Franchise.Filter ( )

	lNbLigne = Dw_Franchise.RowCount ( )

	For lCptLigne = 1 to lNbLigne

		Dw_Franchise.DeleteRow ( 0 )

	Next


	Dw_Franchise.SetFilter ( "" )
	Dw_Franchise.Filter ( )		

	lNbLigne = Dw_Franchise.RowCount ( )

	/*------------------------------------------------------------------*/
	/* Remise $$HEX2$$e0002000$$ENDHEX$$00 de la variable d'instance isNivFra de la fen$$HEX1$$ea00$$ENDHEX$$tre     */
	/* w_t_sa_DelPlaFra dans le cas ou tous les plafonds de la garantie */
	/* portaient sur la condition supprim$$HEX1$$e900$$ENDHEX$$e.                            */
	/*------------------------------------------------------------------*/
	If IsValid ( w_t_sp_Condition_Gti ) And ( lNbLigne = 0 ) Then

		w_t_sp_Condition_Gti.isIdNivFra = ""

	End If




	/*------------------------------------------------------------------*/
	/* Suppression des d$$HEX1$$e900$$ENDHEX$$lais rattach$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la condition.                 */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_NIV_DEL = '" + sIdTypCode + "' AND ID_REF_DEL = " + String ( lIdCode )


	dw_Delai.SetFilter ( sFiltre )
	dw_Delai.Filter ( )

	lNbLigne = dw_Delai.RowCount ( )

	For lCptLigne = 1 to lNbLigne

		dw_Delai.DeleteRow ( 0 )

	Next
		

	/*------------------------------------------------------------------*/
	/* Suppression des plafonds rattach$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la condition.               */
	/*------------------------------------------------------------------*/

	sFiltre = "ID_NIV_PLAF = '" + sIdTypCode + "' AND ID_REF_PLAF = " + String ( lIdCode )

	Dw_Plafond.SetFilter ( sFiltre )
	Dw_Plafond.Filter ( )

	lNbLigne = Dw_Plafond.RowCount ( )

	For lCptLigne = 1 to lNbLigne

		Dw_Plafond.DeleteRow ( 0 )

	Next



	/*----------------------------------------------------------------------------*/
	/* R$$HEX1$$e900$$ENDHEX$$initialisation des champs ALT_REG, ALT_PLAF, ALT_DEL, ALT_FRAN.          */
	/*----------------------------------------------------------------------------*/
	Dw_Source.SetItem ( ilLigSourceSupp, "ALT_REG"		, "N"	)
	Dw_Source.SetItem ( ilLigSourceSupp, "ALT_PLAF"		, "N"	)
	Dw_Source.SetItem ( ilLigSourceSupp, "ALT_DEL"		, "N"	)
	Dw_Source.SetItem ( ilLigSourceSupp, "ALT_FRAN"		, "N"	)

	/*------------------------------------------------------------------*/
	/* Suppression des filtres                                          */
	/*------------------------------------------------------------------*/

	sFiltre = ""


	Dw_Plafond.SetFilter ( sFiltre )
	Dw_Plafond.Filter ( )


	Dw_Delai.SetFilter ( sFiltre )
	Dw_Delai.Filter ( )

	/*------------------------------------------------------------------*/
	/* S'il y a bien une ligne courante,                                */
	/* Si le statut de la ligne courante est NotModified ou             */
	/* DataModified, on copie la ligne dans le buffer DELETE! de        */
	/* dw_source.                                                       */
	/*------------------------------------------------------------------*/
	dwItemstat = Dw_Source.GetItemStatus ( ilLigSourceSupp, 0 , PRIMARY!)

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

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Condition
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	10/11/1997 16:24:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	

//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
Uo_Condition.Pb_enlever_tout.Visible = False
Uo_Condition.Pb_ajouter_tout.Visible = False
end on

on uo_condition.destroy
call u_ajout::destroy
end on

type uo_affilier from u_ajout within w_tm_sp_garantie
integer x = 46
integer y = 292
integer width = 3351
integer height = 1352
integer taborder = 50
boolean border = false
end type

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_affilier
//* Evenement 		: UE_DWSOURCE_SQLPREVIEW
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 18:16:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Insertion des cartes pour une garantie
//*					  dans la table AFFILIER.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Integer		iActionCode =0		// ActionCode pour l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement
String		sSql					// Ordre SQL $$HEX2$$e0002000$$ENDHEX$$ex$$HEX1$$e900$$ENDHEX$$cuter.
Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer.
dwBuffer		dwBuf					// Buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 8 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 8 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
DateTime		dtMajLe				// Date de Mise $$HEX2$$e0002000$$ENDHEX$$Jour.
DateTime			dDteAffil			// Date d'affiliation de la carte

Long			lIdProd				// Identifiant du produit.
Long			lIdRev				// identifiant de la revision.
Long			lIdGti				// identifiant de la garantie.
Long			lIdCarte				// identifiant de la carte.
String		sMajPar				// Utilisateur

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dtMajLe = Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
sMajPar = Dw_1.GetItemString   ( 1 , "MAJ_PAR" )
lIdProd = Dw_1.GetItemNumber   ( 1 , "ID_PROD" )
lIdRev  = Dw_1.GetItemNumber   ( 1 , "ID_REV"  )
lIdGti  = Dw_1.GetItemNumber   ( 1 , "ID_GTI"  )


/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "AFFILIER"
//Migration PB8-WYNIWYG-03/2006 FM
//sSql = uo_Affilier.dw_Source.GetSqlPreview ()
sSql = sql_syntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* lecture du num$$HEX1$$e900$$ENDHEX$$ro de ligne $$HEX2$$e0002000$$ENDHEX$$traiter                             */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Uo_Affilier.Dw_Source.GetUpdateStatus ( lLig, dwBuf )
lLig = ligne
dwBuf = buffer_dw
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"
		
		lIdCarte 	= Uo_Affilier.Dw_Source.GetItemNumber 		( lLig, "ID_CARTE" 			)	
		dDteAffil	= Uo_Affilier.Dw_Source.GetItemDateTime    	( lLig, "DTE_AFFILIATION"	) // [PI056] getItemDate en GetItemDateTime



		itrTrans.DW_I01_AFFILIER ( 	lIdProd,		&
												lIdrev, 		&
												lIdgti, 		&
												lIdcarte,	&
												dDteAffil, &
											  	dtMajLe, 	&
												dtMajLe, 	&
												sMajPar )

		If itrTrans.SqlCode <> 0	Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_CARTE", "DTE_AFFILIATION" }
			sVal [ 1 ] = "'" + String ( lIdProd    ) + "'"
			sVal [ 2 ] = "'" + String ( lIdRev     ) + "'"
			sVal [ 3 ] = "'" + String ( lIdGti     ) + "'"
			sVal [ 4 ] = "'" + String ( lIdCarte   ) + "'"
			sVal [ 5 ] = "'" + String ( dDteAffil  ) + "'"  

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'
	
			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1

			Else 

				iActionCode = 2

			End If

		End If

	Case  "UPDA"

		lIdCarte 	= Uo_Affilier.Dw_Source.GetItemNumber 		( lLig, "ID_CARTE" 			)	

//		itrTrans.DW_U01_AFFILIER ( 	lIdProd,		&
//												lIdRev, 		&
//												lIdGti, 		&
//												lIdCarte,	&
//												dDteAffil, &
//												dtMajLe, 	&
//												sMajPar )


		If itrTrans.SQLcode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

			sCle [ 1 ]	= "'" + String ( lIdProd  ) + "'"
			sCle [ 2 ]	= "'" + String ( lIdRev   ) + "'"
			sCle [ 3 ]	= "'" + String ( lIdGti   ) + "'"
			sCle [ 4 ]	= "'" + String ( lIdCarte ) + "'"

			sVal [ 1 ]  = f_GetItem ( Dw_Source, lLig, "DTE_AFFILIATION" )

			sType = 'U'
	
			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				iActionCode = 1 

			End If

		End If

	Case	"DELE"

		sCle [ 1 ]	= "'" + String ( lIdProd  ) + "'"
		sCle [ 2 ]	= "'" + String ( lIdRev   ) + "'"
		sCle [ 3 ]	= "'" + String ( lIdGti   ) + "'"
		sCle [ 4 ]	= f_GetItemBuffer ( Dw_Source, lLig, "ID_CARTE", dwBuf, False )


		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			iActionCode = 1

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( iActionCode )
ll_ret = iActionCode
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_affilier
//* Evenement 		: ue_DwSource_ItemError
//* Auteur			: V.Capelle
//* Date				: 10/11/1997 17:59:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des messages d'erreur pour uo_Affilier
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sErrCol					// Nom de la colonne en Erreur


stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Cartes"
stMessage.Icon		= Information!


sErrCol				= Upper ( Dw_Source.GetColumnName ()	)

Choose Case sErrCol

	Case 	"DTE_AFFILIATION"

		Choose Case iiErreurAffilier
			
			Case 0
				stMessage.sVar[1] = "date d'affiliation"
				stMessage.sCode	= "GENE002"

			Case 1
				stMessage.sCode	= "GENE006"

		End Choose


		Dw_Source.SetItem ( Dw_Source.GetRow ( ), Dw_Source.GetColumn ( ),&
								  Dw_Source.GetItemDateTime ( Dw_Source.GetRow ( ), Dw_Source.GetColumnName ( ) ) ) // [PI056] getItemDate en GetItemDateTime

		
End Choose


f_Message ( stMessage )

iiErreurAffilier = 0
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source. SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwsource_rbuttondown;call u_ajout::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_affilier
//* Evenement 		: rButtonDown
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 18:08:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de demande d'une date
//*					  d'affiliation pour les cartes qui n'en ont pas 
//*					  encore et positionnement de la date si celle-ci
//*					  est saisie.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String	sDateAffil		//Date d'affiliation $$HEX2$$e0002000$$ENDHEX$$positionner
Long 		lCpt				//Compteur pour la structation des dates
Long 		lNbCarte			//Nombre de carte affili$$HEX1$$e900$$ENDHEX$$e
Date		dDateAffil		//Date d'affiliation $$HEX2$$e0002000$$ENDHEX$$inserer pour les cartes sans date d'affiliation

lNbCarte	  = Dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification qu'il existe des carte affili$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la garantie.     */
/*------------------------------------------------------------------*/
If lNbCarte > 0 Then

	Open ( w_t_Sp_Affil_Carte )

	sDateAffil	= Message.StringParm


	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification que la valeur saisie est correcte.                  */
	/*------------------------------------------------------------------*/
	If isDate ( sDateAffil ) And Not ( isNull ( sDateAffil ) )Then

		If	( Date ( sDateAffil ) >= Date ( "1980-01-01" ) ) Then
			dDateAffil = Date ( sDateAffil )
			lCpt = Dw_Source.Find ( "isNull ( DTE_AFFILIATION )", 1, lNbCarte  )   

			/*------------------------------------------------------------------*/
			/* Mise en place de la valeur saisie pour les cartes o$$HEX2$$f9002000$$ENDHEX$$la date     */
			/* d'affiliation est absente.                                       */
			/*------------------------------------------------------------------*/
			Do While lCpt > 0 

				Dw_Source.SetItem ( lCpt, "DTE_AFFILIATION", dDateAffil )				 
				lCpt = Dw_Source.Find ( "isNull ( DTE_AFFILIATION )", lCpt, lNbCarte  )   

			Loop

		Else
			/*------------------------------------------------------------------*/
			/* Message d'erreur si la date $$HEX2$$e0002000$$ENDHEX$$positionner est ant$$HEX1$$e900$$ENDHEX$$rieure au      */
			/* 1/1/1980.                                                        */
			/*------------------------------------------------------------------*/
			stMessage.sTitre= "Saisie d'une date d'affiliation par d$$HEX1$$e900$$ENDHEX$$faut"
			stMessage.sCode = "GENE006"
			f_Message ( stMessage )

		End If

	End If

End If
end on

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_affilier
//* Evenement 		:	Constructor ( Extend )
//* Auteur			:	V.Capelle
//* Date				:	06/11/1997 16:23:20
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

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur                              */
/*------------------------------------------------------------------*/
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*----------------------------------------------------------------------------*/
/* Pas d'effets 3D                                                            */
/*----------------------------------------------------------------------------*/
ibEffet3D		= False
end event

event ue_dwsource_itemchanged;call super::ue_dwsource_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_affilier
//* Evenement 		: UE_DwSource_ItemChanged
//* Auteur			: V.Capelle
//* Date				: 10/11/1997 17:24:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rification des champs de dwsource lors d'une
//*					  modification.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sNomCol					//Nom de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
String	sVal						//Valeur de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
Date 		dVal
Int 		iActionCode = 0		//Argument pour le SetActionCode 

sNomCol				= Upper ( Dw_Source.GetColumnName ()	)
sVal					= Dw_Source.GetText ( )
dVal              = Date ( sVal )
iiErreurAffilier	= 0

Choose Case sNomCol

		Case 	"DTE_AFFILIATION"

			If ( Date ( sVal ) < Date ( "1980-01-01" ) ) Then
				
				iiErreurAffilier 	= 1
				iActionCode 		= 1 				

			End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//This.dw_Source. SetActionCode ( iActionCode )
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_affilier
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: V. Capelle
//* Date				: 05/11/97 18:04:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des cartes affect$$HEX1$$e900$$ENDHEX$$es
//*					  on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*					  ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
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

If ilLigSourceSupp > 0 Then

	dwItemstat = Dw_Source.GetItemStatus ( ilLigSourceSupp, 0 , PRIMARY!)

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

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Affilier
//* Evenement 		: Ue_dwRecherche_Retrieve ( OverRide )
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 16:58:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On OverRide l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement car on a besoin de 3
//*                 arguments pour le retrieve
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
ilLigRecherche = dw_Recherche.Retrieve ( ilIdProd, ilIdRev, ilIdGti  )
end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_Affilier
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	V.Capelle
//* Date				:	10/11/1997 16:24:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
Uo_Affilier.Pb_enlever_tout.Visible = False
Uo_Affilier.Pb_ajouter_tout.Visible = False
end on

on ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwSource_Retrieve ( OverRide )
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 16:58:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On OverRide l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement car on a besoin de 3
//*                 arguments pour le retrieve
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
ilLigSource = dw_Source.Retrieve ( ilIdProd, ilIdRev, ilIdGti  )
end on

on uo_affilier.destroy
call u_ajout::destroy
end on

type uo_onglets from u_onglets within w_tm_sp_garantie
integer x = 18
integer y = 184
integer width = 2926
integer height = 108
integer taborder = 0
boolean border = false
end type

