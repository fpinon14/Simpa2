HA$PBExportHeader$w_main_sp_boitesarchive.srw
forward
global type w_main_sp_boitesarchive from w_main
end type
end forward

global type w_main_sp_boitesarchive from w_main
int X=1
int Y=1
int Width=3639
int Height=2373
boolean TitleBar=true
string Title="Gestion Bo$$HEX1$$ee00$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$archive"
string MenuName="m_main_sp_boitesarchive"
long BackColor=12632256
end type
global w_main_sp_boitesarchive w_main_sp_boitesarchive

on w_main_sp_boitesarchive.create
call w_main::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_sp_boitesarchive" then this.MenuID = create m_main_sp_boitesarchive
end on

on w_main_sp_boitesarchive.destroy
call w_main::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

