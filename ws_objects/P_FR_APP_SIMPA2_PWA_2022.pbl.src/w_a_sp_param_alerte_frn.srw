$PBExportHeader$w_a_sp_param_alerte_frn.srw
$PBExportComments$[PM95]
forward
global type w_a_sp_param_alerte_frn from w_8_accueil
end type
type pb_extraire from picturebutton within w_a_sp_param_alerte_frn
end type
end forward

global type w_a_sp_param_alerte_frn from w_8_accueil
integer width = 3538
integer height = 1504
string title = "Accueil - Gestion des alertes fournisseurs"
pb_extraire pb_extraire
end type
global w_a_sp_param_alerte_frn w_a_sp_param_alerte_frn

type variables
s_Interro	istInterroHisto
end variables

forward prototypes
private function boolean wf_droit_modif ()
private subroutine wf_split (string aschaine, string asseparateur, ref string astab[])
end prototypes

private function boolean wf_droit_modif ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_a_sp_param_alerte_frn::wf_droit_modif
//* Auteur			: F. Pinon
//* Date				: 16/11/2011 14:45:26
//* Libellé			: 
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
Long 		lTotLigne

/*--------------------------------------------------------------------*/
/* La présence d'une ligne 222 pour l'opérateur */
/* connecté                                                           */   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 222		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;
 
 return (lTotLigne >0)
end function

private subroutine wf_split (string aschaine, string asseparateur, ref string astab[]);

String		sChaine
Long			lCpt, lPos

lCpt			=  1
lPos			= -1
sChaine		= RightTrim ( asChaine )

Do While	sChaine <> "" And lPos <> 0 

	lPos	= Pos ( sChaine, asSeparateur )
	If	lPos <> 0 Then
		asTab[ lCpt ]	= Trim ( Left ( sChaine, lPos -1) )
		sChaine			= Mid ( sChaine, lPos +  Len(asSeparateur), Len ( sChaine ) - lPos -  Len(asSeparateur) +1)
		lCpt ++
	Else
		asTab[ lCpt ] = Trim ( sChaine )
	End If
Loop
end subroutine

on w_a_sp_param_alerte_frn.create
int iCurrent
call super::create
this.pb_extraire=create pb_extraire
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_extraire
end on

on w_a_sp_param_alerte_frn.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_extraire)
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
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
itrTrans=SQLCA

/*------------------------------------------------------------------*/
/* Fenêtre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche de paramétrage alertes"
pb_Interro.istInterro.sDataObject			= "d_sp_int_param_alert_frn"
pb_Interro.istInterro.sCodeDw					= "PARAM_ALERTE_FRN"

pb_Interro.istInterro.sData[1].sNom			= "id_param"
pb_Interro.istInterro.sData[1].sDbName		= "id_param"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_prod"
pb_Interro.istInterro.sData[2].sDbName		= "id_prod"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom			= "id_gti"
pb_Interro.istInterro.sData[3].sDbName		= "id_gti"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="
pb_Interro.istInterro.sData[3].sMoteur		= "MSS"

pb_Interro.istInterro.sData[4].sNom			= "id_four"
pb_Interro.istInterro.sData[4].sDbName		= "id_four"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "id_alerte"
pb_Interro.istInterro.sData[5].sDbName		= "id_alerte"
pb_Interro.istInterro.sData[5].sType		= "NUMBER"
pb_Interro.istInterro.sData[5].sOperande	= "="
pb_Interro.istInterro.sData[5].sMoteur		= "MSS"


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des paramètres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE		// Utilisation du bouton Controler

pb_creer.Visible=wf_droit_modif( )

dw_1.ilMaxlig=0
end event

event ue_fin_interro;
//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn !! OVERRIDE !!
//* Evenement 		: ue_fin_interro
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
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

String sClause, sDate
s_Pass stPass
String sCritere[], sVal[]
Int iPos
String sIdFour
Decimal{0} dcIdProd, dcIdGti
Date	dtMajLe
Long lIdParam, lIdAlerte

SetPointer( HourGlass! )

// Init
SetNull(sIdFour)
SetNull(dcIdProd)
SetNull(dcIdGti)
SetNull(lIdParam)
SetNull(lIdAlerte)

stPass = Message.PowerObjectParm
sClause				= stPass.sTab[1]

If sClause = "" Then return 1

sClause=Mid(sClause,8)

//f_decomposerchaine(sClause," and ",sCritere)
wf_split(sClause," AND ",sVal)

For iPos=1 to upperbound(sVal)
	f_decomposerchaine(sVal[iPos],"=",sCritere)
	
	Choose case sCritere[1]
		Case "id_prod"
			dcIdProd=Dec(sCritere[2])
			if dcIdProd=0 Then SetNull(dcIdProd)
		Case "id_param"
			lIdParam=Long(sCritere[2])
			if lIdParam=0 Then SetNull(lIdParam)
		Case "id_four"
			sIdFour=sCritere[2]
			sIdFour=Mid(sIdFour, 2, Len(sIdFour) - 2)
			if sIdFour="*" Then SetNull(sIdFour)
		Case "id_gti"
			dcIdGti=Dec(sCritere[2])
			if dcIdGti=0 Then SetNull(dcIdGti)
		Case "id_alerte"
			lIdAlerte=Long(sCritere[2])
			if lIdAlerte=0 Then SetNull(lIdAlerte)
		End Choose
Next

dw_1.Retrieve (lIdParam,dcIdProd,dcIdGti, sIdFour, lIdAlerte) 

This.TriggerEvent( "Ue_TaillerHauteur" )

dw_1.SetFocus ()
end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn
//* Evenement 		: ue_preparer_interro
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			:	Charge les datawindow de la fenêtre d'interroration.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcProd	// DDDW des produits.
DataWindowChild	dwcGti	// DDDW des garanties.
DataWindowChild	dwcFour	// DDDW des fournisseurs.
DataWindowChild	dwcAlerte	// DDDW des alertes

w_interro.dw_1.GetChild ( "id_prod", dwcProd )
dwcProd.SetTransObject ( itrTrans )
dwcProd.Retrieve("ID_PROD")

w_interro.dw_1.GetChild ( "id_gti", dwcGti )
dwcGti.SetTransObject ( itrTrans )
dwcGti.Retrieve("ID_GTI")

w_interro.dw_1.GetChild ( "id_four", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve("-10" )

w_interro.dw_1.GetChild ( "id_alerte", dwcAlerte )
dwcAlerte.SetTransObject ( itrTrans )
dwcAlerte.Retrieve( )
end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
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

istPass.bInsert = True

f_OuvreTraitement ( W_T_Sp_Param_alerte_frn, istPass )
end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn
//* Evenement 		: ue_modifier
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
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

istPass.bInsert = False

istPass.sTab[1] 	= String(dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PARAM" ))

istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Sp_Param_alerte_frn, istPass ) 


end event

type cb_debug from w_8_accueil`cb_debug within w_a_sp_param_alerte_frn
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_param_alerte_frn
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_param_alerte_frn
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_param_alerte_frn
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_param_alerte_frn
integer x = 233
integer width = 2866
integer height = 580
string dataobject = "d_sp_a_param_alerte_frn"
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
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

This.SetTransObject(SQLCA)
This.iitmheight = 16
end event

type pb_tri from w_8_accueil`pb_tri within w_a_sp_param_alerte_frn
boolean visible = false
integer x = 1847
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_param_alerte_frn
integer x = 2089
end type

type pb_extraire from picturebutton within w_a_sp_param_alerte_frn
integer x = 827
integer y = 16
integer width = 242
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Extraire"
string picturename = "K:\PB4OBJ\BMP\excel2.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_alerte_frn::pb_extraire
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 16/11/2011
//* Libellé			: 
//* Commentaires	: TODO
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Datastore dsParamTarif
Long lNull
String sNull
Date dtNull
Integer iRet
u_sp_gs_extract_excel uo_extract_excel
Boolean bRet

SetNull(lNull)
SetNull(sNull)
SetNull(dtNull)

stMessage.sTitre  	= "Extraction du paramétrage des alertes fournisseurs"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!


dsParamTarif = CREATE DataStore
dsParamTarif.dataobject="d_lst_param_alerte_frn"
dsParamTarif.SetTransObject(SQLCA)
dsParamTarif.Retrieve()

iRet = dsParamTarif.Saveas(stglb.sreptempo + "PARAM_ALERTE_FRN.XLS", Excel8!,TRUE) // [MIG_PB2022]

stMessage.sVar[1] = stglb.sreptempo + "PARAM_ALERTE_FRN.XLS"

If iRet = 1 Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "GENE013"
	stMessage.sVar[1] = "Le fichier" + stMessage.sVar[1] + " est généré."
Else
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "ANCE008"
End if

Destroy dsParamTarif

f_message(stMessage)

end event

