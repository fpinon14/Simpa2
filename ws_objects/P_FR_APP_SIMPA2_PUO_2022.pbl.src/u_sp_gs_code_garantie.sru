HA$PBExportHeader$u_sp_gs_code_garantie.sru
$PBExportComments$-} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux codes garantie.
forward
global type u_sp_gs_code_garantie from nonvisualobject
end type
end forward

global type u_sp_gs_code_garantie from nonvisualobject
end type
global u_sp_gs_code_garantie u_sp_gs_code_garantie

type variables
u_Transaction	itrTrans	// Objet de transaction par d$$HEX1$$e900$$ENDHEX$$faut

u_DataWindow	idwPieces,	&
		idwRefus,	&
		idwCodCon


u_Ajout		iuAjout
end variables

forward prototypes
public function boolean uf_terminervalider ()
public function boolean uf_gs_codrgptstatexiste (string ascodrgptstat)
public function boolean uf_preparervalider (long adcidprod)
public function string uf_presencecodegarantie ()
public function string uf_controlersaisie ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout, ref u_datawindow adwpieces, ref u_datawindow adwrefus, ref u_datawindow adwcodcon)
public function string uf_presencemotifrefus ()
public function string uf_presencepieceevenement ()
end prototypes

public function boolean uf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_TerminerValider ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	03/07/1997 12:20:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Update les Datawindows : Code garanties et les DW li$$HEX1$$e900$$ENDHEX$$es.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------

Boolean	bRet		// Valeur de retour de la fonction.

bRet		= True


If iuAjout.Dw_Source.Update ( ) = -1	Then

	bRet = False

Else

	If iDwPieces.Update ( ) = -1	Then

		bRet = False

	Else

		If iDwRefus.Update ( ) = -1	Then

			bRet = False

		Else

			iDwCodCon.SetFilter ( "" )
			iDwCodCon.Filter    (    )
			If iDwCodCon.Update (    ) = -1	Then		bRet = False

		End If

	End If

End If

Return ( bRet )
end function

public function boolean uf_gs_codrgptstatexiste (string ascodrgptstat);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Gs_CodRgptStatExiste ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	02/07/1997 17:10:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste si le Cod Rgpt Stat pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre existe dans la table des
//*					 	codes.
//* Commentaires	: 
//*
//* Arguments		:	String		asCodRgptStat	( Val ) : Valeur du code de regroupement.
//*
//* Retourne		:	Boolean		True  existe
//*										False n'existe pas
//*
//*-----------------------------------------------------------------

DataWindowChild	dwCodRgptStat // DropDownDataWindow des codes de regroupement des stats.
Boolean 				bRet			  // Valeur de retour de la fonction
Long					lNumLig		  // Num$$HEX1$$e900$$ENDHEX$$ro de la ligne dans dwCodRgptStat.

bRet = False

/*--------------------- --------------------------------------------*/
/* Si on trouve le code dans la DDDW, on renvoit TRUE.              */
/*------------------------------------------------------------------*/
iuAjout.dw_Source.GetChild ( "COD_RGPT_STAT" , dwCodRgptStat )

lNumLig = 	dwCodRgptStat.Find &
				( "ID_CODE = " + asCodRgptStat, 1 , dwCodRgptStat.RowCount ( ) )

If lNumLig > 0 Then bRet = True

Return ( bRet )
end function

public function boolean uf_preparervalider (long adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_PreparerValider ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	03/05/1997 13:11:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rifie s'il est possible de supprimer le code garantie.
//*
//* Arguments		: Long		adcIdProd	( Val )	: identifiant du produit.
//*
//* Retourne		: Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.

String	sLibGti			// Variable correspondant au libell$$HEX2$$e9002000$$ENDHEX$$de la garantie $$HEX2$$e0002000$$ENDHEX$$supprimer.
String	sFiltre			// Chaine filtrant les Dw li$$HEX1$$e900$$ENDHEX$$es.

Long		lNbGarantie		// Nombre garantie d$$HEX1$$e900$$ENDHEX$$finies avec ce code.
Long		dcIdGti			// Variable correspondant $$HEX2$$e0002000$$ENDHEX$$la garantie $$HEX2$$e0002000$$ENDHEX$$supprimer.
Long 		lCpt				// Compteur : nombre de lignes dans une Dw.			
Long		lNbLigCib		// Nombre de lignes dans Dw_Cible.
Long		lNbLigRch		// Nombre de lignes dans Dw_Recherche.
Long		lRet				// N$$HEX2$$b0002000$$ENDHEX$$d'une ligne renvoy$$HEX2$$e9002000$$ENDHEX$$par un find.

bRet 			= True
sFiltre		= ""
lNbLigCib	= iuAjout.Dw_Cible.RowCount ()
lNbLigRch	= iuAjout.Dw_Recherche.RowCount ()


For	lCpt = 1 To lNbLigCib

	/*------------------------------------------------------------------*/
	/* si une ligne est dans la Dw_Cible mais ne se trouve pas dans 	  */
	/* Dw_Recherche c'est qu'elle vient d'$$HEX1$$ea00$$ENDHEX$$tre supprim$$HEX1$$e900$$ENDHEX$$e de Dw_Source   */
	/*------------------------------------------------------------------*/
	dcIdGti 	= iuAjout.dw_Cible.GetItemNumber ( lCpt, "ID_GTI" )
	sLibGti	= iuAjout.dw_Cible.GetItemString ( lCpt, "LIB_GTI" )
	lRet		= iuAjout.dw_Recherche.Find ( "ID_GTI=" + String ( dcIdGti ) , 1, lNbLigrch ) 
 
	If lRet = 0	Then

		/*------------------------------------------------------------------*/
		/* Recherche si cette garantie peut-$$HEX1$$ea00$$ENDHEX$$tre supprim$$HEX1$$e900$$ENDHEX$$e                  */
		/*------------------------------------------------------------------*/
	   itrTrans.IM_S03_GARANTIE ( adcIdProd, dcIdGti, lNbGarantie )

		If ( lNbGarantie <> 0 ) Or Not F_Procedure ( stMessage, itrTrans, "IM_S03_GARANTIE" ) Then

			bRet = False
			Exit

		End If

	End If

Next


If Not ( bRet ) Then

	stMessage.sTitre  = "Validation Impossible"
	stMessage.Icon		= StopSign!
	stMessage.sVar[1] = sLibGti
	stMessage.sCode   = "REFU011"
	f_Message ( stMessage )

End If

Return ( bRet )
end function

public function string uf_presencecodegarantie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_PresenceCodeGarantie
//* Auteur			:	YP
//* Date				:	10/11/1997 10:12:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins un code garantie d$$HEX1$$e900$$ENDHEX$$fini
//*						pour le produit. Si oui, teste s'il existe au moins
//*						une pi$$HEX1$$e800$$ENDHEX$$ce, un motif, un Evt pour chaque garantie.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------

String		sPos			// Valeur de retour de la fonction

If iuAjout.Dw_Source.RowCount () = 0 then

	sPos = "ID_GTI"

	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le d'existence des codes garanties"
	stMessage.Icon		= Information!
	stMessage.sCode	= "GENE009"
	stMessage.sVar[1] = "une garantie"
	stMessage.sVar[2] = "e"

	f_Message ( stMessage )
	
End If

Return ( sPos )
end function

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie ()
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 23/04/1997 17:20:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que tous les champs obligatoire ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisie pour
//*					  toutes les codes garantie.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String 	""  --> Contr$$HEX1$$f400$$ENDHEX$$le de saisie Ok
//*											  Nom de la colonne en erreur					
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* TEST0002          20/11/97          20/11/97				  YP
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]		// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr [ 3 ]		// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sVal [ 3 ]		// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String 		sNouvelleLigne	// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText				// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sPos				// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$

Long 			lCptLig 			// Compteur pour les lignes
Long			lNbrLig			// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long 			lCptCol 			// Compteur pour les colonnes
Long			lNbrCol			// Nombre de colonnes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier

sCol [ 1 ]		= "MT_CMT"
sCol [ 2 ]		= "COD_RGPT_STAT"
sCol [ 3 ]		= "LIB_GTI"

/*------------------------------------------------------------------*/
/* TEST0002 : Modification du message pour le groupe statistique    */
/* non renseign$$HEX1$$e900$$ENDHEX$$.                                                   */
/*------------------------------------------------------------------*/
sErr [ 1 ]		= " - Le montant provisionn$$HEX1$$e900$$ENDHEX$$"
sErr [ 2 ]		= " - Le groupe statistique"
sErr [ 3 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de la garantie"

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrLig			= iuAjout.Dw_Source.RowCount ()
lNbrCol			= UpperBound ( sCol )

If lNbrLig > 0	Then

	For lCptLig = 1	To lNbrLig

		For lCptCol = 1	To	lNbrCol

			If lCptCol = 3 Then 

				sVal [ lCptCol ] = iuAjout.Dw_Source.GetItemString ( lCptLig, sCol [ lCptCol ] )

			Else

				sVal [ lCptCol ] = String ( iuAjout.Dw_Source.GetItemNumber ( lCptLig, sCol [ lCptCol ] ) )

			End If

			If IsNull ( sVal [ lCptCol ] ) or Trim ( sVal [ lCptCol ] ) = ""	Then

				If sPos = "" Then sPos = sCol [ lCptCol ]
				sText = sText + sErr [ lCptCol ] + sNouvelleLigne

			End If

		Next
	
		If sPos <> ""	Then

			iuAjout.Dw_Source.SetRow ( lCptLig )
			exit

		End If

	Next

	/*------------------------------------------------------------------*/
	/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
	/*------------------------------------------------------------------*/
	If	sPos <> "" Then

		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des garanties"
		stMessage.Icon		= Information!
		stMessage.sCode	= "GENE001"
		stMessage.sVar[1] = sText

		f_Message ( stMessage )

	End If

End If

Return ( sPos )
end function

public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout, ref u_datawindow adwpieces, ref u_datawindow adwrefus, ref u_datawindow adwcodcon);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Initialisation
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 14:23:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des variables d'instance
//*
//* Commentaires	: 
//*
//* Arguments		:	u_Transaction		atrTrans		( Val )
//*					 	u_Ajout				auAjout		( Ref )
//*					 	u_Datawindow		aDwPieces	( Ref )
//*					 	u_Datawindow		aDwRefus		( Ref )
//*					 	u_Datawindow		aDwCodCon	( Ref )
//*	
//* Retourne		:	Rien
//*										
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
iDwPieces	= adwPieces
iDwRefus		= adwRefus
iDwCodCon	= adwCodCon


end subroutine

public function string uf_presencemotifrefus ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_PresenceMotifRefus
//* Auteur			:	YP
//* Date				:	09/12/1997 10:12:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins
//*						une pi$$HEX1$$e800$$ENDHEX$$ce, un motif, un Evt pour chaque garantie.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------

String		sLibGar		// Libell$$HEX2$$e9002000$$ENDHEX$$de la garantie
String		sMessRefus	// Libelle afficher en cas d'absence de refus uniquement.

Long			li				// Variable de compteur

Long			lNbGar		// Nombre de garantie sans motif de refus, sert $$HEX2$$e0002000$$ENDHEX$$distinguer
								// le singulier du pluriel pour le message de confirmation

Decimal{0}	dcIdGti 		//Variable relative $$HEX2$$e0002000$$ENDHEX$$la garantie.


lNbGar = 0

For li = 1 To iuAjout.Dw_Source.RowCount ()

	dcIdGti = iuAjout.Dw_Source.GetItemNumber ( li, "ID_GTI" )
	sLibGar = iuAjout.Dw_Source.GetItemString ( li, "LIB_GTI" )

	/*------------------------------------------------------------------*/
	/* Y a t-il un motif de refus pour la garantie courante ?           */
	/* S'il ne manque que des motifs de refus, on demande simplement    */
	/* s'il est normal que les motifs soient absents                    */
	/*------------------------------------------------------------------*/

	If ( idwRefus.Find ( "ID_GTI=" + String ( dcIdGti ) , 1, idwRefus.RowCount() ) = 0 ) Then

			lNbGar ++
			sMessRefus = sMessRefus + "~r~n~t- " + sLibGar

	End If

Next

If ( sMessRefus <> "" ) Then

	If ( lNbGar = 1 ) Then

		/*------------------------------------------------------------------*/
		/* S'il n'y a qu'une garantie en cause, on vire la chaine "~r~n~t-  */
		/* ".                                                               */
		/*------------------------------------------------------------------*/
		sMessRefus = Mid ( sMessRefus , 6 )

		sMessRefus = "- Il n'y a pas de motif de refus pour la garantie " + sMessRefus + ".~r~n~r~nEst-ce normal ?"

	Else

		sMessRefus = "- Il n'y a pas de motif de refus pour les garanties suivantes : " + sMessRefus + ".~r~n~r~nEst-ce normal ?"

	End If

End If

Return ( sMessRefus )
end function

public function string uf_presencepieceevenement ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_PresencePieceEvenement
//* Auteur			:	YP
//* Date				:	09/12/1997 11:51:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins
//*						une pi$$HEX1$$e800$$ENDHEX$$ce, un motif, un Evt pour chaque garantie.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

String		sMessage		// Message d'erreur en cas d'absence d'un code condition.
String		sLibGar		// Libell$$HEX2$$e9002000$$ENDHEX$$de la garantie.
String		sGarantie	// Message pour la garantie.
String		sManque		// Message pour les entit$$HEX1$$e900$$ENDHEX$$s manquantes.

Long			li				// Variable de compteur

Decimal{0}	dcIdGti 		//Variable relative $$HEX2$$e0002000$$ENDHEX$$la garantie.

idwPieces.SetFilter ( "" )
idwPieces.Filter ( )

For li = 1 To iuAjout.Dw_Source.RowCount ( )

	sGarantie	= ""
	sManque		= ""

	dcIdGti = iuAjout.Dw_Source.GetItemNumber ( li, "ID_GTI" )
	sLibGar = iuAjout.Dw_Source.GetItemString ( li, "LIB_GTI" )

	/*-------------------------------------------------------------------*/
	/* Y a t-il une pi$$HEX1$$e800$$ENDHEX$$ce pour la garantie courante ?                    */
	/*-------------------------------------------------------------------*/
	If ( idwPieces.Find ( "ID_GTI=" + String ( dcIdGti ) , 1, idwPieces.RowCount() ) = 0 ) Then

		sGarantie = "- Pour la garantie " + sLibGar + " : il manque "
		sManque = sManque + "une pi$$HEX1$$e800$$ENDHEX$$ce"

	End If


	/*------------------------------------------------------------------*/
	/* Y a t-il un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement pour la garantie courante ?                */
	/*------------------------------------------------------------------*/
	If ( idwCodCon.Find ( "ID_TYP_CODE = '+EV' AND ID_GTI=" + String ( dcIdGti ) , 1, idwCodCon.RowCount() ) = 0 ) Then

		If ( sGarantie = "" ) Then 

			sGarantie = "- Pour la garantie " + sLibGar + " : il manque "
			sManque = sManque + "un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement"

		Else

			sManque = sManque + ", un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement"

		End If

	End If

	If ( sGarantie <> "" ) Then

		sMessage = sMessage + sGarantie + sManque + " ~r~n"

	End If


Next

Return ( sMessage )
end function

on u_sp_gs_code_garantie.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_code_garantie.destroy
TriggerEvent( this, "destructor" )
end on

