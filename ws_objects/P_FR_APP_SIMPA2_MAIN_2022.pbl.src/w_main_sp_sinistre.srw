HA$PBExportHeader$w_main_sp_sinistre.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre MAIN pour le module de gestion des sinistres de l'application SIMPA 2.
forward
global type w_main_sp_sinistre from w_main
end type
end forward

global type w_main_sp_sinistre from w_main
int X=1
int Y=1
int Width=3639
int Height=2373
boolean TitleBar=true
string Title="Gestion des sinistres SIMPA 2"
string MenuName="m_main_sp_sinistre"
long BackColor=12632256
end type
global w_main_sp_sinistre w_main_sp_sinistre

on open;call w_main::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Main::Open (Extend)
//* Evenement 		: Open
//* Auteur			: Fabry Jean-Fran$$HEX1$$e700$$ENDHEX$$ois
//* Date				: 03/09/1997 17:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1  JFF		09/09/2002	Activation/D$$HEX1$$e900$$ENDHEX$$sactivation des menu "Saisie" et "Validation" via le fichier INI
//*-----------------------------------------------------------------

Boolean bRaccWorkflow 

/*------------------------------------------------------------------*/
/* #1 : JFF le 09/09/2002														  */
/*------------------------------------------------------------------*/
bRaccWorkflow = Upper ( ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "N" )) = "O"      
This.MenuId.Item [ 1 ].Item [ 1 ].Enabled = bRaccWorkflow // Saisie
This.MenuId.Item [ 1 ].Item [ 3 ].Enabled = bRaccWorkflow // Validation

end on

on w_main_sp_sinistre.create
call w_main::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_sp_sinistre" then this.MenuID = create m_main_sp_sinistre
end on

on w_main_sp_sinistre.destroy
call w_main::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

