HA$PBExportHeader$u_sp_gs_affilier.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les relatifs aux cartes affili$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$une garantie
forward
global type u_sp_gs_affilier from u_sp_gs_anc_u_ajout
end type
end forward

global type u_sp_gs_affilier from u_sp_gs_anc_u_ajout
end type
global u_sp_gs_affilier u_sp_gs_affilier

forward prototypes
public function string uf_controlersaisie ()
public function boolean uf_terminervalider ()
public function boolean uf_initcartes ()
end prototypes

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie ()
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 14:28:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que la date d'affiliation a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisie 
//*					  pour toutes les cartes affili$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la garantie.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: String 	""  --> Contr$$HEX1$$f400$$ENDHEX$$le de saisie Ok
//*									Nom de la colonne en erreur					
//*
//*-----------------------------------------------------------------

String 		sCol[ 1 ]		// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[ 1 ]		// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String 		sNouvelleLigne	// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText				// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sPos				// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$
String		sVal				// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long 			lCptLig 			// Compteur pour les lignes
Long			lNbrLig			// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier

sCol[ 1 ]		= "DTE_AFFILIATION"

sErr[ 1 ]		= " - La date d'affiliation"

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrLig			= iuAjout.Dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

If lNbrLig > 0	Then

	For lCptLig = 1	To lNbrLig

		sVal = String ( iuAjout.Dw_Source.GetItemDateTime ( lCptLig, sCol[ 1 ] ) ) // [PI056] date-> datetime
		If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

			If sPos = "" Then sPos = sCol[ 1 ]
			sText = sText + sErr[ 1 ] + sNouvelleLigne

		End If

		If sPos <> ""	Then
			iuAjout.Dw_Source.SetRow 		( lCptLig )
			exit

		End If

	Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

	If	sPos <> "" Then

		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des cartes"
		stMessage.Icon		= Information!
		stMessage.sCode	= "GENE"

		stMessage.sVar[1] = sText
		stMessage.sCode	= stMessage.sCode + "001"

		f_Message ( stMessage )

		
	End If

End If

Return ( sPos )
end function

public function boolean uf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_Terminervalider
//* Auteur			:	V.Capelle
//* Date				:	07/11/1997 14:33:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$clenche l'update pour les cartes affili$$HEX1$$e900$$ENDHEX$$es $$HEX1$$e000$$ENDHEX$$
//*						une garantie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en		Vrai si l'update s'est bien pass$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------
Boolean		bRet = True		// Valeur de retour de la fonction

If ( iuAjout.Dw_Source.Update () = -1 ) Then bRet = False

Return ( bRet )
end function

public function boolean uf_initcartes ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_ReinitCartesAffilier ( Public )
//* Auteur			:	V.Capelle
//* Date				:	12/11/1997 16:14:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise l'u_ajout des cartes affili$$HEX1$$e900$$ENDHEX$$es au produit
//* Commentaires	:	
//*
//* Arguments		:	
//*
//* Retourne		: Boolean.
//*
//*-----------------------------------------------------------------
//* #1	JCA		15/11/2006		DCMP 060825 - trie par id_carte
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Permet de populiser les informations dans la Datawindow de Recherche       */
/* pour les cartes couvertes                                                  */
/*----------------------------------------------------------------------------*/

iUAjout.Uf_dwRechercheRetrieve ( "", iUAjout )

iUAjout.Dw_Recherche.RowsCopy  ( 1, iUAjout.Dw_Recherche.RowCount ( ), PRIMARY!, &
                                 iUAjout.Dw_Cible, 1                 , PRIMARY! )


/*----------------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source pour les cartes        */
/* couvertes                                                                  */
/*----------------------------------------------------------------------------*/
iUAjout.Uf_dwSourceRetrieve ( "", iUAjout )

iUAjout.Dw_Cible.SetSort    ( "id_carte A" ) // #1
iUAjout.Dw_Cible.Sort       ( )

iUAjout.Dw_Source.SetSort   ( "id_carte A" ) // #1
iUAjout.Dw_Source.Sort      ( )


Return ( TRUE )
end function

on u_sp_gs_affilier.create
call super::create
end on

on u_sp_gs_affilier.destroy
call super::destroy
end on

