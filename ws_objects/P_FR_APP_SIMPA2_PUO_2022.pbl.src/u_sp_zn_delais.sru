HA$PBExportHeader$u_sp_zn_delais.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux  d$$HEX1$$e900$$ENDHEX$$lais
forward
global type u_sp_zn_delais from u_spb_zn_anc
end type
end forward

global type u_sp_zn_delais from u_spb_zn_anc
end type
global u_sp_zn_delais u_sp_zn_delais

forward prototypes
public function string uf_zn_controlersaisie (datawindow adwdelai)
private function boolean uf_zn_delaidejautilise (datawindow adwsource)
private function boolean uf_zn_duree (datawindow adwsource)
end prototypes

public function string uf_zn_controlersaisie (datawindow adwdelai);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_controlersaisie
//* Auteur			:	V.Capelle
//* Date				:	27/11/1997 11:13:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le que les d$$HEX1$$e900$$ENDHEX$$lais saisis ne sont pas 
//*						pr$$HEX1$$e900$$ENDHEX$$sents ailleurs et que les bornes sont dans
//*						le bon sens.
//* Commentaires	:	
//*
//* Arguments		:	Datawindow    adwFranchise	Datawindow source
//*
//* Retourne		: String			"" si OK
//*										colonne en erreur sinon.
//*
//*-----------------------------------------------------------------
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
Long 			lNbrLig				// Nombre de d$$HEX1$$e900$$ENDHEX$$lais param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s.

lNbrLig			= adwDelai.RowCount ()

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

If lNbrLig > 0	Then

	/*------------------------------------------------------------------*/
	/* On teste s'il y a des paragraphes non renseign$$HEX1$$e900$$ENDHEX$$s dans            */
	/* Uo_PLafonds.Dw_Source, si c'est le cas et que l'utilisateur      */
	/* souhaite les saisir alors on stoppe la sortie et on se           */
	/* positionne sur le premier paragraphe manquant.                   */
	/*------------------------------------------------------------------*/
	If Not Uf_Zn_DelaiDejaUtilise ( adwDelai ) Then

		sPos = "ID_TYP_DEL"
			
	Else

		If Not ( Uf_Zn_Duree ( adwDelai ) ) Then
	
			sPos = "DUR_MIN"

		End If
	
	End If

End If

Return ( sPos )
end function

private function boolean uf_zn_delaidejautilise (datawindow adwsource);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_DelaiDejaUtilise ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			: V.Capelle
//* Date				: 28/11/97 16:05:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie pour chaque d$$HEX1$$e900$$ENDHEX$$lai saisi s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un 
//*					  indicateur (territorialit$$HEX1$$e900$$ENDHEX$$, nature de sinistre, garantie ...)
//*                 sur lequel ce d$$HEX1$$e900$$ENDHEX$$lai a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi pour en avertir l'utilisateur.
//* Commentaires	: 
//*
//* Arguments		: adwSource		DataWindow	: DataWindow des d$$HEX1$$e900$$ENDHEX$$lais.
//*
//* Retourne		: String			= True  Si les d$$HEX1$$e900$$ENDHEX$$lais saisis ne l'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$sur
//*												  d'autres indicateurs.
//*										= False Si un d$$HEX1$$e900$$ENDHEX$$lais saisi l'a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$sur un autre
//*												  indicateur.
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*  #1 JFF		24/11/99 M$$HEX1$$ea00$$ENDHEX$$me Type, M$$HEX1$$ea00$$ENDHEX$$me Niveau, OK
//*							M$$HEX1$$ea00$$ENDHEX$$me Type, Niveau diff$$HEX1$$e900$$ENDHEX$$rent, Pas OK				
//*  #2 JFF		11/04/03 Avec les modifications que j'ai apport$$HEX2$$e9002000$$ENDHEX$$sur les refus (621 par exemple)
//* 							Cette fonction ne doit plus $$HEX1$$ea00$$ENDHEX$$tre bloquante.
//*-----------------------------------------------------------------


// #2
Return True

Boolean		bRet					= True		//Valeur de retour de la fonction.
Long			lCpt									//Premier indice de boucle.
Long			lCpt2									//Deuxi$$HEX1$$e800$$ENDHEX$$me indice de boucle.
Long			lNbrLig								//Nombre de ligne dans adwSource (PRIMARY!).
Long			lNbrLig2								//Nombre de ligne dans adwSource (FILTER! ).
String		sIdTypDel							//type du plafond saisi.
String		sLibDelai							//Libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$lai
String		sIdTypDelFiltre					//Type de plafond saisi sur un autre indicateur.
String		sIndicateur			= ""			//Indicateur sur lequel un plafond a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisi.
String		sIndicateurBufPrim= ""			//Indicateur sur le Buffer Primary

lNbrLig  = adwSource.RowCount ( ) 
lNbrLig2 = adwSource.FilteredCount ( )

For lCpt = 1 to lNbrLig


	/*------------------------------------------------------------------*/
	/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le type de plafond saisi                             */
	/*------------------------------------------------------------------*/
	sIdTypDel = adwSource.GetItemString ( lCpt , "ID_TYP_DEL" )

	// #1
	sIndicateurBufPrim = adwSource.GetItemString ( lCpt , "ID_NIV_DEL" )

	sLibDelai = adwSource.GetItemString ( lCpt , "LIB_CODE"   )

	/*------------------------------------------------------------------*/
	/* On cherche le plafond dans les autres indicateurs (qui ont $$HEX1$$e900$$ENDHEX$$t$$HEX4$$e900200020002000$$ENDHEX$$*/
	/* filtr$$HEX1$$e900$$ENDHEX$$s)                                                         */
	/*------------------------------------------------------------------*/
	For lCpt2 = 1 to lNbrLig2

		sIdTypDelFiltre = adwSource.GetItemString ( lCpt2 , "ID_TYP_DEL" , FILTER! , True )

		If sIdTypDel = sIdTypDelFiltre Then

			/*------------------------------------------------------------------*/
			/* On renvoit l'indicateur ( le niveau ) en sortie de fonction      */
			/*------------------------------------------------------------------*/
			sIndicateur = adwSource.GetItemString ( lCpt2 , "ID_NIV_DEL" , FILTER! , True )

			// #1
			If sIndicateurBufPrim = sIndicateur Then sIndicateur = ""

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

		// #1
		CASE "-GA"

			sIndicateur = "une garantie"


	End Choose


	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des D$$HEX1$$e900$$ENDHEX$$lais"
	stMessage.Icon		= StopSign!
	stMessage.sVar[1] = sLibDelai
	stMessage.sVar[2] = sIndicateur
	stMessage.sCode	= "REFU006"

	f_Message ( stMessage )

	/*------------------------------------------------------------------*/
	/* Si l'utilisateur ne souhaite plus sortir, on le positionne sur   */
	/* la ligne pour laquelle il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un plafond sur un autre    */
	/* indicateur.                                                      */
	/*------------------------------------------------------------------*/

	bRet = False
	adwSource.SetRow ( lCpt )

End If

Return ( bRet )
end function

private function boolean uf_zn_duree (datawindow adwsource);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_duree ( Priv$$HEX1$$e900$$ENDHEX$$e )
//* Auteur			: V.Capelle
//* Date				: 28/11/97 12:14:31
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

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des D$$HEX1$$e900$$ENDHEX$$lais"
	stMessage.Icon		= StopSign!
	stMessage.sCode	= "REFU004"
	f_Message ( stMessage )

End If

Return ( bRet )

end function

on u_sp_zn_delais.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_delais.destroy
TriggerEvent( this, "destructor" )
end on

