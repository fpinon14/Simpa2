HA$PBExportHeader$w_a_sp_trt_m.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre Traitement Mensuel
forward
global type w_a_sp_trt_m from w_a_sp_trt
end type
end forward

global type w_a_sp_trt_m from w_a_sp_trt
boolean TitleBar=true
string Title="Traitement MENSUEL"
end type
global w_a_sp_trt_m w_a_sp_trt_m

on ue_definirtrt;call w_a_sp_trt::ue_definirtrt;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_m
//* Evenement 		: ue_DefinirTrt
//* Auteur			: DBI
//* Date				: 26/01/1999 11:19:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Armement de la variable isTypTrt
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

isTypTrt	=	"M"
end on

on w_a_sp_trt_m.create
call w_a_sp_trt::create
end on

on w_a_sp_trt_m.destroy
call w_a_sp_trt::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_dates from w_a_sp_trt`dw_dates within w_a_sp_trt_m
boolean BringToTop=true
end type

type dw_dept from w_a_sp_trt`dw_dept within w_a_sp_trt_m
boolean BringToTop=true
end type

type dw_etat from w_a_sp_trt`dw_etat within w_a_sp_trt_m
boolean BringToTop=true
end type

type pb_lancer from w_a_sp_trt`pb_lancer within w_a_sp_trt_m
boolean BringToTop=true
end type

