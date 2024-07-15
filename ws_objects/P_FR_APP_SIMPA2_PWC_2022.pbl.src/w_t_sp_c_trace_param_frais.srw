HA$PBExportHeader$w_t_sp_c_trace_param_frais.srw
$PBExportComments$[O2M_FRAIS].FPI
forward
global type w_t_sp_c_trace_param_frais from w_8_ancetre_consultation
end type
type dw_1 from u_datawindow within w_t_sp_c_trace_param_frais
end type
type pb_1 from u_pbtrier within w_t_sp_c_trace_param_frais
end type
end forward

global type w_t_sp_c_trace_param_frais from w_8_ancetre_consultation
integer x = 5
integer y = 148
integer width = 2848
integer height = 1796
string title = "Historique des modifications"
boolean controlmenu = false
boolean minbox = false
dw_1 dw_1
pb_1 pb_1
end type
global w_t_sp_c_trace_param_frais w_t_sp_c_trace_param_frais

type variables
Long 		ilIdProd,ilIdGti, ilIdSeq, ilIdProcess
String	isIdFour,isMajPar
Date		idtMajLe

Boolean 	ibFromAccueil

String 	isImportTri
end variables

forward prototypes
private subroutine wf_construire_chaine_tri ()
end prototypes

private subroutine wf_construire_chaine_tri ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_c_trace_param_frais::wf_construire_chaine_tri
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 17:24:46
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

String sTab, sNew, sImport

sTab			= "~t"
sNew			= "~r~n"

sImport = "Date Modif"	+ sTab	+ &
			 "1" + sTab	+ &
			 "MAJ_LE"		+ sNew

sImport = sImport+ "Produit"	+ sTab	+ &
			 "2" + sTab	+ &
			 "ID_PROD"		+ sNew

sImport = sImport+ "N$$HEX2$$b0002000$$ENDHEX$$Param."	+ sTab	+ &
			 "4" + sTab	+ &
			 "ID_SEQ"		+ sNew

isImportTri = sImport

end subroutine

on w_t_sp_c_trace_param_frais.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_1
end on

on w_t_sp_c_trace_param_frais.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.pb_1)
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_c_trace_param_frais
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 14:37:41
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

s_pass	stPass

stPass=Message.Powerobjectparm

If UpperBound(stPass.lTab) > 1 Then
	ilIdProd  = stPass.lTab [ 1 ] 
	ilIdGti  = stPass.lTab [ 2 ] 
	ilIdprocess = stPass.lTab [ 3 ]
	isIdFour = stPass.sTab [ 1 ] 
	isMajPar = stPass.sTab [ 2 ] 
	idtMajLe = stPass.dtab[1] 
	ibFromAccueil = TRUE
	
Else
	ilIdSeq = stPass.lTab [ 1 ] 
	ibFromAccueil = FALSE
End if

wf_Construire_Chaine_Tri()
end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_c_trace_param_frais
//* Evenement 		: show
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 16:10:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value boolean show	 */
/* 	value long status	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If ibfromaccueil Then
	dw_1.dataobject="d_sp_constrace_param_frais"
	dw_1.settransobject( SQLCA )
	dw_1.Retrieve(ilIdprod, isIdfour, ilidgti, ilidprocess, Datetime(idtmajle), ismajpar) // [PI056] Datetime
Else
	dw_1.dataobject="d_sp_constrace_param_frais2"
	dw_1.settransobject( SQLCA )
	dw_1.Retrieve( ilidseq )
End if
end event

event close;// OVERRIDE
end event

event ue_trier;call super::ue_trier;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_c_trace_param_frais !! OVERRIDE !!
//* Evenement 		: ue_trier
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 17:17:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sRet
s_tri  stTri
Long lLigne

// .... Remplissage de la Structure de Tri

stTri.sImport		= This.isImportTri
stTri.sTriActuel	= dw_1.isTri

OpenWithParm ( w_Tri, stTri )

sRet = Message.StringParm

// .... Deux cas possibles
// .... sRet = NULL		-> La personne $$HEX2$$e0002000$$ENDHEX$$appuyer sur RETOUR
//								-> On ne fait rien
//
// .... sRet <> NULL 	-> La Chaine est Vide ou Non
//								-> On positionne la cha$$HEX1$$ee00$$ENDHEX$$ne de Tri et On Tri la DW

If	Not IsNull ( sRet ) Then

	dw_1.isTri = sRet
	dw_1.TriggerEvent ( "Ue_Trier" )

End If

dw_1.SetFocus ()



end event

type cb_debug from w_8_ancetre_consultation`cb_debug within w_t_sp_c_trace_param_frais
integer x = 2395
integer y = 20
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_t_sp_c_trace_param_frais
boolean visible = false
integer x = 1614
integer y = 72
integer width = 1157
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_t_sp_c_trace_param_frais
integer y = 36
integer width = 242
integer height = 144
end type

type dw_1 from u_datawindow within w_t_sp_c_trace_param_frais
integer x = 32
integer y = 204
integer width = 2766
integer height = 1388
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_sp_constrace_param_frais"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from u_pbtrier within w_t_sp_c_trace_param_frais
integer x = 320
integer y = 36
integer width = 233
integer height = 136
integer taborder = 11
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean originalsize = false
end type

