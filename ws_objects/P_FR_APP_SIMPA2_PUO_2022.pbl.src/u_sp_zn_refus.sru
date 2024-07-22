HA$PBExportHeader$u_sp_zn_refus.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux motifs de refus
forward
global type u_sp_zn_refus from u_spb_zn_anc
end type
end forward

global type u_sp_zn_refus from u_spb_zn_anc
end type
global u_sp_zn_refus u_sp_zn_refus

forward prototypes
public function string uf_zn_controlersaisie (datawindow adw)
end prototypes

public function string uf_zn_controlersaisie (datawindow adw);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_ControlerSaisie ()
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 15:16:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le si un paragraphe et une nature de motif
//*					  de refus a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisie pour chaque motif de refus.
//* Arguments		: Datawindow aDw ( Val ) : datawindow $$HEX2$$e0002000$$ENDHEX$$controler.
//*
//* Retourne		: String	"" ->	OK, sinon colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol[ 1 ]		// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr[ 1 ]		// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne	// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText				// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos				// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal				// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long 			lCpt				// Compteur : nombre lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long 			lCpt2				// Compteur : nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrLig			// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol			// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sCol[ 1 ]		= "ID_PARA"

sErr[ 1 ]		= " - Le paragraphe"

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrCol			= UpperBound ( sCol )
lNbrLig			= aDw.RowCount ()

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

If lNbrLig > 0	Then

	For lCpt = 1	To lNbrLig

		For	lCpt2 = 1 To lNbrCol

			sVal = aDw.GetItemString ( lCpt, sCol[ lCpt2 ] )
			If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

				If sPos = "" Then sPos = sCol[ lCpt2 ]
				sText = sText + sErr[ lCpt2 ] + sNouvelleLigne

			End If

		Next

		If sPos <> ""	Then

			aDw.SetRow ( lCpt )
			exit

		End If

	Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

	If	sPos <> "" Then

		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des motifs de refus"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = sText
		stMessage.sCode	= "GENE001"

		f_Message ( stMessage )

	End If

End If

Return ( sPos )
end function

on u_sp_zn_refus.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_refus.destroy
TriggerEvent( this, "destructor" )
end on

