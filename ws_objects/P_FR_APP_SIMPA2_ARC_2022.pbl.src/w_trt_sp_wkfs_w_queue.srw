HA$PBExportHeader$w_trt_sp_wkfs_w_queue.srw
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
int X=1
int Y=1
int Width=3589
int Height=2121
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
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
call w_8_traitement_master::create
this.st_message=create st_message
this.dw_plj=create dw_plj
this.dw_trt_boitearchive=create dw_trt_boitearchive
this.cb_noboite=create cb_noboite
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_message
this.Control[iCurrent+2]=dw_plj
this.Control[iCurrent+3]=dw_trt_boitearchive
this.Control[iCurrent+4]=cb_noboite
end on

on w_trt_sp_wkfs_w_queue.destroy
call w_8_traitement_master::destroy
destroy(this.st_message)
destroy(this.dw_plj)
destroy(this.dw_trt_boitearchive)
destroy(this.cb_noboite)
end on

type dw_1 from w_8_traitement_master`dw_1 within w_trt_sp_wkfs_w_queue
int X=42
int Y=241
int Width=3315
int Height=1165
int TabOrder=40
string DataObject="dw_trt_sp_wkfs_w_queue"
boolean Border=false
end type

type st_titre from w_8_traitement_master`st_titre within w_trt_sp_wkfs_w_queue
int X=2053
int Y=41
int Width=371
boolean Visible=false
end type

type pb_retour from w_8_traitement_master`pb_retour within w_trt_sp_wkfs_w_queue
int Y=25
int TabOrder=50
end type

type pb_valider from w_8_traitement_master`pb_valider within w_trt_sp_wkfs_w_queue
int X=284
int Y=25
int TabOrder=70
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_trt_sp_wkfs_w_queue
int Y=25
int TabOrder=90
boolean Visible=false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_trt_sp_wkfs_w_queue
int Y=25
int TabOrder=60
boolean Visible=false
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_trt_sp_wkfs_w_queue
int Y=25
int TabOrder=80
boolean Visible=false
end type

type st_message from statictext within w_trt_sp_wkfs_w_queue
int X=55
int Y=749
int Width=2049
int Height=81
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Un regroupement poss$$HEX1$$e800$$ENDHEX$$de ce profil"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=14267805
long BorderColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_plj from u_datawindow within w_trt_sp_wkfs_w_queue
int X=1107
int Y=973
int TabOrder=30
boolean Visible=false
string DataObject="d_sp_sin_boite_archive"
end type

type dw_trt_boitearchive from u_datawindow within w_trt_sp_wkfs_w_queue
int X=2405
int Y=73
int Width=787
int Height=85
int TabOrder=10
string DataObject="d_sp_arc_boite_archive"
boolean Border=false
end type

type cb_noboite from commandbutton within w_trt_sp_wkfs_w_queue
int X=3210
int Y=77
int Width=83
int Height=69
int TabOrder=20
boolean BringToTop=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Wkfs_w_queue::cb_noboite
//* Evenement     : clicked
//* Auteur        : PLJ
//* Date          : 05/09/2003 09:46:33
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Ouvre la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion des num$$HEX1$$e900$$ENDHEX$$ros de bo$$HEX1$$ee00$$ENDHEX$$te
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
String	sNoBoite, sNoBoiteOrigine
s_Pass	stPass	

/*------------------------------------------------------------------*/
/* Pour la m$$HEX1$$e900$$ENDHEX$$thode centralis$$HEX1$$e900$$ENDHEX$$, le code_oper ne correspond pas aux   */
/* iniatiales de l'op$$HEX1$$e900$$ENDHEX$$rateur connect$$HEX2$$e9002000$$ENDHEX$$(stglb.sCodOper), mais au     */
/* pseudo op$$HEX1$$e900$$ENDHEX$$rateur centre d'archivage ( #XXX ) code_car '-OA'      */
/* Nous devons donc passer le code op$$HEX1$$e900$$ENDHEX$$rateur $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion*/
/* des bo$$HEX1$$ee00$$ENDHEX$$tes.                                                      */
/*------------------------------------------------------------------*/
stPass.udwTab[1] = dw_trt_boitearchive
stPass.sTab[2]   = invQueue.isIdOper
dw_trt_boitearchive.SaveAs ( "C:\AAA\ARCH.xls", Excel!, True )

stPass.sTab[1]   = 'VAL'
OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nouveau num$$HEX1$$e900$$ENDHEX$$ro de boite                           */
/*------------------------------------------------------------------*/
sNoBoite = Message.StringParm
sNoBoiteOrigine = dw_trt_boitearchive.GetItemString ( 1, "NO_BOITE" )

If sNoBoite <> "RETOUR" Then
	If sNoBoite <> sNoBoiteOrigine Or isNull ( sNoBoiteOrigine ) Then
		dw_trt_boitearchive.SetItem ( 1, "NO_BOITE", sNoBoite )
	End If
End If


end on

