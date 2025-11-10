$PBExportHeader$w_trt_sp_wkfs_w_queue.srw
forward
global type w_trt_sp_wkfs_w_queue from w_8_traitement_master
end type
type st_message from statictext within w_trt_sp_wkfs_w_queue
end type
type dw_plj from u_datawindow within w_trt_sp_wkfs_w_queue
end type
type dw_trt_boitearchive from u_datawindow within w_trt_sp_wkfs_w_queue
end type
type cb_noboite from commandbutton within w_trt_sp_wkfs_w_queue
end type
end forward

global type w_trt_sp_wkfs_w_queue from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3589
integer height = 2120
st_message st_message
dw_plj dw_plj
dw_trt_boitearchive dw_trt_boitearchive
cb_noboite cb_noboite
end type
global w_trt_sp_wkfs_w_queue w_trt_sp_wkfs_w_queue

type variables
Private:

n_cst_sp_wkfs_w_queue	invQueue
end variables

forward prototypes
public function boolean wf_preparermodifier ()
public function boolean wf_preparervalider ()
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_tm_sp_wkfs_w_Queue::wf_PreparerModifier
//* Auteur			:	PLJ
//* Date				:	08/09/2003
//* Libellé			:	Opération avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Booléen 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


Return invQueue.uf_Preparer ( istPass )


end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Wkfs_Profil::Wf_PreparerValider
//* Auteur			: PLJ
//* Date				: 09/11/2003
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------



Return invQueue.uf_Valider()
end function

on ue_valider;//*-----------------------------------------------------------------
//
//* Objet 		   : W_Tm_Sp_Wkfs_Profil::ue_Valider ( OverRide )
//* Auteur			: PLJ
//* Date				: 09/11/2003
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Boolean bOk

s_Pass	stPass

SetPointer( HourGlass! )

dw_Trt_BoiteArchive.AcceptText ()

bOk = invQueue.uf_Valider  ()

If bOk Then 

	If ( ibMajAccueil ) Then
		If istPass.bInsert Then
			stPass.sTab[1] = "CRE"
		Else
			stPass.sTab[1] = "MOD"
		End If

		isMajAccueil 		= ""	
		This.TriggerEvent ( "ue_MajAccueil" )
		stPass.sTab[2]	= isMajAccueil

		Message.PowerObjectParm = stPass

		If ( IsValid( dw_1.iuDwdetailSource ) ) Then
			If ( Not ibModeDetail ) Then
				dw_1.iudwdetailsource.TriggerEvent ( "ue_MajAccueil" )
			End If
		Else
			iwParent.TriggerEvent ( "ue_MajAccueil" )
		End If

	End If
	
	
	This.PostEvent( "ue_retour" )
	
End If

end on

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_profil
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


invQueue = create n_cst_sp_wkfs_w_queue

invQueue.Uf_Initialiser ( dw_1, dw_Trt_BoiteArchive )
end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_Tm_sp_wkfs_profil
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libellé			: Fermeture de la fenêtre
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*--------------------------------------------*/
/* Destruction du NVUO de Gestion             */
/*--------------------------------------------*/
Destroy	invQueue 
end on

on w_trt_sp_wkfs_w_queue.create
int iCurrent
call super::create
this.st_message=create st_message
this.dw_plj=create dw_plj
this.dw_trt_boitearchive=create dw_trt_boitearchive
this.cb_noboite=create cb_noboite
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
this.Control[iCurrent+2]=this.dw_plj
this.Control[iCurrent+3]=this.dw_trt_boitearchive
this.Control[iCurrent+4]=this.cb_noboite
end on

on w_trt_sp_wkfs_w_queue.destroy
call super::destroy
destroy(this.st_message)
destroy(this.dw_plj)
destroy(this.dw_trt_boitearchive)
destroy(this.cb_noboite)
end on

type cb_debug from w_8_traitement_master`cb_debug within w_trt_sp_wkfs_w_queue
end type

type dw_1 from w_8_traitement_master`dw_1 within w_trt_sp_wkfs_w_queue
integer x = 41
integer y = 240
integer width = 3314
integer height = 1164
integer taborder = 40
string dataobject = "dw_trt_sp_wkfs_w_queue"
boolean border = false
end type

type st_titre from w_8_traitement_master`st_titre within w_trt_sp_wkfs_w_queue
boolean visible = false
integer x = 2053
integer y = 40
integer width = 370
end type

type pb_retour from w_8_traitement_master`pb_retour within w_trt_sp_wkfs_w_queue
integer y = 24
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_valider from w_8_traitement_master`pb_valider within w_trt_sp_wkfs_w_queue
integer x = 283
integer y = 24
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_trt_sp_wkfs_w_queue
boolean visible = false
integer y = 24
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_controler from w_8_traitement_master`pb_controler within w_trt_sp_wkfs_w_queue
boolean visible = false
integer y = 24
integer width = 242
integer height = 144
integer taborder = 60
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_trt_sp_wkfs_w_queue
boolean visible = false
integer y = 24
integer width = 242
integer height = 144
integer taborder = 80
end type

type st_message from statictext within w_trt_sp_wkfs_w_queue
boolean visible = false
integer x = 55
integer y = 748
integer width = 2048
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 14267805
boolean enabled = false
string text = "Un regroupement possède ce profil"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_plj from u_datawindow within w_trt_sp_wkfs_w_queue
boolean visible = false
integer x = 1106
integer y = 972
integer taborder = 30
string dataobject = "d_sp_sin_boite_archive"
end type

type dw_trt_boitearchive from u_datawindow within w_trt_sp_wkfs_w_queue
integer x = 2405
integer y = 72
integer width = 786
integer height = 84
integer taborder = 10
string dataobject = "d_sp_arc_boite_archive"
boolean border = false
end type

type cb_noboite from commandbutton within w_trt_sp_wkfs_w_queue
integer x = 3209
integer y = 76
integer width = 82
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Wkfs_w_queue::cb_noboite
//* Evenement     : clicked
//* Auteur        : PLJ
//* Date          : 05/09/2003 09:46:33
//* Libellé       : 
//* Commentaires  : Ouvre la fenêtre de gestion des numéros de boîte
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------
String	sNoBoite, sNoBoiteOrigine
s_Pass	stPass	

/*------------------------------------------------------------------*/
/* Pour la méthode centralisé, le code_oper ne correspond pas aux   */
/* iniatiales de l'opérateur connecté (stglb.sCodOper), mais au     */
/* pseudo opérateur centre d'archivage ( #XXX ) code_car '-OA'      */
/* Nous devons donc passer le code opérateur à la fenêtre de gestion*/
/* des boîtes.                                                      */
/*------------------------------------------------------------------*/
stPass.udwTab[1] = dw_trt_boitearchive
stPass.sTab[2]   = invQueue.isIdOper
dw_trt_boitearchive.SaveAs ( "C:\AAA\ARCH.xls", Excel8!, True ) // [MIG_PB2022] 

stPass.sTab[1]   = 'VAL'
OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )


/*------------------------------------------------------------------*/
/* On récupère le nouveau numéro de boite                           */
/*------------------------------------------------------------------*/
sNoBoite = Message.StringParm
sNoBoiteOrigine = dw_trt_boitearchive.GetItemString ( 1, "NO_BOITE" )

If sNoBoite <> "RETOUR" Then
	If sNoBoite <> sNoBoiteOrigine Or isNull ( sNoBoiteOrigine ) Then
		dw_trt_boitearchive.SetItem ( 1, "NO_BOITE", sNoBoite )
	End If
End If


end event

