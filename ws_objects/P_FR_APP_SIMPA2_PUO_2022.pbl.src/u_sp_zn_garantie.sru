HA$PBExportHeader$u_sp_zn_garantie.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux garanties.
forward
global type u_sp_zn_garantie from u_spb_zn_anc
end type
end forward

global type u_sp_zn_garantie from u_spb_zn_anc
end type
global u_sp_zn_garantie u_sp_zn_garantie

forward prototypes
public function string uf_zn_controlersaisie ()
end prototypes

public function string uf_zn_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_Zn_ControlerSaisie() ( Public )
//* Auteur			:	V.Capelle
//* Date				:	04/11/1997 15:33:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des champs d'une garantie
//* Commentaires	:	
//*
//* Arguments		: 	Aucun
//*
//* Retourne		: 	String	"" ->	OK, sinon colonne en erreur
//*
//*-----------------------------------------------------------------
String 		sCol[ 6 ]		// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr[ 6 ]		// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne	// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText				// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos				// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal				// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol			// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lCpt				// Compteur de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sCol[ 1 ]		= "ID_PROD"
sCol[ 2 ]		= "ID_REV"
sCol[ 3 ]		= "ID_GTI"
sCol[ 4 ]		= "ID_POLICE"
sCol[ 5 ]		= "COD_TYP_FRA"
sCol[ 6 ]		= "COD_RADICAL"


sErr[ 1 ]		= " - Le produit"
sErr[ 2 ]		= " - La r$$HEX1$$e900$$ENDHEX$$vision"
sErr[ 3 ]		= " - La garantie"
sErr[ 4 ]		= " - La police"
sErr[ 5 ]		= " - Le type de franchise"
sErr[ 6 ]		= " - Le code radical"

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrCol			= UpperBound ( sCol )


/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	sVal = String ( iDw_1.GetItemNumber ( 1, sCol[ lCpt ] ) )
	If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

		If sPos = "" Then sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next


/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

If	sPos <> "" Then

	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Pi$$HEX1$$e800$$ENDHEX$$ces"
	stMessage.Icon		= Information!
	stMessage.sVar[1] = sText
	stMessage.sCode	= "GENE001"
	f_Message ( stMessage )

End If



Return ( sPos )
end function

on u_sp_zn_garantie.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_garantie.destroy
TriggerEvent( this, "destructor" )
end on

