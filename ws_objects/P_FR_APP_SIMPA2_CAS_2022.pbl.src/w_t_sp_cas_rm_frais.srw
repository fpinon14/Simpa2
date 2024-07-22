HA$PBExportHeader$w_t_sp_cas_rm_frais.srw
$PBExportComments$[PM72.2]
forward
global type w_t_sp_cas_rm_frais from w_8_accueil
end type
type dw_2 from u_datawindow within w_t_sp_cas_rm_frais
end type
end forward

global type w_t_sp_cas_rm_frais from w_8_accueil
integer width = 4073
integer height = 2216
string title = "Saisie d$$HEX1$$1920$$ENDHEX$$un montant de frais d$$HEX1$$1920$$ENDHEX$$envoi"
dw_2 dw_2
end type
global w_t_sp_cas_rm_frais w_t_sp_cas_rm_frais

type variables
u_gs_sp_cas_rm_frais iuo_rmfrais
end variables

forward prototypes
private subroutine wf_reinit_dw2 (boolean abactiver)
end prototypes

private subroutine wf_reinit_dw2 (boolean abactiver);
end subroutine

on w_t_sp_cas_rm_frais.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_t_sp_cas_rm_frais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
end on

event ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rm_frais
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 13:39:23
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

iuo_rmfrais=CREATE u_gs_sp_cas_rm_frais

iuo_rmfrais.uf_initialiser( dw_1, dw_2 ) 

// [PM72]
If dw_1.GetItemNumber ( 1, "ID_SIN" ) > 0 Then
	iuo_rmfrais.uf_charger()
End If

end event

event close;call super::close;Destroy iuo_rmfrais
end event

type cb_debug from w_8_accueil`cb_debug within w_t_sp_cas_rm_frais
end type

type pb_retour from w_8_accueil`pb_retour within w_t_sp_cas_rm_frais
boolean visible = false
integer x = 3470
integer y = 60
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_t_sp_cas_rm_frais
boolean visible = false
integer x = 2711
integer y = 36
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_t_sp_cas_rm_frais
boolean visible = false
integer x = 1742
integer y = 24
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_t_sp_cas_rm_frais
boolean visible = true
integer x = 5
integer y = 36
integer width = 3694
integer height = 1100
string title = "Saisie d$$HEX1$$1920$$ENDHEX$$un montant de frais d$$HEX1$$1920$$ENDHEX$$envoi li$$HEX2$$e9002000$$ENDHEX$$au PM72"
string dataobject = "d_sp_cas_rm_frais"
boolean vscrollbar = false
boolean border = false
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rm_frais
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 13:40:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value integer xpos	 */
/* 	value integer ypos	 */
/* 	value long row	 */
/* 	value dwobject dwo	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If isnull(dwo) Then return 0

if Upper(dwo.name) = "B_CHARGER" Then
	
	If This.AcceptText() = -1 Then return 0
	
	iuo_rmfrais.uf_charger()

End if
end event

event dw_1::constructor;call super::constructor;uf_Activer_Selection ( FALSE )

ibMenuActif=FALSE
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rm_frais
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 15:44:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72"
	stMessage.Icon			= Information!
	stMessage.bouton=OK!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
		Case "ID_SIN_1"
			This.iiReset = 1
			stMessage.sVar[1] = "r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistre"				
			stMessage.sCode	= "GENE002"
	End Choose

	F_Message ( stMessage )

	Return This.Uf_Reinitialiser ()

End If

return AncestorReturnValue


end event

type pb_tri from w_8_accueil`pb_tri within w_t_sp_cas_rm_frais
boolean visible = false
integer x = 1998
integer y = 32
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_t_sp_cas_rm_frais
end type

type dw_2 from u_datawindow within w_t_sp_cas_rm_frais
integer x = 5
integer y = 1152
integer width = 3707
integer height = 620
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_sp_cas_valid_rm_frais"
boolean border = false
end type

event clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rm_frais
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 13:40:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value integer xpos	 */
/* 	value integer ypos	 */
/* 	value long row	 */
/* 	value dwobject dwo	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Decimal dcIdSin

Choose Case Upper(dwo.name)
	Case "B_ANNULER"
		
		stmessage.sTitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72 "
		stmessage.berreurg=FALSE
		stmessage.scode="WFRA013"
		stMessage.bouton=YesNo!
		stMessage.icon=Question!

		if f_message(stmessage) = 1 Then Close(Parent)
		
	Case "B_REGLER"
		if This.Describe("b_regler.Enabled") = "0" Then Return 0
		
		If This.AcceptText() = 1 Then iuo_rmfrais.uf_valider()
		
End Choose
end event

event itemchanged;call super::itemchanged;Long llRet

llRet=iuo_rmfrais.uf_zn_mtreg( )

Return llRet
end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rm_frais
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 16:31:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
// 			FPI	 26/12/2011	[PM72_DOMCOM] Sur les dom_com, pas de montant > $$HEX2$$e0002000$$ENDHEX$$50
//*-----------------------------------------------------------------

Long ll_return

Choose Case Upper ( This.GetColumnName () ) 
	Case "MT_REG"
		// Gestion pour l'override
		If This.GetText () = "" Then 
			This.SetItem ( 1, "MT_REG", stNul.dtm )
			This.TriggerEvent ("ItemChanged" )
			ll_return = 3
			ibErreur = FALSE
		Else
			ibErreur = TRUE
		End If
		isErrCol		= Upper ( This.GetColumnName () )

End Choose 

If	ibErreur Then

	stMessage.sTitre		= "R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72 "
	stMessage.Icon			= Information!
	stMessage.bouton=OK!

	stMessage.bErreurG	= FALSE
	
	Choose Case isErrCol

	Case "MT_REG"
		Choose Case This.iiErreur
		Case 1
			stMessage.sVar[1] =  "montant du r$$HEX1$$e800$$ENDHEX$$glement"			
			stMessage.sCode	= "GENE001"

		Case 2
			stMessage.sVar[1] = "montant du r$$HEX1$$e800$$ENDHEX$$glement"
			stMessage.sCode	= "GENE002"

		Case 3
			This.Uf_Reinitialiser ()
			Return 1
		Case 4
			stMessage.bErreurG= False
			stMessage.sCode	= "WFRA006"
			
		Case 5 // [PM72_DOMCOM] 
			stMessage.bErreurG= False
			stMessage.sCode	= "WFRA009"
			
		End choose
	End choose
End if

If ibErreur Then
	F_Message ( stMessage )

	ll_return = This.Uf_Reinitialiser ()
	Return ( ll_return )
End If

Return AncestorReturnValue
end event

event constructor;call super::constructor;ibMenuActif=FALSE
end event

