HA$PBExportHeader$u_sp_gs_courrier.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux Courrier d'un Produit
forward
global type u_sp_gs_courrier from nonvisualobject
end type
end forward

global type u_sp_gs_courrier from nonvisualobject
end type
global u_sp_gs_courrier u_sp_gs_courrier

type variables
u_Transaction	itrTrans	// Objet de transaction par d$$HEX1$$e900$$ENDHEX$$faut
u_Ajout			iuAjout
u_datawindow	iDwParagraphes
end variables

forward prototypes
public function boolean uf_terminervalider ()
public function string uf_controlersaisie ()
public function string uf_presencecourrier ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout, ref u_datawindow aDwParagraphes)
end prototypes

public function boolean uf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_TerminerValider ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 14:19:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Update de la Datawindow Source de l'objet UO_COURRIER.
//*
//* Arguments		: 
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	02/05/2007	DCMP 070051 - 	Mise $$HEX2$$e0002000$$ENDHEX$$jour de la datawindow des paragraphes
//*-----------------------------------------------------------------

Boolean	bRet	= True		// Valeur de retour de la fonction.

// #1 - toutes les mises $$HEX2$$e0002000$$ENDHEX$$jour se font sur la datawindow invisible qui est [dw_paragraphes]
//If iuAjout.Dw_Source.Update () = -1	Then	
//	bRet = False
//
//end if

if iDwParagraphes.Update ( ) = -1	then
	bRet = false

end if
// FIN - #1 

Return ( bRet )
end function

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie ()
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 01/07/1997 14:02:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que tous les champs obligatoire ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisie pour
//*					  tous les courriers.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String 	""  --> Contr$$HEX1$$f400$$ENDHEX$$le de saisie Ok
//*											  Nom de la colonne en erreur					
//*
//*-----------------------------------------------------------------

String 		sCol [ 1 ]		// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr [ 1 ]		// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sVal [ 1 ]		// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String 		sNouvelleLigne	// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText				// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sPos				// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$

Long 			lCptLig 			// Compteur pour les lignes
Long			lNbrLig			// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long 			lCptCol 			// Compteur pour les colonnes
Long			lNbrCol			// Nombre de colonnes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier

sCol [ 1 ]		= "ID_COUR"

sErr [ 1 ]		= " - Le code du courrier type"

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrLig			= iuAjout.Dw_Source.RowCount ()
lNbrCol			= UpperBound ( sCol )

If lNbrLig > 0	Then

	For lCptLig = 1	To lNbrLig

		For lCptCol = 1	To	lNbrCol

			sVal [ lCptCol ] = String ( iuAjout.Dw_Source.GetItemString ( lCptLig, sCol [ lCptCol ] ) )

			If IsNull ( sVal [ lCptCol ] ) or Trim ( sVal [ lCptCol ] ) = ""	Then

				If sPos = "" Then sPos = sCol [ lCptCol ]
				sText = sText + sErr [ lCptCol ] + sNouvelleLigne

			End If

		Next
	
		If sPos <> ""	Then

			iuAjout.Dw_Source.SetRow ( lCptLig )
			Exit

		End If

	Next

	/*------------------------------------------------------------------*/
	/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
	/*------------------------------------------------------------------*/
	If	sPos <> "" Then

		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des courriers"
		stMessage.Icon		= Information!
		stMessage.sCode	= "GENE001"
		stMessage.sVar[1] = sText

		f_Message ( stMessage )

	End If

End If

Return ( sPos )
end function

public function string uf_presencecourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_PresenceCourrier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	01/07/1997 14:36:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins un courrier d$$HEX1$$e900$$ENDHEX$$fini pour le produit.
//*
//* Commentaires	: 
//*
//* Arguments		:	
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------

String		sMess		// Valeur de retour de la fonction.

If iuAjout.Dw_Source.RowCount () = 0 then

	sMess = "- Il n'y a aucun courrier.~r~n"
	
End If

Return ( sMess )
end function

public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout, ref u_datawindow aDwParagraphes);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Initialisation
//* Auteur			:	JCA
//* Date				:	02/05/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des variables d'instance
//*
//* Commentaires	: 
//*
//* Arguments		:	u_Transaction		atrTrans		( Val )
//*					 	u_Ajout				auAjout		( Ref )
//*					 	u_Datawindow		aDwParagraphes	( Ref )
//*	
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation de l'objet de transaction.                        */
/*------------------------------------------------------------------*/
itrtrans		= atrTrans

/*------------------------------------------------------------------*/
/* Initialisation le l'objet d'ajout.                               */
/*------------------------------------------------------------------*/
iuAjout = auAjout

/*------------------------------------------------------------------*/
/* Initialisation de Dw de travail.                                 */
/*------------------------------------------------------------------*/
iDwParagraphes	= aDwParagraphes


end subroutine

on u_sp_gs_courrier.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_courrier.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

