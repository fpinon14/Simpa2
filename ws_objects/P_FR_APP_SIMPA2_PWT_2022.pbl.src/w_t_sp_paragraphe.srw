HA$PBExportHeader$w_t_sp_paragraphe.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des paragraphes.
forward
global type w_t_sp_paragraphe from w_t_spb_paragraphe
end type
end forward

global type w_t_sp_paragraphe from w_t_spb_paragraphe
end type
global w_t_sp_paragraphe w_t_sp_paragraphe

type variables
u_sp_gs_paragraphe	iUoSpGsParagraphe
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
end prototypes

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:05:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------


Boolean 	bRet 			// Variable de retour de la fonction .
String 	sIdPara		// Identifiant du paragraphe $$HEX2$$e0002000$$ENDHEX$$supprimer.
String 	sRet			// Retour de la fonction de contr$$HEX1$$f400$$ENDHEX$$le des contraintes d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX1$$e900$$ENDHEX$$.
Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Paragraphe"
stMessage.sVar[ 1 ] 	= "ce paragraphe"
stMessage.Bouton		= YesNo!
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
	/* COMPOSITION, MOTIF, PIECE et PARA_PROD                           */
	/*------------------------------------------------------------------*/
	sIdPAra 	= Dw_1.GetItemString ( 1, "id_Para" )
	sRet 		= iuoSpGsParagraphe.uf_Gs_Sup_Para ( sIdPara )

	If ( sRet <> "" ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'un Paragraphe"
		stMessage.sVar[ 1 ] 	= sRet  
		stMessage.sVar[ 2 ] 	= "ce paragraphe"
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU002"
		bRet 						= False
		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/
		Dw_1.DeleteRow ( 0 )
		bRet = True

	End If

End If

Return ( bRet )
end function

on ue_initialiser;call w_t_spb_paragraphe::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_si_paragraphe
//* Evenement 		:	Ue_Initialiser
//* Auteur			:	Y. Picard
//* Date				:	20/08/1997 09:39:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise les Uo de gestion pour les paragraphes de SINDI.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

iUoSpGsParagraphe = CREATE u_sp_gs_paragraphe

iUoSpGsParagraphe.Uf_Initialisation ( iTrTrans , Dw_1 )
end on

on close;call w_t_spb_paragraphe::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_si_paragraphe
//* Evenement 		:	Close
//* Auteur			:	Y. Picard
//* Date				:	20/08/1997 09:39:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$truit les Uo de gestion pour les paragraphes de SINDI.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

DESTROY iUoSpGsParagraphe
end on

on w_t_sp_paragraphe.create
call w_t_spb_paragraphe::create
end on

on w_t_sp_paragraphe.destroy
call w_t_spb_paragraphe::destroy
end on

type pb_word from w_t_spb_paragraphe`pb_word within w_t_sp_paragraphe
boolean BringToTop=true
end type

type mle_visualisation from w_t_spb_paragraphe`mle_visualisation within w_t_sp_paragraphe
boolean BringToTop=true
end type

type uo_paragraphe from w_t_spb_paragraphe`uo_paragraphe within w_t_sp_paragraphe
boolean BringToTop=true
end type

