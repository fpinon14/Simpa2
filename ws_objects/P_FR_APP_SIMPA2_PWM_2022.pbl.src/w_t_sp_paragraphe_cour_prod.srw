HA$PBExportHeader$w_t_sp_paragraphe_cour_prod.srw
forward
global type w_t_sp_paragraphe_cour_prod from w_ancetre
end type
type uo_paragraphe from u_spb_ajout_courtyp within w_t_sp_paragraphe_cour_prod
end type
type pb_1 from u_8_pbvalider within w_t_sp_paragraphe_cour_prod
end type
end forward

global type w_t_sp_paragraphe_cour_prod from w_ancetre
integer width = 2496
integer height = 1832
boolean titlebar = true
string title = "Gestion du courrier "
event ue_ouverture pbm_custom01
uo_paragraphe uo_paragraphe
pb_1 pb_1
end type
global w_t_sp_paragraphe_cour_prod w_t_sp_paragraphe_cour_prod

type variables

Public:

w_tm_sp_produit		iWappel

Boolean			ibDejaOuvert = False
Boolean			ibouverture    = False

Decimal			idcIdProd
String			isIdCour

end variables

forward prototypes
public subroutine wf_positionnerobjets ()
end prototypes

event ue_ouverture;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: ue_ouverture
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisations qui sont ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$CHAQUE ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: Ces lignes ne peuvent pas $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$es sur l'ACTIVATE car elles
//*					  seraient d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$es lors de l'affichage de messages d'erreur. 
//* 					  De m$$HEX1$$ea00$$ENDHEX$$me, sur l'UE_INITIALISER, elles ne seraient ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$es qu'une fois.
//*				  
//*-----------------------------------------------------------------

uo_paragraphe.event uf_charger( )

If ( istPass.bEnableParent = False ) Then

	iwAppel.Enabled = False

End If
end event

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_paragraphe_cour_prod::wf_positionnerobjets
//* Auteur			: JCA
//* Date				: 17/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: DCMP 070051
//*						Fen$$HEX1$$ea00$$ENDHEX$$tre de modification des paragraphe pour un courrier
//*						et un produit
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


this.x				= 20
this.y				= 100
this.width			= 3484
this.Height			= 1600

uo_paragraphe.X		= 60
uo_paragraphe.Y		= 260
uo_paragraphe.Width	= this.width - 120
uo_paragraphe.Height	= this.height  - 400

end subroutine

on w_t_sp_paragraphe_cour_prod.create
int iCurrent
call super::create
this.uo_paragraphe=create uo_paragraphe
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_paragraphe
this.Control[iCurrent+2]=this.pb_1
end on

on w_t_sp_paragraphe_cour_prod.destroy
call super::destroy
destroy(this.uo_paragraphe)
destroy(this.pb_1)
end on

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_sp_paragraphe_cour_prod
//* Evenement 		:	Show
//* Auteur			:	JCA
//* Date				:	25/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  -
//*-----------------------------------------------------------------

This.Enabled = True
end event

event ue_controler;call super::ue_controler;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: UE_CONTROLER
//* Auteur			: JCA
//* Date				: 25/04/2005
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle si la saisie des paragraphes est correcte.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* S'il n'y pas au moins un paragraphe composant le courrier,		  */
/* la validation ne peut pas continuer                              */
/*------------------------------------------------------------------*/
if uo_Paragraphe.dw_Source.RowCount () < 1 then

	/*------------------------------------------------------------------*/
	/* Erreur indiquant qu'il faut au moins un paragraphe               */
	/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Param$$HEX1$$e800$$ENDHEX$$trage des Courriers par produit"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= false
	stMessage.sCode 		= "REFU042"

	f_Message ( stMessage ) 

else
	this.PostEvent ( "Ue_Retour" )
	
end if
end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: Ue_Initialiser
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

this.wf_positionnerobjets()

iwAppel = w_tm_sp_produit

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source,   */
/* cible.                                                           */
/*------------------------------------------------------------------*/
uo_paragraphe.Uf_Initialiser (	"d_sp_lst_para_cour_prod_rch", &
											"d_sp_compo_para_cour_prod", &
											"d_sp_lst_para_cour_prod", &
											itrTrans )


end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: Open
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Lors de l'ouverure de la fen$$HEX1$$ea00$$ENDHEX$$tre on arme ce boolean. La fen$$HEX1$$ea00$$ENDHEX$$tre  */
/* n'est ouverte qu'une fois, ensuite elle est cach$$HEX1$$e900$$ENDHEX$$e puis          */
/* visualis$$HEX1$$e900$$ENDHEX$$e.                                                      */
/*------------------------------------------------------------------*/

ibDejaOuvert = True



end event

event hide;call super::hide;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: HIDE
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Indique pour la prochaine ouverture de fen$$HEX1$$ea00$$ENDHEX$$tre que l'User Event  */
/* ue_ouverture pourra $$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement              */
/* WE_CHILDACTIVATE.                                                */
/*------------------------------------------------------------------*/
ibOuverture = False

This.Enabled = False
end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: We_ChildActivate
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: S'execute lorsque la fen$$HEX1$$ea00$$ENDHEX$$tre est visualis$$HEX1$$e900$$ENDHEX$$e. 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If ibDejaOuvert Then

	istPass = Message.PowerObjectParm

	ibDejaOuvert  = False

	itrTrans			= istPass.trTrans			// Objet transaction de la fenetre appelante
	iwParent			= istPass.wParent			// Fenetre Appelante	
	idcIdProd		= istPass.ltab[2]
	isIdCour			= istPass.stab[1]

	This.TriggerEvent ( "ue_Initialiser" )

End If

/*------------------------------------------------------------------*/
/* Rend inaccessible la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.                          */
/*------------------------------------------------------------------*/
If ( Not istPass.bEnableParent ) Then

	iwParent.TriggerEvent ( "ue_DisableFenetre" )

End If
/*------------------------------------------------------------------*/
/* A CHAQUE ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre, on d$$HEX1$$e900$$ENDHEX$$clenche l'User Event      */
/* ue_ouverture qui ex$$HEX1$$e900$$ENDHEX$$cute des initialisations pour les onglets.   */
/* le Bool$$HEX1$$e900$$ENDHEX$$en emp$$HEX1$$ea00$$ENDHEX$$che son d$$HEX1$$e900$$ENDHEX$$clenchement lorque le WE_CHILDACTIVATE  */
/* est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par l'affichage de messages d'erreur.              */
/*------------------------------------------------------------------*/

If Not ibOuverture Then

	/*------------------------------------------------------------------*/
	/* Indique que l'ouverture a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$faite. Donc dans le                */
	/* WE_CHILDACTIVATE, ce User Event ne sera plus d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$jusqu'$$HEX4$$e000200020002000$$ENDHEX$$*/
	/* la prochaine fermeture/ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.                  */
	/*------------------------------------------------------------------*/
	ibOuverture = True

	TriggerEvent ( "Ue_Ouverture" )

	This.Show ( )

	SetPointer ( Arrow! )

End If

end event

event ue_retour;call super::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: Ue_Retour
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR	Date		Modification
//* 
//*-----------------------------------------------------------------

/*-----------------------------------------------------------------------*/
/* Enl$$HEX1$$e800$$ENDHEX$$ve les filtres pour les datawindows de l'objet des paragraphes.   */
/*-----------------------------------------------------------------------*/
uo_paragraphe.dw_Source.SetFilter ( "" )
uo_paragraphe.dw_Source.Filter ()

uo_paragraphe.dw_Source.ShareDataOff ()

/*------------------------------------------------------------------*/
/* Rend accessible la fen$$HEX1$$ea00$$ENDHEX$$tre appelante.                            */
/*------------------------------------------------------------------*/
If ( Not istPass.bEnableParent ) Then

	iwAppel.Enabled = True

End If

This.Hide ()

/*------------------------------------------------------------------*/
/* Rend invisible la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des paragraphes si    */
/* elle est ouverte                                                 */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	W_Consulter_Paragraphe.Hide ()

End If
end event

type uo_paragraphe from u_spb_ajout_courtyp within w_t_sp_paragraphe_cour_prod
event uf_charger ( )
integer x = 146
integer y = 268
integer width = 2098
integer height = 864
integer taborder = 20
end type

event uf_charger();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_paragraphe_cour_prod::uf_charger
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

uo_paragraphe.SetRedraw ( False )

uo_paragraphe.Dw_Cible.Reset ()

iwAppel.dw_paragraphes.ShareData ( uo_paragraphe.dw_Source )

uo_paragraphe.Dw_Source.SetFilter ( "ID_COUR = '" + isIdCour + "'")
uo_paragraphe.Dw_Source.Filter ()
uo_paragraphe.Dw_Source.Sort ()

uo_paragraphe.Dw_Recherche.Retrieve ( idcIdProd, isIdCour )
uo_paragraphe.Dw_Recherche.RowsCopy	( 1, uo_paragraphe.Dw_Recherche.RowCount (), PRIMARY!, uo_paragraphe.Dw_Cible, 1, PRIMARY! )

uo_paragraphe.Dw_Cible.SelectRow ( 0, False )	
uo_paragraphe.Dw_Cible.SetFocus  ()
uo_paragraphe.Dw_Cible.SelectRow ( 1, True )

uo_paragraphe.SetRedraw ( True )

end event

on uo_paragraphe.destroy
call u_spb_ajout_courtyp::destroy
end on

event ue_dimensionner;call super::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_paragraphe
//* Evenement 		: Ue_Dimensionner
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_paragraphe.Pb_enlever_tout.Visible = False
uo_paragraphe.Pb_ajouter_tout.Visible = False

end event

event ue_dwsource_rbuttondown;call super::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_paragraphe
//* Evenement 		:	ue_dwsource_rbuttondown
//* Auteur			:	La Recrue
//* Date				:	02/07/97 13:48:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courant de la ligne courante.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sCol		// Colonne sur laquelle se trouve le curseur
Long			lLig		// Ligne sur laquelle se trouve le curseur

s_Pass		stPass

lLig	=	f_GetObjectAtPointer ( This.Dw_Source, sCol )

If lLig > 0 Then

	This.Dw_Source.ScrollToRow ( lLig )
	This.Dw_Source.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.Dw_Source.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.Dw_Source.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_paragraphe
//* Evenement 		: CONSTRUCTOR
//* Auteur			: JCA
//* Date				: 30/04/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de l'objet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e800$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = false

/*------------------------------------------------------------------*/
/* Utilisation des boutons 													  */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur                              */
/*------------------------------------------------------------------*/
ibIndicateur = False

/*------------------------------------------------------------------*/
/* On ne veut pas de s$$HEX1$$e900$$ENDHEX$$lection multiple dans la source.             */
/*------------------------------------------------------------------*/
ibSourceSelMul	= False


end event

event ue_dwsource_supprime;call super::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_paragraphe
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: JCA
//* Date				: 02/05/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lors de la suppression d'un record de la liste des pi$$HEX1$$e800$$ENDHEX$$ces
//*                 affect$$HEX1$$e900$$ENDHEX$$s, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est $$HEX2$$e0002000$$ENDHEX$$NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat			// Statut de la ligne courante.
integer			iIdOrdre				// order de tri du paragraphe dans la Dw

Long				lNbLigSource		// Nombre de lignes de la datawindow Source
Long				lCpt					// Compteur de boucle

integer			li_Ligsup			// indice ligne $$HEX2$$e0002000$$ENDHEX$$supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/

If This.ilLigSourceSupp > 0 Then

	iIdOrdre	  = Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_ORDRE" )

	dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then
		li_Ligsup = Dw_Source.DeletedCount() + 1

		dw_source.object.data.Delete[li_Ligsup] = dw_source.object.data.Primary[This.ilLigSourceSupp]
			
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)
		
	End If

	lNbLigSource	=	Dw_Source.RowCount ( )
	For lCpt = This.ilLigSourceSupp + 1 to lNbLigSource

		Dw_Source.SetItem ( lCpt, "ID_ORDRE", iIdOrdre )
		iIdOrdre ++
	Next
	
End If

end event

event ue_click_plus;call super::ue_click_plus;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_paragraphe
//* Evenement 		: ue_click_plus
//* Auteur			: JCA
//* Date				: 14/05/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification ordre du tri
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcCptTriActuel
Decimal{0}	dcCptTriFutur

Long			lNbLig
Long			lLigCour

String 		sObjet

lNbLig	=	This.Dw_Source.RowCount ( )
lLigCour	=	This.Dw_Source.GetRow ( )
sObjet	=	This.Dw_Source.GetObjectAtPointer ( )

If Pos ( sObjet, "b_moins" ) > 0 Then

	If lLigCour < lNbLig Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "ID_ORDRE" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour + 1, "ID_ORDRE" )

		This.Dw_Source.SetItem ( lLigCour, 		"ID_ORDRE", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour + 1, "ID_ORDRE", dcCptTriActuel 	)
	End If	
ElseIf Pos ( sObjet, "b_plus" ) > 0 Then

	If lLigCour > 1 Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "ID_ORDRE" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour - 1, "ID_ORDRE" )

		This.Dw_Source.SetItem ( lLigCour, 		"ID_ORDRE", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour - 1, "ID_ORDRE", dcCptTriActuel 	)
	End If
End If

end event

event ue_dwcible_supprime;call super::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_paragraphe_cour_prod
//* Evenement 		: ue_dwcible_supprime
//* Auteur			: JCA
//* Date				: 21/05/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

integer iIdOrdre

if this.ilLigSourceSupp > 0 Then
	
	iIdOrdre = uo_paragraphe.dw_source.rowcount() + 1

	f_creele ( uo_paragraphe.dw_cible, this.ilLigSourceSupp )
	f_majpar ( uo_paragraphe.dw_cible, this.ilLigSourceSupp )
	
	uo_paragraphe.dw_cible.setitem ( this.ilLigSourceSupp, 'ID_PROD', idcIdProd )
	uo_paragraphe.dw_cible.setitem ( this.ilLigSourceSupp, 'ID_NAT_COUR', isidcour )
	uo_paragraphe.dw_cible.setitem ( this.ilLigSourceSupp, 'ID_COUR', isidcour )
	uo_paragraphe.dw_cible.setitem ( this.ilLigSourceSupp, 'ID_ORDRE', iIdOrdre )
	uo_paragraphe.dw_cible.setitem ( this.ilLigSourceSupp, 'ALT_CONF', 'N' )
	
end if

return 0

end event

type pb_1 from u_8_pbvalider within w_t_sp_paragraphe_cour_prod
integer x = 55
integer y = 44
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -7
string facename = "Arial"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_1
//* Evenement 		: CLICKED - OVERRIDE
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 22/01/1997 15:29:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle la saisie avant de fermer la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.Triggerevent ( "ue_controler" )
end on

