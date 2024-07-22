HA$PBExportHeader$w_a_sp_trt_stat_sin.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre de lancement des traitements SIMPA2
forward
global type w_a_sp_trt_stat_sin from w_a_sp_traitement
end type
type dw_gar_sin_stat from datawindow within w_a_sp_trt_stat_sin
end type
type dw_stat_sin from datawindow within w_a_sp_trt_stat_sin
end type
type dw_reg_gti from datawindow within w_a_sp_trt_stat_sin
end type
type dw_uf_stat from datawindow within w_a_sp_trt_stat_sin
end type
type pb_lancer from picturebutton within w_a_sp_trt_stat_sin
end type
type dw_suivi_trt from datawindow within w_a_sp_trt_stat_sin
end type
type dw_reg_gti_frais from datawindow within w_a_sp_trt_stat_sin
end type
end forward

global type w_a_sp_trt_stat_sin from w_a_sp_traitement
boolean visible = false
string title = "Traitement de la TABLE STAT_SIN"
dw_gar_sin_stat dw_gar_sin_stat
dw_stat_sin dw_stat_sin
dw_reg_gti dw_reg_gti
dw_uf_stat dw_uf_stat
pb_lancer pb_lancer
dw_suivi_trt dw_suivi_trt
dw_reg_gti_frais dw_reg_gti_frais
end type
global w_a_sp_trt_stat_sin w_a_sp_trt_stat_sin

type variables
Private :
	U_Sp_Gs_Trait_Stat_Sin	iuoStatSin

end variables

on open;call w_a_sp_traitement::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Trt_Stat_Sin::Ue_Initialiser (EXTEND)
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 15:07:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient d'ouvrir la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil qui sert $$HEX2$$e0002000$$ENDHEX$$lancer le      */
/* traitement sur la table STAT_SIN. Cette fen$$HEX1$$ea00$$ENDHEX$$tre est h$$HEX1$$e900$$ENDHEX$$rit$$HEX1$$e900$$ENDHEX$$e de   */
/* la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement (W_A_SP_TRAITEMENT). Cette derni$$HEX1$$e800$$ENDHEX$$re se  */
/* charge d'initialiser diff$$HEX1$$e900$$ENDHEX$$rents objets. (DW_DATES, UO_DEFIL,     */
/* itrTrans).                                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de cr$$HEX1$$e900$$ENDHEX$$er un NVUO pour la gestion   */
/* particuli$$HEX1$$e800$$ENDHEX$$re sur STAT_SIN.                                       */
/*------------------------------------------------------------------*/

DataWindow	dwNorm[6]

iuoStatSin	=	Create U_Sp_Gs_Trait_Stat_Sin

dwNorm[ 1]	= dw_Gar_Sin_Stat
dwNorm[ 2]	= dw_Stat_Sin
dwNorm[ 3]	= dw_Reg_Gti
dwNorm[ 4]	= dw_Uf_Stat
dwNorm[ 5]	= dw_Reg_Gti_Frais
dwNorm[ 6]	= dw_Suivi_Trt
itrTrans		= SQLCA

iuoStatSin.Uf_Initialiser ( dw_1, dw_Dates, dw_Dept, uo_Defil, itrTrans )
iuoStatSin.Uf_Initialiser_Dw_Desc ( dwNorm[] )

iuoStatSin.Uf_Choix_Periode ()

/*------------------------------------------------------------------*/
/* On remet le focus par d$$HEX1$$e900$$ENDHEX$$faut sur le bouton RETOUR. En effet, la  */
/* fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre positionne le focus sur le bouton INTERRO, qui   */
/* est invisible actuellement.                                      */
/*------------------------------------------------------------------*/

Pb_Retour.SetFocus ()

end on

on close;call w_a_sp_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Trt_Stat_Sin::Close (EXTEND)
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 15:11:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermeture d$$HEX1$$e900$$ENDHEX$$finitive de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iUoStatSin


end on

on w_a_sp_trt_stat_sin.create
int iCurrent
call super::create
this.dw_gar_sin_stat=create dw_gar_sin_stat
this.dw_stat_sin=create dw_stat_sin
this.dw_reg_gti=create dw_reg_gti
this.dw_uf_stat=create dw_uf_stat
this.pb_lancer=create pb_lancer
this.dw_suivi_trt=create dw_suivi_trt
this.dw_reg_gti_frais=create dw_reg_gti_frais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gar_sin_stat
this.Control[iCurrent+2]=this.dw_stat_sin
this.Control[iCurrent+3]=this.dw_reg_gti
this.Control[iCurrent+4]=this.dw_uf_stat
this.Control[iCurrent+5]=this.pb_lancer
this.Control[iCurrent+6]=this.dw_suivi_trt
this.Control[iCurrent+7]=this.dw_reg_gti_frais
end on

on w_a_sp_trt_stat_sin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_gar_sin_stat)
destroy(this.dw_stat_sin)
destroy(this.dw_reg_gti)
destroy(this.dw_uf_stat)
destroy(this.pb_lancer)
destroy(this.dw_suivi_trt)
destroy(this.dw_reg_gti_frais)
end on

type cb_debug from w_a_sp_traitement`cb_debug within w_a_sp_trt_stat_sin
end type

type pb_retour from w_a_sp_traitement`pb_retour within w_a_sp_trt_stat_sin
integer taborder = 30
end type

type pb_interro from w_a_sp_traitement`pb_interro within w_a_sp_trt_stat_sin
end type

type pb_creer from w_a_sp_traitement`pb_creer within w_a_sp_trt_stat_sin
end type

type dw_1 from w_a_sp_traitement`dw_1 within w_a_sp_trt_stat_sin
integer x = 4105
integer y = 652
integer width = 242
integer height = 100
integer taborder = 0
boolean enabled = false
boolean vscrollbar = false
boolean livescroll = false
end type

type pb_tri from w_a_sp_traitement`pb_tri within w_a_sp_trt_stat_sin
end type

type pb_imprimer from w_a_sp_traitement`pb_imprimer within w_a_sp_trt_stat_sin
end type

type dw_dates from w_a_sp_traitement`dw_dates within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 672
integer y = 76
boolean enabled = false
boolean livescroll = false
end type

type dw_dept from w_a_sp_traitement`dw_dept within w_a_sp_trt_stat_sin
boolean visible = false
integer y = 12
integer height = 168
integer taborder = 20
boolean enabled = false
end type

type uo_defil from w_a_sp_traitement`uo_defil within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 869
integer y = 248
integer width = 1627
boolean enabled = false
end type

type dw_volcane from w_a_sp_traitement`dw_volcane within w_a_sp_trt_stat_sin
integer x = 4101
integer y = 780
integer width = 242
integer height = 100
end type

type dw_etat from w_a_sp_traitement`dw_etat within w_a_sp_trt_stat_sin
integer x = 3127
integer y = 856
integer width = 242
integer height = 100
integer taborder = 0
end type

type dw_gar_sin_stat from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 3127
integer y = 1280
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
end type

type dw_stat_sin from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 3127
integer y = 1000
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_stat_sin"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_Stat_Sin::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sSql

Long dcIdSin, dcIdPeriode, dcIdGti, dcIdRgpt
Long dcCodEtat, dcCptEtat, dcCptOuv, dcCptReg
Long lLig

Decimal {2} dcMtReg, dcMtProv

dwBuffer		dwBuf

DateTime dtMajLe, dtCreeLe
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion.          */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdPeriode		= This.GetItemNumber ( lLig,	"ID_PERIODE"			)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdRgpt			= This.GetItemNumber ( lLig,	"ID_RGPT"				)

	dcCodEtat		= This.GetItemNumber ( lLig,	"COD_ETAT"				)

	dcCptEtat		= This.GetItemNumber ( lLig,	"CPT_ETAT"				)
	dcCptOuv			= This.GetItemNumber ( lLig,	"CPT_OUV"				)
	dcCptReg			= This.GetItemNumber ( lLig,	"CPT_REG"				)

	dcMtReg			= This.GetItemNumber ( lLig,	"MT_REG"					)
	dcMtProv			= This.GetItemNumber ( lLig,	"MT_PROV"				)

	sMajPar			= stGLB.sCodOper
	dtMajLe			= This.GetItemDateTime ( lLig, "MAJ_LE" 					)
	dtCreeLe			= dtMajLe

	
	sSql = 'sysadm.DW_I01_STAT_SIN ' 										+	&
				String ( dcIdSin 							) + ', '				+ 	&
				String ( dcIdPeriode						) + ', '				+ 	&
				String ( dcIdGti 							) + ', '				+ 	&
				String ( dcIdRgpt 						) + ', '				+ 	&
				String ( dcCodEtat 						) + ', '				+ 	&
				String ( dcCptEtat 						) + ', '				+ 	&
				String ( dcCptOuv 						) + ', '				+ 	&
				String ( dcCptReg 						) + ', '				+ 	&
				String ( dcMtReg, "0.00" 				) + ', '				+ 	&
				String ( dcMtProv, "0.00"  			) + ', '				+ 	&
				'"' + String ( dtCreeLe, "dd/mm/yyyy hh:mm:ss.ff" 	)	+ '"' + 	', '				+ 	&
				'"' + String ( dtMajLe, "dd/mm/yyyy hh:mm:ss.ff"	)	+ '"'	+	', '				+ 	&
				'"' + sMajPar + '"'

	// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
	//EXECUTE IMMEDIATE :sSql USING	itrTrans	;
	f_execute( sSql, itrTrans )
	// [MIGPB11] [EMD] : Fin Migration

	uo_Defil.Uf_Progression ( lLig )

	If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//		This.SetActionCode ( 1 )
		ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
	Else
//Migration PB8-WYNIWYG-03/2006 FM
//		This.SetActionCode ( 2 )
		ll_ret = 2
//Migration PB8-WYNIWYG-03/2006 FM
	End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_reg_gti from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 3127
integer y = 1140
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_reg_gti_somme_stat"
end type

type dw_uf_stat from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 3127
integer y = 1420
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_gar_sin_stat_uf"
end type

type pb_lancer from picturebutton within w_a_sp_trt_stat_sin
integer x = 283
integer y = 16
integer width = 233
integer height = 136
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Lancer"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Trt_Stat_Sin::Pb_Lancer (EXTEND)
//* Evenement 		: Lancement du traitement
//* Auteur			: Erick John Stark
//* Date				: 22/12/1998 11:42:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va lancer le traitement
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga

Parent.Enabled	= False

iUoStatSin.Uf_Traitement ( 2, stPass_Dga )

Parent.Enabled	= True




end on

type dw_suivi_trt from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 64
integer y = 348
integer width = 3273
integer height = 1172
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trace_traitement"
boolean vscrollbar = true
end type

type dw_reg_gti_frais from datawindow within w_a_sp_trt_stat_sin
boolean visible = false
integer x = 3127
integer y = 704
integer width = 242
integer height = 100
boolean enabled = false
string dataobject = "d_sp_reg_gti_stat_etape03"
end type

