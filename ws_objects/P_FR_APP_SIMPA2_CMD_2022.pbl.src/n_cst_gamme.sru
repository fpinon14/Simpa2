HA$PBExportHeader$n_cst_gamme.sru
$PBExportComments$/* SFR */ Objet li$$HEX4$$e9002000e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre gamme
forward
global type n_cst_gamme from u_gs_sp_sinistre_anc
end type
end forward

global type n_cst_gamme from u_gs_sp_sinistre_anc
end type
global n_cst_gamme n_cst_gamme

type variables
Private :

DataWindow	idwFourGme
DataWindow	idwLstGme
DataWindow	idwLstGmeSin
DataWindow	idwLstCmdeSin
DataWindow	idwGme
DataWindow	idwGmeFour

Picture		ibmFleche

Integer		ilRetGamme
end variables

forward prototypes
public subroutine uf_initialiserfenetre (picture abm_fleche)
private function long uf_determinergammesurfour (string asfour, ref string asmarque, ref string asmodele, ref string aslibgamme)
public subroutine uf_controlerzone (string asnomcol, string asvalcol)
private subroutine uf_chargergamme (string asfour)
public function long uf_getgamme ()
private subroutine uf_selmobass (string asfind)
private subroutine uf_chargermobassure (boolean abinit, string asmarque, string asmodele, string aslibgamme)
private function long uf_chargerdw (boolean abinit, string asfour)
private subroutine uf_znidfour (string asvalcol)
private subroutine uf_znidgamme (string asvalcol)
public subroutine uf_initialiser_dw_desc (ref s_pass astpass)
private subroutine uf_inslgnttesgmes (string asfour)
public subroutine uf_clicklgn (long alnumcol)
private subroutine uf_filtrelstgme (string asfiltre, boolean absel)
end prototypes

public subroutine uf_initialiserfenetre (picture abm_fleche);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_InitialiserFenetre ( PUBLIC )
//* Auteur        : Catherine Abdmeziem
//* Date          : 13/09/2002 16:10:16
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Chargement des dw_lst_gamme ( r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e de sinistre ),
//*					  et dw_Four_gamme ( populisation des dddw $$HEX2$$e0002000$$ENDHEX$$partir des dddw de dw_lst_gamme ci-dessus )
//*
//* Arguments     : ( Val )	Picture	abm_Fleche	:	bitmap utilis$$HEX1$$e900$$ENDHEX$$e pour afficher la s$$HEX1$$e900$$ENDHEX$$lection
//*																	d'un mobile dans la liste des mod$$HEX1$$e800$$ENDHEX$$les / gammes
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild, dwChild1
String				sFour
Long					lCodTel, lNbLgn

ibmFleche = abm_Fleche

ilRetGamme = 0

/*------------------------------------------------------------------*/
/* On populise la dddw id_four $$HEX2$$e0002000$$ENDHEX$$partir de dw_w_commande de sinistre*/
/*------------------------------------------------------------------*/
idwLstCmdeSin.GetChild ( "ID_FOUR", dwChild )
idwFourGme.GetChild ( "ID_FOUR", dwChild1 )
dwChild.ShareData ( dwChild1 )

idwLstGme.SetRowFocusIndicator ( ibmFleche )

/*------------------------------------------------------------------*/
/* d$$HEX1$$e900$$ENDHEX$$termination du fournisseur                                     */
/*------------------------------------------------------------------*/
lCodTel = idw_Produit.GetItemNumber ( 1, "COD_TEL" )

Choose Case lCodTel
	Case 21
		sFour = "CEG"

	Case Else
		sFour = ""

End Choose

idwFourGme.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* Populisation de la liste des mod$$HEX1$$e800$$ENDHEX$$les / gammes $$HEX2$$e0002000$$ENDHEX$$partir de la dw  */
/* de w_tm_sp_sinistre                                              */
/*------------------------------------------------------------------*/
idwLstGmeSin.ShareData ( idwLstGme )

/*------------------------------------------------------------------*/
/* Populisation des dddw id_gamme des 2 dw de w_sp_gamme $$HEX2$$e0002000$$ENDHEX$$partir   */
/* de dw_gamme de w_tm_sp_sinistre                                  */
/*------------------------------------------------------------------*/
/* Modif CAG 02/10/02 : pb de filtrage quand le fournisseur est     */
/* initialis$$HEX4$$e9002000e0002000$$ENDHEX$$vide, puis choix d'un fournisseur : l'une des 2     */
/* dddw ne prend pas le filtre.                                     */
/* La populisation se faisait $$HEX2$$e0002000$$ENDHEX$$partir de la dddw de dw_lst_gamme   */
/* dans w_tm_sp_sinistre.                                           */
/* Maintenant, recopie des lignes de cette dddw dans 2 dw cach$$HEX1$$e900$$ENDHEX$$es,  */
/* chacune des 2 dddw est partag$$HEX1$$e900$$ENDHEX$$e avec sa dw. Le filtre est fait   */
/* ensuite sur les 2 dw dans uf_chargergamme.                       */
/*------------------------------------------------------------------*/
idwLstGmeSin.Getchild ( "ID_GAMME", dwChild )

lNbLgn = dwChild.RowCount ( )

If lNbLgn > 0 Then dwChild.RowsCopy( 1, lNbLgn, PRIMARY!, idwGme, 1, PRIMARY! )
If lNbLgn > 0 Then dwChild.RowsCopy( 1, lNbLgn, PRIMARY!, idwGmeFour, 1, PRIMARY! )

idwLstGme.GetChild ( "ID_GAMME", dwChild1)
idwGme.ShareData ( dwChild1 )

idwFourGme.GetChild ( "ID_GAMME", dwChild1)
idwGmeFour.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* Pose du FILTRE sur GAMME ( table code comprend les libell$$HEX1$$e900$$ENDHEX$$s (    */
/* dizaine ), les prix max ( code 100 + code des libell$$HEX1$$e900$$ENDHEX$$s ) +       */
/* la TVA ( code 201 ) ) + FOURN.                                   */
/*------------------------------------------------------------------*/
This.uf_ChargerGamme ( sFour )

ilRetGamme = uf_ChargerDw ( TRUE, sFour )



end subroutine

private function long uf_determinergammesurfour (string asfour, ref string asmarque, ref string asmodele, ref string aslibgamme);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_DeterminerGammeSurFour ( PRIVATE )
//* Auteur        : Catherine Abdmeziem
//* Date          : 25/09/2002 15:16:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : D$$HEX1$$e900$$ENDHEX$$termination de la gamme en fonction des codes orian ( null ou non ), lorsque le fournisseur est renseign$$HEX1$$e900$$ENDHEX$$
//*					  en fonction de la gamme, positionnement des dw ( filtre + s$$HEX1$$e900$$ENDHEX$$lection ) + r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$de la gamme
//*
//* Arguments     : ( Val )	String	asFour :			Code fournisseur initialis$$HEX1$$e900$$ENDHEX$$
//*					  ( Ref )	String	asMarque :		Marque ramen$$HEX1$$e900$$ENDHEX$$e de w_sin
//*					  ( Ref )	String	asModele :		Mod$$HEX1$$e800$$ENDHEX$$le ramen$$HEX2$$e9002000$$ENDHEX$$de w_sin
//*					  ( Ref )	String	asLibGamme :	Libell$$HEX2$$e9002000$$ENDHEX$$de la gamme affich$$HEX2$$e9002000$$ENDHEX$$dans la zone mobile assur$$HEX1$$e900$$ENDHEX$$
//*
//* Retourne      : Long	lGamme = Gamme d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild_Idgamme, dwChild_IdFour
String				sFiltre, sMarqLgn, sModlLgn, sFind
Long					lNbLgn, lGamme, lOrianMarq, lOrianModl, lNumLgn, lLgnIdFour

idwFourGme.GetChild ( "ID_GAMME", dwChild_IdGamme )
idwFourGme.GetChild ( "ID_FOUR", dwChild_IdFour )
lOrianMarq = idw_WSin.GetItemNumber ( 1, "ID_ORIAN_MARQUE" )
lOrianModl = idw_WSin.GetItemNumber ( 1, "ID_ORIAN_MODELE" )
lLgnIdFour = dwChild_IdFour.GetRow ()

If IsNull( lOrianMarq ) or IsNull ( lOrianModl ) Then
	If asMarque <> "" and asModele <> "" Then
		asLibGamme = " ( Aucun code orian donnant la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la gamme chez " + &
						 dwChild_IdFour.GetItemString ( lLgnIdFour, "LIB_CODE" ) + " )"
	Else
		asLibGamme = "Aucun mobile r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$renc$$HEX2$$e9002000$$ENDHEX$$en adh$$HEX1$$e900$$ENDHEX$$sion"
	End If
Else
	// codes orian renseign$$HEX1$$e900$$ENDHEX$$s
	sFind = "ID_ORIAN_MARQUE = " + String ( lOrianMarq ) + " AND " + &
			  "ID_ORIAN_MODELE = " + String ( lOrianModl ) + " AND " + &
			  "ID_FOUR = '" + asFour + "'"
	lNbLgn = idwLstGme.Find ( sFind, 1, idwLstGme.RowCount ())
	If lNbLgn = 0 Then
/*------------------------------------------------------------------*/
/* d$$HEX1$$e900$$ENDHEX$$termination de la gamme n$$HEX1$$e900$$ENDHEX$$gative                               */
/*------------------------------------------------------------------*/
		If asMarque <> "" and asModele <> "" Then
			asLibGamme = "~r~n( Aucune gamme de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence en fonction des codes orian ( " + String ( lOrianMarq ) + ", " + String ( lOrianModl ) + " ) " +  &
							"chez " + dwChild_IdFour.GetItemString ( lLgnIdFour, "LIB_CODE" ) + " )"
		Else
			asLibGamme = "Aucun mobile r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$renc$$HEX2$$e9002000$$ENDHEX$$en adh$$HEX1$$e900$$ENDHEX$$sion ~r~n" + &
							 "( Aucune gamme de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence en fonction des codes orian ( " + String ( lOrianMarq ) + ", " + String ( lOrianModl ) + " ) " + &
							 "chez " + dwChild_IdFour.GetItemString ( lLgnIdFour, "LIB_CODE" ) + " )"
		End If
	Else
/*------------------------------------------------------------------*/
/* d$$HEX1$$e900$$ENDHEX$$termination de la gamme positive                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* marque et mod$$HEX1$$e800$$ENDHEX$$le proviennent de la table gamme selon les codes   */
/* orian. Si pls port correspondent $$HEX2$$e0002000$$ENDHEX$$ces codes orian, on prend le  */
/* 1er                                                              */
/*------------------------------------------------------------------*/
		If asMarque = "" Or asModele = "" Then
			asMarque = idwLstGme.GetItemString ( lNbLgn, "MARQ_PORT" )
			asModele = idwLstGme.GetItemString ( lNbLgn, "MODL_PORT" )
		End If
		lGamme = idwLstGme.GetItemNumber ( lNbLgn, "ID_GAMME" )
		sFiltre = "ID_CODE = " + String ( lGamme )
		lNumLgn = dwChild_IdGamme.Find ( sFiltre, 1, dwChild_IdGamme.Rowcount () )
		asLibGamme = " ( " + dwChild_IdGamme.GetItemString ( lNumLgn, "CF_LIB_GAMME" ) + &
						 " chez " + dwChild_IdFour.GetItemString ( lLgnIdFour, "LIB_CODE" ) + " )"

/*------------------------------------------------------------------*/
/* s$$HEX1$$e900$$ENDHEX$$lection du portable dans la liste                              */
/*------------------------------------------------------------------*/
		sFiltre = "ID_FOUR = '" + asFour + "' AND " + &
					 "ID_GAMME = " + String ( lGamme )
		This.uf_FiltreLstGme ( sFiltre, FALSE )
		This.uf_SelMobAss ( sFind )
	End If
End If

Return lGamme

end function

public subroutine uf_controlerzone (string asnomcol, string asvalcol);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ControlerZone ( PUBLIC )
//* Auteur        : Catherine Abdmeziem
//* Date          : 25/09/2002 16:59:03
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des zones
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asNomCol	:	Nom de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
//*					  ( Val )	String	asValCol	:	Valeur de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Choose Case Upper ( asNomCol )

/*------------------------------------------------------------------*/
/* Choix d'un fournisseur => refilter de la liste des mod$$HEX1$$e800$$ENDHEX$$les +     */
/* refilter de la dddw id_gamme                                     */
/*------------------------------------------------------------------*/
	Case "ID_FOUR"
		This.uf_ZnIdFour ( asValCol )

/*------------------------------------------------------------------*/
/* Choix d'une gamme => refilter de la liste des mod$$HEX1$$e800$$ENDHEX$$les d'apr$$HEX1$$e800$$ENDHEX$$s    */
/* la gamme                                                         */
/*------------------------------------------------------------------*/
	Case "ID_GAMME"
		This.uf_ZnIdGamme ( asValCol )
		
End Choose

end subroutine

private subroutine uf_chargergamme (string asfour);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ChargerGamme	( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 26/09/2002 14:23:02
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement de la dddw des gammes
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asFour	:	Le fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$ou d$$HEX1$$e900$$ENDHEX$$fini
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String				sFiltre
Long					lNbLgn
  
sFiltre = "ID_CODE < 100 AND CF_FOUR = '" + asFour + "'"

idwGme.SetFilter ( sFiltre )
idwGme.Filter ()
idwGme.Sort ()

idwGmeFour.SetFilter ( sFiltre )
idwGmeFour.Filter ()
idwGmeFour.Sort ()

/*------------------------------------------------------------------*/
/* Ajout de la valeur "toutes gammes confondues" dans la zone       */
/* gamme si ce n'est pas d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$fait ( populisation dans sinistre )   */
/*------------------------------------------------------------------*/
/* le rowcount est utile dans le cas d'un fournisseur null (        */
/* codtel <> 21 et donc la dddw n'est pas populis$$HEX2$$e9002000$$ENDHEX$$dans sinistre )  */
/*------------------------------------------------------------------*/
If idwGmeFour.RowCount () > 0 Then
	If idwGmeFour.GetItemNumber ( 1, "ID_CODE" ) <> 0 Then
		This.uf_InsLgnTtesGmes ( asFour )
	End If
Else
	This.uf_InsLgnTtesGmes ( asFour )
End If

end subroutine

public function long uf_getgamme ();//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_GetGamme ( PUBLIC )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 26/09/2002 15:06:45
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Renvoit la gamme
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Long	ilRetGamme	Gamme d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l'initialisation
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

If isnull ( ilRetGamme ) Then ilRetGamme = 0

Return ilRetGamme
end function

private subroutine uf_selmobass (string asfind);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_SelMobAss ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 26/09/2002 15:27:13
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$lection d'un portable dans la liste des mod$$HEX1$$e800$$ENDHEX$$les / gammes
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asFind	:	cha$$HEX1$$ee00$$ENDHEX$$ne permettant la s$$HEX1$$e900$$ENDHEX$$lection d'un portable dans la liste
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long	lNbLgn

lNbLgn = idwLstGme.Find ( asFind, 1, idwLstGme.RowCount ())
If lNbLgn <> 0 Then
	idwLstGme.ScrollToRow ( lNblgn )
	idwLstGme.SetRow ( lNblgn )
	idwLstGme.SetItem ( lNblgn, "AFF_COULEUR", "O" )
	This.uf_ClickLgn ( lNblgn )
End If


end subroutine

private subroutine uf_chargermobassure (boolean abinit, string asmarque, string asmodele, string aslibgamme);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ChargerMobAssure ( PRIVATE )
//* Auteur        : Catherine Abdmeziem
//* Date          : 13/09/2002 17:20:11
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Chargement du libell$$HEX2$$e9002000$$ENDHEX$$de la zone "Mobile Assur$$HEX1$$e900$$ENDHEX$$"
//*
//* Arguments     : ( Val )	Boolean	abInit		:		Indique si l'appel de la fonction est sur initialisation
//*					  ( Val )	String	asMarque		:		Marque
//*					  ( Val )	STring	asModele		:		Mod$$HEX1$$e800$$ENDHEX$$le
//*					  ( Val ) 	String	asLibGamme	:		Libell$$HEX2$$e9002000$$ENDHEX$$de la gamme
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sMobAss

If abInit Then
	If asMarque <> "" and asModele <> "" Then
		sMobAss =  asMarque + ", " + asModele + asLibGamme
	Else
		sMobAss = asLibGamme
	End If
	idwFourGme.SetItem ( 1, "MOBILE_ASSURE", sMobAss )
End If
end subroutine

private function long uf_chargerdw (boolean abinit, string asfour);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ChargerDw ( PRIVATE )
//* Auteur        : Catherine Abdmeziem
//* Date          : 25/09/2002 14:10:03
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Chargement des dw de la fen$$HEX1$$ea00$$ENDHEX$$tre W_Sp_Gamme
//*
//* Arguments     : ( Val ) Boolean	abInit	:	indique si la fonction est appel$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l'initialisation
//*					  ( Val ) String	asFour	:	valeur du fournisseur initialis$$HEX1$$e900$$ENDHEX$$
//*
//* Retourne      : 			 Long		lGamme	:	gamme d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$e (ou non)
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String				sMarque, sModele, sFiltre, sLibGamme, sModif
Long					lNbLgn, lGamme
Boolean				bFilter, bTri, bTrouve, bOk

/*------------------------------------------------------------------*/
/* Initialisation des champs de dw_Four_Gamme :                     */
/* fournisseur, en fonction de cod_tel du produit                   */
/* gamme, en fonction du fournisseur                                */
/* mobile_assur$$HEX4$$e9002000e0002000$$ENDHEX$$partir de dw_wsin de w_tm_sp_sinistre,           */
/*                        du fournisseur et de la gamme             */
/*------------------------------------------------------------------*/
idwFourGme.SetItem ( 1, "ID_FOUR", asFour )

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des donn$$HEX1$$e900$$ENDHEX$$es du sinistre. Affectation de vide si     */
/* null pour tests simplifi$$HEX1$$e900$$ENDHEX$$s + concat$$HEX1$$e900$$ENDHEX$$nation.                      */
/*------------------------------------------------------------------*/
sMarque = idw_WSin.GetItemString ( 1, "MARQ_PORT" )
If IsNull ( sMarque ) Then sMarque = ""
sModele = idw_WSin.GetItemString ( 1, "MODL_PORT" )
If IsNull ( sModele ) Then sModele = ""

/*------------------------------------------------------------------*/
/* Initialisation de la liste avec asFour                           */
/*------------------------------------------------------------------*/
sFiltre = "ID_FOUR = '" + asFour + "'"
This.uf_FiltreLstGme ( sFiltre, FALSE )

bOk = TRUE

If asFour <> "" Then
	bOk = FALSE
	// D$$HEX1$$e900$$ENDHEX$$protection de la zone ID_GAME de dw_Four_Gamme
	sModif = "ID_GAMME.protect = 0 ID_GAMME.background.color = 16777215 ID_GAMME.border = 5"
	lGamme = This.uf_DeterminerGammeSurFour ( asFour, sMarque, sModele, sLibGamme )
End If
If bOk Then
	// asFour = ""
	// Protection de la zone ID_GAME de dw_Four_Gamme
	sModif = "ID_GAMME.protect = 1 ID_GAMME.background.color = 12632256 ID_GAMME.border = 6"

	If sMarque <> "" And sModele <> "" Then
		sLibGamme = " ( Pas de d$$HEX1$$e900$$ENDHEX$$termination de gamme sans fournisseur )"
	Else
		sLibGamme = "Aucun mobile r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$renc$$HEX2$$e9002000$$ENDHEX$$en adh$$HEX1$$e900$$ENDHEX$$sion"
	End If
	idwFourGme.GetChild ( "ID_GAMME", dwChild )

/*------------------------------------------------------------------*/
/* le rowcount est utile dans le cas d'un fournisseur null (        */
/* codtel <> 21 et donc la dddw n'est pas populis$$HEX2$$e9002000$$ENDHEX$$dans sinistre )  */
/*------------------------------------------------------------------*/
	If dwChild.RowCount ( ) > 0 Then
		lGamme = 0
	Else
		lGamme = -1
	End If
End If
idwFourGme.Modify ( sModif )

// Positionnement de la dddw de la gamme.
If lGamme <> - 1 Then
	idwFourGme.SetItem ( 1, "ID_GAMME", lGamme )
Else
	idwFourGme.SetItem ( 1, "ID_GAMME", "" )
End If

uf_ChargerMobAssure ( abInit, sMarque, sModele, sLibGamme )

Return lGamme
end function

private subroutine uf_znidfour (string asvalcol);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ZnIdFour ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 26/09/2002 14:27:06
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Zone ID_FOUR
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asValCol	:	Valeur de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long	lGamme

This.uf_ChargerGamme ( asValCol )
lGamme = This.uf_ChargerDw ( FALSE, asValCol )

end subroutine

private subroutine uf_znidgamme (string asvalcol);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ZnIdGamme ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 26/09/2002 13:17:06
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Zone Id_Gamme
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asValCol	:	Valeur de la colonne modifi$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String	sFiltre, sFind
Long		lGamme, lOrianMarq, lOrianModl

lOrianMarq = idw_WSin.GetItemNumber ( 1, "ID_ORIAN_MARQUE" )
lOrianModl = idw_WSin.GetItemNumber ( 1, "ID_ORIAN_MODELE" )

If asValCol <> "0" Then
	sFiltre = "ID_FOUR = '" + Upper ( idwFourGme.GetItemString ( 1, "ID_FOUR" ) ) + "' AND " + &
				 "ID_GAMME = " + asValCol
Else
	sFiltre = "ID_FOUR = '" + Upper ( idwFourGme.GetItemString ( 1, "ID_FOUR" ) ) + "'"
End If
This.uf_FiltreLstGme ( sFiltre, FALSE )

sFind = "ID_ORIAN_MARQUE = " + String ( lOrianMarq ) + " AND " + &
		  "ID_ORIAN_MODELE = " + String ( lOrianModl )
If Not ( IsNull ( sFind ) ) Then	This.uf_SelMobAss ( sFind )

end subroutine

public subroutine uf_initialiser_dw_desc (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_Initialiser_Dw_Desc ( PUBLIC )
//* Auteur        : Catherine Abdmeziem
//* Date          : 25/09/2002 11:07:10
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Initialisation des dw d'instances
//*
//* Arguments     : ( Ref )	s_Pass	astPass	:	datawindow de la liste des gammes de w_sin
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


idwLstGmeSin	=	astPass.dwNorm [ 2 ]
idwLstCmdeSin	=	astPass.dwNorm [ 3 ]
idwGme			=	astPass.dwNorm [ 4 ]
idwGmeFour		=	astPass.dwNorm [ 5 ]
idwFourGme		=	astPass.dwNorm [ 6 ]
idwLstGme		=	astPass.dwNorm [ 7 ]

end subroutine

private subroutine uf_inslgnttesgmes (string asfour);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_InsLgnTtesGmes ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 02/10/2002 11:20:33
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Ins$$HEX1$$e800$$ENDHEX$$re la ligne toutes gammes confondues
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asFour	:	Id fournisseur
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long lNbLgn


lNbLgn = idwGmeFour.InsertRow ( 1 )
idwGmeFour.SetItem ( lNbLgn, "LIB_CODE", asFour + "/Toutes gammes confondues" )
idwGmeFour.SetItem ( lNbLgn, "ID_CODE", 0 )

end subroutine

public subroutine uf_clicklgn (long alnumcol);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_ClickLgn	( PUBLIC )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 01/10/2002 12:20:29
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Changement de la couleur d'une ligne cliqu$$HEX1$$e900$$ENDHEX$$e sur idwLstGme
//* Commentaires  : 
//*
//* Arguments     : ( Val )	Long	alNumCol	:	Num$$HEX1$$e900$$ENDHEX$$ro de la ligne cliqu$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Integer iCompt
Long lNbLgn

lNbLgn = idwLstGme.RowCount ()

For iCompt = 1 To lNbLgn
	idwLstGme.SetItem ( iCompt, "AFF_COUL_BL", "N" )
Next

idwLstGme.SetItem ( alNumCol, "AFF_COUL_BL", "O" )

end subroutine

private subroutine uf_filtrelstgme (string asfiltre, boolean absel);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gamme::uf_FiltreLstGme ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 02/10/2002 11:35:02
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Filtre la liste des mod$$HEX1$$e800$$ENDHEX$$les / gammes
//* Commentaires  : ( + d$$HEX1$$e900$$ENDHEX$$finition de la couleur des lignes sur fl$$HEX1$$e800$$ENDHEX$$che )
//*
//* Arguments     : ( Val )	String	asFiltre	:	Filtre $$HEX2$$e0002000$$ENDHEX$$appliquer
//*					  ( Val )	Boolean	abSel		:	indique si un portable est s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

idwLstGme.SetFilter ( asFiltre )
idwLstGme.Filter ()
idwLstGme.Sort ()

If Not ( abSel ) Then This.uf_ClickLgn ( 1 )
end subroutine

on n_cst_gamme.create
TriggerEvent( this, "constructor" )
end on

on n_cst_gamme.destroy
TriggerEvent( this, "destructor" )
end on

