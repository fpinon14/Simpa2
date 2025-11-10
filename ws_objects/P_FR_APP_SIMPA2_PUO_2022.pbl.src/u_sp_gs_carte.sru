HA$PBExportHeader$u_sp_gs_carte.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux cartes
forward
global type u_sp_gs_carte from u_spb_gs_anc
end type
end forward

global type u_sp_gs_carte from u_spb_gs_anc
end type
global u_sp_gs_carte u_sp_gs_carte

forward prototypes
public function boolean uf_gs_sup_carte (decimal adcidcarte)
public function boolean uf_gs_chevaucher (decimal adcidcarte, string asrangmini, string asrangmaxi, ref string astext)
end prototypes

public function boolean uf_gs_sup_carte (decimal adcidcarte);//*-----------------------------------------------------------------
//*
//* Fonction		: UF_GS_SUP_CARTE
//* Auteur			: YP
//* Date				: 04/09/1997 12:08:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rification de l'absence de garantie en relation
//*					  avec la carte avant suppression de celle-ci
//* Commentaires	: Aucun
//*
//* Arguments		: Decimal			adcIdCarte	// Identifiant de la Carte
//*															// $$HEX2$$e0002000$$ENDHEX$$supprimer
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Boolean 		bRet 			= True	//Valeur de retour de la fonction
Long 			lNbGarantie	= 0		//Nbre de garanties en relation avec la carte


/*------------------------------------------------------------------*/
/* Recherche du nombre de garanties en relation avec la carte       */
/*------------------------------------------------------------------*/

lNbGarantie = itrTrans.IM_S01_AFFILIER ( adcIdCarte )

If ( lNbGarantie > 0 ) Or Not f_Procedure ( stMessage , itrTrans , "IM_S01_AFFILIER" ) Then &
   bRet = False

Return ( bRet )

end function

public function boolean uf_gs_chevaucher (decimal adcidcarte, string asrangmini, string asrangmaxi, ref string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_gs_chevaucher
//* Auteur			: YP
//* Date				: 04/09/97 11:36:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que la plage de No de carte saisie ne chevauche pas une plage
//*                 existante.
//* Commentaires	: En cas de modification d'une carte existante, le SELECT ne doit pas
//*                 tester le chevauchement pour l'Id Carte en cours de modif., donc on
//*                 l'exclut du test.
//*                 En cas de cr$$HEX1$$e900$$ENDHEX$$ation, la carte n'existe pas encore et l'Id n'est pas
//*                 affect$$HEX1$$e900$$ENDHEX$$, $$HEX2$$e0002000$$ENDHEX$$l'appel de la pr$$HEX1$$e900$$ENDHEX$$sente fonction on initialisera 
//*                 l'Id Carte $$HEX2$$e0002000$$ENDHEX$$"0".
//*
//* Arguments		: Decimal      adcIdCarte           ( Val ) Valeur de l'Id Carte
//*					  String			asRangMini				( Val ) Valeur du rang mini
//*                 String       asRangMaxi           ( Val ) Valeur du rang maxi
//*					  Strng			asText					( Ref ) Lib du cr$$HEX1$$e900$$ENDHEX$$neau de carte chevauch$$HEX2$$e9002000$$ENDHEX$$(en retour)
//*
//* Retourne		: Boolean	   False = Pas de chevauchement : OK.
//*										TRUE  = Il y a chevauchement.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Modif par JFF le 28/07/00 :                                      */
/* Nouvelle proc$$HEX1$$e900$$ENDHEX$$dure pour le contr$$HEX1$$f400$$ENDHEX$$le du chevauchement de cr$$HEX1$$e900$$ENDHEX$$neau  */
/* de carte l'ancienne proc$$HEX1$$e900$$ENDHEX$$dure $$HEX1$$e900$$ENDHEX$$tait bugg$$HEX1$$e900$$ENDHEX$$e.                      */
/*------------------------------------------------------------------*/

Boolean bRet = False		// Valeur de retour de la fonction
Long lNbRang				// Nbre de rang chevauchant rencontr$$HEX1$$e900$$ENDHEX$$s

bRet 	 = FALSE
asText =  Fill  ( " ", 100 )

itrTrans.IM_S05_CARTE ( adcIdCarte , asRangMini , asRangMaxi, asText )

If Pos ( asText, ";", 1 ) > 0 Or Not f_Procedure ( stMessage , itrTrans , "IM_S05_CARTE" ) Then bRet = TRUE

Return ( bRet )
end function

on u_sp_gs_carte.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_carte.destroy
TriggerEvent( this, "destructor" )
end on

