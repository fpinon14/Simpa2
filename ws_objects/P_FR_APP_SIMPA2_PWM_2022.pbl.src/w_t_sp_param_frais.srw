HA$PBExportHeader$w_t_sp_param_frais.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des frais.
forward
global type w_t_sp_param_frais from w_traitement
end type
type cb_histo from commandbutton within w_t_sp_param_frais
end type
type st_creation from statictext within w_t_sp_param_frais
end type
type cb_dup from commandbutton within w_t_sp_param_frais
end type
end forward

global type w_t_sp_param_frais from w_traitement
integer height = 1676
string title = "Param$$HEX1$$e900$$ENDHEX$$trage des frais"
cb_histo cb_histo
st_creation st_creation
cb_dup cb_dup
end type
global w_t_sp_param_frais w_t_sp_param_frais

type variables
u_sp_gs_param_frais iUoSpGsParamFrais
end variables

forward prototypes
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
public function boolean wf_valider ()
public function boolean wf_preparervalider ()
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_preparermodifier
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 17:25:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sIdSeq, sIdFour
DatawindowChild dwChild
Long lIdProd, lIdGti

sIdSeq = istPass.sTab[1]

pb_supprimer.Visible=TRUE
cb_histo.Visible = TRUE
pb_valider.Text="&Valider"
st_creation.Visible=FALSE

dw_1.Retrieve(long(sIdSeq))

dw_1.uf_initialisercouleur(  {"ID_PROD"})
dw_1.uf_proteger ( {"ID_PROD"}, "1")  

lIdProd = dw_1.getItemNumber(1,"ID_PROD")

dw_1.getchild( "ID_FOUR", dwChild)
dwChild.Retrieve(lIdProd)

// Filtre pour n'avoir qu'O2M
dwChild.SetFilter("ID_CODE_FRN='O2M'")
dwChild.Filter()
		
		
sIdFour = dw_1.getItemstring( 1, "ID_FOUR")
dw_1.getchild( "ID_GTI", dwChild)
dwChild.Retrieve(lIdProd,sIdFour)

lIdGti= dw_1.getItemNumber(1,"ID_GTI")
dw_1.getchild( "ID_PROCESS", dwChild)
dwChild.Retrieve(lIdProd,sIdFour,lIdGti)

pb_controler.Enabled=TRUE

Return TRUE
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_preparerinserer
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 17:37:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

dw_1.uf_initialisercouleur(  {"ID_PROD"})
dw_1.uf_proteger ( {"ID_PROD"}, "0")

pb_supprimer.Visible=FALSE
cb_histo.Visible = FALSE

pb_Valider.Text="Cr$$HEX2$$e900e900$$ENDHEX$$r"
st_creation.Visible=FALSE

iuospgsparamfrais.uf_reinitialiser( )

dw_1.setcolumn( "ID_PROD")
Return TRUE
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_controlersaisie
//* Auteur			: F. Pinon
//* Date				: 23/10/2009 08:59:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Return iuospgsparamfrais.uf_controler_oblig( )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_controlergestion
//* Auteur			: F. Pinon
//* Date				: 23/10/2009 09:00:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Return iuospgsparamfrais.uf_controler( )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_preparersupprimer
//* Auteur			: F. Pinon
//* Date				: 23/10/2009 11:38:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean		bRet 			// Variable de retour de la fonction.
Integer		iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur

bRet 		= True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un param$$HEX1$$e900$$ENDHEX$$trage de frais"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Question!
stMessage.sCode		= "PAFR005"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else
	dw_1.DeleteRow ( 0 )		
End If

Return ( bRet )
end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_valider
//* Auteur			: F. Pinon
//* Date				: 03/11/2009 15:36:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	06/07/2011	[PM72.Correction] D$$HEX1$$e900$$ENDHEX$$sactivation du valider pendant l'enregistrement
//*-----------------------------------------------------------------

Boolean bRet

pb_valider.Enabled=FALSE // 	[PM72.Correction] 

bRet=super::wf_valider()

If istpass.binsert Then
	If bRet Then
		st_creation.Text="Cr$$HEX1$$e900$$ENDHEX$$ation du param$$HEX1$$e900$$ENDHEX$$trage r$$HEX1$$e900$$ENDHEX$$ussie"
		st_creation.Textcolor = 32768
	Else
		st_creation.Text="Echec de cr$$HEX1$$e900$$ENDHEX$$ation du param$$HEX1$$e900$$ENDHEX$$trage"
		st_creation.Textcolor = 255
	End if
	st_creation.Visible=TRUE

End if

wf_pb_ctl_vld(0) // 	[PM72.Correction] 

Return bRet
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_frais::wf_preparervalider
//* Auteur			: F. Pinon
//* Date				: 05/01/2010 10:37:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [FRAIS_O2M]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	18/10/2010	[PM72.2] Suppression msg erreur -> dberror
//*-----------------------------------------------------------------
/*
If dw_1.getitemstatus( 1, "MT_RBT", Primary!) <> NotModified! Then
	// Message d'info pour DMDI sur det_pro
	stMessage.berreurg=FALSE
	stMessage.scode="PAFR006"
	stMessage.sTitre="Rappel : faire une DMDI"
	f_message(stMessage)
End if
*/
Return TRUE
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 09:54:38
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

iUoSpGsParamFrais = CREATE u_sp_gs_param_frais

iUoSpGsParamFrais.Uf_Initialisation ( iTrTrans , Dw_1 )
end event

on w_t_sp_param_frais.create
int iCurrent
call super::create
this.cb_histo=create cb_histo
this.st_creation=create st_creation
this.cb_dup=create cb_dup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_histo
this.Control[iCurrent+2]=this.st_creation
this.Control[iCurrent+3]=this.cb_dup
end on

on w_t_sp_param_frais.destroy
call super::destroy
destroy(this.cb_histo)
destroy(this.st_creation)
destroy(this.cb_dup)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 09:55:34
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

Destroy iuospgsparamfrais
end event

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: ue_majaccueil
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 17:05:52
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
//* 		FPI	28/07/2010	[PM72] Ajout de la colonne typ_rbt
//			FPI	07/01/2014	[VDOC16435]
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sMajLe		// Variable tampon pour MAJ_LE.
String sLibProd
DataWindowChild ldwc
Long lLigneProd

sTab				= "~t"
sMajLe			=	String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy" )

// [VDOC16435]
dw_1.GetChild( "ID_PROD", ldwc)
lLigneProd=ldwc.Find( "ID_PROD=" + String(dw_1.GetItemNumber ( 1, "ID_PROD"  )), 1, ldwc.RowCount())
sLibProd=ldwc.GetItemString(lLigneProd,"LIB_LONG")

isMajAccueil 	=	String(dw_1.GetItemNumber ( 1, "ID_SEQ"  )) + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_PROD"  )) + sTab	+ &
						sLibProd + sTab	+ &
						dw_1.GetItemString (1, "ID_FOUR") + sTab	+ &
						dw_1.Describe("Evaluate('LookUpDisplay(id_four) ', 1)") + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_GTI"  )) + sTab	+ &
						dw_1.Describe("Evaluate('LookUpDisplay(id_gti) ', 1)") + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_PROCESS"  )) + sTab	+ &
						+ sTab + sTab	+ + sTab	+ sTab	+ &
						sTab	+ sTab	+ sTab + &
						sMajLe								 		 + sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR"  )
end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 23/10/2009 10:19:13
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

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre.                                                         */
/*------------------------------------------------------------------*/
This.X					=    1
This.Y					=    1
This.Width				= 3617
This.Height				= 2057

end event

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais !! OVERRIDE !!
//* Evenement 		: ue_retour
//* Auteur			: F. Pinon
//* Date				: 03/11/2009 15:22:48
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

Long lNull
Long		lPrepare
Boolean	bOk

SetNull(lNull)


lPrepare = Message.WordParm

If lPrepare = 1 Then
	bOk = Wf_PreparerAbandonner() 
Else
	bOk = True
End If

If ( bOk ) Then

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_EnableFenetre" )
	End If

	If ( ibModeDetail ) Then
		If ( IsValid ( dw_1.iudwDetailSource ) ) Then
			dw_1.iudwDetailSource.SetFocus()
		End If
	End If

	If (Not istPass.binsert) or lPrepare = 1 Then
		If ( istPass.bCloseRetour ) Then
			Close ( This )
		Else
			dw_1.SetRedraw( True )
			This.Hide ()
		End If
	Else
		dw_1.setitem(1,"ID_SEQ",lNull)
		dw_1.SetItemStatus ( 1, 0, Primary!, New! )
		This.bringtotop = TRUE
	End if
End If

Return 0



end event

type cb_debug from w_traitement`cb_debug within w_t_sp_param_frais
end type

type dw_1 from w_traitement`dw_1 within w_t_sp_param_frais
integer x = 256
integer y = 276
integer width = 1815
integer height = 1240
string dataobject = "d_sp_param_frais"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 11:17:49
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

String		sVal			// Valeur du champ saisi.
Integer		iAction		// valeur du SetActionCode.

iAction	= 0
sVal 		= This.GetText ( )

st_creation.Visible=FALSE

iAction = iUoSpGsParamFrais.Uf_ControlerZone ( isNomCol, sVal )

Return iAction 
end event

event dw_1::ue_dropdown;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais !! OVERRIDE !!
//* Evenement 		: ue_dropdown
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 16:59:42
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


end event

event dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: dberror
//* Auteur			: F. Pinon
//* Date				: 18/10/2010 14:20:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM72.2] Les PS de m$$HEX1$$e000$$ENDHEX$$j renvoient une erreur SQL
//*				  
//* Arguments		: value long sqldbcode	 */
/* 	value string sqlerrtext	 */
/* 	value string sqlsyntax	 */
/* 	value dwbuffer buffer	 */
/* 	value long row	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If sqldbcode > 50000 or sqldbcode=18054 Then
	stMessage.berreurg=FALSE
	stMessage.scode="PAFR007"
	stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des frais"
	f_message(stMessage)
End if

Return 1
end event

event dw_1::itemerror;call super::itemerror;//			FPI	07/01/2015	[VDOC16435]

Choose Case Upper ( This.GetColumnName () ) 
	Case "ID_PROD"
		stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des frais"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sVar[1] 	= "Le code produit"
		stMessage.sCode		= "WSIN131"
		F_Message ( stMessage )
		
		this.SetItem(1,"ID_PROD",This.GetItemNumber(1,"ID_PROD"))
End Choose

Return 1
end event

type st_titre from w_traitement`st_titre within w_t_sp_param_frais
boolean visible = false
end type

type pb_retour from w_traitement`pb_retour within w_t_sp_param_frais
integer width = 274
integer height = 160
end type

type pb_valider from w_traitement`pb_valider within w_t_sp_param_frais
integer width = 274
integer height = 160
end type

type pb_imprimer from w_traitement`pb_imprimer within w_t_sp_param_frais
boolean visible = false
integer x = 2245
integer y = 116
integer width = 274
integer height = 160
end type

type pb_controler from w_traitement`pb_controler within w_t_sp_param_frais
integer width = 274
integer height = 160
end type

type pb_supprimer from w_traitement`pb_supprimer within w_t_sp_param_frais
integer width = 274
integer height = 160
end type

type cb_histo from commandbutton within w_t_sp_param_frais
integer x = 1243
integer y = 96
integer width = 343
integer height = 152
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Historique"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_frais
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 16:52:02
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

s_pass		stPass		// structure de passage pour l'appel de W_t_sp_c_trace_param_frais.
Long 			lIdSeq

SetPointer ( HourGlass! )

lIdSeq = dw_1.GetItemnumber( 1,"ID_SEQ")

If isValid ( W_t_sp_c_trace_param_frais )	= False	Then

	stPass.trTrans 		= istPass.trTrans
	stPass.wParent			= Parent.Parentwindow()
	stPass.bEnableParent	= False
	stPass.lTab [ 1 ] = lIdSeq 
	
	OpenWithParm ( W_t_sp_c_trace_param_frais, stPass, stPass.wParent )

Else

	W_t_sp_c_trace_param_frais.ilIdSeq = lIdSeq
	W_t_sp_c_trace_param_frais.ibFromAccueil = FALSE
	W_t_sp_c_trace_param_frais.Show ()

End If



end event

type st_creation from statictext within w_t_sp_param_frais
integer x = 873
integer y = 140
integer width = 1783
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Cr$$HEX1$$e900$$ENDHEX$$ation du param$$HEX1$$e800$$ENDHEX$$tre r$$HEX1$$e900$$ENDHEX$$ussi"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_dup from commandbutton within w_t_sp_param_frais
integer x = 2103
integer y = 312
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Dupliquer"
end type

event clicked;pb_supprimer.Visible=FALSE
cb_histo.Visible = FALSE

pb_Valider.Text="Cr$$HEX2$$e900e900$$ENDHEX$$r"
st_creation.Visible=FALSE

dw_1.uf_proteger ( {"ID_PROD"}, "0") 

dw_1.SetItemstatus( 1, 0, Primary!, NewModified!)
istPass.bInsert=TRUE

end event

