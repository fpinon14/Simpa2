HA$PBExportHeader$u_sp_zn_plafonds.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux  plafonds
forward
global type u_sp_zn_plafonds from u_spb_zn_anc
end type
end forward

global type u_sp_zn_plafonds from u_spb_zn_anc
end type
global u_sp_zn_plafonds u_sp_zn_plafonds

forward prototypes
public function string uf_zn_controlersaisie (datawindow adwplafond)
private function boolean uf_zn_plafond (datawindow adw_source)
private function boolean uf_zn_plafondexistedeja (datawindow adwsource)
end prototypes

public function string uf_zn_controlersaisie (datawindow adwplafond);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_controlersaisie
//* Auteur			:	V.Capelle
//* Date				:	25/11/1997 11:13:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle si le plafond et le paragraphe ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi.
//* Commentaires	:	
//*
//* Arguments		:	Datawindow    adwplafond	Datawindow source
//*
//* Retourne		: String			"" si OK
//*										colonne en erreur sinon.
//*
//*-----------------------------------------------------------------
String 		sCol[ 1 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr[ 1 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long 			lCpt					// Compteur : nombre lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long 			lCpt2					// Compteur : nombre de colonnes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrLig				// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sCol[ 1 ]		= "MT_PLAF"

sErr[ 1 ]		= " - Tous les montants"


sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrCol			= UpperBound ( sCol )
lNbrLig			= aDwPlafond.RowCount ()

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

If lNbrLig > 0	Then

	For lCpt = 1	To lNbrLig

		For	lCpt2 = 1 To lNbrCol

			If sCol[ lCpt2 ] = "MT_PLAF" Then

				sVal = String ( aDwPlafond.GetItemNumber ( lCpt, sCol[ lCpt2 ] ) )

			Else

				sVal = aDwPlafond.GetItemString ( lCpt, sCol[ lCpt2 ] )

			End If
			If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

				If sPos = "" Then sPos = sCol[ lCpt2 ]
				sText = sText + sErr[ lCpt2 ] + sNouvelleLigne

			End If

		Next

		If sPos <> ""	Then

			aDwPlafond.SetRow ( lCpt )
			exit

		End If

	Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

	If	sPos <> "" Then

		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des plafonds"
		stMessage.Icon		= Information!
		stMessage.sCode	= "GENE001"
		stMessage.sVar[1] = sText


		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* On teste s'il y a des paragraphes non renseign$$HEX1$$e900$$ENDHEX$$s dans            */
		/* Uo_PLafonds.Dw_Source, si c'est le cas et que l'utilisateur      */
		/* souhaite les saisir alors on stoppe la sortie et on se           */
		/* positionne sur le premier paragraphe manquant.                   */
		/*------------------------------------------------------------------*/
		If Not Uf_Zn_Plafond ( aDwPlafond ) Then

			sPos = "ID_PARA"
			
		Else

			If Uf_Zn_PlafondExisteDeja ( aDwPlafond ) Then
	
				sPos = "MT_PLAF"

			End If
	
		End If

	End If

End If

Return ( sPos )
end function

private function boolean uf_zn_plafond (datawindow adw_source);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_plafond ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			:	V.Capelle
//* Date				:	25/11/1997 11:16:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	teste si des paragraphes n'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$cis$$HEX1$$e900$$ENDHEX$$, l'indique $$HEX1$$e000$$ENDHEX$$
//*					   l'utilisateur et se positionne sur la bonne ligne si l'utilisateur
//*						souhaite le renseigner.
//* Commentaires	:	
//*
//* Arguments		: adw_source 	datawindow  : Datawindow dans laquelle on teste la
//*                                            pr$$HEX1$$e900$$ENDHEX$$sence de paragraphes.
//*
//* Retourne		: Boolean	False  : Paragraphe manquant et l'utilisateur souhaite le 
//*      								      renseign$$HEX1$$e900$$ENDHEX$$, on ne continue pas la sortie
//*									True   : Pas de paragraphe manquant, on peut continuer.
//*					
//*-----------------------------------------------------------------
Boolean		bRet					//Valeur de retour de la fonction.
Long 			lNbrLig				//Nombre de ligne dans la dw adw_source.
Long			lNumLig				//Num$$HEX1$$e900$$ENDHEX$$ro de la premi$$HEX1$$e800$$ENDHEX$$re ligne o$$HEX2$$f9002000$$ENDHEX$$le paragrpahe est manquant.
Integer		iReponse				//Reponse $$HEX2$$e0002000$$ENDHEX$$la question utilisateur.


/*------------------------------------------------------------------*/
/* SI on trouve un paragraphe non renseign$$HEX1$$e900$$ENDHEX$$, on demande $$HEX12$$e00020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* l'utilisateur s'il veut le saisir. Dans ce cas on le positionne  */
/* sur le premier paragraphe non renseign$$HEX2$$e9002000$$ENDHEX$$et on ne sortira plas    */
/* de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                                   */
/*------------------------------------------------------------------*/

lNumLig = 0
bRet    = True

lNbrLig = Adw_Source.RoWCount()

lNumLig = Adw_Source.Find ( "IsNull(ID_PARA) or ID_PARA=''" , 1 , lNbrLig )

If lNumLig > 0 Then

	stMessage.bouton  = YesNo!
	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Plafonds"
	stMessage.sVar[1] = "Un plafond"
	stMessage.Icon		= Question!
	stMessage.sCode	= "CONF005"

	iReponse = f_Message ( stMessage )

	If iReponse = 1 Then

		Adw_Source.SetRow ( lNumLig )

		bRet = False

	End If

End If

Return ( bRet )
end function

private function boolean uf_zn_plafondexistedeja (datawindow adwsource);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_plafondexistedeja ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			: Y. Picard
//* Date				: 03/02/97 14:17:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie pour chaque plafond saisi s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un 
//*						indicateur (territorialit$$HEX1$$e900$$ENDHEX$$, nature de sinistre, garantie ...)
//*                  sur lequel ce plafond a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi pour en avertir l'utilisateur.
//* Commentaires	: 
//*
//* Arguments		: adwSource		DataWindow	: DataWindow des plafonds.
//*
//* Retourne		: String			= False Si les plafonds saisis ne l'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$sur
//*													d'autres indicateurs.
//*										= True  Si un plafond saisi l'a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$sur un autre
//*													indicateur.
//*
//*-----------------------------------------------------------------
Boolean		bRet					= False		//Valeur de retour de la fonction.
Long			lCpt									//Premier indice de boucle.
Long			lCpt2									//Deuxi$$HEX1$$e800$$ENDHEX$$me indice de boucle.
Long			lNbrLig								//Nombre de ligne dans adwSource (PRIMARY!).
Long			lNbrLig2								//Nombre de ligne dans adwSource (FILTER! ).
String		sIdTypPlaf							//type du plafond saisi.
String		sIdTypPlafFiltre					//Type de plafond saisi sur un autre indicateur.
String		sIndicateur			= ""			//Indicateur sur lequel un plafond a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi.
Integer		iReponse								//Reponse de l'utilisateur.

lNbrLig  = adwSource.RowCount ( ) 
lNbrLig2 = adwSource.FilteredCount ( )

For lCpt = 1 to lNbrLig


	/*------------------------------------------------------------------*/
	/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le type de plafond saisi                             */
	/*------------------------------------------------------------------*/
	sIdTypPlaf = adwSource.GetItemString ( lCpt , "ID_TYP_PLAF" )

	/*------------------------------------------------------------------*/
	/* On cherche le plafond dans les autres indicateurs (qui ont $$HEX1$$e900$$ENDHEX$$t$$HEX4$$e900200020002000$$ENDHEX$$*/
	/* filtr$$HEX1$$e900$$ENDHEX$$s)                                                         */
	/*------------------------------------------------------------------*/
	For lCpt2 = 1 to lNbrLig2

		sIdTypPlafFiltre = adwSource.GetItemString ( lCpt2 , "ID_TYP_PLAF" , FILTER! , True )

		If sIdTypPlaf = sIdTypPlafFiltre Then

			/*------------------------------------------------------------------*/
			/* On renvoit l'indicateur ( le niveau ) en sortie de fonction      */
			/*------------------------------------------------------------------*/
			sIndicateur = adwSource.GetItemString ( lCpt2 , "ID_NIV_PLAF" , FILTER! , True )
			exit

		End If

	Next

	If sIndicateur <> "" Then exit

Next

If sIndicateur <> "" Then

	Choose CASE sIndicateur

		CASE "XX"

			sIndicateur = "la garantie"

		CASE "+TR"

			sIndicateur = "une territorialit$$HEX1$$e900$$ENDHEX$$"

		CASE "+NS"

			sIndicateur = "une nature de sinistre"

		CASE "+DT"

			sIndicateur = "un d$$HEX1$$e900$$ENDHEX$$tail de sinistre"

		CASE "+EV"

			sIndicateur = "un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement"


	End Choose


	stMessage.bouton  = YesNo!
	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Plafonds"
	stMessage.Icon		= question!
	stMessage.sVar[1] = sIndicateur
	stMessage.sCode	= "CONF004"

	iReponse = f_Message ( stMessage )

	/*------------------------------------------------------------------*/
	/* Si l'utilisateur ne souhaite plus sortir, on le positionne sur   */
	/* la ligne pour laquelle il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un plafond sur un autre    */
	/* indicateur.                                                      */
	/*------------------------------------------------------------------*/

	If iReponse = 2 Then 

		bRet = True
		adwSource.SetRow ( lCpt )

	End If

End If

Return ( bRet )
end function

on u_sp_zn_plafonds.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_plafonds.destroy
TriggerEvent( this, "destructor" )
end on

