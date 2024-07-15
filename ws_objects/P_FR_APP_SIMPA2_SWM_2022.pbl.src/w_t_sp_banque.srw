HA$PBExportHeader$w_t_sp_banque.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour la recherche des agences.
forward
global type w_t_sp_banque from w_ancetre
end type
type dw_lst_agence from u_datawindow_detail within w_t_sp_banque
end type
type dw_1 from u_datawindow within w_t_sp_banque
end type
type pb_valider from u_8_pbvalider within w_t_sp_banque
end type
type pb_interro from u_8_pbinterro within w_t_sp_banque
end type
type pb_retour from u_8_pbretour within w_t_sp_banque
end type
end forward

global type w_t_sp_banque from w_ancetre
boolean visible = true
integer x = 0
integer y = 0
integer width = 3570
integer height = 1744
boolean titlebar = true
string title = "Recherche des coordonn$$HEX1$$e900$$ENDHEX$$es bancaires"
dw_lst_agence dw_lst_agence
dw_1 dw_1
pb_valider pb_valider
pb_interro pb_interro
pb_retour pb_retour
end type
global w_t_sp_banque w_t_sp_banque

type variables
Private :
	u_gs_sp_sinistre_creer_lst_Detail	iuoGsDetail
	w_Ancetre_Traitement		iwParentDet


end variables

event ue_valider;call super::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Ue_Valider
//* Evenement 		: Ue_Valider
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1  JFF		01/10/2002	DCMP020321 A.Gaudin : Mettre m$$HEX1$$ea00$$ENDHEX$$me m$$HEX1$$e900$$ENDHEX$$thode de formatage
//*								pour le Cr$$HEX1$$e900$$ENDHEX$$dit Lyonnais que pour la BNP.
//* #2  JFF		10/05/2004	Modif demand$$HEX2$$e9002000$$ENDHEX$$par P.Oslaj (m$$HEX1$$e900$$ENDHEX$$mo du 10/05/2004).
//* #3  JFF		13/10/2008	[DCMP080707]
//*-----------------------------------------------------------------
String sNom, sAdr1, sAdr2, sAdrCp, sAdrVille, sIdBq

Long lLig

lLig = dw_Lst_Agence.GetSelectedRow ( 0 )

If	lLig > 0 Then
	sIdBq = dw_Lst_Agence.GetItemString ( lLig, "ID_BQ" )
	Choose Case sIdBq

/*------------------------------------------------------------------*/
/* Cas de la BNP.                                                   */
/*------------------------------------------------------------------*/
	Case "30004"

/*------------------------------------------------------------------*/
/* #2 changement de format.          										  */
/*------------------------------------------------------------------*/
/* BNP PARIBAS                                                      */
/* NOM DE L'AGENCE                                                  */
/* ACI : ZnnnnnA                                                    */
/*------------------------------------------------------------------*/
		sNom			= dw_Lst_Agence.GetItemString ( lLig, "LIB_AG" )
		sAdr1			= dw_Lst_Agence.GetItemString ( lLig, "LIB_SERVICE" )
		sAdr2			= "ACI : Z" + Right ( "00000" + dw_Lst_Agence.GetItemString ( lLig, "ID_AG" ), 5 ) + "A"
		sAdrCp		= "00000"
		sAdrVille	= "."

/*------------------------------------------------------------------*/
/* AGENCE.LIB_AG                                                    */
/* 'AGENCE' + AGENCE.ID_AG                                          */
/* AGENCE.LIB_SERVICE                                               */
/* '00000' '.'                                                      */
/*------------------------------------------------------------------*/
//		sNom			= dw_Lst_Agence.GetItemString ( lLig, "LIB_AG" )
//		sAdr1			= "AGENCE " + dw_Lst_Agence.GetItemString ( lLig, "ID_AG" )
//		sAdr2			= dw_Lst_Agence.GetItemString ( lLig, "LIB_SERVICE" )
//		sAdrCp		= "00000"
//		sAdrVille	= "."


	Case "30002"
/*------------------------------------------------------------------*/
/* #1 : Cas du CREDIT LYONNAIS.                                     */
/* (Idem $$HEX2$$e0002000$$ENDHEX$$BNP)																	  */
/*------------------------------------------------------------------*/
//* #3  [DCMP080707]
/*
		sNom			= dw_Lst_Agence.GetItemString ( lLig, "LIB_AG" )
		sAdr1			= "AGENCE " + dw_Lst_Agence.GetItemString ( lLig, "ID_AG" )
		sAdr2			= dw_Lst_Agence.GetItemString ( lLig, "LIB_SERVICE" )
		sAdrCp		= "00000"
		sAdrVille	= "."
*/

//* #3  [DCMP080707]
		sNom			= dw_Lst_Agence.GetItemString ( lLig, "LIB_AG" )
		sAdr1			= dw_Lst_Agence.GetItemString ( lLig, "LIB_SERVICE" )
		sAdr2			= "AGENCE " + dw_Lst_Agence.GetItemString ( lLig, "ID_AG" )
		sAdrCp		= "00000"
		sAdrVille	= "."



	Case Else
/*------------------------------------------------------------------*/
//* Autres cas.                                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* AGENCE.LIB_AG                                                    */
/* AGENCE.ADR_1                                                     */
/* AGENCE.ADR_2                                                     */
/* AGENCE.ADR_CP AGENCE.ADR_VILLE                                   */
/*------------------------------------------------------------------*/
		sNom			= dw_Lst_Agence.GetItemString ( lLig, "LIB_AG" )
		sAdr1			= dw_Lst_Agence.GetItemString ( lLig, "ADR_1" )
		sAdr2			= dw_Lst_Agence.GetItemString ( lLig, "ADR_2" )
		sAdrCp		= dw_Lst_Agence.GetItemString ( lLig, "ADR_CP" )
		sAdrVille	= dw_Lst_Agence.GetItemString ( lLig, "ADR_VILLE" )
		
	End Choose

	iwParentDet.dw_1.SetItem ( 1, "COD_INTER", 	"B" )
	iwParentDet.dw_1.SetItem ( 1, "COD_CIV", 		"4" )
	iwParentDet.dw_1.SetItem ( 1, "NOM", 			sNom )
	iwParentDet.dw_1.SetItem ( 1, "ADR_1", 		sAdr1 )
	iwParentDet.dw_1.SetItem ( 1, "ADR_2", 		sAdr2 )
	iwParentDet.dw_1.SetItem ( 1, "ADR_CP", 		sAdrCp )
	iwParentDet.dw_1.SetItem ( 1, "ADR_VILLE",	sAdrVille )
	iwParentDet.dw_1.SetItem ( 1, "NUM_TELD", 	stNul.str )
	iwParentDet.dw_1.SetItem ( 1, "NUM_TELB", 	stNul.str )
	iwParentDet.dw_1.SetItem ( 1, "NUM_FAX", 		stNul.str )

	iwParentDet.dw_1.SetItem ( 1, "RIB_BQ", 		stNul.str )
	iwParentDet.dw_1.SetItem ( 1, "RIB_GUI", 		stNul.str )
	iwParentDet.dw_1.SetItem ( 1, "RIB_CPT", 		stNul.str )
	iwParentDet.dw_1.SetItem ( 1, "RIB_CLE", 		stNul.str )

	iwParentDet.dw_1.SetItem ( 1, "COD_BQ", 		sIdBq )
	iwParentDet.dw_1.SetItem ( 1, "COD_AG", 		dw_Lst_Agence.GetItemString ( lLig, "ID_AG" ) )

	// Gestion des fournisseurs
	Choose Case dw_1.GetItemString ( 1, "ALT_FOUR" )
		Case "O"
			iwParentDet.dw_1.SetItem ( 1, "COD_INTER", 	"F" )
			iwParentDet.dw_1.SetItem ( 1, "COD_CIV", 		"5" )
			iwParentDet.dw_1.SetItem ( 1, "ID_FOUR", 		dw_Lst_Agence.GetItemString ( lLig, "ID_BQ" ) )
			iwParentDet.dw_1.SetItem ( 1, "COD_MODE_REG", "FM" )
	End Choose 

/*------------------------------------------------------------------*/
/* Les coordonn$$HEX1$$e900$$ENDHEX$$es deviennent non saisissables.                     */
/*------------------------------------------------------------------*/
	iwParentDet.TriggerEvent ( "Ue_Banque" )

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Retour, uniquement si la ligne de    */
/* dw_Lst_Agence est valide.                                        */
/*------------------------------------------------------------------*/

	This.TriggerEvent ( "Ue_Retour" )
End If
end event

on ue_interro;call w_ancetre::ue_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Ue_Interro
//* Evenement 		: Ue_Interro
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 11:55:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sCodBq, sCodAg, sMod

Long lPos

If	dw_1.AcceptText () > 0 Then

	sCodBq = Trim ( dw_1.GetItemString ( 1, "COD_BQ" ) )
	sCodAg = Trim ( dw_1.GetItemString ( 1, "COD_AG" ) )

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine si le COD_BQ contient "*".                          */
/*------------------------------------------------------------------*/
	lPos = Pos ( sCodBq, "*" )
	If	lPos > 0 Then sCodBq = Left ( sCodBq, ( lPos - 1 ) ) + "%"

	If ( IsNull ( sCodAg ) Or Trim ( sCodAg ) = "" ) And sCodBq <> "" Then
		sCodAg = "%"
	Else
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine si le COD_AG contient "*".                          */
/*------------------------------------------------------------------*/
		lPos = Pos ( sCodAg, "*" )
		If	lPos > 0 Then sCodAg = Left ( sCodAg, ( lPos - 1 ) ) + "%"

		If	( IsNull ( sCodBq ) Or Trim ( sCodBq ) = "" ) And Trim ( sCodAg ) <> "" Then sCodBq = "%"
	End If

	If IsNull ( sCodBq + sCodAg ) Then Return

	dw_Lst_Agence.Reset ()

	sMod = "datawindow.table.procedure = ~"1 EXECUTE sysadm.DW_S01_AGENCE_LSTDET "		+ &
													"'" + sCodBq + "'" + ", "								+ &
													"'" + sCodAg + "'" + "~""

	dw_Lst_Agence.Uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre non saisissable pendant la recherche.         */
/*------------------------------------------------------------------*/
	This.Enabled = False

	dw_Lst_Agence.SetRedraw ( False )
	dw_Lst_Agence.Retrieve ()
	dw_Lst_Agence.SetRedraw ( True )

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre saisissable apr$$HEX1$$e900$$ENDHEX$$s la recherche.               */
/*------------------------------------------------------------------*/
	This.Enabled = True
	dw_Lst_Agence.SetFocus ()
End If

end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:55:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* JFF			09/03/2015	[MANTIS14653][DT133_CASTO
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On va cr$$HEX1$$e900$$ENDHEX$$er la DW de d$$HEX1$$e900$$ENDHEX$$tail pour les agences.                    */
/*------------------------------------------------------------------*/
iuoGsDetail = Create u_Gs_Sp_Sinistre_Creer_Lst_Detail
iuoGsDetail.Uf_Creer_Detail ( 1, dw_lst_agence, istPass.trTrans )
Destroy iuoGsDetail

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re une ligne dans la DW dw_1 pour permettre la saisie.    */
/*------------------------------------------------------------------*/
dw_1.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* On arrete la recherche $$HEX2$$e0002000$$ENDHEX$$150 lignes dans Dw_Lst_Agence.          */
/*------------------------------------------------------------------*/
dw_Lst_Agence.Uf_Activer_Menu ( False )
dw_Lst_Agence.ilMaxLig = 150

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
iwParentDet = istPass.wParent

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT non saisissable.                       */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = False

// [MANTIS14653]
If UpperBound ( istPass.lTab ) > 0 Then
	If istPass.lTab [1] = 23400 Then
		Dw_1.SetItem ( 1, "COD_BQ", String ( istPass.lTab [1] ))
		Dw_1.SetItem ( 1, "COD_AG", String ( istPass.lTab [2] ))
	End If
End If

end event

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1769
This.Width		= 3598
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:49:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass = Message.PowerObjectParm

This.PostEvent ( "Ue_Initialiser" )


end event

on w_t_sp_banque.create
int iCurrent
call super::create
this.dw_lst_agence=create dw_lst_agence
this.dw_1=create dw_1
this.pb_valider=create pb_valider
this.pb_interro=create pb_interro
this.pb_retour=create pb_retour
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lst_agence
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_valider
this.Control[iCurrent+4]=this.pb_interro
this.Control[iCurrent+5]=this.pb_retour
end on

on w_t_sp_banque.destroy
call super::destroy
destroy(this.dw_lst_agence)
destroy(this.dw_1)
destroy(this.pb_valider)
destroy(this.pb_interro)
destroy(this.pb_retour)
end on

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT saisissable.                           */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = True

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
Close ( This )
end on

type cb_debug from w_ancetre`cb_debug within w_t_sp_banque
end type

type dw_lst_agence from u_datawindow_detail within w_t_sp_banque
boolean visible = false
integer x = 64
integer y = 308
integer width = 3442
integer height = 1316
integer taborder = 40
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
end type

on retrieverow;call u_datawindow_detail::retrieverow;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Agence::RetrieveRow!
//* Evenement 		: RetrieveRow!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 12:11:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Incr$$HEX1$$e900$$ENDHEX$$mentation du nombre de lignes retrouv$$HEX1$$e900$$ENDHEX$$es
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.ilNbrLig ++

If	This.ilNbrLig = This.ilMaxLig Then
	DbCancel ()
	MessageBox ( "Arr$$HEX1$$ea00$$ENDHEX$$t", "Le nombre maximum de lignes est atteint~n~rLa s$$HEX1$$e900$$ENDHEX$$lection est incompl$$HEX1$$e800$$ENDHEX$$te" )
End If


end on

on doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Lst_Agence::DoubleClicked! (OVERRIDE)
//* Evenement 		: DoubleClicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 11:36:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Valider" )

end on

type dw_1 from u_datawindow within w_t_sp_banque
integer x = 2624
integer y = 20
integer width = 791
integer height = 272
integer taborder = 10
string dataobject = "d_sp_int_agence"
boolean border = false
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:35:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Integer iAction
String sText, sVal, sNull

SetNull ( sNull )

iAction	= 0

If this.GetItemString ( 1, "ALT_FOUR" ) <> "O" Then
	Choose Case isNomCol
	Case "COD_BQ", "COD_AG"
		sText = This.GetText ()
		If	sText = "" Or IsNull ( sText ) Then Return
	
		If	Pos ( sText, "*" ) > 0 Then Return
	
		sVal	= String (  Dec ( GetText () ), "00000" )
		This.SetItem ( 1, isNomCol, sVal )
		iAction	= 2
	
	End Choose
End If

If this.GetItemString ( 1, "ALT_FOUR" ) = "O" Then
	Choose Case isNomCol
	Case "COD_BQ"
		sText = This.GetText ()
		If	sText = "" Or IsNull ( sText ) Then Return
	
		If	Pos ( sText, "*" ) > 0 Then Return
	
		This.SetItem ( 1, "COD_AG", "-1" )
	
	End Choose
End If


Choose Case isNomCol
	Case "ALT_FOUR"
		Choose Case This.GetText ()
			Case "O" 
				This.Modify ( "cod_bq_t.text = 'Code fournisseur' cod_ag_t.text = '' cod_ag_t.visible = 0 cod_ag.visible = 0 ")
			Case "N" 
				This.Modify ( "cod_bq_t.text = 'Code de la banque' cod_ag_t.text = 'Code de l~~'agence' cod_ag_t.visible = 1 cod_ag.visible = 1")
		End Choose

		This.SetItem ( 1, "COD_BQ", sNull )	
		This.SetItem ( 1, "COD_AG", sNull )	

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//dw_1.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "COD_BQ"
		stMessage.sVar[1] = "code banque"
		stMessage.sCode	= "GENE003"

	Case "COD_AG"
		stMessage.sVar[1] = "code agence"
		stMessage.sCode	= "GENE003"

	End Choose

	F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser ()
	Return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_valider from u_8_pbvalider within w_t_sp_banque
integer x = 325
integer y = 56
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_interro from u_8_pbinterro within w_t_sp_banque
integer x = 2368
integer y = 88
integer width = 242
integer height = 144
integer taborder = 30
string text = "&Chercher"
boolean default = true
string picturename = "k:\pb4obj\bmp\8_plein.bmp"
end type

type pb_retour from u_8_pbretour within w_t_sp_banque
integer x = 78
integer y = 56
integer width = 242
integer height = 144
integer taborder = 20
boolean cancel = true
end type

