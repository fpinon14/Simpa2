$PBExportHeader$w_t_sp_categ_cour.srw
$PBExportComments$Fenêtre d'affichage des courriers avant validation pour visualisation de la catégorie DCMP 040366
forward
global type w_t_sp_categ_cour from window
end type
type dw_w_cour_blob from datawindow within w_t_sp_categ_cour
end type
type dw_1 from datawindow within w_t_sp_categ_cour
end type
type cb_1 from commandbutton within w_t_sp_categ_cour
end type
end forward

global type w_t_sp_categ_cour from window
integer x = 1335
integer y = 688
integer width = 4462
integer height = 584
boolean titlebar = true
string title = "Catégorie des courriers"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
dw_w_cour_blob dw_w_cour_blob
dw_1 dw_1
cb_1 cb_1
end type
global w_t_sp_categ_cour w_t_sp_categ_cour

type variables
Private :

	s_Pass	istPass

	u_DataWindow_Detail	idwLstInter
	DataWindow		idwWCourrier
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Categ_Cour::Wf_PositionnerObjet		(PRIVATE)
//* Auteur			: Catherine ABDMEZIEM
//* Date				: 05/11/2004
//* Libellé			: 
//* Commentaires	: Positionnement dynamique des objets de la fenêtre
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
/* Position de la fenêtre.                                          */
/*------------------------------------------------------------------*/
lX = gwmdi.x
lY = gwmdi.y

This.X		=	lX + 20
This.Y		=	lY + 9

end subroutine

event open;//*-----------------------------------------------------------------
//*
//* Fonction      : W_T_Sp_Categ_Cour::open
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 05/11/2004
//* Libellé       : 
//* Commentaires  : Chargement de la dw avec w_cour_blob_arch du dossier
//*						DCMP 040366
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChildDest, dwChild
Long					lCpt, lLig, lLigTrv, lIdInter
String				sFilter, sTxtCompo1, sAltSuiviMail, sAdrMail


istPass = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* Pointage sur la dw de la liste des inter de w_tm_sp_sinistre +   */
/* dw de w_courrier                                                 */
/*------------------------------------------------------------------*/
idwLstInter = istPass.dwTab [ 1 ]
idwWCourrier = istPass.dwNorm [ 2 ]

dw_W_Cour_Blob.SetTransObject ( istPass.trTrans )

/*------------------------------------------------------------------*/
/* Positionnement de la fenêtre                                     */
/*------------------------------------------------------------------*/
wf_PositionnerObjets ()
// On rend la zone id_typ_doc inaccessible tout le temps
dw_1.Modify ( "ID_TYP_DOC.background.color = 12632256" )
dw_1.Modify ( "ID_TYP_DOC.border = 6" )
dw_1.Modify ( "ID_TYP_DOC.protect = 1" )

/*------------------------------------------------------------------*/
/* Récupération de la dddw des natures de documents déjà populisés  */
/* dans w_tm_sp_sinistre                                            */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "ID_TYP_DOC", dwChildDest )
istPass.dwNorm [ 1 ].ShareData ( dwChildDest )


// [DNTMAIL1-2]
if dw_1.Getchild ( "ID_CANAL", dwChild) = 1 then
	dwChild.SetTRansObject(sqlca)
	dwChild.Retrieve('-MS')
End If
if dw_1.Getchild ( "COD_INTER", dwChild) = 1 then
	dwChild.SetTRansObject(sqlca)
	dwChild.Retrieve('-IN')
End If

/*------------------------------------------------------------------*/
/* Récupération des courriers                                       */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Chargement de la dw des w_cour_blob avec le n° de sinistre       */
/*------------------------------------------------------------------*/
dw_W_Cour_Blob.Retrieve ( istPass.lTab [ 1 ] )

/*------------------------------------------------------------------*/
/* Recopie de chaque courrier dans la dw                            */
/* d_stk_choix_regen_courrier_sim2                                  */
/*------------------------------------------------------------------*/
For lCpt = 1 To dw_W_Cour_Blob.RowCount ()

	dw_1.InsertRow ( 0 )

	lLig = dw_1.RowCount()
	lIdInter = dw_W_Cour_Blob.GetItemNumber ( lCpt, "ID_I" )
	dw_1.SetItem ( lLig , "ID_INTER", lIdInter )

	lLigTrv = idwLstInter.Find ( "ID_I = " + String ( lIdInter ), 1, idwLstInter.RowCount () )
	dw_1.SetItem ( lLig, "COD_INTER", idwLstInter.GetItemString ( lLigTrv, "COD_INTER" ) )
	dw_1.SetItem ( lLig, "NOM", idwLstInter.GetItemString ( lLigTrv, "NOM" ) )
	
	sAltSuiviMail = idwLstInter.GetItemString (lLigTrv , "ALT_SUIVI_MAIL")
	sAdrMail =      idwLstInter.GetItemString (lLigTrv , "ADR_MAIL")
	
	// [PM159]
	dw_1.SetItem ( lLig, "ID_CANAL", idwWCourrier.GetItemString ( lLigTrv, "ID_CANAL" ) )
	
/*	// [PM159]
	IF sAltSuiviMail = "O" And NOT (isnull (sAdrMail) OR sAdrMail = "") THEN
	
		dw_1.SetItem ( lLig, "ID_CANAL", "MA")
	Else
		dw_1.SetItem ( lLig, "ID_CANAL", "CO")
	End If	
*/

	lLigTrv = idwWCourrier.Find ( "ID_I = " + String ( lIdInter ), 1, idwWCourrier.RowCount () )
	If idwWCourrier.GetItemString ( lLigTrv, "ALT_PART" ) = "O" Then
		dw_1.SetItem ( lLig, "TYPE_COUR", "CP")
		/*------------------------------------------------------------------*/
		/* La date de modification est celle spécifiée uniquement pour les  */
		/* CP dans le chmp txt_compo1 de w_courrier et est positionnée après*/
		/* le mot clef DTEMOD                                               */
		/*------------------------------------------------------------------*/
		sTxtCompo1 = idwWCourrier.GetItemString ( lLigTrv, "TXT_COMPO1" )
		sTxtCompo1 = Mid ( sTxtCompo1, Pos ( sTxtCompo1, "DTEMOD", 1 ) + 7, 19 )
		dw_1.SetItem ( lLig, "MAJ_LE", sTxtCompo1 )
	Else
		dw_1.SetItem ( lLig, "TYPE_COUR", "CA")
	End If

	dw_1.SetItem ( lLig, "ID_TYP_DOC", dw_W_Cour_Blob.GetItemNumber ( lCpt, "ID_TYP_DOC" ) )

	/*------------------------------------------------------------------*/
	/* On force la colonne "droit" de toutes les lignes à 1 pour que    */
	/* le sens interdit n'apparaisse jamais                             */
	/*------------------------------------------------------------------*/
	dw_1.SetItem ( lLig, "DROIT", 1 )

End For

end event

on w_t_sp_categ_cour.create
this.dw_w_cour_blob=create dw_w_cour_blob
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_w_cour_blob,&
this.dw_1,&
this.cb_1}
end on

on w_t_sp_categ_cour.destroy
destroy(this.dw_w_cour_blob)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type dw_w_cour_blob from datawindow within w_t_sp_categ_cour
boolean visible = false
integer x = 315
integer y = 4
integer width = 256
integer height = 120
integer taborder = 20
boolean enabled = false
string dataobject = "d_lst_w_cour_blob"
boolean livescroll = true
end type

type dw_1 from datawindow within w_t_sp_categ_cour
integer x = 27
integer y = 132
integer width = 4343
integer height = 296
integer taborder = 30
string dataobject = "d_stk_choix_regen_courrier_sim2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_t_sp_categ_cour
integer x = 23
integer y = 12
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

on clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 11/10/2004
//* Libellé       : 
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

Close ( Parent )
end on

