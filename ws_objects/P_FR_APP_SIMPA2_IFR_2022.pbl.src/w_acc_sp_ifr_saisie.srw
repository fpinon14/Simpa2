HA$PBExportHeader$w_acc_sp_ifr_saisie.srw
$PBExportComments$Fenetre Accueil pour saisie table IFR
forward
global type w_acc_sp_ifr_saisie from w_8_accueil
end type
end forward

global type w_acc_sp_ifr_saisie from w_8_accueil
boolean TitleBar=true
string Title="Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil - IFR"
end type
global w_acc_sp_ifr_saisie w_acc_sp_ifr_saisie

on ue_modifier;call w_8_accueil::ue_modifier;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Saisie
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture automatique de la fenetre de traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

istPass.bSupprime = True
istPass.bControl  = False

F_OuvreTraitement ( W_Trt_Sp_ifr_saisie, istpass )
end on

on ue_enablefenetre;call w_8_accueil::ue_enablefenetre;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Saisie
//* Evenement 		: ue_enablefenetre
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture automatique de la fenetre d'accueil lorsque
//*                 l'on revient de la fenetre de traitement 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

This.PostEvent ( "ue_retour" )
end on

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//* Objet 			: W_Acc_Sp_Ifr_Saisie
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture automatique de la fenetre de traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent ( "UE_MODIFIER" )
end on

on w_acc_sp_ifr_saisie.create
call w_8_accueil::create
end on

on w_acc_sp_ifr_saisie.destroy
call w_8_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

