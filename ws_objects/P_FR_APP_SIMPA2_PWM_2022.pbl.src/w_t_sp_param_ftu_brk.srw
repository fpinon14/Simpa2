HA$PBExportHeader$w_t_sp_param_ftu_brk.srw
$PBExportComments$[PM02] Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises de mat$$HEX1$$e900$$ENDHEX$$riels
forward
global type w_t_sp_param_ftu_brk from w_traitement
end type
type st_creation from statictext within w_t_sp_param_ftu_brk
end type
type dw_2 from u_datawindow_detail within w_t_sp_param_ftu_brk
end type
type st_1 from statictext within w_t_sp_param_ftu_brk
end type
type dw_cree_le from datawindow within w_t_sp_param_ftu_brk
end type
type p_focus from picture within w_t_sp_param_ftu_brk
end type
type cb_aide from commandbutton within w_t_sp_param_ftu_brk
end type
type cb_edb from commandbutton within w_t_sp_param_ftu_brk
end type
end forward

global type w_t_sp_param_ftu_brk from w_traitement
integer width = 3881
integer height = 2740
string title = "Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises de mat$$HEX1$$e900$$ENDHEX$$riels sinistr$$HEX1$$e900$$ENDHEX$$s"
boolean ibmajaccueil = true
event type long ue_supprimerdetail ( unsignedlong wparm,  long lparm )
st_creation st_creation
dw_2 dw_2
st_1 st_1
dw_cree_le dw_cree_le
p_focus p_focus
cb_aide cb_aide
cb_edb cb_edb
end type
global w_t_sp_param_ftu_brk w_t_sp_param_ftu_brk

type variables
u_sp_gs_param_ftu_brk iUoSpGsParamFtuBrk
Long ilLastIdTarif

Constant String K_NOMFIC_AIDE="DOC_PM02"
Constant String K_NOMFIC_EDB="EDB_DPG_PM02"
end variables

forward prototypes
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
public function boolean wf_valider ()
public function boolean wf_preparervalider ()
private subroutine wf_proteger ()
private subroutine wf_setmode_creation (boolean bpassmodif)
public function boolean wf_suite_valider ()
public function boolean wf_executervalider ()
private subroutine wf_set_cree_le ()
public function boolean wf_preparerabandonner ()
private subroutine wf_afficher_doc (string asnomfichier)
end prototypes

event type long ue_supprimerdetail(unsignedlong wparm, long lparm);//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: ue_supprimerdetail
//* Auteur			: F. Pinon
//* Date				: 17/03/2011 16:54:26
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

dw_2.DeleteRow(dw_2.GetRow())

Return 0

end event

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_preparermodifier
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
String sIdSeq, sIdFour, sIdTypArt
DatawindowChild dwcChild
Decimal dcIdProd, dcIdGti

sIdSeq = istPass.sTab[1]

pb_supprimer.Visible=TRUE
st_creation.Visible=FALSE

dw_1.Retrieve(long(sIdSeq))
dw_2.Retrieve(long(sIdSeq))

dw_2.SetSort("MT_PIVOT_MIN, MT_PIVOT_MAX, PERIODE_MIN_J, PERIODE_MAX_J")
dw_2.Sort()

dw_1.Modify("ALT_ACTIF.CheckBox.Text='Tarif actif (ID=" + string(dw_1.GetItemnumber( 1, "ID_TARIF")) + ")'")

// Maj des ddw
dcIdProd = dw_1.getItemDecimal( 1, "ID_PROD")
dcIdGti = dw_1.getItemDecimal( 1, "ID_GTI")
sIdTypArt=dw_1.GetItemString(1,"ID_TYP_ART")

dw_1.getchild( "ID_REV", dwcChild )		
dwcChild.Retrieve(dcIdProd)
		
dw_1.getchild( "ID_GTI", dwcChild )		
dwcChild.Retrieve(dcIdProd)
	
dw_1.getchild( "ID_TYP_ART", dwcChild )		
dwcChild.Retrieve(dcIdProd)

dw_1.getchild( "ID_MARQ_ART", dwcChild )		
dwcChild.Retrieve(dcIdProd,sIdTypArt)

dw_1.getchild( "ID_MODL_ART", dwcChild )		
dwcChild.Retrieve(dcIdProd,sIdTypArt)
dwcChild.SetFilter("marque='" + dw_1.GetItemString(1,"ID_MARQ_ART") + "' or marque='-1'")
dwcChild.Filter()
dwcChild.Sort()

dw_1.getchild( "ID_FOUR", dwcChild )		
dwcChild.Retrieve(dcIdProd, dcIdGti)
		
dw_1.getchild( "ID_FOUR_FORFAIT", dwcChild )		
dwcChild.Retrieve(dcIdProd,dcIdGti)
	
// Protection des zones	
iuospgsparamftubrk.uf_proteger_modif( )

dw_1.object.alt_mode_creat.Visible=TRUE
dw_1.object.alt_reinit.Visible=FALSE

wf_set_cree_le( )	

This.Title="Modification de tarif"

Return TRUE
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_preparerinserer
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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

st_creation.Visible=FALSE

iUoSpGsParamFtuBrk.uf_reinitialiser( )

dw_1.setcolumn( "ID_PROD")

wf_setmode_creation( FALSE )

if dw_cree_le.RowCount() = 0 Then dw_cree_le.InsertRow(0)

dw_cree_le.Reset()
dw_cree_le.InsertRow(0)
dw_cree_le.SetItem( 1, "MAJ_PAR", stglb.scodoper )
dw_1.Modify("ALT_ACTIF.CheckBox.Text='Tarif actif'")

Return TRUE
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_controlersaisie
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
//* 		FPI	03/06/2011	 [PM02.RetourNC]
//*-----------------------------------------------------------------
String sPos

If dw_2.Accepttext( ) = -1 Then 
	idwcontrole=dw_2 // [PM02.RetourNC]
	return "IE_MT_PIVOT_MIN"
End if

sPos= iUoSpGsParamFtuBrk.uf_controler_oblig( )

if sPos="" Then
	sPos= iUoSpGsParamFtuBrk.uf_controler_oblig_vts( )
	if sPos <> "" Then 
		dw_2.setFocus( )
		idwcontrole=dw_2
	End if
End if

Return sPos
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_controlergestion
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
String sPos

sPos = iUoSpGsParamFtuBrk.uf_controler( )

if sPos <> "" Then 
	Choose Case Upper(sPos)
		Case "IE_MT_PIVOT_MIN","IE_MT_PIVOT_MAX","MT_PIVOT_MIN","MT_PIVOT_MAX","PERIODE_MIN_J","PERIODE_MAX_J","TX_REPRISE"
			idwcontrole=dw_2
		Case Else	
			idwcontrole=dw_1
	End Choose
End if

Return sPos
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_preparersupprimer
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
stMessage.sTitre 		= "Suppression d'un param$$HEX1$$e900$$ENDHEX$$trage de tarif"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Question!
stMessage.sCode		= "PATF001"

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
//* Fonction		: w_t_sp_param_ftu_brk::wf_valider
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
//* 		FPI	24/10/2011	 [PM02.DP175] Autorisation d'ins$$HEX1$$e900$$ENDHEX$$rer une seule et unique ligne si DP 175
//*-----------------------------------------------------------------

Boolean bRet
Long lNull
Datetime dtNow
DataWindowChild dwChild

bRet=TRUE

SetNull(lNull)

bRet=super::wf_valider()

If bRet Then
	dtNow =Datetime(Today(),Now())
	
	If istpass.binsert Then
		st_creation.Text="Cr$$HEX1$$e900$$ENDHEX$$ation en base r$$HEX1$$e900$$ENDHEX$$ussie (ID=" + string(dw_1.GetItemnumber( 1, "ID_TARIF")) + ")"
		if dw_1.GetItemString(1,"ALT_REINIT") = "O" Then 
			iuospgsparamftubrk.uf_reinitialiser( )
			wf_setmode_creation( FALSE )
		Else
			wf_setmode_creation( FALSE )
		End if
		
		dw_cree_le.SetItem(1,"CREE_LE",dtNow)
	Else
		st_creation.Text="Modification en base r$$HEX1$$e900$$ENDHEX$$ussie"
	End if
	st_creation.Textcolor = 32768
	dw_cree_le.SetItem(1,"MAJ_LE",dtNow)
Else
	If istpass.binsert Then
		st_creation.Text="Echec de cr$$HEX1$$e900$$ENDHEX$$ation du param$$HEX1$$e900$$ENDHEX$$trage"
	Else
		st_creation.Text="Echec de modification du param$$HEX1$$e900$$ENDHEX$$trage"
	End if
	st_creation.Textcolor = 255
End if

st_creation.Visible=TRUE

// [PM02.DP175] - On recharge
Dw_1.Getchild("id_prod",dwChild)
dwChild.Retrieve()

wf_pb_ctl_vld(0)

Return bRet
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_preparervalider
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
//*-----------------------------------------------------------------

f_majpar(dw_1,1)
Return TRUE
end function

private subroutine wf_proteger ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_proteger
//* Auteur			: F. Pinon
//* Date				: 10/03/2011 13:49:37
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

Long 		lTotLigne
Long lTotCol, lCol

/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 220 pour l'op$$HEX1$$e900$$ENDHEX$$rateur */
/* connect$$HEX60$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 220		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;


If lTotLigne = 0 Then
   pb_controler.enabled = FALSE
   pb_valider.enabled = FALSE
   pb_supprimer.enabled = FALSE
	
	// Protection des dw
	 lTotCol=Long(dw_1.Object.DataWindow.Column.Count)
  	For lCol=1 to lTotCol
		dw_1.uf_proteger( {dw_1.Describe("#" + string(lCol) + ".Name")}, "1")
	 Next

	 lTotCol=Long(dw_2.Object.DataWindow.Column.Count)
  	For lCol=1 to lTotCol
		dw_2.uf_proteger( {dw_2.Describe("#" + string(lCol) + ".Name")}, "1")
	 Next

Else
   pb_controler.enabled = TRUE
   pb_valider.enabled = TRUE
   pb_supprimer.enabled = TRUE
End If





end subroutine

private subroutine wf_setmode_creation (boolean bpassmodif);//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_setmode_creation
//* Auteur			: F. Pinon
//* Date				: 14/03/2011 17:31:15
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

Long lNull
Long lRow

SetNull(lNull)

dw_1.object.alt_mode_creat.Visible=FALSE
dw_1.object.alt_reinit.Visible=TRUE

If bPassModif Then
	This.Title="Modification de tarif"
	dw_1.object.alt_mode_creat.Visible=TRUE
	dw_1.SetItem(1,"ALT_MODE_CREAT","N")
	pb_supprimer.Visible=TRUE
	pb_supprimer.Enabled=TRUE
	dw_1.uf_proteger ( {"ID_PROD","ID_REV","ID_GTI","ID_BRK","ID_TYP_ART","ID_MARQ_ART","ID_MODL_ART","DTE_DEB_EFF","DTE_FIN_EFF","TYP_EFF","ID_FOUR","ID_METHODE","ALT_SANS_VALIDITE","ALT_SANS_FIN_VALIDE"}, "1")
	istpass.binsert = FALSE
Else
	This.Title="Cr$$HEX1$$e900$$ENDHEX$$ation de tarif"
	pb_supprimer.Visible=FALSE
	dw_1.setItem( 1,"id_tarif",lNull)
	dw_1.setItemStatus( 1, 0, Primary!,New!)
	
	If dw_2.RowCount() > 0 Then
		For lRow=1 to dw_2.RowCount() 
			dw_2.setItemStatus( lRow, 0, Primary!,New!)
		Next
	End if
	
	istpass.binsert = TRUE
	
	dw_1.Modify("ALT_ACTIF.CheckBox.Text='Tarif actif'")
	
	dw_1.uf_proteger ( {"ID_PROD","ID_REV","ID_GTI","ID_BRK","ID_TYP_ART","ID_MARQ_ART","ID_MODL_ART","DTE_DEB_EFF","DTE_FIN_EFF","TYP_EFF","ID_FOUR","ID_METHODE","ALT_SANS_VALIDITE","ALT_SANS_FIN_VALIDE"}, "0")

	
End if


end subroutine

public function boolean wf_suite_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_suite_valider
//* Auteur			: F. Pinon
//* Date				: 17/03/2011 10:59:24
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

// Pour $$HEX1$$e900$$ENDHEX$$viter que la fen$$HEX1$$ea00$$ENDHEX$$tre se ferme $$HEX2$$e0002000$$ENDHEX$$chaque cr$$HEX1$$e900$$ENDHEX$$ation
This.bringtotop = TRUE

// On ne ferme qu'en modification
Return (Not istpass.bInsert)
end function

public function boolean wf_executervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_executervalider
//* Auteur			: F. Pinon
//* Date				: 17/03/2011 11:29:13
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

Boolean bRet
Long lRow, lIdTarif

bRet=super::wf_executervalider( )

If bRet Then
	
	lIdTarif = dw_1.GetItemNumber(1,"ID_TARIF")
	ilLastidtarif=lIdTarif
	for lRow=1 to dw_2.RowCount()
		f_majpar(dw_2,lRow)
		dw_2.SetItem(lRow,"ID_TARIF",lIdTarif)
	Next

	bRet = dw_2.uf_update( )
End if

Return bRet

end function

private subroutine wf_set_cree_le ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_set_cree_le
//* Auteur			: F. Pinon
//* Date				: 29/03/2011 15:54:23
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

Datetime dtMajLeParam, dtMajLeParamVts, dtCreeLeParam
Long lRow

lRow=1
If dw_cree_le.RowCount() = 0 Then dw_cree_le.InsertRow(0)

dtCreeLeParam = dw_1.getItemdatetime( 1, "CREE_LE")
dw_cree_le.SetItem(1,"CREE_LE", dtCreeLeParam )

dtMajLeParam=dw_1.getItemdatetime( 1, "MAJ_LE")
SetNull(dtMajLeParamVts)

If dw_2.RowCount() > 0 Then
	dtMajLeParamVts=datetime(dw_2.Describe("Evaluate('max(maj_le)',0)"))
	dw_2.setredraw( FALSE)
	dw_2.Setsort("MAJ_LE D")
	dw_2.Sort()
End if

if isnull(dtMajLeParamVts) or dtMajLeParam > dtMajLeParamVts Then
	dw_cree_le.SetItem(1,"MAJ_LE",dtMajLeParam)
	dw_cree_le.SetItem(1,"MAJ_PAR",dw_1.getitemstring( 1,"MAJ_PAR") )
Else
	dw_cree_le.SetItem(1,"MAJ_LE",dtMajLeParamVts)
	dw_cree_le.SetItem(1,"MAJ_PAR",dw_2.getitemstring( 1,"MAJ_PAR") )
End if

if dw_2.RowCount() > 0 Then
	dw_2.SetSort("MT_PIVOT_MIN, MT_PIVOT_MAX, PERIODE_MIN_J, PERIODE_MAX_J")
	dw_2.Sort()
	dw_2.setredraw( TRUE)
End if
end subroutine

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::wf_preparerabandonner
//* Auteur			: F. Pinon
//* Date				: 01/04/2011 09:51:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On a cliqu$$HEX2$$e9002000$$ENDHEX$$sur retour. On demande confirmation.
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

Boolean bRet

bRet=TRUE

stmessage.berreurg=FALSE
stmessage.bouton=YesNo!
stmessage.icon=Question!
stmessage.scode="PATF017"
stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises"

bRet=(f_message(stMessage) = 1)

Return bRet



end function

private subroutine wf_afficher_doc (string asnomfichier);//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: wf_afficher_doc
//* Auteur			: F. Pinon
//* Date				: 01/04/2011 11:29:40
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


String		sFic,sRun, sFicTmp
Boolean  bOk
String 	sRepWord
n_cst_string	nvString 
Blob blBlob

sFic=ProfileString(stGlb.sFichierIni,"DOCUMENTATION","AIDE","")

sFic = Upper ( Replace ( sFic, Pos ( sFic, "*", 1 ), 1, asnomfichier ))

/*-----------------------------------------------------------------*/
/* L'aide existe-t-elle 												*/
/*-----------------------------------------------------------------*/

bOk = f_FileExists ( sFic )

If Not bOk Then
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprise"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If


//[I037] -- Appel a Word par Nouvelle methode
//sRepWord = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", "REP_WORD", "" )
sRepWord = f_getwordexe()
/*------------------------------------------------------------------*/
/* Le chemin o$$HEX2$$f9002000$$ENDHEX$$trouver word est vide.                              */
/*------------------------------------------------------------------*/
If sRepWord = "" Then 
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprise"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE02"
	F_Message ( stMessage )
	Return
End If

sFicTmp = Upper ( stGlb.sreptempo + asnomfichier + ".DOC"  )

If f_FileExists ( sFicTmp ) Then 
	
	bOk = FileDelete ( sFicTmp )
	If Not bOk Then
		stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprise"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "AIDE03"
		stMessage.sVar[1]		= "l'aide"
		stMessage.sVar[2]		= sFicTmp
		F_Message ( stMessage )
		Return
	End If
End If

/*------------------------------------------------------------------*/
/* Lecture du fichier source.                                       */
/*------------------------------------------------------------------*/
bOk = F_LireFichierBlob ( blBlob, sFic )
If Not bOk Then
	stMessage.sTitre  	=  "Aide Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprise"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* Ecriture en local vers fichier destination.							  */
/*------------------------------------------------------------------*/
bOk = F_EcrireFichierBlob ( blBlob, sFicTmp)
If Not bOk Then
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprise"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE05"
	stMessage.sVar[1]		= sFicTmp
	F_Message ( stMessage )
	Return
End If

sRun = sRepWord + " " + sFicTmp

RUN ( sRun )


end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
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

iUoSpGsParamFtuBrk = CREATE u_sp_gs_param_ftu_brk

iUoSpGsParamFtuBrk.Uf_Initialisation ( iTrTrans , Dw_1, dw_2 )

dw_2.SetRowFocusIndicator ( p_Focus )
end event

on w_t_sp_param_ftu_brk.create
int iCurrent
call super::create
this.st_creation=create st_creation
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_cree_le=create dw_cree_le
this.p_focus=create p_focus
this.cb_aide=create cb_aide
this.cb_edb=create cb_edb
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_creation
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_cree_le
this.Control[iCurrent+5]=this.p_focus
this.Control[iCurrent+6]=this.cb_aide
this.Control[iCurrent+7]=this.cb_edb
end on

on w_t_sp_param_ftu_brk.destroy
call super::destroy
destroy(this.st_creation)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_cree_le)
destroy(this.p_focus)
destroy(this.cb_aide)
destroy(this.cb_edb)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
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

Destroy iUoSpGsParamFtuBrk
end event

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
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
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sDteDebEff, sDteFinEff		

sTab				= "~t"

sDteDebEff			=	String ( dw_1.GetItemDateTime ( 1, "DTE_DEB_EFF"  ), "dd/mm/yyyy " ) + " 00:00:00.00" // [PI056]
sDteFinEff			=	String ( dw_1.GetItemDateTime ( 1, "DTE_FIN_EFF"  ), "dd/mm/yyyy" ) + " 00:00:00.00" // [PI056]
	
isMajAccueil 	=	String(illastidtarif ) + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_PROD"  )) + sTab	+ &
						dw_1.GetItemString (1, "ALT_ACTIF") + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_GTI"  )) + sTab	+ &
						dw_1.GetItemString (1, "ID_BRK") + sTab	+ &
						dw_1.GetItemString (1, "ID_TYP_ART") + sTab	+ &
						sDteDebEff + sTab + sDteFinEff + sTab	 + &
						dw_1.GetItemString (1, "TYP_EFF") + sTab	+ &
						dw_1.GetItemString (1, "TYP_VETUSTE") 
						
end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
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
This.Width				= 3870
This.Height				= 2800 

end event

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk !! OVERRIDE !!
//* Evenement 		: ue_retour
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
		dw_1.setitem(1,"ID_TARIF",lNull)
		dw_1.SetItemStatus ( 1, 0, Primary!, New! )
		This.bringtotop = TRUE
	End if
End If

Return 0



end event

event hide;call super::hide;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: hide
//* Auteur			: F. Pinon
//* Date				: 02/03/2011 17:49:30
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

gWMdi.Width -=310
gWMdi.Height -=1070
iwparent.Height =1864
end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: Show
//* Auteur			: F. Pinon
//* Date				: 02/03/2011 17:49:30
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

gWMdi.Width +=310
gWMdi.Height +=1070
iwparent.Height=3000

wf_proteger()
end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::ue_creer
//* Auteur			: F. Pinon
//* Date				: 15/03/2011 10:45:06
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
Long lRow

lRow=dw_2.InsertRow(0)

dw_2.Scrolltorow( lRow)
dw_2.SetRow(lRow)
dw_2.selectrow( 0,FALSE)
end event

type cb_debug from w_traitement`cb_debug within w_t_sp_param_ftu_brk
integer y = 0
end type

type dw_1 from w_traitement`dw_1 within w_t_sp_param_ftu_brk
integer x = 46
integer y = 228
integer width = 3794
integer height = 1696
string dataobject = "d_sp_param_ftu_brk"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
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
Datetime dtNull

iAction	= 0
SetNull(dtNull)
sVal 		= This.GetText ( )

st_creation.Visible=FALSE

iAction = iUoSpGsParamFtuBrk.Uf_ControlerZone ( isNomCol, sVal )

if Upper(isNomCol) = "ALT_MODE_CREAT" Then wf_setmode_creation( FALSE)

If istPass.binsert and not isnull(dw_cree_le.GetItemDateTime(1,"CREE_LE") ) Then
	dw_cree_le.SetItem(1,"CREE_LE",dtNull)
	dw_cree_le.SetItem(1,"MAJ_LE",dtNull)
End if

Return iAction
end event

event dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
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

If sqldbcode =2601 Then // Cl$$HEX2$$e9002000$$ENDHEX$$d'index en double
	stMessage.berreurg=FALSE
	stMessage.scode="PATF003"
	stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises"
	f_message(stMessage)
End if

Return 1
end event

event dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: ?
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
 // 			FPI	03/06/2011	[PM02.RetourNC] Message pour erreur de produit
 //			FPI	26/06/2011	[PM02.29062011] Gestion de la zone id_prod en fonction de l'option DP 175
//*-----------------------------------------------------------------

Long ll_return, lPos

String sCols[]={"DTE_DEB_EFF","DTE_FIN_EFF","PER_CPLT", &
	"MT_PIVOT",  "MT_DECOTE","TX_DECOTE", &
	"MT_FORFAITAIRE","TX_TVA","ID_PROD"}
	
String sLibCols[]={"date de d$$HEX1$$e900$$ENDHEX$$but de validit$$HEX1$$e900$$ENDHEX$$","date de fin de validit$$HEX1$$e900$$ENDHEX$$", "p$$HEX1$$e900$$ENDHEX$$riode compl$$HEX1$$e900$$ENDHEX$$mentaire", &
	"tarif de reprise fixe", "montant de d$$HEX1$$e900$$ENDHEX$$cote num$$HEX1$$e900$$ENDHEX$$raire", "pourcentage de d$$HEX1$$e900$$ENDHEX$$cote", &
	"montant forfaitaire","taux de TVA","produit"}

ll_return=2

Choose Case Upper ( This.GetColumnName () ) 
	Case "DTE_DEB_EFF"
		stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but de validit$$HEX1$$e900$$ENDHEX$$"
		
		// Gestion pour l'override
		If This.GetText () = "" Then 
			This.SetItem ( 1, "DTE_DEB_EFF", stNul.dtm )
			This.TriggerEvent ("ItemChanged" )
			ll_return = 3
			ibErreur = FALSE
		Else
			ibErreur = TRUE
		End If
		isErrCol		= Upper ( This.GetColumnName () )

	Case "DTE_FIN_EFF"
		stMessage.scode = "GENE002"
		stMessage.sVar[1] = "date de fin de validit$$HEX1$$e900$$ENDHEX$$"
		
		// Gestion pour l'override
		If This.GetText () = "" Then 
			This.SetItem ( 1, "DTE_FIN_EFF", stNul.dtm )
			This.TriggerEvent ("ItemChanged" )
			ll_return = 3
			ibErreur = FALSE
		Else
			ibErreur = TRUE
		End If
		isErrCol		= Upper ( This.GetColumnName () )

	Case "TYP_MT_PIVOT"
		ibErreur = FALSE
		ll_return = This.Uf_Reinitialiser ()
	
	Case Else
		// Sinon on d$$HEX1$$e900$$ENDHEX$$clenche l'anc$$HEX1$$ea00$$ENDHEX$$tre, et la suite ci-dessous
		Call super::itemerror
End Choose 

If	ibErreur Then

	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	if This.iiErreur = 0 Then // Messages "est incorrect"
		stMessage.scode = "GENE003"
		
		For lPos = 1 To UpperBound(sCols)
		
			if isErrCol = sCols[lPos] Then
				stMessage.sVar[1] = sLibCols[lPos]
				if lPos < 4 Then stMessage.scode = "GENE002"
			
				 // [PM02.RetourNC]
				 if lPos=9 Then 
					 stMessage.scode="PATF020"
					stMessage.bErreurG	= FALSE
				End if
			End if
		Next
	Else
		// [PM02.29062011]
		Choose Case isErrCol
			
		Case "ID_PROD"
			Choose Case This.iiErreur
			Case 1
				// Les stMessage.sVar sont d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "PATF021"
	
			End Choose

		End Choose
		// :[PM02.29062011]
		
	End if
	
	F_Message ( stMessage )

	ll_return = This.Uf_Reinitialiser ()
End If

Return ll_return
end event

type st_titre from w_traitement`st_titre within w_t_sp_param_ftu_brk
boolean visible = false
integer y = 0
end type

type pb_retour from w_traitement`pb_retour within w_t_sp_param_ftu_brk
integer y = 48
integer width = 274
integer height = 160
end type

type pb_valider from w_traitement`pb_valider within w_t_sp_param_ftu_brk
integer y = 48
integer width = 274
integer height = 160
end type

type pb_imprimer from w_traitement`pb_imprimer within w_t_sp_param_ftu_brk
boolean visible = false
integer x = 2738
integer y = 16
integer width = 274
integer height = 160
end type

type pb_controler from w_traitement`pb_controler within w_t_sp_param_ftu_brk
integer y = 48
integer width = 274
integer height = 160
end type

type pb_supprimer from w_traitement`pb_supprimer within w_t_sp_param_ftu_brk
integer y = 48
integer width = 274
integer height = 160
end type

type st_creation from statictext within w_t_sp_param_ftu_brk
integer x = 1170
integer y = 92
integer width = 1486
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
boolean focusrectangle = false
end type

type dw_2 from u_datawindow_detail within w_t_sp_param_ftu_brk
integer x = 69
integer y = 2040
integer width = 2935
integer height = 580
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sp_param_ftu_brk_vts"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;// !! OVERRIDE

If Row > 0 Then
	SelectRow(0, False)
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue
end event

event ue_modifiermenu;call super::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_ftu_brk::ue_modifiermenu
//* Auteur			: F. Pinon
//* Date				: 15/03/2011 10:52:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*16777215
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
This.Uf_Mnu_SupprimerItem ( 2 )

If This.Getselectedrow( 0) =  0 Then
	This.uf_mnu_interdiritem(3)
Else
	This.uf_mnu_autoriseritem( 3)
End if

end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 14/03/2011
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

iAction = iUoSpGsParamFtuBrk.uf_controlerzone_vts(row, isNomCol, sVal )

Return iAction
end event

event itemerror;call super::itemerror;Long ll_return, lPos

String sCols[]={"IE_MT_PIVOT_MIN","IE_MT_PIVOT_MAX",  &
	"MT_PIVOT_MIN","MT_PIVOT_MAX", "TX_REPRISE",  &
	"PERIODE_MIN_J", "PERIODE_MAX_J" 	}
	
String sLibCols[]={"type d'inclusion du montant pivot minimum","type d'inclusion du montant pivot maximum",  &
	"montant pivot minimum", "montant pivot maximum", "taux de reprise", & 
	"p$$HEX1$$e900$$ENDHEX$$riode minimum","p$$HEX1$$e900$$ENDHEX$$riode maximum"}

ll_return=2

If	ibErreur Then

	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	if This.iiErreur = 0 Then // Messages "est incorrect"
		stMessage.scode = "GENE003"
		For lPos = 1 To UpperBound(sCols)
			if isErrCol = sCols[lPos] Then
				stMessage.sVar[1] = sLibCols[lPos]
				if lPos > 5 Then stMessage.scode = "GENE002"
			End if
		Next
	Else
		/* Exemple
		Choose Case isErrCol
			
		Case "DTE_SURV_DATE"
			Choose Case This.iiErreur
			Case 1
				stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date inf$$HEX1$$e900$$ENDHEX$$rieure au 01/01/1994
				stMessage.sCode	= "GENE002"
	
			Case 2
				stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date de survenance > Date de d$$HEX1$$e900$$ENDHEX$$claration
				stMessage.sVar[2] = "inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
				stMessage.sVar[3] = "date de d$$HEX1$$e900$$ENDHEX$$claration"
				stMessage.bErreurG= False
				stMessage.sCode	= "WSIN140"
	
			
	
			End Choose

		End Choose
				*/
	End if
	
	F_Message ( stMessage )

	ll_return = This.Uf_Reinitialiser ()
End If

Return ll_return
end event

type st_1 from statictext within w_t_sp_param_ftu_brk
integer x = 69
integer y = 1952
integer width = 2935
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 10789024
string text = "Tranche montant pivot/v$$HEX1$$e900$$ENDHEX$$tust$$HEX1$$e900$$ENDHEX$$/Taux de reprise"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_cree_le from datawindow within w_t_sp_param_ftu_brk
integer x = 3013
integer y = 2056
integer width = 805
integer height = 464
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sp_cree_le"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_focus from picture within w_t_sp_param_ftu_brk
boolean visible = false
integer x = 535
integer y = 2124
integer width = 91
integer height = 76
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type cb_aide from commandbutton within w_t_sp_param_ftu_brk
integer x = 3451
integer y = 148
integer width = 279
integer height = 88
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aide"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 01/04/2011 11:29:40
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


wf_afficher_doc( K_NOMFIC_AIDE )
end event

type cb_edb from commandbutton within w_t_sp_param_ftu_brk
integer x = 3451
integer y = 48
integer width = 279
integer height = 88
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "EDB DPG"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_ftu_brk
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 01/04/2011 11:29:40
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


wf_afficher_doc( K_NOMFIC_EDB )

end event

