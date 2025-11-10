HA$PBExportHeader$w_a_sp_wkfs_w_queue_c.srw
$PBExportComments$Fenetre accueil wkfs_w_queue pour centralisateur
forward
global type w_a_sp_wkfs_w_queue_c from w_a_sp_anc_wkfs_w_queue
end type
type pb_supprimer from picturebutton within w_a_sp_wkfs_w_queue_c
end type
end forward

global type w_a_sp_wkfs_w_queue_c from w_a_sp_anc_wkfs_w_queue
pb_supprimer pb_supprimer
end type
global w_a_sp_wkfs_w_queue_c w_a_sp_wkfs_w_queue_c

on open;call w_a_sp_anc_wkfs_w_queue::open;//*-----------------------------------------------------------------
//*
//* Objet         : w_a_sp_wkfs_w_queue_c
//* Evenement     : Open  (Extend)
//* Auteur        : PLJ
//* Date          : 03/12/2004
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

Long lTotLigne = 0

/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 205(droit de suppression WKFS_W_QUEUE) fait*/
/* appara$$HEX1$$ee00$$ENDHEX$$tre le bouton pb_supprimer pour l'op$$HEX1$$e900$$ENDHEX$$rateur connect$$HEX9$$e90020002000200020002000200020002000$$ENDHEX$$*/
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 205		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;


If lTotLigne > 0 Then
   pb_supprimer.Visible = True
Else
	pb_supprimer.Visible = False
End If
end on

on ue_typ_trt;call w_a_sp_anc_wkfs_w_queue::ue_typ_trt;//*-----------------------------------------------------------------
//*
//* Objet         : w_a_sp_wkfs_w_queue_c
//* Evenement     : ue_typ_trt
//* Auteur        : PLJ
//* Date          : 16/09/2003 10:07:11
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


icOrigineTrt = 'C'



end on

on w_a_sp_wkfs_w_queue_c.create
int iCurrent
call super::create
this.pb_supprimer=create pb_supprimer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_supprimer
end on

on w_a_sp_wkfs_w_queue_c.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_supprimer)
end on

type pb_retour from w_a_sp_anc_wkfs_w_queue`pb_retour within w_a_sp_wkfs_w_queue_c
integer taborder = 60
end type

type pb_interro from w_a_sp_anc_wkfs_w_queue`pb_interro within w_a_sp_wkfs_w_queue_c
integer taborder = 80
end type

type pb_creer from w_a_sp_anc_wkfs_w_queue`pb_creer within w_a_sp_wkfs_w_queue_c
integer taborder = 70
end type

type dw_1 from w_a_sp_anc_wkfs_w_queue`dw_1 within w_a_sp_wkfs_w_queue_c
end type

type pb_tri from w_a_sp_anc_wkfs_w_queue`pb_tri within w_a_sp_wkfs_w_queue_c
integer taborder = 90
end type

type pb_imprimer from w_a_sp_anc_wkfs_w_queue`pb_imprimer within w_a_sp_wkfs_w_queue_c
end type

type dw_stk_operateur from w_a_sp_anc_wkfs_w_queue`dw_stk_operateur within w_a_sp_wkfs_w_queue_c
end type

type dw_trt_centraloper from w_a_sp_anc_wkfs_w_queue`dw_trt_centraloper within w_a_sp_wkfs_w_queue_c
end type

type pb_supprimer from picturebutton within w_a_sp_wkfs_w_queue_c
boolean visible = false
integer x = 1006
integer y = 16
integer width = 233
integer height = 136
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Supprimer"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_annu.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_wkf_w_queue_c::pd_supprimer
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 03/12/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Suppresion de la ligne de wkfs_w_queue
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 			MADM/JCA	05/05/2006 suppression du prefixe table '05/05/2006'
//*-----------------------------------------------------------------

long	lIdSin, lRet


lIdSin = dw_1.getItemNumber ( dw_1.ilLigneClick, "ID_SIN")

stMessage.sTitre     = "Centralisation"
stMessage.Icon	      = Question!
stMessage.bErreurG	= False
stMessage.sCode		= "BARC055"
stMessage.bTrace  	= False
stMessage.Bouton		= YesNo!
stMessage.sVar[1]    = String (lIdSin)
 
lRet = f_Message ( stMessage )

If lRet = 1 Then

	DELETE FROM sysadm.wkfs_w_queue WHERE id_sin = :lIdSin
    USING SQLCA;

	IF SQLCA.SqlCode <> 0 OR SQLCA.SqlDBCode <> 0 Then
		f_Commit ( SQLCA, FALSE )
	Else
		f_Commit ( SQLCA, TRUE  )
		dw_1.DeleteRow ( dw_1.ilLigneClick )
	End If


End If
end event

