HA$PBExportHeader$w_t_sp_param_alerte_frn.srw
$PBExportComments$[PM95] Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail pour le param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs
forward
global type w_t_sp_param_alerte_frn from w_traitement
end type
type st_creation from statictext within w_t_sp_param_alerte_frn
end type
type p_focus from picture within w_t_sp_param_alerte_frn
end type
type cb_aide from commandbutton within w_t_sp_param_alerte_frn
end type
type cb_edb from commandbutton within w_t_sp_param_alerte_frn
end type
end forward

global type w_t_sp_param_alerte_frn from w_traitement
integer width = 3593
integer height = 1804
string title = "Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
boolean ibmajaccueil = true
event type long ue_supprimerdetail ( unsignedlong wparm,  long lparm )
st_creation st_creation
p_focus p_focus
cb_aide cb_aide
cb_edb cb_edb
end type
global w_t_sp_param_alerte_frn w_t_sp_param_alerte_frn

type variables
u_sp_gs_param_alerte_frn iUoSpGsParamAlerteFrn
Long ilLastIdTarif

Constant String K_NOMFIC_AIDE="DOC_PM95"
Constant String K_NOMFIC_EDB="EDB_DPG_PM95"
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
public function boolean wf_preparerabandonner ()
private subroutine wf_afficher_doc (string asnomfichier)
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_preparermodifier
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: TODO
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
DatawindowChild dwcChild
Decimal dcIdProd, dcIdGti
Integer iIdAlerte

sIdSeq = istPass.sTab[1]

pb_supprimer.Visible=TRUE
st_creation.Visible=FALSE

dw_1.Retrieve(long(sIdSeq))

//dw_1.Modify("ALT_ACTIF.CheckBox.Text='Alerte active (ID=" + string(dw_1.GetItemnumber( 1, "ID_PARAM")) + ")'")

// Maj des ddw
dcIdProd = dw_1.getItemDecimal( 1, "ID_PROD")
dcIdGti = dw_1.getItemDecimal( 1, "ID_GTI")
iIdAlerte = dw_1.GetItemNumber( 1, "ID_ALERTE")

dw_1.getchild( "ID_PROD", dwcChild )		
dwcChild.Retrieve()

dw_1.getchild( "ID_GTI", dwcChild )		
dwcChild.Retrieve(dcIdProd)
	
dw_1.getchild( "ID_FOUR", dwcChild )		
dwcChild.Retrieve(dcIdProd, dcIdGti)

dw_1.getchild( "ID_ALERTE", dwcChild )		
dwcChild.Retrieve()

iUoSpGsParamAlerteFrn.uf_controlerzone( "ID_ALERTE", String(iIdAlerte) )

// Protection des zones	
iUoSpGsParamAlerteFrn.uf_proteger_modif( )

dw_1.object.alt_mode_creat.Visible=TRUE
dw_1.object.alt_reinit.Visible=FALSE

This.Title="Modification de param$$HEX1$$e900$$ENDHEX$$trage alerte fournisseur"

Return TRUE
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_preparerinserer
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

iUoSpGsParamAlerteFrn.uf_reinitialiser( )

dw_1.setcolumn( "ID_PROD")

wf_setmode_creation( FALSE )

dw_1.SetItem( 1, "MAJ_PAR", stglb.scodoper )
dw_1.Modify("ALT_ACTIF.CheckBox.Text='Alerte active'")

Return TRUE
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_controlersaisie
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
//*-----------------------------------------------------------------
String sPos

sPos= iUoSpGsParamAlerteFrn.uf_controler_oblig( )


Return sPos
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_controlergestion
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

sPos = iUoSpGsParamAlerteFrn.uf_controler( )

if sPos <> "" Then 
	idwcontrole=dw_1
End if

Return sPos
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_preparersupprimer
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: TODO
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
stMessage.sTitre 		= "Suppression d'un param$$HEX1$$e900$$ENDHEX$$trage d'alerte fournisseur"
stMessage.bErreurG=FALSE
stMessage.Bouton		= YesNo!
stMessage.Icon			= Question!
stMessage.sCode		= "PAAF004"

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
//* Fonction		: w_t_sp_param_alerte_frn::wf_valider
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
		st_creation.Text="Cr$$HEX1$$e900$$ENDHEX$$ation en base r$$HEX1$$e900$$ENDHEX$$ussie (ID=" + string(dw_1.GetItemnumber( 1, "ID_PARAM")) + ")"
		if dw_1.GetItemString(1,"ALT_REINIT") = "O" Then 
			iUoSpGsParamAlerteFrn.uf_reinitialiser( )
			wf_setmode_creation( FALSE )
		Else
			wf_setmode_creation( FALSE )
		End if
		
		dw_1.SetItem(1,"CREE_LE",dtNow)
	Else
		st_creation.Text="Modification en base r$$HEX1$$e900$$ENDHEX$$ussie"
	End if
	st_creation.Textcolor = 32768
	dw_1.SetItem(1,"MAJ_LE",dtNow)
Else
	If istpass.binsert Then
		st_creation.Text="Echec de cr$$HEX1$$e900$$ENDHEX$$ation du param$$HEX1$$e900$$ENDHEX$$trage"
	Else
		st_creation.Text="Echec de modification du param$$HEX1$$e900$$ENDHEX$$trage"
	End if
	st_creation.Textcolor = 255
End if

st_creation.Visible=TRUE

Dw_1.Getchild("id_prod",dwChild)
dwChild.Retrieve()

wf_pb_ctl_vld(0)

Return bRet
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_preparervalider
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
//* Fonction		: w_t_sp_param_alerte_frn::wf_proteger
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 222 pour l'op$$HEX1$$e900$$ENDHEX$$rateur */
/* connect$$HEX60$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 222		AND
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

Else
   pb_controler.enabled = TRUE
   pb_valider.enabled = TRUE
   pb_supprimer.enabled = TRUE
End If





end subroutine

private subroutine wf_setmode_creation (boolean bpassmodif);//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_setmode_creation
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
	This.Title="Modification d'alerte fournisseur"
	dw_1.object.alt_mode_creat.Visible=TRUE
	dw_1.SetItem(1,"ALT_MODE_CREAT","N")
	pb_supprimer.Visible=TRUE
	pb_supprimer.Enabled=TRUE
	
	iuospgsparamalertefrn.uf_proteger_modif( )
	
	istpass.binsert = FALSE
Else
	This.Title="Cr$$HEX1$$e900$$ENDHEX$$ation d'alerte fournisseur"
	pb_supprimer.Visible=FALSE
	dw_1.setItem( 1,"id_Param",lNull)
	dw_1.setItemStatus( 1, 0, Primary!,New!)
	
	istpass.binsert = TRUE
	
	dw_1.Modify("ALT_ACTIF.CheckBox.Text='Alerte active'")
	
	dw_1.uf_proteger ( {"ID_PROD","ID_GTI","ID_FOUR","ID_ALERTE","ALT_ACTIF","DEL_EXTR_J","RELANCE_2"}, "0")

End if

wf_Pb_Ctl_Vld(0)


end subroutine

public function boolean wf_suite_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_suite_valider
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
//* Fonction		: w_t_sp_param_alerte_frn::wf_executervalider
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
Long lRow, lIdParam

bRet=super::wf_executervalider( )

If bRet Then
	
	lIdParam = dw_1.GetItemNumber(1,"ID_PARAM")
	ilLastidtarif=lIdParam
End if

Return bRet

end function

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_param_alerte_frn::wf_preparerabandonner
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On a cliqu$$HEX2$$e9002000$$ENDHEX$$sur retour. On demande confirmation.
//*
//* Arguments		: TODO
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
stmessage.scode="PAAF003"
stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"

bRet=(f_message(stMessage) = 1)

Return bRet



end function

private subroutine wf_afficher_doc (string asnomfichier);//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: wf_afficher_doc
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If


sRepWord = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", "REP_WORD", "" )
/*------------------------------------------------------------------*/
/* Le chemin o$$HEX2$$f9002000$$ENDHEX$$trouver word est vide.                              */
/*------------------------------------------------------------------*/
If sRepWord = "" Then 
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des aletres fournisseurs"
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
		stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
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
	stMessage.sTitre  	=  "Aide Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
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
	stMessage.sTitre  	= "Aide Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
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
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

iUoSpGsParamAlerteFrn = CREATE u_sp_gs_param_alerte_frn

iUoSpGsParamAlerteFrn.Uf_Initialisation ( iTrTrans , Dw_1 )

end event

on w_t_sp_param_alerte_frn.create
int iCurrent
call super::create
this.st_creation=create st_creation
this.p_focus=create p_focus
this.cb_aide=create cb_aide
this.cb_edb=create cb_edb
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_creation
this.Control[iCurrent+2]=this.p_focus
this.Control[iCurrent+3]=this.cb_aide
this.Control[iCurrent+4]=this.cb_edb
end on

on w_t_sp_param_alerte_frn.destroy
call super::destroy
destroy(this.st_creation)
destroy(this.p_focus)
destroy(this.cb_aide)
destroy(this.cb_edb)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

Destroy iUoSpGsParamAlerteFrn
end event

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: ue_majaccueil
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
String	sDteCreeLe, sDteMajLe, sLibGti, sLibAlerte
DatawindowChild dwcChild
Long lRow

sTab				= "~t"
sDteCreeLe			=	String ( dw_1.GetItemDateTime ( 1, "CREE_LE"  ), "dd/mm/yyyy hh:mm:ss" ) //+ " 00:00:00.00"
sDteMajLe			=	String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy hh:mm:ss" ) //+ " 00:00:00.00"

sLibGti=""
dw_1.GetChild("ID_GTI",dwcChild)
lRow=dwcChild.Find("ID_GTI=" +String(dw_1.GetItemNumber(1,"ID_GTI")), 1,dwcChild.RowCount( ))
If lRow > 0 Then
	sLibGti=dwcChild.GetItemString( lRow, "LIB_GTI")
End if

sLibAlerte=""
dw_1.GetChild("ID_ALERTE",dwcChild)
lRow=dwcChild.Find("ID_ALERTE=" +String(dw_1.GetItemNumber(1,"ID_ALERTE")), 1,dwcChild.RowCount( ))
If lRow > 0 Then
	sLibAlerte=dwcChild.GetItemString( lRow, "NAT_ALERTE")
End if

isMajAccueil 	=	String(illastidtarif ) + sTab	+ &
						dw_1.GetItemString (1, "ALT_ACTIF") + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_PROD"  )) + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_GTI"  )) + sTab	+ &
						dw_1.GetItemString (1, "ID_FOUR") + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "ID_ALERTE"  )) + sTab	+ &
						String(dw_1.GetItemNumber ( 1, "DEL_EXTR_J"  )) + sTab	+ &
						dw_1.GetItemString (1, "RELANCE_2") + sTab	+ &
						sDteCreeLe + sTab	+ &						
						sDteMajLe + sTab	+ &						
						dw_1.GetItemString (1, "MAJ_PAR") + sTab	+ &					
						sLibGti + sTab	+ &						
						sLibAlerte 
						
end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

end event

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn !! OVERRIDE !!
//* Evenement 		: ue_retour
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
		dw_1.setitem(1,"ID_PARAM",lNull)
		dw_1.SetItemStatus ( 1, 0, Primary!, New! )
		This.bringtotop = TRUE
	End if
End If

Return 0



end event

event hide;call super::hide;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: hide
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
/*
gWMdi.Width -=310
gWMdi.Height -=1070*/
end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: Show
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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
/*
gWMdi.Width +=310
gWMdi.Height +=1070
*/
wf_proteger()
end event

type cb_debug from w_traitement`cb_debug within w_t_sp_param_alerte_frn
integer y = 0
end type

type dw_1 from w_traitement`dw_1 within w_t_sp_param_alerte_frn
integer x = 0
integer y = 212
integer width = 3557
integer height = 1448
string dataobject = "d_sp_param_alerte_frn"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
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

iAction = iUoSpGsParamAlerteFrn.Uf_ControlerZone ( isNomCol, sVal )

if Upper(isNomCol) = "ALT_MODE_CREAT" Then wf_setmode_creation( FALSE)

If istPass.binsert and not isnull(dw_1.GetItemDateTime(1,"CREE_LE") ) Then
	dw_1.SetItem(1,"CREE_LE",dtNull)
	dw_1.SetItem(1,"MAJ_LE",dtNull)
End if

Return iAction
end event

event dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: dberror
//* Auteur			: F. Pinon
//* Date				: 18/10/2010 14:20:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: TODO
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
	stMessage.scode="PAAF005"
	stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
	f_message(stMessage)
End if

Return 1
end event

event dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: TODO
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
	Case ""
	Case Else
		// Sinon on d$$HEX1$$e900$$ENDHEX$$clenche l'anc$$HEX1$$ea00$$ENDHEX$$tre, et la suite ci-dessous
		Call super::itemerror
End Choose 

If	ibErreur Then

	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	if This.iiErreur = 0 Then // Messages "est incorrect"
		If isErrcol="DEL_EXTR_J" Then 
			stMessage.sVar[1] = "d$$HEX1$$e900$$ENDHEX$$lai d'extraction"
			stMessage.scode = "GENE003"
		End if
	Else
		// Autres messages
		
	End if
	
	F_Message ( stMessage )

	ll_return = This.Uf_Reinitialiser ()
End If

Return ll_return
end event

type st_titre from w_traitement`st_titre within w_t_sp_param_alerte_frn
boolean visible = false
integer y = 0
end type

type pb_retour from w_traitement`pb_retour within w_t_sp_param_alerte_frn
integer y = 48
integer width = 274
integer height = 160
end type

type pb_valider from w_traitement`pb_valider within w_t_sp_param_alerte_frn
integer y = 48
integer width = 274
integer height = 160
end type

type pb_imprimer from w_traitement`pb_imprimer within w_t_sp_param_alerte_frn
boolean visible = false
integer x = 2738
integer y = 16
integer width = 274
integer height = 160
end type

type pb_controler from w_traitement`pb_controler within w_t_sp_param_alerte_frn
integer y = 48
integer width = 274
integer height = 160
end type

type pb_supprimer from w_traitement`pb_supprimer within w_t_sp_param_alerte_frn
integer y = 48
integer width = 274
integer height = 160
end type

type st_creation from statictext within w_t_sp_param_alerte_frn
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

type p_focus from picture within w_t_sp_param_alerte_frn
boolean visible = false
integer x = 535
integer y = 2124
integer width = 91
integer height = 76
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type cb_aide from commandbutton within w_t_sp_param_alerte_frn
integer x = 3218
integer y = 304
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
//* Objet			: w_t_sp_param_alerte_frn
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 16/11/2011 11:29:40
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

type cb_edb from commandbutton within w_t_sp_param_alerte_frn
integer x = 3218
integer y = 204
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
//* Objet			: w_t_sp_param_alerte_frn
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

