HA$PBExportHeader$w_t_sp_popup_pol_ass.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple pour afficher police / assurance des gtis (DCMP 030381)
forward
global type w_t_sp_popup_pol_ass from window
end type
type dw_1 from datawindow within w_t_sp_popup_pol_ass
end type
type cb_1 from commandbutton within w_t_sp_popup_pol_ass
end type
end forward

global type w_t_sp_popup_pol_ass from window
integer x = 1344
integer y = 688
integer width = 3639
integer height = 656
boolean titlebar = true
string title = "Liste des polices et assurances par garantie"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
end type
global w_t_sp_popup_pol_ass w_t_sp_popup_pol_ass

type variables
Private :

	s_Pass	istPass
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Popup_Pol_Ass::Wf_PositionnerObjet		(PRIVATE)
//* Auteur			: Catherine ABDMEZIEM
//* Date				: 08/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement dynamique des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long	lX, lY

/*------------------------------------------------------------------*/
/* Position de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                          */
/*------------------------------------------------------------------*/
lX = gwmdi.x
lY = gwmdi.y

This.X		=	lX + 55
This.Y		=	lY + 9

end subroutine

event open;//*-----------------------------------------------------------------
//*
//* Fonction      : W_T_Sp_Popup_Pol_Ass::open
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 07/07/2004 09:18:58
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Chargement de la dw contenant les polices et
//*						assurances pour chaque gti du produit du dr DCMP 030381
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	 FPI	 26/10/2009	[EXPANSION5.LIB_POLICE] Ajout du param id_boutique_adh
//*		SBA 	21/07/2010	[PC202] Correction lib_police lors d'une gestion particuli$$HEX1$$e800$$ENDHEX$$re
//*-----------------------------------------------------------------

Long			lNb, lCpt, lFind
Long			lIdProd, lIdRev, lIdGti, lIdPolice, lIdCie
String		sLibCie, sLibPolice, sLibGti
String 		sIdBoutique			// #1 - [EXPANSION5.LIB_POLICE]
Datastore 	dsLibPolice			// #1 - [EXPANSION5.LIB_POLICE]
Long			lIdSin				// #1 - [EXPANSION5.LIB_POLICE]

DataWindow			dwGarantie
DataWindow			dwPolice
DataWindow			dwLstGti
DataWindowChild	dwChild
U_DataWindow		dwSin

istPass = Message.PowerObjectParm

// #1 - [EXPANSION5.LIB_POLICE]
SetNull(sIdBoutique) 
if Upperbound(istPass.sTab) > 1 Then sIdBoutique = istPass.sTab [ 2 ]
// Fin #1 - [EXPANSION5.LIB_POLICE]
	
// Positionnement de la fen$$HEX1$$ea00$$ENDHEX$$tre
wf_PositionnerObjets ()

If istPass.sTab [ 1 ] = "T" Then
/*------------------------------------------------------------------*/
/* La popup est appel$$HEX1$$e900$$ENDHEX$$e de w_tm_sp_sinistre                         */
/*------------------------------------------------------------------*/
	// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des dw de garantie et police d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$es dans w_tm_sp_sinistre
	dwGarantie	= istPass.dwNorm [ 1 ]
	dwPolice		= istPass.dwNorm [ 2 ]
	dwLstGti		= istPass.dwTab [ 1 ]

	// #1 - [EXPANSION5.LIB_POLICE]
	if Not isNull(sIdBoutique) Then
		dsLibPolice=CREATE datastore
		dsLibPolice.dataobject="d_stk_lib_police"
		dsLibPolice.setTransobject( SQLCA)
		If dwLstGti.RowCount () > 0 Then
			lIdSin = dwLstGti.GetItemNumber ( 1, "ID_SIN" )
		End if
	End if
	// Fin #1 - [EXPANSION5.LIB_POLICE]
	
	For lCpt = 1 to dwGarantie.RowCount ()
		dw_1.InsertRow ( 0 )
		lIdProd = dwGarantie.GetItemNumber ( lCpt, "ID_PROD" )
		dw_1.SetItem ( lCpt, "ID_PROD", lIdProd )
		lIdRev = dwGarantie.GetItemNumber ( lCpt, "ID_REV" )
		dw_1.SetItem ( lCpt, "ID_REV", lIdRev )
		lIdGti = dwGarantie.GetItemNumber ( lCpt, "ID_GTI" )
		dw_1.SetItem ( lCpt, "ID_GTI", lIdGti )

		dwLstGti.GetChild ( "ID_GTI", dwChild )
		lFind = dwChild.Find ( "ID_GTI = " + String ( lIdGti ), 0, dwChild.RowCount () )
		sLibGti = dwChild.GetItemString ( lFind, "LIB_GTI" )
		dw_1.SetItem ( lCpt, "LIB_GTI", String ( dwGarantie.GetItemNumber ( lCpt, "ID_GTI" ) ) + " - " + sLibGti )

		// ... n$$HEX2$$b0002000$$ENDHEX$$de police $$HEX2$$e0002000$$ENDHEX$$partir de la garantie
		lIdPolice = dwGarantie.GetItemNumber ( lCpt, "ID_POLICE" )
		dw_1.SetItem ( lCpt, "ID_POLICE", lIdPolice )

		// #1 - [EXPANSION5.LIB_POLICE]
		
		// ... gestion normal : libell$$HEX2$$e9002000$$ENDHEX$$police repris de police
		if isNull(sIdBoutique) Then
			lFind = dwPolice.Find ( "ID_POLICE = " + String ( lIdPolice ), 0, dwPolice.RowCount () )
			sLibPolice = dwPolice.GetItemString ( lFind, "LIB_POLICE" )

		// ... gestion particuli$$HEX1$$e800$$ENDHEX$$re Police/Cie    			
		Else
			sLibPolice=""
			dsLibPolice.Retrieve(lIdSin, lIdProd, lIdRev, lIdGti,lIdPolice)  // [PC202]
			if dsLibPolice.Rowcount( ) > 0 Then
				sLibPolice=dsLibPolice.GetItemString(1, "LIB_POLICE")
			End if
		End if

		// Fin #1 - [EXPANSION5.LIB_POLICE]
		
		dw_1.SetItem ( lCpt, "LIB_POLICE", sLibPolice )
		
		lFind = dwPolice.Find ( "ID_POLICE = " + String ( lIdPolice ), 0, dwPolice.RowCount () )		// [PC202]
		lIdCie = dwPolice.GetItemNumber ( lFind, "ID_CIE" )
		dw_1.SetItem ( lCpt, "ID_CIE", lIdCie )
		sLibCie = dwPolice.GetItemString ( lFind, "LIB_CIE" )
		dw_1.SetItem ( lCpt, "LIB_CIE", sLibCie )
		
	Next
	
	if Not isNull(sIdBoutique) Then Destroy dsLibPolice // #1 - [EXPANSION5.LIB_POLICE]
	
Else
/*------------------------------------------------------------------*/
/* La popup est appel$$HEX1$$e900$$ENDHEX$$e de w_cm_sp_sinistre. On n'y dispose pas de  */
/* la dw des polices. On fait donc une requ$$HEX1$$ea00$$ENDHEX$$te directe $$HEX2$$e0002000$$ENDHEX$$chaque     */
/* appui sur le bouton dans la fen$$HEX1$$ea00$$ENDHEX$$tre w_cm_sp_sinistre.            */
/*------------------------------------------------------------------*/
	dw_1.SetTransObject ( istPass.trTrans )
	dwSin = istPass.dwMaster
	lIdProd = dwSin.GetItemNumber ( 1, "ID_PROD" )
	lIdRev = dwSin.GetItemNumber ( 1, "ID_REV" )
	//	dw_1.Retrieve ( lIdProd, lIdRev )
	dw_1.Retrieve ( lIdProd, lIdRev, sIdBoutique ) // #1 - [EXPANSION5.LIB_POLICE]
End If
end event

on w_t_sp_popup_pol_ass.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_t_sp_popup_pol_ass.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_t_sp_popup_pol_ass
integer x = 261
integer y = 12
integer width = 3355
integer height = 544
integer taborder = 20
string dataobject = "d_sp_sin_pol_ass"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_t_sp_popup_pol_ass
integer x = 5
integer y = 8
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fermer"
end type

on clicked;close ( Parent )
end on

