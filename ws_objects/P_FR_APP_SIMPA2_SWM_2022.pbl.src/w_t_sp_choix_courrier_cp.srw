HA$PBExportHeader$w_t_sp_choix_courrier_cp.srw
$PBExportComments$permet de choisir son mod$$HEX1$$e800$$ENDHEX$$le de courrier particulier
forward
global type w_t_sp_choix_courrier_cp from window
end type
type st_1 from statictext within w_t_sp_choix_courrier_cp
end type
type dw_choix_type_courrier from datawindow within w_t_sp_choix_courrier_cp
end type
type st_patienter from statictext within w_t_sp_choix_courrier_cp
end type
type dw_modele_courrier from datawindow within w_t_sp_choix_courrier_cp
end type
type cb_creer from commandbutton within w_t_sp_choix_courrier_cp
end type
type cb_retour from commandbutton within w_t_sp_choix_courrier_cp
end type
end forward

global type w_t_sp_choix_courrier_cp from window
integer width = 1742
integer height = 524
boolean titlebar = true
string title = "Untitled"
windowtype windowtype = response!
long backcolor = 12632256
event ue_charger pbm_custom01
st_1 st_1
dw_choix_type_courrier dw_choix_type_courrier
st_patienter st_patienter
dw_modele_courrier dw_modele_courrier
cb_creer cb_creer
cb_retour cb_retour
end type
global w_t_sp_choix_courrier_cp w_t_sp_choix_courrier_cp

type variables
Private :

s_Choix_Modele_Cp istModCour

String	isFiltreOrigine
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
private subroutine wf_creer ()
end prototypes

on ue_charger;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_Choix_Courrier_CP
//* Evenement     : Close
//* Auteur        : Fabry JF
//* Date          : 08/01/2003 17:14:47
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

DatawindowChild	dwChild

dw_Modele_Courrier.GetChild ( "ID_COUR", dwChild )
istModCour.dwNatCour.ShareData ( dwChild )

isFiltreOrigine = istModCour.dwNatCour.Describe ("datawindow.table.filter" )
If isFiltreOrigine = "?" Then isFiltreOrigine = ""

istModCour.dwNatCour.SetFilter ( "ID_NAT_COUR <> 'APART1'" )
istModCour.dwNatCour.Filter ()
istModCour.dwNatCour.Sort ( )


end on

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction      : wf_PositionnerObjets (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 14:49:51
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

Return 

This.x = 1189
This.y = 553
This.width = 2204
This.Height = 1165

cb_creer.x = 311
cb_creer.y = 25
cb_creer.width = 270
cb_creer.Height = 93

dw_modele_courrier.x = 33
dw_modele_courrier.y = 137
dw_modele_courrier.width = 2100
dw_modele_courrier.Height = 645



end subroutine

private subroutine wf_creer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_choix_courrier_cp::wf_creer (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 08/01/2004 16:26:44
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

String sIdCour

dw_Modele_Courrier.AcceptText ()
cb_Creer.Enabled = FALSE

Choose Case dw_choix_type_courrier.GetItemString ( 1, "CHOIX_TYPE" )

	// Courrier Standard SPB
	Case "CSPB"
		istModCour.sIdCour = ""

	// Autre Modele
	Case "AMOD"

		sIdCour = dw_modele_courrier.GetItemString ( 1, "ID_COUR" )

		If IsNull ( sIdCour ) Then sIdCour = ""
		If sIdCour = "" Then

			stMessage.sTitre		= "Recherche des communes"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "CACO003"
			F_Message ( stMessage )

			cb_Creer.Enabled = True
			Return
		End If

		istModCour.sIdCour = sIdCour

End Choose

Close ( This )
end subroutine

on close;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_Choix_Courrier_CP
//* Evenement     : Close
//* Auteur        : Fabry JF
//* Date          : 08/01/2003 17:14:47
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

istModCour.dwNatCour.SetFilter ( isFiltreOrigine  )
istModCour.dwNatCour.Filter ()
istModCour.dwNatCour.Sort ( )

CloseWithReturn ( This, istModCour )


end on

on open;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_Choix_Courrier_CP
//* Evenement     : Close
//* Auteur        : Fabry JF
//* Date          : 08/01/2003 17:14:47
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

istModCour = Message.PowerObjectParm

This.X = w_mdi_sp.X + 2000
This.Y = w_mdi_sp.Y + 1000

istModCour.sIdCour = ""
dw_Modele_Courrier.Hide ()

dw_choix_type_courrier.InsertRow ( 0 )
dw_modele_courrier.InsertRow ( 0 )

This.wf_PositionnerObjets ()

This.Title = "Choix du mod$$HEX1$$e800$$ENDHEX$$le de Courrier Particulier"

PostEvent ("UE_CHARGER") 



end on

on w_t_sp_choix_courrier_cp.create
this.st_1=create st_1
this.dw_choix_type_courrier=create dw_choix_type_courrier
this.st_patienter=create st_patienter
this.dw_modele_courrier=create dw_modele_courrier
this.cb_creer=create cb_creer
this.cb_retour=create cb_retour
this.Control[]={this.st_1,&
this.dw_choix_type_courrier,&
this.st_patienter,&
this.dw_modele_courrier,&
this.cb_creer,&
this.cb_retour}
end on

on w_t_sp_choix_courrier_cp.destroy
destroy(this.st_1)
destroy(this.dw_choix_type_courrier)
destroy(this.st_patienter)
destroy(this.dw_modele_courrier)
destroy(this.cb_creer)
destroy(this.cb_retour)
end on

type st_1 from statictext within w_t_sp_choix_courrier_cp
integer x = 41
integer y = 124
integer width = 1655
integer height = 288
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Cette fonction vous ouvre un courrier particulier vide, standard (Continuer). Si vous souhaitez un mod$$HEX1$$e800$$ENDHEX$$le, passez par un COURRIER GESTIONNAIRE dans ce cas (Retour)."
boolean focusrectangle = false
end type

type dw_choix_type_courrier from datawindow within w_t_sp_choix_courrier_cp
integer x = 27
integer y = 124
integer width = 1198
integer height = 152
integer taborder = 30
string dataobject = "d_sp_int_choix_type_cp"
boolean border = false
boolean livescroll = true
end type

on itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Choix_Type_Courrier
//* Evenement     : ItemChanged
//* Auteur        : Fabry JF
//* Date          : 09/01/2004 14:31:23
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


dw_modele_courrier.Visible = Upper ( GetText () ) = "AMOD"





end on

type st_patienter from statictext within w_t_sp_choix_courrier_cp
boolean visible = false
integer x = 366
integer y = 432
integer width = 1362
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Veuillez Patientez pendant le chargement...."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_modele_courrier from datawindow within w_t_sp_choix_courrier_cp
event we_touche pbm_dwnkey
boolean visible = false
integer x = 27
integer y = 288
integer width = 1541
integer height = 120
integer taborder = 40
string dataobject = "d_sp_int_choix_modele_cp"
boolean border = false
boolean livescroll = true
end type

type cb_creer from commandbutton within w_t_sp_choix_courrier_cp
integer x = 302
integer y = 16
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuer"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Creer
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 09:33:09
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

Parent.wf_creer ()


end on

type cb_retour from commandbutton within w_t_sp_choix_courrier_cp
integer x = 41
integer y = 16
integer width = 247
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retour"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Retour
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 09:33:09
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

istModCour.sIdCour = "RETOUR"

Close ( Parent )


end on

