HA$PBExportHeader$w_a_sp_wkfs_w_queue_p.srw
$PBExportComments$Fenetre accueil wkfs_w_queue pour sold$$HEX2$$e9002000$$ENDHEX$$priv$$HEX1$$e900$$ENDHEX$$
forward
global type w_a_sp_wkfs_w_queue_p from w_a_sp_anc_wkfs_w_queue
end type
end forward

global type w_a_sp_wkfs_w_queue_p from w_a_sp_anc_wkfs_w_queue
end type
global w_a_sp_wkfs_w_queue_p w_a_sp_wkfs_w_queue_p

on ue_typ_trt;call w_a_sp_anc_wkfs_w_queue::ue_typ_trt;//*-----------------------------------------------------------------
//*
//* Objet         : w_a_sp_wkfs_w_queue_p
//* Evenement     : ue_typ_trt
//* Auteur        : PLJ
//* Date          : 16/09/2003 10:12:18
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


icOrigineTrt = 'P'
end on

on w_a_sp_wkfs_w_queue_p.create
call w_a_sp_anc_wkfs_w_queue::create
end on

on w_a_sp_wkfs_w_queue_p.destroy
call w_a_sp_anc_wkfs_w_queue::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_trt_centraloper from w_a_sp_anc_wkfs_w_queue`dw_trt_centraloper within w_a_sp_wkfs_w_queue_p
boolean Visible=false
end type

