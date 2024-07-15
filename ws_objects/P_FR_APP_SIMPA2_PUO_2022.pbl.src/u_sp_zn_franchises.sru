HA$PBExportHeader$u_sp_zn_franchises.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux  franchises
forward
global type u_sp_zn_franchises from u_spb_zn_anc
end type
end forward

global type u_sp_zn_franchises from u_spb_zn_anc
end type
global u_sp_zn_franchises u_sp_zn_franchises

forward prototypes
public function string uf_zn_controlersaisie (datawindow adwfranchise)
private function boolean uf_zn_duree (datawindow adwsource)
private function boolean uf_zn_paragraphe (datawindow adw_source)
private subroutine uf_positionnecompteur (ref datawindow adwsource)
end prototypes

public function string uf_zn_controlersaisie (datawindow adwfranchise);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Zn_ControlerSaisie
//* Auteur			:	V.Capelle
//* Date				:	27/11/1997 11:13:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le si le montant a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi et qu'il n'y a
//*						eu qu'une franchise de saisie.
//* Commentaires	:	
//*
//* Arguments		:	Datawindow    adwFranchise	Datawindow source
//*
//* Retourne		:  String		  "" si OK
//*										  colonne en erreur sinon.
//*
//*-----------------------------------------------------------------
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long 			lCpt					// Compteur : nombre lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrLig				// Nombre de lignes $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbTypFra			// Nombre de type de franchise diff$$HEX1$$e900$$ENDHEX$$rents

sNouvelleLigne	= "~r~n"
sPos				= ""
sText				= sNouvelleLigne
lNbrLig			= adwFranchise.RowCount ()
lNbTypFra		= Integer ( adwFranchise.Describe ( "Evaluate ('Count ( id_typ_fra for all distinct )', 0 )" ) )
/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
If lNbrLig > 0	Then

	/*----------------------------------------------------------------------------*/
	/* Test qu'il n'y a bien eu qu'un type de franchise saisi.                    */
	/*----------------------------------------------------------------------------*/
	If lNbTypFra <= 1  Then
	
		For lCpt = 1 To lNbrLig

	 		sVal = String ( adwFranchise.GetItemNumber ( lCpt, "MT_FRA" ) )

			If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

				sPos  = "MT_FRA"
				sText = " - Tous les montants"  + sNouvelleLigne

			End If

			If sPos <> ""	Then

				adwFranchise.SetRow ( lCpt )
				Exit

			End If

		Next
		/*------------------------------------------------------------------*/
		/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
		/*------------------------------------------------------------------*/
		If	sPos <> "" Then

			stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des franchises"
			stMessage.Icon		= Information!
			stMessage.sCode	= "GENE001"
			stMessage.sVar[1] = sText
			f_Message ( stMessage )

		Else

			/*------------------------------------------------------------------*/
			/* On teste s'il y a des paragraphes non renseign$$HEX1$$e900$$ENDHEX$$s dans            */
			/* Uo_Franchises.Dw_Source, si c'est le cas et que l'utilisateur    */
			/* souhaite les saisir alors on stoppe la sortie et on se           */
			/* positionne sur le premier paragraphe manquant.                   */
			/*------------------------------------------------------------------*/
			If Not Uf_Zn_Paragraphe ( adwFranchise ) Then

				sPos = "ID_PARA"
			
			Else

				/*----------------------------------------------------------------------------*/
				/* On teste si les borne de d$$HEX1$$e900$$ENDHEX$$lai sont dans le bon ordre.                     */
				/*----------------------------------------------------------------------------*/
				If Not ( Uf_Zn_Duree ( adwFranchise ) ) Then
	
					sPos = "DUR_MIN"

				Else

					Uf_PositionneCompteur ( adwFranchise )

				End If
	
			End If

		End If

	Else

		/*----------------------------------------------------------------------------*/
		/* On Interdit la saisie de plus d'une franchise.                             */
		/*----------------------------------------------------------------------------*/
		stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des franchises"
		stMessage.Icon		= StopSign!
		stMessage.sCode	= "REFU009"
		sPos              = "MT_FRA"
		f_Message ( stMessage )
		
	End If

End If

Return ( sPos )
end function

private function boolean uf_zn_duree (datawindow adwsource);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_duree ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			: V.Capelle
//* Date				: 27/11/97 12:14:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que la borne maxi du d$$HEX1$$e900$$ENDHEX$$lai est bien sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$
//*                 la borne mini.
//* Commentaires	: 
//*
//* Arguments		: adwSource datawindow : 	datawindow des d$$HEX1$$e900$$ENDHEX$$lais.
//*
//* Retourne		: Boolean 						= True  si Ok
//*														= False sinon
//*
//*-----------------------------------------------------------------
Boolean	bRet			= True		//Valeur de retour de la fonction.
Long 		lNbrLig						//Nombre de ligne dans la datawindow adwSource.
Long		lCpt							//Indice  de boucle.


lNbrLig = adwSource.RowCount ( ) 

For lCpt = 1 to lNbrLig 

	If adwSource.GetItemNumber ( lCpt , "DUR_MIN" ) > &
		adwSource.GeTItemNumber ( lCpt , "DUR_MAX" )   Then

		adwSource.SetRow ( lCpt )
		bRet = False
		exit

	End If

Next

If ( bRet = False ) Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Franchises"
	stMessage.Icon		= StopSign!
	stMessage.sCode	= "REFU004"
	f_Message ( stMessage )

End If

Return ( bRet )

end function

private function boolean uf_zn_paragraphe (datawindow adw_source);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_paragraphe ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			:	V.Capelle
//* Date				:	27/11/1997 11:16:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste si des paragraphes n'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$cis$$HEX1$$e900$$ENDHEX$$, l'indique $$HEX1$$e000$$ENDHEX$$
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
	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Franchises"
	stMessage.sVar[1] = "Une franchise"
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

private subroutine uf_positionnecompteur (ref datawindow adwsource);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_positionnecompteur
//* Auteur			:	V.Capelle
//* Date				:	08/12/1997 16:40:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Calcule et positionne les compteurs pour les 
//*						diff$$HEX1$$e900$$ENDHEX$$rentes franchises
//* Commentaires	:	
//*
//* Arguments		:	Datawindow	adwSource
//Migration PB8-WYNIWYG-03/2006 FM	
//adwsource devient du type datawindow au lieu de u_datawindow
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//* Retourne		:	( Rien )
//*
//*-----------------------------------------------------------------
Long 				lNbFranchise		//Nombre de franchises param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$es
Long				lCpt					//Compteur 
Long				lIdCptSuiv			//Prochain num$$HEX1$$e900$$ENDHEX$$ro $$HEX2$$e0002000$$ENDHEX$$positionner

DwItemStatus	DwStatus				//Etat de la ligne


lNbFranchise = adwSource.RowCount ()

For lCpt = 1 To lNbFranchise 

	dwStatus 	= adwSource.GetItemStatus ( lCpt, 0, Primary! )  
	If ( dwStatus = New! Or dwStatus = NewModified! ) Then

		adwSource.SetItem ( lCpt, "ID_CPT_FRA", 0 )

	End If

Next

lIdCptSuiv = Long ( adwSource.Describe ( "Evaluate ( 'Max ( ID_CPT_FRA )', 0 )" ) ) + 1


For lCpt = 1 To lNbFranchise 

	dwStatus 	= adwSource.GetItemStatus ( lCpt, 0, Primary! )  
	If ( dwStatus = New! Or dwStatus = NewModified! ) Then

		adwSource.SetItem ( lCpt, "ID_CPT_FRA", lIdCptSuiv )
		lIdCptSuiv ++

	End If

Next
end subroutine

on u_sp_zn_franchises.create
call super::create
end on

on u_sp_zn_franchises.destroy
call super::destroy
end on

