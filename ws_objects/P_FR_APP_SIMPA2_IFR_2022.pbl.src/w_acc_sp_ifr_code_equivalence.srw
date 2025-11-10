HA$PBExportHeader$w_acc_sp_ifr_code_equivalence.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour modification code $$HEX1$$e900$$ENDHEX$$quivalence
forward
global type w_acc_sp_ifr_code_equivalence from w_8_accueil
end type
end forward

global type w_acc_sp_ifr_code_equivalence from w_8_accueil
integer x = 1075
integer y = 481
end type
global w_acc_sp_ifr_code_equivalence w_acc_sp_ifr_code_equivalence

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Code_equivalence
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 25/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture automatique de la fenetre de traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "UE_MODIFIER" )
end on

on w_acc_sp_ifr_code_equivalence.create
call super::create
end on

on w_acc_sp_ifr_code_equivalence.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on ue_modifier;call w_8_accueil::ue_modifier;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Code_Equivalence
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture automatique de la fenetre de traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

istPass.bSupprime = True
istPass.bControl  = False

F_OuvreTraitement ( W_Trt_Sp_ifr_Code_Equivalence, istpass )
end on

on ue_enablefenetre;call w_8_accueil::ue_enablefenetre;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Code_Equivalence
//* Evenement 		: ue_enablefenetre
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture automatique de la fenetre d'accueil lorsque
//*                 l'on revient de la fenetre de traitement 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

This.PostEvent ( "ue_retour" )
end on

type pb_retour from w_8_accueil`pb_retour within w_acc_sp_ifr_code_equivalence
end type

type pb_interro from w_8_accueil`pb_interro within w_acc_sp_ifr_code_equivalence
end type

type pb_creer from w_8_accueil`pb_creer within w_acc_sp_ifr_code_equivalence
end type

type dw_1 from w_8_accueil`dw_1 within w_acc_sp_ifr_code_equivalence
end type

type pb_tri from w_8_accueil`pb_tri within w_acc_sp_ifr_code_equivalence
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_acc_sp_ifr_code_equivalence
end type

