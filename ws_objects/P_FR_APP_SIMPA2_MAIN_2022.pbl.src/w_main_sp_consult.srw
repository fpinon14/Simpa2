HA$PBExportHeader$w_main_sp_consult.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre MAIN pour le module de consultation de l'application SIMPA 2.
forward
global type w_main_sp_consult from w_main
end type
end forward

global type w_main_sp_consult from w_main
int X=1
int Y=1
int Width=3639
int Height=2373
boolean TitleBar=true
string Title="PARAMETRAGE SIMPA 2"
string MenuName="m_main_sp_consult"
long BackColor=12632256
end type
global w_main_sp_consult w_main_sp_consult

on w_main_sp_consult.create
call w_main::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_sp_consult" then this.MenuID = create m_main_sp_consult
end on

on w_main_sp_consult.destroy
call w_main::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

