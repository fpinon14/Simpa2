HA$PBExportHeader$w_acc_sp_ifr_integration_ifr.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour modification IFR
forward
global type w_acc_sp_ifr_integration_ifr from w_8_accueil
end type
type dw_charg from datawindow within w_acc_sp_ifr_integration_ifr
end type
type dw_log from datawindow within w_acc_sp_ifr_integration_ifr
end type
type dw_trt from datawindow within w_acc_sp_ifr_integration_ifr
end type
type st_libcharg from statictext within w_acc_sp_ifr_integration_ifr
end type
type st_logtrt from statictext within w_acc_sp_ifr_integration_ifr
end type
type dw_stk_param from datawindow within w_acc_sp_ifr_integration_ifr
end type
end forward

global type w_acc_sp_ifr_integration_ifr from w_8_accueil
integer width = 2318
integer height = 992
string title = "Fen$$HEX1$$ea00$$ENDHEX$$tre d~'int$$HEX1$$e900$$ENDHEX$$gration des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiels"
long backcolor = 67108864
dw_charg dw_charg
dw_log dw_log
dw_trt dw_trt
st_libcharg st_libcharg
st_logtrt st_logtrt
dw_stk_param dw_stk_param
end type
global w_acc_sp_ifr_integration_ifr w_acc_sp_ifr_integration_ifr

type variables

Private Constant integer K_HAUTEUR = 650 

Private :
u_sp_ifr_integration	 iuoObjInt

Boolean ibChargement
end variables

forward prototypes
public subroutine wf_positionnerobjets ()
end prototypes

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: wf_positionnerobjets
//* Auteur			: Fabry JF
//* Date				: 28/07/2008 11:41:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: (none)
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

pb_creer.Hide ()
pb_interro.Hide ()
pb_tri.Hide ()
pb_imprimer.Hide ()

dw_trt.x = 18
dw_trt.y = 188
dw_trt.width = 1179
dw_trt.height = 2196

dw_charg.x = 1216
dw_charg.y = 96
dw_charg.width = 2358
dw_charg.height = 624

dw_log.x = 1216
dw_log.y = 832
dw_log.width = 2358
dw_log.height = 1548

st_libcharg.x = 1216
st_libcharg.y = 16
st_libcharg.width = 1125
st_libcharg.height = 64

st_logtrt.x = 1216
st_logtrt.y = 748
st_logtrt.width = 1125
st_logtrt.height = 64

end subroutine

on w_acc_sp_ifr_integration_ifr.create
int iCurrent
call super::create
this.dw_charg=create dw_charg
this.dw_log=create dw_log
this.dw_trt=create dw_trt
this.st_libcharg=create st_libcharg
this.st_logtrt=create st_logtrt
this.dw_stk_param=create dw_stk_param
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_charg
this.Control[iCurrent+2]=this.dw_log
this.Control[iCurrent+3]=this.dw_trt
this.Control[iCurrent+4]=this.st_libcharg
this.Control[iCurrent+5]=this.st_logtrt
this.Control[iCurrent+6]=this.dw_stk_param
end on

on w_acc_sp_ifr_integration_ifr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_charg)
destroy(this.dw_log)
destroy(this.dw_trt)
destroy(this.st_libcharg)
destroy(this.st_logtrt)
destroy(this.dw_stk_param)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: ue_initialiser
//* Auteur			: Fabry JF
//* Date				: 23/07/2008 14:26:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP080388] L'int$$HEX1$$e900$$ENDHEX$$gralit$$HEX2$$e9002000$$ENDHEX$$de cette fen$$HEX1$$ea00$$ENDHEX$$tre concerne cette DCMP
//*				  
//* Arguments		: value unsignedlong wparam	 
//* 					  value long 		   lparam	 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

s_Pass stPass

wf_PositionnerObjets ()

stPass.dwNorm [1] = dw_trt
stPass.dwNorm [2] = dw_charg
stPass.dwNorm [3] = dw_log
stPass.dwNorm [4] = dw_stk_param


iuoObjInt = Create u_sp_ifr_integration

iuoObjInt.uf_Initialiser ( stPass )



end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: show
//* Auteur			: Fabry JF
//* Date				: 28/07/2008 11:23:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value boolean show	 
//* 					  value long 	 status
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

gWMdi.Height += K_HAUTEUR

iuoObjInt.uf_preparermodifier ( )
end event

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: close
//* Auteur			: Fabry JF
//* Date				: 28/07/2008 11:23:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If IsValid ( iuoObjInt ) Then Destroy ( iuoObjInt )

gWMdi.Height -= K_HAUTEUR

end event

type cb_debug from w_8_accueil`cb_debug within w_acc_sp_ifr_integration_ifr
end type

type pb_retour from w_8_accueil`pb_retour within w_acc_sp_ifr_integration_ifr
end type

type pb_interro from w_8_accueil`pb_interro within w_acc_sp_ifr_integration_ifr
end type

type pb_creer from w_8_accueil`pb_creer within w_acc_sp_ifr_integration_ifr
end type

type dw_1 from w_8_accueil`dw_1 within w_acc_sp_ifr_integration_ifr
integer x = 2752
integer y = 32
integer width = 82
integer height = 88
borderstyle borderstyle = stylebox!
end type

type pb_tri from w_8_accueil`pb_tri within w_acc_sp_ifr_integration_ifr
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_acc_sp_ifr_integration_ifr
boolean visible = true
end type

type dw_charg from datawindow within w_acc_sp_ifr_integration_ifr
event ue_switchblocage ( boolean abswitchblocage )
integer x = 795
integer y = 188
integer width = 334
integer height = 260
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_stk_sp_ifr_chargement"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_switchblocage(boolean abswitchblocage);//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: ue_switchblocage
//* Auteur			: Fabry JF
//* Date				: 31/07/2008 14:48:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value boolean abswitch
//*
//* Retourne		: (none)
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

ibChargement = abSwitchBlocage


end event

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: itemchanged
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:30:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 
//* 					  value dwobject dwo
//* 					  value string data
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVal

If ibChargement Then Return 2

stMessage.sTitre = "Traitement"
stMessage.sCode = "INRF003"
stMessage.icon = Exclamation!
F_Message ( stMessage )

sVal = dw_Charg.GetItemString ( row, String ( dwo.name )  )
dw_Charg.SetItem ( row, String ( dwo.name ), sVal )
dw_Charg.SetText ( sVal )

Return 1

end event

event losefocus;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: losefocus
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:57:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


This.AcceptText ()
end event

event itemfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: itemfocuschanged
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:57:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row
//* 					  value dwobject dwo	 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVal

If ibChargement Then Return 2

stMessage.sTitre = "Traitement"
stMessage.sCode = "INRF003"
stMessage.icon = Exclamation!
F_Message ( stMessage )

sVal = dw_Charg.GetItemString ( row, String ( dwo.name )  )
dw_Charg.SetItem ( row, String ( dwo.name ), sVal )
dw_Charg.SetText ( sVal )

Return 0
end event

event itemerror;String sVal

sVal = dw_Charg.GetItemString ( row, String ( dwo.name )  )
dw_Charg.SetItem ( row, String ( dwo.name ), sVal )
dw_Charg.SetText ( sVal )

Return 1
end event

type dw_log from datawindow within w_acc_sp_ifr_integration_ifr
integer x = 1573
integer y = 188
integer width = 334
integer height = 260
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_suivi_trt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_trt from datawindow within w_acc_sp_ifr_integration_ifr
integer x = 18
integer y = 188
integer width = 334
integer height = 260
integer taborder = 30
boolean bringtotop = true
string title = "Fen$$HEX1$$ea00$$ENDHEX$$tre d~'int$$HEX1$$e900$$ENDHEX$$gration des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiels"
string dataobject = "d_trt_sp_ifr_action_integr_ifr"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: buttonclicked
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 14:37:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row
//* 					  value long actionreturncode
//* 					  value dwobject dwo	 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

ibChargement = lower ( string ( dwo.name ) ) = "b_chargement" 

iuoObjInt.uf_TrtAction ( dwo.name )

ibChargement = False
end event

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: itemchanged
//* Auteur			: Fabry JF
//* Date				: 31/07/2008 10:28:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 	value long row
//* 						value dwobject dwo
//* 						value string data
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Choose Case Lower ( String ( dwo.name ) )
	Case "nom_ref"
		
		If Upper ( iuoObjInt.uf_GetTrtEnCours () ) <> "VALIDERREF" Then
			Return 1
		End If

End CHoose




end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_acc_sp_ifr_integration_ifr
//* Evenement 		: itemerror
//* Auteur			: Fabry JF
//* Date				: 31/07/2008 10:28:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 	value long row
//* 						value dwobject dwo
//* 						value string data
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Choose Case Lower ( String ( dwo.name ) )
	Case "nom_ref"

		stMessage.sTitre = "Traitement"
		stMessage.sCode = "INRF001"
		stMessage.icon = Information!
		F_Message ( stMessage )
		
		This.SetItem ( 1, String ( dwo.name ), This.GetItemString ( 1, String ( dwo.name ) ) )
		
		Return 1

End CHoose

end event

type st_libcharg from statictext within w_acc_sp_ifr_integration_ifr
integer x = 407
integer y = 188
integer width = 334
integer height = 260
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fichier charg$$HEX2$$e9002000$$ENDHEX$$pour traitement"
boolean focusrectangle = false
end type

type st_logtrt from statictext within w_acc_sp_ifr_integration_ifr
integer x = 1184
integer y = 188
integer width = 334
integer height = 260
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Log du traitement"
boolean focusrectangle = false
end type

type dw_stk_param from datawindow within w_acc_sp_ifr_integration_ifr
boolean visible = false
integer x = 18
integer y = 488
integer width = 334
integer height = 260
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_stk_sp_ifr_param"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

