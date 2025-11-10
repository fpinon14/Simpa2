HA$PBExportHeader$w_t_sp_groupe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des groupes
forward
global type w_t_sp_groupe from w_t_spb_groupe
end type
end forward

global type w_t_sp_groupe from w_t_spb_groupe
end type
global w_t_sp_groupe w_t_sp_groupe

type variables
u_sp_gs_groupecarte	iUoGsGroupeCarte
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
end prototypes

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	YP
//* Date				:	13/08/97 15:01:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean	bRet			// Valeur de retour de la fonction
String 	sText1		// Variable de retour de la fonction de controle du Uo iuogsGroupe
String 	sText2		// Variable de retour de la fonction de controle du Uo iuogsGroupeCarte

Long		dcIdGrp		// Identifiant du groupe $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet   = True
sText1 = ""
sText2 = ""

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Groupe"
stMessage.sVar[ 1 ] 	= "ce groupe"
stMessage.Bouton		= OkCancel!
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rencielle vis $$HEX2$$e0002000$$ENDHEX$$vis de la table  */
	/* Produit et Etablissement.                                        */
	/*------------------------------------------------------------------*/
	dcIdGrp = Dw_1.GetItemNumber ( 1, "ID_GRP" )

	sText1	= iuoGsGroupeCarte.Uf_Gs_Sup_Grp ( dcIdGrp )

	sText2   = iuoGsGroupe.Uf_Gs_Sup_Grp ( dcIdGrp )

	If sText1 <> "" Or sText2 <> "" Then

		bRet = False

		/*----------------------------------------------------------------------------*/
		/* Si sText1 ou sText2 = "PROC", alors une erreur a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$e et g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e par */
		/* la fonction f_procedure, un message d'erreur a donc d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affich$$HEX1$$e900$$ENDHEX$$.      */
		/*----------------------------------------------------------------------------*/
		If sText1 <> "PROC" And sText2 <> "PROC" Then

			/*----------------------------------------------------------------------------*/
			/* On g$$HEX1$$e800$$ENDHEX$$re la liaison entre les messages d'erreur afin d'avoir les "," et le  */
			/* "et" plac$$HEX1$$e900$$ENDHEX$$s au bonne endroit dans la phrase.                               */
			/*----------------------------------------------------------------------------*/
			If sText1 <> "" Then

				If sText2 <> "" Then

					If Pos ( sText2 , " et " ) > 0 Then

						sText2 = sText1 + ", " + sText2

					Else

						stext2 = sText1 + " et " + sText2

					End If

				Else

					sText2 = sText1

				End If
				
			End If

			stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression du Groupe"
			stMessage.sVar[ 1 ] 	= sText2
			stMessage.sVar[ 2 ] 	= "ce groupe"
			stMessage.sCode		= "REFU002"
			stMessage.bErreurG	= TRUE
			f_Message ( stMessage )

		End If

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/

		dw_1.DeleteRow ( 0 )

	End If

End If

Return ( bRet )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_groupe::wf_controlersaisie
//* Auteur         : F. Pinon
//* Date            : 09/01/2009 09:14:50
//* Libell$$HEX10$$e900200020002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires   : 09/01/2009 - Contr$$HEX1$$f400$$ENDHEX$$le libell$$HEX2$$e9002000$$ENDHEX$$chef de file
//*
//* Arguments      : 
//*
//* Retourne      : string   
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date        Modification
//* #..   ...   ../../....   
//* #1   FPI      16/02/2009   Correction bug + ajout d'une r$$HEX1$$e800$$ENDHEX$$gle
//* #2   FPI      26/11/2009   [20091126.FPI] Correction insensibilit$$HEX2$$e9002000$$ENDHEX$$de casse de car.
//*-----------------------------------------------------------------

String sPos
Long lidGrpBase, lidGrpProd, lIdGrp
String sLibGrp,sLibGrpProd
DataWindowChild dwcGroupe
Long lRow

sPos = ""

lIdGrp = Dw_1.GetItemNumber( 1, "id_grp" )
lidGrpBase = Dw_1.GetItemNumber( 1, "id_grp_base" )

dw_1.GetChild("id_grp_prod",dwcGroupe)
lRow = dwcGroupe.Find( &
   "id_code=" + string(dw_1.getitemnumber( 1,"id_grp_prod")), &
   1,dwcGroupe.RowCount())
sLibGrpProd=dwcGroupe.getitemstring(lRow,"lib_code")
   

If lidGrpBase = lidGrp Then // Chef de file
   // RG : pour un chef de file, libell$$HEX2$$e9002000$$ENDHEX$$du grp = libell$$HEX2$$e9002000$$ENDHEX$$grp Sherpa
   sLibGrp = Dw_1.GetItemString ( 1, "lib_grp" )
   
//   if sLibGrp <>sLibGrpProd Then // Libell$$HEX1$$e900$$ENDHEX$$s diff$$HEX1$$e900$$ENDHEX$$rents
   if Upper(sLibGrp) <> Upper(sLibGrpProd) Then // #2
      stMessage.sTitre      = "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Groupes"
      stMessage.Icon         = Information!
      stMessage.sCode      = "REFU043"
   
      f_Message ( stMessage )

      sPos ="lib_grp"
   End If
Else // Groupe secondaire
   // RG : pour grp secondaire, libell$$HEX2$$e9002000$$ENDHEX$$du grp ppal= libell$$HEX2$$e9002000$$ENDHEX$$grp Sherpa
   sLibGrp = Dw_1.GetItemString ( 1, "lib_grp_base" )
   
//   if sLibGrp <>sLibGrpProd Then // Libell$$HEX1$$e900$$ENDHEX$$s diff$$HEX1$$e900$$ENDHEX$$rents
   if Upper(sLibGrp) <> Upper(sLibGrpProd) Then // #2
      stMessage.sTitre      = "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Groupes"
      stMessage.Icon         = Information!
      stMessage.sCode      = "REFU043"
   
      f_Message ( stMessage )

      sPos ="id_grp_prod"
   End If
end if

/* #1 Ancien code ci-dessous
// Contr$$HEX1$$f400$$ENDHEX$$le du libell$$HEX2$$e9002000$$ENDHEX$$d'un groupe "Chef de file"
lidGrpBase = Dw_1.GetItemNumber( 1, "id_grp_base" )
lidGrpProd = Dw_1.GetItemNumber( 1, "id_grp_prod" )

If lidGrpBase = lidGrpProd Then // Chef de file
   sLibGrp = Dw_1.GetItemString ( 1, "lib_grp" )
      
   dw_1.GetChild("id_grp_prod",dwcGroupe)
   sLibGrpProd=dwcGroupe.getitemstring(dwcGroupe.getRow(),"lib_code")

   if sLibGrp <>sLibGrpProd Then // Libell$$HEX1$$e900$$ENDHEX$$s diff$$HEX1$$e900$$ENDHEX$$rents
      stMessage.sTitre      = "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Groupes"
      stMessage.Icon         = Information!
      stMessage.sCode      = "REFU043"
   
      f_Message ( stMessage )

      sPos ="lib_grp"
   End If
end if
*/

Return sPos

end function

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_groupe
//* Evenement 		:	Close
//* Auteur			:	YP
//* Date				:	13/08/97 15:21:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion pour le        */
/* param$$HEX1$$e900$$ENDHEX$$trage des groupes                                          */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsGroupeCarte
If IsVAlid(iuoGsGroupeCarte) Then Destroy iuoGsGroupeCarte
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_initialiser;call w_t_spb_groupe::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_groupe
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	YP
//* Date				:	13/08/97 14:57:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Groupes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsGroupeCarte = Create u_sp_gs_GroupeCarte

iuoGsGroupeCarte.uf_initialisation ( itrTrans, Dw_1 )

end on

on w_t_sp_groupe.create
call super::create
end on

on w_t_sp_groupe.destroy
call super::destroy
end on

type cb_debug from w_t_spb_groupe`cb_debug within w_t_sp_groupe
end type

type dw_1 from w_t_spb_groupe`dw_1 within w_t_sp_groupe
end type

type st_titre from w_t_spb_groupe`st_titre within w_t_sp_groupe
end type

type pb_retour from w_t_spb_groupe`pb_retour within w_t_sp_groupe
end type

type pb_valider from w_t_spb_groupe`pb_valider within w_t_sp_groupe
end type

type pb_imprimer from w_t_spb_groupe`pb_imprimer within w_t_sp_groupe
string text = "&Imprimer"
end type

type pb_controler from w_t_spb_groupe`pb_controler within w_t_sp_groupe
end type

type pb_supprimer from w_t_spb_groupe`pb_supprimer within w_t_sp_groupe
end type

