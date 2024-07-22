HA$PBExportHeader$w_trt_choix_rdv.srw
$PBExportComments$[FNAC_PROD_ECH_TECH]
forward
global type w_trt_choix_rdv from window
end type
type st_msg_t from statictext within w_trt_choix_rdv
end type
type st_msg from statictext within w_trt_choix_rdv
end type
type dw_rdvchoisi from datawindow within w_trt_choix_rdv
end type
type dw_choixrdv from datawindow within w_trt_choix_rdv
end type
type cb_annuler from commandbutton within w_trt_choix_rdv
end type
type cb_ok from commandbutton within w_trt_choix_rdv
end type
end forward

global type w_trt_choix_rdv from window
integer width = 1902
integer height = 1504
boolean titlebar = true
string title = "Choix de Rendez-Vous"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_valider ( )
event ue_annuler ( )
event ue_postopen ( )
st_msg_t st_msg_t
st_msg st_msg
dw_rdvchoisi dw_rdvchoisi
dw_choixrdv dw_choixrdv
cb_annuler cb_annuler
cb_ok cb_ok
end type
global w_trt_choix_rdv w_trt_choix_rdv

type variables
protected:
u_gs_sp_sinistre_gestion_rdv 	invGestionRDV
n_cst_attrib_rdv					invRDV
end variables

forward prototypes
public subroutine wf_addrdv (long arow)
public subroutine wf_suprdv (long arow)
public function integer wf_errormsg (integer aerrcode)
end prototypes

event ue_valider();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::ue_valider
//* Auteur			: PHG
//* Date				: 24/10/2008 10:28:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [FNAC_PROD_ECH_TECH] Validation des RDV
//*
//* Arguments		: (none)
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string sListRDVFormate
string sData
integer iRet

// 1/ Validation des RDV
invRDV.uf_razrdv()
sData = dw_rdvchoisi.object.datawindow.Data
iRet = invGestionRDV.uf_Valider(dw_rdvchoisi.object.datawindow.Data, invRDV)

// 2/ Gestion des Erreurs retourn$$HEX1$$e900$$ENDHEX$$e par l'objet.
if iRet < 0 Then
	wf_errormsg(iRet)
	invRDV.uf_razrdv()
	invRDV.uf_ajoutrdv('[ANNULER]')
	return
End If

Close(This)

end event

event ue_annuler();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::ue_annuler
//* Auteur			: PHG
//* Date				: 24/10/2008 11:10:58
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

Close(This)


end event

event ue_postopen();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::ue_postopen
//* Auteur			: PHG
//* Date				: 29/10/2008 16:13:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Action a faire apr$$HEX1$$e800$$ENDHEX$$s ouverture fenetre
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
// Gestion customisation graphique ( doit se faire en post Open sinon Bug Pb de rafraichissement sur
// desactivation du control_menu )

// gestion Bouton Annuler et Ok
if Not invrdv.bannulerautorise Then
	// Bouton Ok centr$$HEX1$$e900$$ENDHEX$$
	cb_ok.SetRedraw(FALSE)
	cb_ok.x = this.Width/2 - cb_ok.Width/2
	
	// Bouton Annuler & control menu desactiv$$HEX1$$e900$$ENDHEX$$
	cb_annuler.visible = FALSE
	This.controlmenu = FALSE
	cb_ok.SetRedraw(TRUE)
End If

// Gestion Message
if len(invRdv.smsg)>0 then
	st_msg.text = invRdv.sMsg
Else
	st_msg.text = "Aucune Informations."
End If




end event

public subroutine wf_addrdv (long arow);//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::wf_addrdv
//* Auteur			: PHG
//* Date				: 24/10/2008 11:50:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Insertion d'une nouveau RDV
//*
//* Arguments		: value long arow	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long lRow

lRow = dw_rdvchoisi.InsertRow(0)
if lRow >0 then
	dw_rdvchoisi.object.date_rdv[lRow]	= dw_choixrdv.object.date_rdv[arow]
	dw_rdvchoisi.object.heure_deb[lRow]	= dw_choixrdv.object.heure_deb[arow]
	dw_rdvchoisi.object.heure_fin[lRow]	= dw_choixrdv.object.heure_fin[arow]
End If

end subroutine

public subroutine wf_suprdv (long arow);//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::wf_suprdv
//* Auteur			: PHG
//* Date				: 24/10/2008 11:55:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression d'un RDV dans la liste.
//*
//* Arguments		: value New Functio	 */
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string	sFind
long 		lRow

sFind = 	"DATE_RDV = date('"+string(dw_choixrdv.object.date_rdv[arow], "dd/mm/yyyy")+"') and " + &
			"HEURE_DEB = time('"+string(dw_choixrdv.object.heure_deb[arow], "hh:mm:ss")+"') and " + &
			"HEURE_FIN = time('"+string(dw_choixrdv.object.heure_fin[arow], "hh:mm:ss")+"')"

lRow = dw_rdvchoisi.Find(sFind, 1, dw_rdvchoisi.RowCount()+1 )
if lRow > 0 then
	dw_rdvchoisi.RowsDiscard(lRow, lRow, Primary!)
End If

end subroutine

public function integer wf_errormsg (integer aerrcode);//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::wf_errormsg
//* Auteur			: PHG
//* Date				: 28/10/2008 14:05:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value integer aerrcode	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string sDateErreur

stMessage.sTitre  	= "Prise de Rendez-Vous"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
Choose Case aErrCode
	Case invGestionRDV.k_import_err+9 TO invGestionRDV.k_import_err
		stMessage.Icon			= StopSign!
		stMessage.sCode	= "GENE013"
		stMessage.sVar[1] = "Erreur Interne. Prise de Rendev-vous impossible. Contacter le 2110."
		
	Case invGestionRDV.k_nb_rdv_non_atteint
		stMessage.sCode	= "COMD488"
		stMessage.sVar[1] = string(invRDV.iNbreRdvADemander)
		
	Case invGestionRDV.k_nb_rdvjour_depasse
		stMessage.sCode	= "COMD501"
		stMessage.sVar[1] = string(invRDV.iRdvAutoriseMemeJournee )
		sDateErreur = invRDV.uf_GetRdv()
		if pos(sDateErreur,invGestionRDV.K_ERREUR)>0 then
			sDateErreur = left(sDateErreur, 10)
		Else
			sDateErreur = "Date non d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$e"
		End If
		stMessage.sVar[2] = sDateErreur
End choose
F_Message ( stMessage )

return 1



end function

on w_trt_choix_rdv.create
this.st_msg_t=create st_msg_t
this.st_msg=create st_msg
this.dw_rdvchoisi=create dw_rdvchoisi
this.dw_choixrdv=create dw_choixrdv
this.cb_annuler=create cb_annuler
this.cb_ok=create cb_ok
this.Control[]={this.st_msg_t,&
this.st_msg,&
this.dw_rdvchoisi,&
this.dw_choixrdv,&
this.cb_annuler,&
this.cb_ok}
end on

on w_trt_choix_rdv.destroy
destroy(this.st_msg_t)
destroy(this.st_msg)
destroy(this.dw_rdvchoisi)
destroy(this.dw_choixrdv)
destroy(this.cb_annuler)
destroy(this.cb_ok)
end on

event open;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::open
//* Auteur			: PHG
//* Date				: 24/10/2008 11:37:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fenetre - Instanciation
//*					  des objets d'instances
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
datastore lds
string	sBuildList

// Verification de l'argument pass$$HEX1$$e900$$ENDHEX$$
if isvalid(message.powerobjectparm) then
	if lower(message.powerobjectparm.ClassName())<>"n_cst_attrib_rdv" then Close(This)
Else
	Close(This)
End If

// Arg Ok, on continue
invrdv = message.PowerObjectparm

This.setRedraw(FALSE)

invgestionrdv = create u_gs_sp_sinistre_gestion_rdv
// On construit la dw
sBuildList = invGestionRDV.uf_buildlistrdv( invRDV )
if sBuildList <> invGestionRDV.K_ERREUR Then
	if dw_choixrdv.ImportString(sBuildList,1,0,1,3,2 ) < 0 then
		Close(This)
	End If
Else
	Close(This)
End If

// On initialise $$HEX2$$e0002000$$ENDHEX$$[annuler] le retour.
invRDV.uf_ajoutrdv("[ANNULER]")
This.Post Event ue_postopen()
This.Post Function setRedraw(TRUE)


end event

event close;CloseWithReturn(This, invRDV)
end event

type st_msg_t from statictext within w_trt_choix_rdv
integer x = 9
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Informations :"
boolean focusrectangle = false
end type

type st_msg from statictext within w_trt_choix_rdv
integer x = 5
integer y = 64
integer width = 1874
integer height = 224
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_rdvchoisi from datawindow within w_trt_choix_rdv
integer x = 1184
integer y = 304
integer width = 695
integer height = 964
integer taborder = 30
string title = "none"
string dataobject = "d_lst_rdv_choisi"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_choixrdv from datawindow within w_trt_choix_rdv
integer x = 5
integer y = 304
integer width = 1166
integer height = 964
integer taborder = 10
string title = "none"
string dataobject = "d_lst_rdv"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::itemchanged
//* Auteur			: PHG
//* Date				: 24/10/2008 11:15:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion de la selection des RDV
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
long lRow
string sFind
choose case lower(dwo.name) 
	case 'alt_select'
		dw_rdvchoisi.SetRedraw(FALSE)
		if data = 'O' Then wf_addrdv(row) // On ajoute un RDV
		If data = 'N' Then wf_suprdv(row) // On retire un RDV
		dw_rdvchoisi.sort()
		dw_rdvchoisi.SetRedraw(TRUE)
End choose
end event

event buttonclicked;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_choix_rdv::buttonclicked
//* Auteur			: PHG
//* Date				: 24/10/2008 11:44:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: gestion de selectionner/deselectionner tout
//*
//* Arguments		: value long row	 */
/* 	value long actionreturncode	 */
/* 	value dwobject dwo	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long lNbSelect, lCpt
string sDescRet, sDescString, sAltSelectToCheck, sAction

Choose case lower(dwo.name)
	case 'b_selectall'
		// On regarde si on a d$$HEX1$$e900$$ENDHEX$$ja tout selectionn$$HEX1$$e900$$ENDHEX$$.
		sDescString = "Evaluate('sum(if(alt_select=~~'O~~', 1,0))', 0)"
		sDescRet = this.Describe(sDescString)
		if IsNumber(sDescRet) then
			lNbSelect = long(sDescRet)
// LE 27/10/2008, DEsactivation du choix Add/supp, gard$$HEX2$$e9002000$$ENDHEX$$pour m$$HEX1$$e900$$ENDHEX$$moire.
//
//			Choose case lNbSelect
//				Case RowCount() // Tout est d$$HEX1$$e900$$ENDHEX$$ja s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$: On deselectionne tout
//					sAction = 'SUP'
//				Case IS < RowCount() // Partiellement selectionne, ou pas s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$:
//													 // On selectione tout, sauf ceux deja selectionn$$HEX1$$e900$$ENDHEX$$.
//					sAction = 'ADD'
//			End Choose 
			if lNbSelect > 0 Then
				sAction = "SUP"
			End If
//
			if sAction <> "" Then
				// On effectue l'action d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$e ( selection globale / deselection globale )
				SetPointer(HourGlass!) // Op$$HEX1$$e900$$ENDHEX$$ration cosm$$HEX1$$e900$$ENDHEX$$tique ( dessin de dw "propre" )
				This.SetRedraw(FALSE)  // avec gestion du pointeur de souris.
				dw_rdvchoisi.SetRedraw(FALSE)
				
				For lCpt = 1 to RowCount() // Action proprement dite
					Choose case sAction
						case 'ADD'
							if object.alt_select[lCpt] = 'N' then 
								this.object.alt_select[lCpt] = 'O'
								wf_addrdv(lCpt)
							End If
								
						case 'SUP'
							if object.alt_select[lCpt] = 'O' then 
								this.object.alt_select[lCpt] = 'N'
								wf_suprdv(lCpt)
							End If
					End Choose
				Next
				dw_rdvchoisi.Sort() // Apr$$HEX1$$e800$$ENDHEX$$s op$$HEX1$$e900$$ENDHEX$$ration, on retrie, fin d'assurer la coh$$HEX1$$e900$$ENDHEX$$rence de l'affichage.
				This.SetRedraw(TRUE)
				dw_rdvchoisi.SetRedraw(TRUE)
				SetPointer(Arrow!)
			End If
		End If
End choose

end event

type cb_annuler from commandbutton within w_trt_choix_rdv
integer x = 1024
integer y = 1292
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annuler"
boolean cancel = true
end type

event clicked;PArent.event ue_annuler( )
end event

type cb_ok from commandbutton within w_trt_choix_rdv
integer x = 480
integer y = 1292
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean default = true
end type

event clicked;PArent.event ue_valider( )
end event

