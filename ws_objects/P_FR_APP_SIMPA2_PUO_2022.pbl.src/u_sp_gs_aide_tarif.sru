HA$PBExportHeader$u_sp_gs_aide_tarif.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux aides tarif
forward
global type u_sp_gs_aide_tarif from u_spb_gs_anc
end type
end forward

global type u_sp_gs_aide_tarif from u_spb_gs_anc
end type
global u_sp_gs_aide_tarif u_sp_gs_aide_tarif

forward prototypes
public subroutine uf_controlersaisie (ref s_pass astpass)
end prototypes

public subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PUBLIC)
//* Auteur			: PLJ
//* Date				: 13/03/1998 11:35:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie AIDE_TARIF
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------




String 		sCol[3]				//Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[3]				//Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String 		sNouvelleLigne		//Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText					//Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String		sPos					//Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$
String		sVal					//Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification
Long 			lCpt					//Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long			lNbrCol				//Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier


sNouvelleLigne			= "~r~n"
lNbrCol					= UpperBound ( sCol )
sPos						= ""
sText						= sNouvelleLigne

sCol[ 1 ]				= "LIB_CODE"
sCol[ 2 ]				= "ID_GTI"
sCol[ 3 ]				= "MT_PREJ"

sErr[ 1 ]				= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du code tarif"
sErr[ 2 ]				= " - La garantie"
sErr[ 3 ]				= " - Le montant"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt = 1 Then

      sVal = iDw_1.GetItemString ( 1, sCol[ lCpt ] )
		
	Else

		sVal = String ( iDw_1.GetItemNumber ( 1 , sCol [ lCpt ] ) )

	End If

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Tarifs"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If


astPass.sTab [1] = sPos
end subroutine

on u_sp_gs_aide_tarif.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_aide_tarif.destroy
TriggerEvent( this, "destructor" )
end on

