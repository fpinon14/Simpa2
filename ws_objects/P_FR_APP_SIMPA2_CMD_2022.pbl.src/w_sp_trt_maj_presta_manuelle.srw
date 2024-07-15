HA$PBExportHeader$w_sp_trt_maj_presta_manuelle.srw
$PBExportComments$[PM103]
forward
global type w_sp_trt_maj_presta_manuelle from window
end type
type cb_annuler from commandbutton within w_sp_trt_maj_presta_manuelle
end type
type cb_valider from commandbutton within w_sp_trt_maj_presta_manuelle
end type
type dw_1 from u_datawindow within w_sp_trt_maj_presta_manuelle
end type
type st_group from structure within w_sp_trt_maj_presta_manuelle
end type
type st_zone from structure within w_sp_trt_maj_presta_manuelle
end type
end forward

type st_group from structure
	string		sgbname
	st_zone		szones[]
end type

type st_zone from structure
	string		snomzone
	boolean		bzonereelle
end type

global type w_sp_trt_maj_presta_manuelle from window
integer width = 3538
integer height = 2296
boolean titlebar = true
string title = "Maj Prestation manuelle"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_annuler cb_annuler
cb_valider cb_valider
dw_1 dw_1
end type
global w_sp_trt_maj_presta_manuelle w_sp_trt_maj_presta_manuelle

type variables
u_datawindow idwCommande
datawindow idwDetPro
Long ilIdProd

private:
st_Group istGroupes[]
end variables

forward prototypes
private subroutine wf_regle_affichage ()
private subroutine wf_cacher (string aslistezone[])
private subroutine wf_init_groupes ()
public subroutine wf_arrangedw ()
private function boolean wf_controler_gestion ()
private function any wf_create_lst_zone (string aslstzones[])
public function boolean wf_valider ()
private function boolean wf_set_valeur (string asnomzone, boolean abzonereelle, any avaleur, string svaleur)
private subroutine wf_fill_fields ()
private function string wf_get_valeur (string asnomzone)
end prototypes

private subroutine wf_regle_affichage ();String sIdRefFour, sIdTypArt, sIdFour, sFilter
Long lDeb, lFin
DataWindowChild ldwc
Boolean bCarrefourCV

bCarrefourCV=FALSE

sIdRefFour=idwcommande.GetItemString(1,"ID_REF_FOUR")
sIdFour=idwcommande.GetItemString(1,"ID_FOUR")
sIdTypArt=idwcommande.GetItemString(1,"ID_TYP_ART")

// R$$HEX1$$e800$$ENDHEX$$gles de visibilit$$HEX1$$e900$$ENDHEX$$
If sIdRefFour <> "A_DIAGNOSTIQUER" And sIdTypArt <> "PRS" Then
	wf_cacher({"DTE_RCP_FRN","APP_INCOMPLET","RETOUR_153","RETOUR_154"})
End if

If sIdTypArt = "EDI" or sIdTypArt="PRS" Then
	wf_cacher( {"MT_TTC_CMDE","ID_SERIE_NOUV"} )
End if

If sIdFour <> "GAM" Then
	wf_cacher( {"NO_BON"} )
End if

If not ( (sIdFour = "SB1" or sIdFour="O2M") And sIdRefFour="A_DIAGNOSTIQUER") Then
	wf_cacher( {"SYMP_NON_DETEC_EN_24H"} )
End if

If not ( (sIdFour = "SB1" or sIdFour="O2M" or sIdFour="MS1") And sIdRefFour="A_DIAGNOSTIQUER") Then
	wf_cacher( {"RDV_CONF"} )
End if

If not (sIdFour="PSM" and sIdTypArt="PRS") Then
	wf_cacher( {"ASSURE_ENVOIE_COLIS","ASSURE_EN_PDV","NUM_PDV"} )
End if

If not (sIdFour="SB1" and sIdRefFour="PEC_A_RECYCLER") Then
	wf_cacher( {"DTE_LIVR_SBE","ETAT_SG","DATE_ETAT_SG","TV_HG","DATE_TV_HG"} )
End if

If sIdFour <> "SCR" Then
	wf_cacher( {"CODE_MAGASIN","CODE_VENDEUR"} )
End if

f_rechdetpro (lDeb, lFin, idwDetpro, ilIdProd,"-DP",141)
bCarrefourCV=(lDeb > 0)

If sIdFour <> "SCR" or lDeb < 0 Then
	wf_cacher( {"INFO_SPB_FRN"} )
End if
	
f_rechdetpro (lDeb, lFin, idwDetpro, ilIdProd,"-DP",140)

if not (lDeb > 0 And sIdFour="O2M" And sIdRefFour = "A_DIAGNOSTIQUER" ) Then
	wf_cacher( {"MARQUE_REMPL","MODELE_REMPL","PRIX_TTC_PUBLIC","PRIX_TTC_FACTU_O2M"} )
End if

// R$$HEX1$$e800$$ENDHEX$$gle pour les ddlb et dddw
// cod_etat
dw_1.GetChild("COD_ETAT",ldwc)

Choose Case sIdFour
	Case "O2M", "MS1", "CDS", "SB1", "TSF","SAM" // [PC467-2] Ajout de SAM
		ldwc.SetFilter("ID_CODE in ('ECT','ANN','RFO')")
	Case "SCR"
		if bCarrefourCV Then
			ldwc.SetFilter("ID_CODE in ('ECT','ANN','RFO','RPC')")
		Else
			ldwc.SetFilter("ID_CODE in ('ECT','ANN','RFO')")
		End if			
	Case Else
		ldwc.SetFilter("ID_CODE in ('ECT','ANN','RPC')")
End choose

ldwc.Filter()

// Status GC
sFilter ="ID_CODE in (" 

if sIdTypArt ="PRS" Then sFilter+="2,21,"
if sIdTypArt = "PRS" And sIdFour="PSM" Then sFilter+="22,23,"

f_rechdetpro (lDeb, lFin, idwDetpro, ilIdProd,"-DP",31)
if lDeb > 0 And sIdFour="DST" Then sFilter+="30,31,32,33,34,"

f_rechdetpro (lDeb, lFin, idwDetpro, ilIdProd,"-DP",37)
if lDeb > 0 And sIdFour="DST" Then sFilter+="40,41,42,43,"

if sIdFour = "MCM" Then sFilter+="201,203,"

If Right(sFilter,1) = "," Then 
	sFilter=Left(sFilter, Len(sFilter) - 1)
	sFilter+=")"
Else
	sFilter=""
End if

If sIdTypArt = "EDI" Then
	Choose Case sIdFour
		Case "O2M","MSS","SB1"
			If sFilter <> "" Then sFilter +=" or "
			sFilter+="(ID_CODE between 151 and 179) or ID_CODE = 231"
	End Choose
End if

If sIdFour="SCR" and bCarrefourCV Then
	sFilter=""
End if

If sFilter <> "" Then
	dw_1.GetChild("STATUS_GC",ldwc)
	ldwc.SetFilter(sFilter)
	ldwc.Filter()
Else
	wf_cacher( {"STATUS_GC"} )
End if

// Bris Visible
Choose case idwCommande.GetItemNumber(1,"STATUS_GC")
	Case 21
		dw_1.Object.bris_visible.Values="Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement~t[BVIE]/Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement avec oxydation~t[BVIEOX]"
	Case 23
		dw_1.Object.bris_visible.Values="Bris non visible sans oxydation~t[BNVSOX]/Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement avec oxydation~t[BVIEOX]"
	Case Else		
		wf_cacher( {"BRIS_VISIBLE"})
End Choose
end subroutine

private subroutine wf_cacher (string aslistezone[]);
Long l
String sChaineModify

If isNull(asListezone) Then return
If UpperBound(asListezone) = 0 Then return

For l=1 To UpperBound(asListezone)
	sChaineModify="t_" + Lower(asListezone[l]) + ".visible=0 "
	
	dw_1.Modify( sChaineModify)
	
	sChaineModify=Lower(asListezone[l]) + ".visible=0 "
	dw_1.Modify( sChaineModify)
Next
end subroutine

private subroutine wf_init_groupes ();String sZones[] // Liste des couples nom_zone, zone r$$HEX2$$e900e900$$ENDHEX$$lle (O/N)

// 1er Groupe
istgroupes[1].sGbName="gb_commande"
sZones={"id_cmd_frn","O", &
	"id_bon_transp","O", &
	"dte_env_cli","O", &
	"cod_etat","O", &
	"status_gc", "O", &
	"dte_rcp_mob_cli","O", &
	"comment_frn","O", &
	"bris_visible", "N", &
	"dte_rcp_frn","O", &
	"app_incomplet","N", &
	"rdv_conf","N", &
	"symp_non_detec_en_24h", "N", &
	"retour_153","N", &
	"retour_154","N"}

istgroupes[1].sZones=wf_create_lst_zone( sZones)

// 2$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[2].sGbName="gb_remplacement"
sZones={"mt_ttc_cmde","O", &
	"id_serie_nouv","O"}

istgroupes[2].sZones=wf_create_lst_zone( sZones)
	
// 3$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[3].sGbName="gb_auchan_o2m"
sZones={"marque_rempl","N", &
	"modele_rempl","N", &
	"prix_ttc_public","N", &
	"prix_ttc_factu_o2m","N"}

istgroupes[3].sZones=wf_create_lst_zone( sZones)

// 4$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[4].sGbName="gb_sbetv"
sZones={"dte_livr_sbe","N", &
	"etat_sg","N", &
	"date_etat_sg","N", &
	"tv_hg","N", &
	"date_tv_hg","N"}

istgroupes[4].sZones=wf_create_lst_zone( sZones)

// 5$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[5].sGbName="gb_carrefour"
sZones={"code_magasin","N", &
	"code_vendeur","N", "info_spb_frn","O"}

istgroupes[5].sZones=wf_create_lst_zone( sZones)

// 6$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[6].sGbName="gb_game"
sZones={"no_bon","N"}


istgroupes[6].sZones=wf_create_lst_zone( sZones)

// 7$$HEX1$$e800$$ENDHEX$$me groupe
istgroupes[7].sGbName="gb_psm"
sZones={"assure_envoie_colis","N","assure_en_pdv","N","num_pdv","N"}

istgroupes[7].sZones=wf_create_lst_zone( sZones)
end subroutine

public subroutine wf_arrangedw ();Long lGb, lZone
Boolean bZoneNonVide
Long lPosInGb, lPosGb, lHeightGb
Long lPosZone, lPosFen
String sLastGbVisible

lPosFen=0

For lGb=1 To UpperBound(istgroupes)
	// On detecte si le groupe est vide
	bZoneNonVide=False

	For lZone = 1 To UpperBound(istgroupes[lGb].sZones)
		if dw_1.Describe(istgroupes[lGb].sZones[lZone].sNomZone + ".Visible") = "1" Then
			bZoneNonVide=TRUE
			exit 
		End if
	Next
	
	lPosGb=Long(dw_1.Describe(istgroupes[lGb].sGbName + ".Y"))
	lPosInGb=0
	
	if bZoneNonVide Then
		// D$$HEX1$$e900$$ENDHEX$$placement dans la GB
		For lZone = 1 To UpperBound(istgroupes[lGb].sZones)
		
			// Exceptions - Zones qui s'affiche selon contexte
			If istgroupes[lGb].sZones[lZone].sNomZone="bris_visible" Then Continue
			
			// Autres Zone
			lPosZone= Long( dw_1.Describe(istgroupes[lGb].sZones[lZone].sNomZone + ".Y") )
			
			if dw_1.Describe(istgroupes[lGb].sZones[lZone].sNomZone + ".Visible") = "0" Then
				
				if lZone < UpperBound(istgroupes[lGb].sZones) Then
					lPosInGb+= Long( dw_1.Describe(istgroupes[lGb].sZones[lZone+1].sNomZone + ".Y"))  - lPosZone 
				End if
			End if
			
			dw_1.Modify(istgroupes[lGb].sZones[lZone].sNomZone + ".Y=" + String(lPosZone - lPosInGb - lPosFen))
			dw_1.Modify("t_" + istgroupes[lGb].sZones[lZone].sNomZone + ".Y=" + String(lPosZone - lPosInGb -lPosFen))
		
		Next
		sLastGbVisible=istgroupes[lGb].sGbName
	Else
		// Gb vide
		if lGb < UpperBound(istgroupes) Then
//			lPosFen+= Long( dw_1.Describe(istgroupes[lGb+1].sGbName + ".Y"))  - lPosGb 
			lPosFen+= Long( dw_1.Describe(istgroupes[lGb].sGbName + ".Height")) 
		End if
		
		dw_1.Modify(istgroupes[lGb].sGbName + ".Visible=0")
		
	End if

	dw_1.Modify(istgroupes[lGb].sGbName + ".Y=" + String(lPosGb - lPosFen))
	
	lHeightGb = Long(dw_1.Describe(istgroupes[lGb].sGbName + ".Height"))
	dw_1.Modify(istgroupes[lGb].sGbName + ".Height=" + String(lHeightGb - lPosInGb))
	
	lPosFen+=lPosInGb
Next

// Redimensionnement des objets
lPosFen= Long( dw_1.Describe(sLastGbVisible + ".Y")) +  Long( dw_1.Describe(sLastGbVisible + ".Height")) + 20
dw_1.Object.DataWindow.Detail.Height=lPosFen

lPosFen+=20
dw_1.Height=lPosFen

this.Height=dw_1.Height +310

// Positionnement des boutons
cb_annuler.Y=dw_1.Height + 48
cb_valider.Y=cb_annuler.Y
end subroutine

private function boolean wf_controler_gestion ();//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_maj_presta_manuelle::wf_controler_gestion
//* Evenement 		: 
//* Auteur			: FPI
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Boolean bRet
String sPos, sVal
Long lVal

bRet=TRUE

// Contr$$HEX1$$f400$$ENDHEX$$les SBETV
If dw_1.Describe("tv_hg.Visible")="1" Then
	if bRet Then
		If dw_1.GetItemString(1,"ETAT_SG") <> "-" And isNull(dw_1.GetItemDate(1,"DATE_ETAT_SG")) Then
			stMessage.svar[1] = "Merci de renseigner la zone ~"Date TV r$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$e livr$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$O2M~". "
			sPos="DATE_ETAT_SG"
			bRet=FALSE
		End if
	End if
	
	if bRet Then
		If dw_1.GetItemString(1,"TV_HG") = "OUI" And isNull(dw_1.GetItemDate(1,"DATE_TV_HG")) Then
			stMessage.svar[1] = "Merci de renseigner la zone ~"Date TV non-r$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$e livr$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$O2M~". "
			sPos="DATE_TV_HG"
			bRet=FALSE
		End if
	End if
End if

// Contr$$HEX1$$f400$$ENDHEX$$les PSM
if bRet and  dw_1.Describe("assure_envoie_colis.Visible")="1" Then
	If dw_1.GetItemString(1,"ASSURE_ENVOIE_COLIS") ="NUL" And dw_1.GetItemString(1,"ASSURE_EN_PDV") ="NUL"  Then
		stMessage.svar[1] = "Merci de s$$HEX1$$e900$$ENDHEX$$lectionner ~"Colis envoy$$HEX4$$e9002000e0002000$$ENDHEX$$la boutique centrale~" ou ~"L'assur$$HEX2$$e9002000$$ENDHEX$$s'est-il rendu en point de vente ?~" "
		sPos="ASSURE_ENVOIE_COLIS"
		bRet=FALSE
	End if
	
	lVal=dw_1.GetItemNumber(1,"NUM_PDV") 
	
	If dw_1.GetItemString(1,"ASSURE_EN_PDV") ="OUI"  And isNull(lVal) Then
		stMessage.svar[1] = "Merci de renseigner le num$$HEX1$$e900$$ENDHEX$$ro de point de vente."
		sPos="NUM_PDV"
		bRet=FALSE		
	End if
End if

// Affichage de l'erreur
if sPos <> "" Then
	stMessage.scode="GENE013"
	stMessage.berreurG=FALSE
	stMessage.stitre="Contr$$HEX1$$f400$$ENDHEX$$le de maj manuelle de prestation"
	stMessage.icon=Information!
	stMessage.bouton=OK!
	
	f_message(stMessage)
	
	dw_1.setcolumn( sPos)
	dw_1.setfocus( )
End if

Return bRet
end function

private function any wf_create_lst_zone (string aslstzones[]);st_zone stLstZones[]
Long lz, lIndex

lIndex=1
For lz=1 to UpperBound(asLstZones) -1 Step 2
	stLstZones[lIndex].sNomZone=asLstZones[lz]
	stLstZones[lIndex].bZoneReelle=(asLstZones[lz + 1] = "O")
	lIndex++
Next


Return stLstZones
end function

public function boolean wf_valider ();Boolean bRet
n_cst_string nvString
Long lGroupe, lZone
String sTypeZone, sNomZone

Long lVal
String sVal
Decimal dcVal
Datetime dttVal
Date dtVal
Any aVal

bRet=TRUE

For lGroupe=1 to UpperBound(istgroupes)
	For lZone=1 to UpperBound(istGroupes[lGroupe].sZones)
		
		SetNull(aVal)
		
		sNomZone=istGroupes[lGroupe].sZones[lZone].sNomZone
		
		// Test si visible
		if dw_1.Describe(	sNomZone + ".Visible")="0" Then Continue
	
		// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la valeur
		sTypeZone=dw_1.Describe(	sNomZone + ".ColType")

		If Pos(Upper(sTypeZone),"CHAR") = 1 Then
			sVal=dw_1.GetItemString(1,sNomZone)
			if isNull(sVal) Then Continue
			aVal=sVal
		End if
		
		If Pos(Upper(sTypeZone),"DATE") = 1 Then
			dtVal=dw_1.GetItemDate(1,sNomZone)
			if isNull(dtVal) Then Continue
			aVal=dtVal
			sVal=String(dtVal)
		End if
		
		If Pos(Upper(sTypeZone),"DECIMAL") = 1 Then
			dcVal=dw_1.GetItemDecimal(1,sNomZone)
			if isNull(dcVal) Then Continue
			aVal=dcVal
			sVal=String(dcVal)
		End if
		
		If isNull(aVal) Then
			lVal=dw_1.GetItemNumber(1,sNomZone)
			if isNull(lVal) Then Continue
			aVal=lVal
			sVal=String(lVal)
		End if
		
		bRet=wf_set_Valeur(sNomZone,istGroupes[lGroupe].sZones[lZone].bZoneReelle,aVal, sVal)
		
		If not bRet Then Return False
	Next
Next

idwCommande.AcceptText()

Return bRet
end function

private function boolean wf_set_valeur (string asnomzone, boolean abzonereelle, any avaleur, string svaleur);//       JFF   21/11/2018 [VDOC27123]

Boolean bRet, bCasPart
n_cst_String nvstring
String sValInfoFrnSpbCplt, sOldValCle, sValComment

bRet=True
bCasPart=FALSE

// Cas particulier "ETAT_SG=-" => suppr de la zone
if Upper(asNomzone) = "ETAT_SG" and sValeur="-" Then sValeur="NUL"

// Mise $$HEX2$$e0002000$$ENDHEX$$jour de la zone
if abZoneReelle Then
	bRet= ( idwcommande.SetItem(1,asNomzone,aValeur) = 1 )
Else
	sValInfoFrnSpbCplt=idwcommande.GetItemString(1,"INFO_FRN_SPB_CPLT")
	
	If isNull(sValInfoFrnSpbCplt) Then sValInfoFrnSpbCplt=""
	
	Choose case Upper(asNomZone)
		Case "BRIS_VISIBLE" 
			sValComment=idwcommande.GetItemString(1,"COMMENT_FRN")
			
			If isnull(sValComment) Then sValComment=""
			
			// Suppr des tags BVIE
			// [VDOC27123]BVID/BVIP/BVIT
			sValComment=nvString.of_globalreplace( sValComment, "[BVIE]", "")
			sValComment=nvString.of_globalreplace( sValComment, "[BVID]", "")
			sValComment=nvString.of_globalreplace( sValComment, "[BVIP]", "")
			sValComment=nvString.of_globalreplace( sValComment, "[BVIT]", "")			
			sValComment=nvString.of_globalreplace( sValComment, "[BVIEOX]", "")
			sValComment=nvString.of_globalreplace( sValComment, "[BNVSOX]", "")
			
			If not isNull(sValeur) Then sValComment=sValeur+sValComment
			
			bRet= ( idwcommande.SetItem(1,"COMMENT_FRN",sValComment) = 1 )
			
			bCasPart =TRUE
		
		Case Else
			// Cas G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral
			if sValeur="NUL" Then
				// On supprime la cl$$HEX2$$e9002000$$ENDHEX$$& sa valeur
				sOldValCle=nvString.of_getkeyvalue( sValInfoFrnSpbCplt,  Upper(asNomZone), ";")
				if sOldValCle<> "" Then
					
					sValInfoFrnSpbCplt=nvString.of_globalreplace ( sValInfoFrnSpbCplt, Upper(asNomZone) + "=" + sOldValCle ,"" )
					
					// Suppr des ; en trop
					sValInfoFrnSpbCplt=nvString.of_globalreplace( sValInfoFrnSpbCplt, ";;", ";")
					If Left(sValInfoFrnSpbCplt,1)=";" Then sValInfoFrnSpbCplt=Mid(sValInfoFrnSpbCplt,2)
					If Right(sValInfoFrnSpbCplt,1)=";" Then sValInfoFrnSpbCplt=Left(sValInfoFrnSpbCplt, Len(sValInfoFrnSpbCplt) -1)
					
				End if
			Else
				bRet = (nvString.of_setkeyvalue( sValInfoFrnSpbCplt, Upper(asNomZone),sValeur, ";") = 1)
			End if
	End Choose
	
	If bRet and Not bCasPart Then
		bRet= ( idwcommande.SetItem(1,"INFO_FRN_SPB_CPLT",sValInfoFrnSpbCplt) = 1 )
	End if
	
end if

Return bRet
end function

private subroutine wf_fill_fields ();Long lGroupe, lZone
String sTypeZone, sNomZone

Long lVal
String sVal
Decimal dcVal
Datetime dttVal
Date dtVal

For lGroupe=1 to UpperBound(istgroupes)
	For lZone=1 to UpperBound(istGroupes[lGroupe].sZones)
		
		sNomZone=istGroupes[lGroupe].sZones[lZone].sNomZone
		
		// Test si visible
		//if dw_1.Describe(	sNomZone + ".Visible")="0" Then Continue
	
		sTypeZone=dw_1.Describe(	sNomZone + ".ColType")

		if istGroupes[lGroupe].sZones[lZone].bZoneReelle Then
			// Zone r$$HEX2$$e900e900$$ENDHEX$$lle
			If Pos(Upper(sTypeZone),"CHAR") = 1 Then
				sVal=idwcommande.GetItemString(1,sNomZone)
				if isNull(sVal) Then Continue
				dw_1.SetItem(1, sNomZone,sVal)
				Continue
			End if
			
			If Pos(Upper(sTypeZone),"DATE") = 1 Then
				If Upper(idwcommande.Describe(	sNomZone + ".ColType")) = "DATETIME" Then
					dtVal=Date(idwcommande.GetItemDateTime(1,sNomZone))
				Else
					dtVal=idwcommande.GetItemDate(1,sNomZone)
				End if
				
				if isNull(dtVal) Then Continue
				
				dw_1.SetItem(1, sNomZone,dtVal)
				Continue
				
			End if
			
			If Pos(Upper(sTypeZone),"DECIMAL") = 1 Then
				dcVal=idwcommande.GetItemDecimal(1,sNomZone)
				if isNull(dcVal) Then Continue
				dw_1.SetItem(1, sNomZone,dcVal)
				Continue
			End if
			
			lVal=idwcommande.GetItemNumber(1,sNomZone)
			if isNull(lVal) Then Continue
			dw_1.SetItem(1, sNomZone,lVal)
		Else
			// Zone s$$HEX1$$e900$$ENDHEX$$rialis$$HEX1$$e900$$ENDHEX$$e
			sVal=wf_get_valeur(sNomZone)
			
			If isNull(sVal) Then Continue
			
			If Pos(Upper(sTypeZone),"CHAR") = 1 Then
				dw_1.SetItem(1, sNomZone,sVal)
				Continue
			End if
			
			If Pos(Upper(sTypeZone),"DATETIME") = 1 Then
				dttVal=Datetime(sVal)
				dw_1.SetItem(1, sNomZone,dttVal)
				Continue
			End if
		
			If Pos(Upper(sTypeZone),"DATE") = 1 Then
				dtVal=Date(sVal)
				dw_1.SetItem(1, sNomZone,dtVal)
				Continue
			End if
			
			If Pos(Upper(sTypeZone),"DECIMAL") = 1 Then
				dcVal=Dec(sVal)
				dw_1.SetItem(1, sNomZone,dcVal)
				Continue
			End if
			
			lVal=Long(sVal)
			dw_1.SetItem(1, sNomZone,lVal)
		End if
	Next
Next

dw_1.AcceptText()
end subroutine

private function string wf_get_valeur (string asnomzone);//       JFF   21/11/2018 [VDOC27123]

String sRet, sValInfoFrnSpbCplt, sValComment
n_cst_string nvString

sValInfoFrnSpbCplt=idwcommande.GetItemString(1,"INFO_FRN_SPB_CPLT")
SetNull(sRet)

Choose case Upper(asNomZone)
	Case "BRIS_VISIBLE"
		sValComment=idwcommande.GetItemString(1,"COMMENT_FRN")
		If Pos(sValComment,"[BVIE]") >0 Then
			sRet="[BVIE]"
		End if

		// [VDOC27123]BVID/BVIP/BVIT
		If Pos(sValComment,"[BVID]") >0 Then
			sRet="[BVID]"
		End if

		If Pos(sValComment,"[BVIP]") >0 Then
			sRet="[BVIP]"
		End if
		
		If Pos(sValComment,"[BVIT]") >0 Then
			sRet="[BVIT]"
		End if
		
		If Pos(sValComment,"[BVIEOX]") >0 Then
			sRet="[BVIEOX]"
		End if
		If Pos(sValComment,"[BNVSOX]") >0 Then
			sRet="[BNVSOX]"
		End if
		
	Case Else
		If Pos(sValInfoFrnSpbCplt, Upper(asNomZone)) >0 Then
			sRet=nvString.of_getkeyvalue(sValInfoFrnSpbCplt, Upper(asNomZone), ";") 
		End if
End Choose

Return sRet
end function

on w_sp_trt_maj_presta_manuelle.create
this.cb_annuler=create cb_annuler
this.cb_valider=create cb_valider
this.dw_1=create dw_1
this.Control[]={this.cb_annuler,&
this.cb_valider,&
this.dw_1}
end on

on w_sp_trt_maj_presta_manuelle.destroy
destroy(this.cb_annuler)
destroy(this.cb_valider)
destroy(this.dw_1)
end on

event open;//*-----------------------------------------------------------------
//*
//* Fonction		: W_sp_trt_maj_presta_manuelle::open
//* Auteur			: F. PINON	
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM103]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
DatawindowChild ldwc
s_pass stPass

dw_1.InsertRow(0)

dw_1.GetChild("COD_ETAT",ldwc)
ldwc.setTransobject( SQLCA)
ldwc.Retrieve( "-EC")

dw_1.GetChild("STATUS_GC",ldwc)
ldwc.setTransobject( SQLCA)
ldwc.Retrieve( "-GC")

dw_1.GetChild("INFO_SPB_FRN",ldwc)
ldwc.setTransobject( SQLCA)
ldwc.Retrieve( "-IF")
ldwc.SetFilter("ID_CODE BETWEEN 1410 and 1455")
ldwc.Filter()

stPass=Message.Powerobjectparm

idwcommande=stPass.udwtab[1]
idwDetpro=stPass.dwNorm[1]
ilIdprod=stPass.ltab[1]

this.title +=" - Commande " + String(idwCommande.GetItemNumber(1,"ID_SIN"))
this.title +="-" + String(idwCommande.GetItemNumber(1,"ID_SEQ"))

wf_init_groupes()
wf_regle_affichage( )
wf_arrangedw()

wf_fill_fields()

end event

type cb_annuler from commandbutton within w_sp_trt_maj_presta_manuelle
integer x = 1838
integer y = 2056
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annuler"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_maj_presta_manuelle::cb_annuler
//* Evenement 		: clicked
//* Auteur			: FPI
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_maj_presta_manuelle
integer x = 1216
integer y = 2056
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_maj_presta_manuelle::valider
//* Evenement 		: clicked
//* Auteur			: FPI
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


If dw_1.AcceptText() = -1 Then Return // Erreur de saisie

if not wf_controler_gestion() Then Return

if wf_valider() Then
	Close(Parent)
End if
end event

type dw_1 from u_datawindow within w_sp_trt_maj_presta_manuelle
integer x = 5
integer width = 3493
integer height = 2008
integer taborder = 10
string dataobject = "d_trt_saisie_retour_presta"
boolean border = false
end type

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_maj_presta_manuelle::dw_1 ( !!! OVERRIDE !!! )
//* Evenement 		: ItemError
//* Auteur			: FPI
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//*-----------------------------------------------------------------
long	ll_ret = 0
n_cst_string lnv_String

Choose Case Upper ( This.GetColumnName () ) 
	Case "MT_TTC_CMDE" , "PRIX_TTC_PUBLIC","PRIX_TTC_FACTU_O2M"
		// Gestion pour l'override
		ibErreur = TRUE
		isErrCol		= Upper ( This.GetColumnName () )

	Case Else
		// Sinon on d$$HEX1$$e900$$ENDHEX$$clenche l'anc$$HEX1$$ea00$$ENDHEX$$tre, et la suite ci-dessous
		Call super::itemerror
		ll_ret = AncestorReturnValue
End Choose 

If	ibErreur Then

	stMessage.sTitre		= "Maj Presta manuelle - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol

	
	Case "MT_TTC_CMDE"
		stMessage.sVar[1] = "montant de la commande"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "PRIX_TTC_PUBLIC"
		stMessage.sVar[1] = "prix TTC public"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "PRIX_TTC_FACTU_O2M"
		stMessage.sVar[1] = "prix TTC factur$$HEX2$$e9002000$$ENDHEX$$par O2M"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"
	
	Case Else
		stMessage.sCode	= "GENE016"
		
	End Choose


	If stMessage.sCode <> "" Then F_Message ( stMessage )

	ll_ret = This.Uf_Reinitialiser ()

End If

return ll_ret
end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_maj_presta_manuelle::dw_1 
//* Evenement 		: ItemChanged
//* Auteur			: FPI
//* Date				: 23/05/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
String sNull, sImeiCorrige
Date dtNull

SetNull(sNull)
SetNull(dtNull)

Choose Case upper(dwo.Name) 
	Case "RETOUR_153"
		If data="OUI" Then
			dw_1.SetItem(1,"RETOUR_154","NUL")
		End if
	Case "RETOUR_154"
		If data="OUI" Then
			dw_1.SetItem(1,"RETOUR_153","NUL")
		End if
	Case "ETAT_SG"
		if not isnull(data) and data <> "-" Then
			dw_1.SetItem(1,"TV_HG","NUL")
			dw_1.SetItem(1,"DATE_TV_HG",dtNull)
		End if
	Case "TV_HG"
		if data="OUI" Then
			dw_1.SetItem(1,"ETAT_SG","-")
			dw_1.SetItem(1,"DATE_ETAT_SG",dtNull)
		End if
	Case "STATUS_GC"
		Choose Case data
			Case "21"
				dw_1.Object.bris_visible.Visible=1
				dw_1.Object.t_bris_visible.Visible=1
				
				dw_1.Object.bris_visible.Values="Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement~t[BVIE]/Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement avec oxydation~t[BVIEOX]"
			Case "23"
				dw_1.Object.bris_visible.Visible=1
				dw_1.Object.t_bris_visible.Visible=1

				dw_1.Object.bris_visible.Values="Bris non visible sans oxydation~t[BNVSOX]/Bris visible irr$$HEX1$$e900$$ENDHEX$$parable $$HEX1$$e900$$ENDHEX$$conomiquement avec oxydation~t[BVIEOX]"
				
			Case Else
				dw_1.Object.bris_visible.Visible=0
				dw_1.Object.t_bris_visible.Visible=0

		End Choose
			
		dw_1.SetItem(1,"BRIS_VISIBLE",sNull)
		
	Case "ASSURE_ENVOIE_COLIS"
		If data="OUI" Then
			dw_1.SetItem(1,"ASSURE_EN_PDV","NUL")
		End if
	Case "ASSURE_EN_PDV"
		If data="OUI" Then
			dw_1.SetItem(1,"ASSURE_ENVOIE_COLIS","NUL")
		End if
	Case "NO_BON"
		// Le no bon GAME doit $$HEX1$$ea00$$ENDHEX$$tre un nombre
		If not isnumber(data) Then return 1
	
	Case "ID_SERIE_NOUV"
		// Si tel, contr$$HEX1$$f400$$ENDHEX$$le IMEI
		If idwCommande.GetItemString(1,"ID_TYP_ART") = "TEL" Then
			If Not f_imei(data,sImeiCorrige ) Then Return 1
		End if
		
	Case "INFO_SPB_FRN"
		Choose case data
			Case "1450","1455"
				dw_1.SetItem(1,"COD_ETAT","RPC")
			Case "1442","1443"
				dw_1.SetItem(1,"COD_ETAT","RFO")
		End Choose
		
End choose

// Status d$$HEX1$$e900$$ENDHEX$$clenchant la fermeture de presta
If  upper(dwo.Name) ="STATUS_GC" Then
	Choose case data
		Case "2","21","151","152","153","154","155","157","160","161","165","166","170","171","167","168","179","175"
			dw_1.SetItem(1,"COD_ETAT","RFO")
			dw_1.uf_proteger( {"COD_ETAT"}, "1")
		Case "178"
			dw_1.SetItem(1,"COD_ETAT","RPC")
			dw_1.uf_proteger( {"COD_ETAT"}, "1")
		Case Else
			dw_1.uf_proteger( {"COD_ETAT"}, "0")
	End Choose
End if

end event

event rbuttondown;// !OVERRIDE!
end event

event losefocus;call super::losefocus;This.AcceptText()
end event

