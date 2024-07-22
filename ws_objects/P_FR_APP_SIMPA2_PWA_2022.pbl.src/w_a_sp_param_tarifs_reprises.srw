HA$PBExportHeader$w_a_sp_param_tarifs_reprises.srw
forward
global type w_a_sp_param_tarifs_reprises from w_8_accueil
end type
type pb_extraire from picturebutton within w_a_sp_param_tarifs_reprises
end type
end forward

global type w_a_sp_param_tarifs_reprises from w_8_accueil
integer width = 3538
integer height = 1504
string title = "Accueil - Gestion des tarifs de reprises des mat$$HEX1$$e900$$ENDHEX$$riels sinistr$$HEX1$$e900$$ENDHEX$$s"
pb_extraire pb_extraire
end type
global w_a_sp_param_tarifs_reprises w_a_sp_param_tarifs_reprises

type variables
s_Interro	istInterroHisto
end variables

forward prototypes
private function boolean wf_droit_modif ()
private subroutine wf_split (string aschaine, string asseparateur, ref string astab[])
end prototypes

private function boolean wf_droit_modif ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_a_sp_param_tarifs_reprises::wf_droit_modif
//* Auteur			: F. Pinon
//* Date				: 14/04/2011 14:45:26
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
Long 		lTotLigne

/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 220 pour l'op$$HEX1$$e900$$ENDHEX$$rateur */
/* connect$$HEX60$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 220		AND
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

on w_a_sp_param_tarifs_reprises.create
int iCurrent
call super::create
this.pb_extraire=create pb_extraire
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_extraire
end on

on w_a_sp_param_tarifs_reprises.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_extraire)
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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
itrTrans=SQLCA

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche de tarifs de reprises de mat$$HEX1$$e900$$ENDHEX$$riel"
pb_Interro.istInterro.sDataObject			= "d_sp_int_param_ftu_brk"
pb_Interro.istInterro.sCodeDw					= "PARAM_TARIF_REPRISE"

pb_Interro.istInterro.sData[1].sNom			= "id_tarif"
pb_Interro.istInterro.sData[1].sDbName		= "id_tarif"
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

pb_Interro.istInterro.sData[4].sNom			= "id_broker"
pb_Interro.istInterro.sData[4].sDbName		= "id_broker"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "id_code_art"
pb_Interro.istInterro.sData[5].sDbName		= "id_code_art"
pb_Interro.istInterro.sData[5].sType		= "STRING"
pb_Interro.istInterro.sData[5].sOperande	= "="

pb_Interro.istInterro.sData[6].sNom			= "id_cie"
pb_Interro.istInterro.sData[6].sDbName		= "id_cie"
pb_Interro.istInterro.sData[6].sType		= "NUMBER"
pb_Interro.istInterro.sData[6].sOperande	= "="
pb_Interro.istInterro.sData[6].sMoteur		= "MSS"

pb_Interro.istInterro.sData[7].sNom			= "id_police"
pb_Interro.istInterro.sData[7].sDbName		= "id_police"
pb_Interro.istInterro.sData[7].sType		= "NUMBER"
pb_Interro.istInterro.sData[7].sOperande	= "="
pb_Interro.istInterro.sData[7].sMoteur		= "MSS"

pb_Interro.istInterro.sData[8].sNom			= "id_marq_art"
pb_Interro.istInterro.sData[8].sDbName		= "id_marq_art"
pb_Interro.istInterro.sData[8].sType		= "STRING"
pb_Interro.istInterro.sData[8].sOperande	= "="

pb_Interro.istInterro.sData[9].sNom			= "id_modl_art"
pb_Interro.istInterro.sData[9].sDbName		= "id_modl_art"
pb_Interro.istInterro.sData[9].sType		= "STRING"
pb_Interro.istInterro.sData[9].sOperande	= "="


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE		// Utilisation du bouton Controler

pb_creer.Visible=wf_droit_modif( )
end event

event ue_fin_interro;
//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises !! OVERRIDE !!
//* Evenement 		: ue_fin_interro
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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

String sClause, sDate
s_Pass stPass
String sCritere[], sVal[]
Int iPos
String sIdBroker, sIdCodeArt, sIdMarqArt, sIdModlArt
Decimal{0} dcIdProd, dcIdGti, dcIdCie, dcIdPolice
Date	dtMajLe
Long lIdTarif

SetPointer( HourGlass! )

// Init
SetNull(sIdBroker)
SetNull(sIdCodeArt)
SetNull(dcIdProd)
SetNull(dcIdGti)
SetNull(dcIdCie)
SetNull(dcIdPolice)
SetNull(lIdTarif)
SetNull(sIdMarqArt)
SetNull(sIdModlArt)

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
		Case "id_tarif"
			lIdTarif=Long(sCritere[2])
			if lIdTarif=0 Then SetNull(lIdTarif)
		Case "id_broker"
			sIdBroker=sCritere[2]
			sIdBroker=Mid(sIdBroker, 2, Len(sIdBroker) - 2)
			if sIdBroker="*" Then SetNull(sIdBroker)
		Case "id_gti"
			dcIdGti=Dec(sCritere[2])
			if dcIdGti=0 Then SetNull(dcIdGti)
		Case "id_code_art"
			sIdCodeArt=sCritere[2]
			sIdCodeArt=Mid(sIdCodeArt, 2, Len(sIdCodeArt) - 2)
			if sIdCodeArt="*" Then SetNull(sIdCodeArt)
		Case "id_marq_art"
			sIdMarqArt=sCritere[2]
			sIdMarqArt=Mid(sIdMarqArt, 2, Len(sIdMarqArt) - 2)
			if sIdMarqArt="*" Then SetNull(sIdMarqArt)
		Case "id_modl_art"
			sIdModlArt=sCritere[2]
			sIdModlArt=Mid(sIdModlArt, 2, Len(sIdModlArt) - 2)
			if sIdModlArt="*" Then SetNull(sIdModlArt)
		Case "id_cie"
			dcIdCie=Dec(sCritere[2])
			if dcIdCie=0 Then SetNull(dcIdCie)
		Case "id_police"
			dcIdPolice=Dec(sCritere[2])
			if dcIdPolice=0 Then SetNull(dcIdPolice)
		End Choose
Next

dw_1.Retrieve (lIdTarif,dcIdProd,dcIdGti, sIdBroker, sIdCodeArt, sIdMarqArt, sIdModlArt, dcIdCie, dcIdPolice)



This.TriggerEvent( "Ue_TaillerHauteur" )

dw_1.SetFocus ()
end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises
//* Evenement 		: ue_preparer_interro
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge les datawindow de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interroration.
//* Commentaires	:	Chargement des produits et des garantie
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcProd	// DDDW des produits.
DataWindowChild	dwcGti	// DDDW des garanties.
DataWindowChild	dwcFour	// DDDW des fournisseurs.
DataWindowChild	dwcProcess	// DDDW des process

w_interro.dw_1.GetChild ( "id_prod", dwcProd )
dwcProd.SetTransObject ( itrTrans )
dwcProd.Retrieve()

w_interro.dw_1.GetChild ( "id_gti", dwcGti )
dwcGti.SetTransObject ( itrTrans )
dwcGti.Retrieve()

w_interro.dw_1.GetChild ( "id_broker", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )

w_interro.dw_1.GetChild ( "id_code_art", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )

w_interro.dw_1.GetChild ( "id_marq_art", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )

w_interro.dw_1.GetChild ( "id_modl_art", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )


w_interro.dw_1.GetChild ( "id_cie", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )

w_interro.dw_1.GetChild ( "id_police", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( )
end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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

istPass.bInsert = True

f_OuvreTraitement ( W_T_Sp_Param_ftu_brk, istPass )
end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises
//* Evenement 		: ue_modifier
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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

istPass.bInsert = False

istPass.sTab[1] 	= String(dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_TARIF" ))

istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Sp_Param_ftu_brk, istPass ) 


end event

event ue_enablefenetre;call super::ue_enablefenetre;this.height=1864
this.triggerEvent("ue_taillerhauteur")
end event

type cb_debug from w_8_accueil`cb_debug within w_a_sp_param_tarifs_reprises
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_param_tarifs_reprises
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_param_tarifs_reprises
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_param_tarifs_reprises
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_param_tarifs_reprises
integer x = 27
integer width = 2999
integer height = 580
string dataobject = "d_sp_a_param_tarifs_reprises"
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_tarifs_reprises
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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

This.SetTransObject(SQLCA)
This.iitmheight = 16
end event

type pb_tri from w_8_accueil`pb_tri within w_a_sp_param_tarifs_reprises
boolean visible = false
integer x = 1847
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_param_tarifs_reprises
integer x = 2089
end type

type pb_extraire from picturebutton within w_a_sp_param_tarifs_reprises
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
//* Objet			: w_a_sp_param_tarifs_reprises::pb_extraire
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 01/03/2011
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

stMessage.sTitre  	= "Extraction du param$$HEX1$$e900$$ENDHEX$$trage des tarifs"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!

// 1$$HEX2$$b0002000$$ENDHEX$$m$$HEX1$$e900$$ENDHEX$$thode : 1 seul fichier
bRet=uo_extract_excel.uf_extract_excel({"d_lst_param_ftu_brk","d_lst_param_ftu_brk_vts"}, &
		{"d_lst_param_ftu_brk","d_lst_param_ftu_brk_vts"}, stglb.sreptempo + "PARAM_FTU_BRK.XLS")

If bRet Then
	stMessage.sVar[1] = stglb.sreptempo + "PARAM_FTU_BRK.XLS"
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "GENE013"
	stMessage.sVar[1] = "Le fichier" +  stglb.sreptempo + "PARAM_FTU_BRK.XLS" + " a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$."

	f_message(stMessage)
	Return
End if

// 2$$HEX2$$b0002000$$ENDHEX$$m$$HEX1$$e900$$ENDHEX$$thode : 2 fichiers
dsParamTarif = CREATE DataStore
dsParamTarif.dataobject="d_lst_param_ftu_brk"
dsParamTarif.SetTransObject(SQLCA)
dsParamTarif.Retrieve()

iRet = dsParamTarif.Saveas(stglb.sreptempo + "PARAM_FTU_BRK.XLS", Excel!,TRUE)


If iRet=1 Then
	dsParamTarif.dataobject="d_lst_param_ftu_brk_vts"
	dsParamTarif.SetTransObject(SQLCA)
	dsParamTarif.Retrieve()

	iRet = dsParamTarif.Saveas(stglb.sreptempo + "PARAM_FTU_BRK_VTS.XLS", Excel!,TRUE)
End if

stMessage.sVar[1] = stglb.sreptempo + "PARAM_FTU_BRK.XLS"
stMessage.sVar[2] = stglb.sreptempo + "PARAM_FTU_BRK_VTS.XLS"

If iRet = 1 Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "GENE013"
	stMessage.sVar[1] = "Les fichiers" + stMessage.sVar[1] + " et " + stMessage.sVar[2] + " ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s."
Else
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "ANCE008"
End if

Destroy dsParamTarif

f_message(stMessage)

end event

