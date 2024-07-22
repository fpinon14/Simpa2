HA$PBExportHeader$w_a_sp_recopie_produit.srw
$PBExportComments$--} fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la recopie de produit
forward
global type w_a_sp_recopie_produit from w_accueil
end type
end forward

global type w_a_sp_recopie_produit from w_accueil
integer height = 1544
string title = "Recopie de produit"
end type
global w_a_sp_recopie_produit w_a_sp_recopie_produit

type variables

end variables

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_recopie_produit
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 09:37:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

This.itrTrans		= SQLCA
istPass.trTrans	= This.itrTrans
istPass.bControl	= True
istPass.bInsert	= False
istPass.bSupprime	= False
istPass.lTab[1]	= UnitsToPixels ( This.Width, XUnitsToPixels! )

f_OuvreTraitement ( W_t_sp_recopie_produit, istPass )



end event

on ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Corb_Oper::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil 								(OVERRIDE)
//* Auteur			: Erick John Stark
//* Date				: 29/09/1997 15:35:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retour de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$clenche cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement. Comme on ne    */
/* veut rien mettre $$HEX2$$e0002000$$ENDHEX$$jour dans la DW d'accueil, on referme         */
/* automatiquement la fen$$HEX1$$ea00$$ENDHEX$$tre. Cela a pour effet de refermer cette  */
/* fen$$HEX1$$ea00$$ENDHEX$$tre et la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement.                             */
/*------------------------------------------------------------------*/

PostEvent ( This, "Ue_Retour" )
end on

on w_a_sp_recopie_produit.create
call super::create
end on

on w_a_sp_recopie_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_accueil`cb_debug within w_a_sp_recopie_produit
end type

type pb_retour from w_accueil`pb_retour within w_a_sp_recopie_produit
end type

type pb_interro from w_accueil`pb_interro within w_a_sp_recopie_produit
boolean visible = false
boolean enabled = false
end type

type pb_creer from w_accueil`pb_creer within w_a_sp_recopie_produit
boolean visible = false
boolean enabled = false
end type

type dw_1 from w_accueil`dw_1 within w_a_sp_recopie_produit
end type

on dw_1::ue_majaccueil;call w_accueil`dw_1::ue_majaccueil;
PostEvent ( Parent, "Ue_Retour" )
end on

type pb_tri from w_accueil`pb_tri within w_a_sp_recopie_produit
integer x = 293
end type

type pb_imprimer from w_accueil`pb_imprimer within w_a_sp_recopie_produit
boolean visible = true
integer x = 567
boolean enabled = true
end type

