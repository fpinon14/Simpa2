HA$PBExportHeader$u_sp_gs_param_ftu_brk.sru
$PBExportComments$[PM02] User Object pour les contr$$HEX1$$f400$$ENDHEX$$les relatifs aux param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises de mat$$HEX1$$e900$$ENDHEX$$riels
forward
global type u_sp_gs_param_ftu_brk from u_spb_gs_anc
end type
end forward

global type u_sp_gs_param_ftu_brk from u_spb_gs_anc
end type
global u_sp_gs_param_ftu_brk u_sp_gs_param_ftu_brk

type variables
Decimal idcTauxTva
String isMode
u_datawindow_detail idw_grille_pivot

Constant Long ilPeriodeFinTranche=1000000
Constant Decimal idcMtFinTranche=100000
Constant Decimal idcMtMax = 50000
end variables

forward prototypes
public function integer uf_controlerzone (string asnomcol, string asval)
public function string uf_controler ()
public function string uf_controler_oblig ()
public subroutine uf_reinitialiser ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
public function long uf_controlerzone_vts (long alrow, string asnomcol, string asval)
public function string uf_controler_oblig_vts ()
public subroutine uf_initialisation (ref u_transaction atrtrans, ref u_datawindow adwdatawindow, ref u_datawindow_detail adw_grille)
private subroutine uf_resize_ddw (boolean aball)
private function long uf_zn_periode (string asval)
private function integer uf_zn_mt (string asval, boolean bmoinsun, string asnomcol)
private function boolean uf_controler_oblig_dc (string asnomcol, string aslibcol, ref string aserr, ref string aspos)
private subroutine uf_zn_alt_sans_validite (string asval)
public subroutine uf_proteger_modif ()
private function integer uf_zn_typ_decote (string asval)
private function integer uf_zn_typ_mt_pivot (string asval)
private function integer uf_zn_idprod (string asval)
end prototypes

public function integer uf_controlerzone (string asnomcol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controlerzone
//* Auteur			: F. Pinon
//* Date				:  02/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asnomcol	 */
/* 	value string asval	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	03/06/2011	[PM02.RetourNC]
// 			FPI	29/06/2011	[PM02.29062011]
//*-----------------------------------------------------------------
DatawindowChild dwcChild
Long lNull, lRet
String sIdFour, sNull
Decimal	dcMt, dcIdProd
Date dteDebEff,dteFinEff
Datetime dtteDebEff,dtteFinEff
Integer iReponse

SetNull(lNull)
SetNull(sNull)

lRet=0

Choose Case Upper(asNomCol)
	Case "ID_PROD"
		
		if not isnull(asval) and trim(asVal)<> "" Then
			If uf_zn_idprod(asVal) = 1 Then Return 1 // [PM02.29062011]
		End if
		
		idw_1.getchild( "ID_REV", dwcChild )		
		dwcChild.Retrieve(dec(asVal))
		idw_1.SetItem(1,"ID_REV", -1)
		
		idw_1.getchild( "ID_GTI", dwcChild )		
		dwcChild.Retrieve(dec(asVal))
		idw_1.SetItem(1,"ID_GTI", -1)
	
		idw_1.getchild( "ID_TYP_ART", dwcChild )		
		dwcChild.Retrieve(dec(asVal))
		idw_1.SetItem(1,"ID_TYP_ART",sNull )
		
		idw_1.getchild( "ID_FOUR", dwcChild )		
		dwcChild.Retrieve(dec(asVal), -1.00)
		idw_1.SetItem(1,"ID_FOUR", sNull)
		
		idw_1.getchild( "ID_FOUR_FORFAIT", dwcChild )		
		dwcChild.Retrieve(dec(asVal), -1.00)
		idw_1.SetItem(1,"ID_FOUR_FORFAIT", sNull)
		
		idw_1.SetItem(1, "ID_METHODE",lNull)
		idw_1.SetItem(1, "ID_BRK",sNull)

		idw_1.getchild( "ID_MARQ_ART", dwcChild )		
		dwcChild.Reset()
		idw_1.SetItem(1,"ID_MARQ_ART",sNull )

		idw_1.getchild( "ID_MODL_ART", dwcChild )		
		dwcChild.Reset()
		idw_1.SetItem(1,"ID_MODL_ART",sNull )

		uf_resize_ddw( FALSE)
	Case "ID_REV"
		
	Case "ID_GTI"
		dcIdProd =idw_1.GetItemNumber( 1, "ID_PROD")
		
		idw_1.getchild( "ID_FOUR", dwcChild )		
		dwcChild.Retrieve(dcIdProd, dec(asVal))
		idw_1.SetItem(1,"ID_FOUR", lNull)
		
		idw_1.getchild( "ID_FOUR_FORFAIT", dwcChild )		
		dwcChild.Retrieve(dcIdProd, dec(asVal))
		idw_1.SetItem(1,"ID_FOUR_FORFAIT", lNull)

		uf_resize_ddw( FALSE)
		
	Case "ID_BRK"
		
	Case "ID_TYP_ART"
	
		dcIdProd =idw_1.GetItemNumber( 1, "ID_PROD")

		idw_1.getchild( "ID_MARQ_ART", dwcChild )		
		dwcChild.Retrieve(dcIdProd,asVal)
		idw_1.SetItem(1,"ID_MARQ_ART",sNull )

		idw_1.getchild( "ID_MODL_ART", dwcChild )		
		dwcChild.Reset()
		idw_1.SetItem(1,"ID_MODL_ART",sNull )
		
	Case "ID_MARQ_ART"

		dcIdProd =idw_1.GetItemNumber( 1, "ID_PROD")
		idw_1.getchild( "ID_MODL_ART", dwcChild )		
		dwcChild.Retrieve(dcIdProd,idw_1.GetItemString( 1, "ID_TYP_ART"))
		
		dwcChild.SetFilter("marque='" + trim(asVal)  +"' or marque='-1'")
		dwcChild.Filter()
		dwcChild.Sort()
		idw_1.SetItem(1,"ID_MODL_ART",sNull )
		
	Case "ALT_ACTIF"
		
	Case "DTE_DEB_EFF"
		dteFinEff = Date(idw_1.GetItemDateTime( 1, "DTE_FIN_EFF"))	 // [PI056] date-> datetime
		
		dteDebEff=Date(asVal)
		if dteDebEff=1900-01-01 Then SetNull(dteDebEff)
		
		If Not ( Isnull(dteDebEff) or isNull(dteFinEff) ) Then
				if dteDebEff > dteFinEff Then lRet=1
		End if
		
	Case "DTE_FIN_EFF"
			dteDebEff =Date(idw_1.GetItemDateTime( 1, "DTE_DEB_EFF"))	 // [PI056] date-> datetime
		
			dteFinEff=Date(asVal)
			if dteFinEff=1900-01-01 Then SetNull(dteFinEff)
		
			If Not ( Isnull(dteDebEff) or isNull(dteFinEff) ) Then
				if dteDebEff > dteFinEff Then lRet=1
			End if
	
	Case "TYP_EFF"
		// [PM02.RetourNC]
		if not (isnull(asVal) or Len(Trim(asVal)) = 0) Then
			Choose case asVal
				Case "DTESRV"
					idw_1.SetItem(1,"TYP_VETUSTE","ACHSRV")
				Case "DTERFR"
					idw_1.SetItem(1,"TYP_VETUSTE","ACHRCP")	
			End choose
		End if
		
	Case "TYP_VETUSTE"
	Case "PER_CPLT"
		if not (isnull(asVal) or Len(Trim(asVal)) = 0) Then
			If not isnumber(asVal) Then 
				lRet=1
			Else
				if Long(asVal) < 0 or Long(asVal)  > 9999 Then lRet=1
			End if
		End if
	Case "PER_CPLT_UT"
	
	Case "TYP_MT_PIVOT"
		lRet = uf_zn_typ_mt_pivot( asVal)
		
	Case "MT_PIVOT"
		lRet=uf_zn_mt( asVal, FALSE, "MT_PIVOT")
		If lRet=0 and dec(asVal) > idcmtmax Then lRet=1
		
	Case "TYP_DECOTE"
		lRet=uf_zn_typ_decote(asVal)
		
	Case "MT_DECOTE"
		lRet=uf_zn_mt( asVal, FALSE,"MT_DECOTE")
		If lRet=0 and dec(asVal) > idcmtmax Then lRet=1
		
	Case "MT_FORFAITAIRE"
		lRet=uf_zn_mt( asVal, FALSE,"MT_FORFAITAIRE")
		If lRet=0 and dec(asVal) > idcmtmax Then lRet=1
		
		if lRet=0 Then
			if Dec(asVal) = 0 Then 
				idw_1.uf_proteger( {"HTTC_FORFAIT","ID_FOUR_FORFAIT"},"1")
				idw_1.SetItem(1,"ID_FOUR_FORFAIT",sNull)
				idw_1.SetItem(1,"HTTC_FORFAIT","TTC")
			Else
				idw_1.uf_proteger( {"HTTC_FORFAIT", "ID_FOUR_FORFAIT"},"0")
				If isNull( idw_1.GetItemString(1,"ID_FOUR_FORFAIT") ) Then
					sIdFour = idw_1.GetItemString(1,"ID_FOUR")
					idw_1.SetItem(1,"ID_FOUR_FORFAIT",sIdFour)
				End if
			End if
		End if
	Case "TX_DECOTE"
		lRet=uf_zn_mt( asVal, FALSE,"TX_DECOTE")
		if lRet=0 And Dec(asVal) > 1 Then
			lRet=1
		End if
		
	Case "TX_TVA"
		lRet=uf_zn_mt( asVal, FALSE,"TX_TVA")
		if lRet=0 And (Dec(asVal) > 1 or Dec(asVal) = 0.00 )Then
			lRet=1
		End if
	Case "PARAM_CPLT"
		
	Case "ALT_SANS_VALIDITE"
		 uf_zn_alt_sans_validite(asval)
		 
	Case "ALT_SANS_FIN_VALIDE"
		If asVal='O' Then
			dteFinEff =Date("01/01/3000")
		Else
			SetNull(dteFinEff)
		End if

		idw_1.SetItem(1,"DTE_FIN_EFF",dteFinEff)
		
End choose

Return lRet

end function

public function string uf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controler
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
//* 		FPI	29/06/2011	 [PM02.29062011]
//* 		FPI	29/06/2011	 [PM02.25072011]
//*-----------------------------------------------------------------

String sPos, sFour
Decimal dcMtPivotMinOld, dcMtPivotMaxOld, dcMtPivotMin, dcMtPivotMax
String sInclusions[4]
Integer iPos
Long lRow, lCol
Long lPeriodeMinOld, lPeriodeMaxOld, lPeriodeMin, lPeriodeMax
String sColsInclusion[]={"IE_MT_PIVOT_MIN","IE_MT_PIVOT_MAX"}
Boolean bPasFinTrancheNum,bPasFinTranchePeriode
Long lIdProd // [PM02.29062011]
Boolean bPeriodeMinPart

sPos=""
stMessage.berreurg = FALSE
stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie du param$$HEX1$$e900$$ENDHEX$$trage des tarifs de reprises"
bPasFinTrancheNum=FALSE
bPasFinTranchePeriode=FALSE
bPeriodeMinPart=FALSE

// [PM02.29062011]
lIdProd = idw_1.getItemNumber( 1, "ID_PROD")

If uf_zn_idprod(string(lIdProd)) = 1 Then
	sPos="TYP_MT_PIVOT"
	stmessage.scode="PATF021" 
End if
// :[PM02.29062011]

If sPos="" and idw_1.GetItemString (1, "TYP_MT_PIVOT") <> "FX" Then
	If idw_grille_pivot.RowCount() <= 0 Then
		stmessage.scode="PATF004" 
		sPos="TYP_MT_PIVOT"
	End if
End if

If sPos="" And idw_grille_pivot.RowCount() > 0 Then
	idw_grille_pivot.SetSort("MT_PIVOT_MIN A, MT_PIVOT_MAX A, PERIODE_MIN_J A, PERIODE_MAX_J A")
	idw_grille_pivot.Sort()

	// Contr$$HEX1$$f400$$ENDHEX$$le premi$$HEX1$$e800$$ENDHEX$$re ligne
	lPeriodeMin= idw_grille_pivot.GetItemNumber(1,"PERIODE_MIN_J")
	lPeriodeMax= idw_grille_pivot.GetItemNumber(1,"PERIODE_MAX_J")
	dcMtPivotMin =  idw_grille_pivot.GetItemDecimal(1,"MT_PIVOT_MIN")
	dcMtPivotMax =  idw_grille_pivot.GetItemDecimal(1,"MT_PIVOT_MAX")
			
	If dcMtPivotMin = 0 And dcMtPivotMax = 0 Then
		sPos="MT_PIVOT_MIN"
		stmessage.scode="PATF011"  
	End if
	
	If dcMtPivotMin <> 0 And dcMtPivotMin <> -1 Then
		sPos="MT_PIVOT_MIN"
		stmessage.scode="PATF014"  
	End if
	
	If dcMtPivotMin = 0 And dcMtPivotMax = idcmtfintranche Then
		sPos="MT_PIVOT_MIN"
		stmessage.scode="PATF016"  
	End if

	if sPos="" And lPeriodeMin <> 0 And lPeriodeMin <> -1 Then
		
		// [PM02.25072011]
		If lPeriodeMin > 0 Then
			stMessage.bouton = YesNo!
			stmessage.scode="PATF022"
			bPeriodeMinPart =(f_message(stmessage) = 1)
		End if
		
		If not bPeriodeMinPart Then
			sPos="PERIODE_MIN_J"
			stmessage.scode="PATF010"
		End if
		// :[PM02.25072011]
		
	end if		

End if

if sPos="" and idw_grille_pivot.RowCount()=1 Then
	// Contr$$HEX1$$f400$$ENDHEX$$le une seule ligne
	If dcMtPivotMax <> idcmtfintranche and dcMtPivotMax <> -1 Then
		// La derni$$HEX1$$e800$$ENDHEX$$re ligne doit indiquer une fin de tranche de Montant
		stMessage.bouton = YesNo!
		stmessage.scode="PATF018"
		If  f_message(stmessage) <>  1 Then
			stmessage.scode="PATF013"
			sPos="MT_PIVOT_MAX"
		End if
	End if
			
	If sPos = "" And lPeriodeMin=0  And lPeriodeMax=ilperiodefintranche Then
		sPos="PERIODE_MIN_J"
		stmessage.scode="PATF015"  
	End if

	If sPos = "" and lPeriodeMax <> ilperiodefintranche and lPeriodeMax <> -1 Then
		// La derni$$HEX1$$e800$$ENDHEX$$re ligne doit indiquer une fin de tranche de p$$HEX1$$e900$$ENDHEX$$riode
		stMessage.bouton = YesNo!
		stmessage.scode="PATF019"
		bPasFinTranchePeriode =(f_message(stmessage) = 1)
		If not bPasFinTranchePeriode Then
			stmessage.scode="PATF012"
			sPos="PERIODE_MAX_J"
		End if
	End if
	
End if

// Contr$$HEX1$$f400$$ENDHEX$$le des autres lignes
If sPos="" Then
	For lRow=2 to idw_grille_pivot.RowCount()
		dcMtPivotMinOld =  idw_grille_pivot.GetItemDecimal(lRow - 1,"MT_PIVOT_MIN")
		dcMtPivotMaxOld =  idw_grille_pivot.GetItemDecimal(lRow - 1,"MT_PIVOT_MAX")
		
		dcMtPivotMin =  idw_grille_pivot.GetItemDecimal(lRow,"MT_PIVOT_MIN")
		dcMtPivotMax =  idw_grille_pivot.GetItemDecimal(lRow,"MT_PIVOT_MAX")
		
		lPeriodeMinOld= idw_grille_pivot.GetItemDecimal(lRow - 1,"PERIODE_MIN_J")
		lPeriodeMaxOld= idw_grille_pivot.GetItemDecimal(lRow - 1,"PERIODE_MAX_J")
		
		lPeriodeMin= idw_grille_pivot.GetItemNumber(lRow,"PERIODE_MIN_J")
		lPeriodeMax= idw_grille_pivot.GetItemNumber(lRow,"PERIODE_MAX_J")

		For lCol=1 to 2
			sInclusions[lCol] = idw_grille_pivot.GetItemString(lRow -1, sColsInclusion[lCol])
			sInclusions[lCol + 2] = idw_grille_pivot.GetItemString(lRow, sColsInclusion[lCol])
		Next
		
		If dcMtPivotMin = dcMtPivotMaxOld  and dcMtPivotMin <> -1 Then
			// Coupure sur le montant
			If  sInclusions[2] = sInclusions[3] Then // "IE_MT_PIVOT_MAX" pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent = "IE_MT_PIVOT_MIN" 
				sPos="IE_MT_PIVOT_MIN"
				stmessage.scode="PATF005"
			End if
			
			If sPos="" Then
				if lPeriodeMin <> 0 And lPeriodeMin <> -1 Then
					
					// [PM02.25072011]
					If lPeriodeMin > 0 And Not bPeriodeMinPart Then
						stMessage.bouton = YesNo!
						stmessage.scode="PATF022"
						bPeriodeMinPart =(f_message(stmessage) = 1)
					End if
		
					If Not bPeriodeMinPart Then
						sPos="PERIODE_MIN_J"
						stmessage.scode="PATF010"
					End if
					// :[PM02.25072011]
				end if				
			End if
			
			If sPos="" Then
				If lPeriodeMaxOld <> ilPeriodeFinTranche and lPeriodeMaxOld <> -1 And Not bPasFinTranchePeriode Then
					// La p$$HEX1$$e900$$ENDHEX$$riode de la ligne pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente doit indiquer une fin de tranche de p$$HEX1$$e900$$ENDHEX$$riode
					stMessage.bouton = YesNo!
					stmessage.scode="PATF019"
					bPasFinTranchePeriode =(f_message(stmessage) = 1)
			
					If not bPasFinTranchePeriode Then
						sPos="PERIODE_MAX_J"
						stmessage.scode="PATF012"
						 lRow = lRow -1 // On se place $$HEX2$$e0002000$$ENDHEX$$la ligne pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
					End if
				End if
			End if
			
			If sPos = "" And lPeriodeMin=0  And lPeriodeMax=ilperiodefintranche Then
				sPos="PERIODE_MIN_J"
				stmessage.scode="PATF015"  
			End if
		Else
			// Il faut que les colonnes de montant pivot soient les m$$HEX1$$ea00$$ENDHEX$$mes que la ligne pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
			If dcMtPivotMinOld <> dcMtPivotMin or dcMtPivotMaxOld <> dcMtPivotMax Or &
				sInclusions[1] <>  sInclusions[3] or sInclusions[2] <>  sInclusions[4] Then
				
				sPos="IE_MT_PIVOT_MIN"
				stmessage.scode="PATF006"  
				
			End if
			
			If sPos="" Then
				// Changement de p$$HEX1$$e900$$ENDHEX$$riode
				If lPeriodeMin <> lPeriodeMaxOld +1 Then
					// Rupture de p$$HEX1$$e900$$ENDHEX$$riode interdite
					sPos="PERIODE_MIN_J"
					stmessage.scode="PATF007"  
				End if
			End if
		End if
		
		if sPos="" and lRow=idw_grille_pivot.RowCount() Then
			// Contr$$HEX1$$f400$$ENDHEX$$le derni$$HEX1$$e800$$ENDHEX$$re ligne
			If dcMtPivotMax <> idcmtfintranche and dcMtPivotMax <> -1 And Not bPasFinTrancheNum Then
				// La derni$$HEX1$$e800$$ENDHEX$$re ligne doit indiquer une fin de tranche de Montant
				stmessage.scode="PATF018"
				stMessage.bouton = YesNo!
				bPasFinTrancheNum =(f_message(stmessage) = 1)
			
				If not bPasFinTrancheNum Then
					sPos="MT_PIVOT_MAX"
					stmessage.scode="PATF013"
				End if
			End if
			
			If sPos = "" and lPeriodeMax <> ilperiodefintranche and lPeriodeMax <> -1 And Not bPasFinTranchePeriode Then
				// La derni$$HEX1$$e800$$ENDHEX$$re ligne doit indiquer une fin de tranche de p$$HEX1$$e900$$ENDHEX$$riode
				stmessage.scode="PATF019"
				stMessage.bouton = YesNo!
				bPasFinTranchePeriode =(f_message(stmessage) = 1)
			
				If not bPasFinTranchePeriode Then
					sPos="PERIODE_MAX_J"
					stmessage.scode="PATF012"
				End if
			End if

		End if
		
		
		If sPos="" and  dcMtPivotMin = 0 And dcMtPivotMax = 0 Then
			sPos="MT_PIVOT_MIN"
			stmessage.scode="PATF011"  
		End if
		
		
		If sPos <> "" Then 
			idw_grille_pivot.SelectRow(0,FALSE)
			idw_grille_pivot.SetRow(lRow)
			Exit // Si une erreur, on sort de la boucle
		End if
	Next
End if

If	sPos <> "" Then
	stMessage.Icon		= Information!
	stMessage.berreurg = FALSE
	stMessage.bouton = OK!
	
	f_Message ( stMessage )
End if

Return sPos
end function

public function string uf_controler_oblig ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controler_oblig
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
//*-----------------------------------------------------------------

String sPos, sVal, sErr, sNouvelleLigne
Integer iPos, iVal
Decimal dcVal
Datetime dtVal // [PI056]

String sCols[]={"ID_PROD","ID_REV","ID_GTI","ID_FOUR","ID_METHODE", "ID_TYP_ART", "ID_BRK", & 
	"DTE_DEB_EFF","DTE_FIN_EFF", "TYP_EFF", &
	"TYP_VETUSTE","PER_CPLT","PER_CPLT_UT", &
	"TYP_MT_PIVOT","HTTC_PIVOT", "MT_PIVOT", &
	"TYP_DECOTE", "MT_DECOTE","HTTC_DECOTE","TX_DECOTE", &
	"MT_FORFAITAIRE","HTTC_FORFAIT","ID_FOUR_FORFAIT","TX_TVA", "ALT_ACTIF"}
	
String sLibCols[]={"le produit","la r$$HEX1$$e900$$ENDHEX$$vision", "la garantie","le prestataire","la m$$HEX1$$e900$$ENDHEX$$thode de rep$$HEX1$$e900$$ENDHEX$$rage", 	"le mat$$HEX1$$e900$$ENDHEX$$riel", "le broker/acheteur", &
	"la date de d$$HEX1$$e900$$ENDHEX$$but de validit$$HEX1$$e900$$ENDHEX$$","la date de fin de validit$$HEX1$$e900$$ENDHEX$$", "l'effet de validit$$HEX1$$e900$$ENDHEX$$", &
	"le type de vetust$$HEX1$$e900$$ENDHEX$$", "la p$$HEX1$$e900$$ENDHEX$$riode compl$$HEX1$$e900$$ENDHEX$$mentaire de vetust$$HEX1$$e900$$ENDHEX$$", "la p$$HEX1$$e900$$ENDHEX$$riode compl$$HEX1$$e900$$ENDHEX$$mentaire de vetust$$HEX1$$e900$$ENDHEX$$", &
	"le type de montant pivot", "l'interpr$$HEX1$$e900$$ENDHEX$$tation du montant pivot (TTC/HT)", "le tarif de reprise fixe", &
	"le type de d$$HEX1$$e900$$ENDHEX$$cote", "le montant de d$$HEX1$$e900$$ENDHEX$$cote num$$HEX1$$e900$$ENDHEX$$raire",  "l'interpr$$HEX1$$e900$$ENDHEX$$tation de la d$$HEX1$$e900$$ENDHEX$$cote num$$HEX1$$e900$$ENDHEX$$raire", "le pourcentage de d$$HEX1$$e900$$ENDHEX$$cote", &
	"le montant forfaitaire", "l'interpr$$HEX1$$e900$$ENDHEX$$tation du montant forfaitaire", "le prestataire associ$$HEX2$$e9002000$$ENDHEX$$au montant forfaitaire", "le taux de TVA", "la case 'Ligne active'"}


sNouvelleLigne	= "~r~n"

sPos=""
sErr=""

// Controle de saisie 
For iPos = 1 To UpperBound(sCols)
	Choose case iPos
		Case 1,2,3,  21
			uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos)
			
		Case 16 // MT_PIVOT
			dcVal=idw_1.GetItemDecimal(1, sCols[iPos])
			If uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos) Then
				If idw_1.GetItemString (1, "TYP_MT_PIVOT") =  "FX" and dcVal = 0.00 Then
					sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
					if sPos ="" Then
						sPos = sCols[iPos]
					End if
				End if
			End if
		Case 5, 12 // "ID_METHODE", "PER_CPLT"
			iVal= idw_1.GetItemNumber(1,sCols[iPos])
			if isNull(iVal) Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		Case 4,6,7,10,11,13,14,15,17,25
			sVal= idw_1.GetItemString(1,sCols[iPos])
			if isNull(sVal) or Len(Trim(sVal)) = 0 Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		Case 8,9 // "DTE_DEB_EFF","DTE_FIN_EFF"
			dtVal= idw_1.GetItemDateTime(1,sCols[iPos])  // [PI056] date-> datetime
			
			if isNull(dtVal) or Date(dtVal) = 1900-01-01 Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		Case 22, 23 // HTTC_FORFAIT, ID_FOUR_FORFAIT
			dcVal=idw_1.GetItemDecimal(1, "MT_FORFAITAIRE")
			If isnull(dcVal) Then dcVal=0
			
			sVal= idw_1.GetItemString(1,sCols[iPos])
			if dcVal<>0 and (isNull(sVal) or Len(Trim(sVal)) = 0) Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		
		Case 18 // MT_DECOTE
			dcVal=idw_1.GetItemDecimal(1, sCols[iPos])
			If uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos) Then
				If idw_1.GetItemString (1, "TYP_DECOTE") =  "DECFIX" and dcVal = 0.00 Then
					sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
					if sPos ="" Then
						sPos = sCols[iPos]
					End if
				End if
			End if
		
		Case 19 // HTTC_DECOTE
			dcVal=idw_1.GetItemDecimal(1, "MT_DECOTE")
			If isnull(dcVal) Then dcVal=0
			
			sVal= idw_1.GetItemString(1,sCols[iPos])
			if (isNull(sVal) or Len(Trim(sVal)) = 0) and  idw_1.GetItemString(1,"TYP_DECOTE") <> "DECPCT" Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		Case 20 // TX_DECOTE
			dcVal=idw_1.GetItemDecimal(1, sCols[iPos])
			If uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos) Then
				If idw_1.GetItemString (1, "TYP_DECOTE") =  "DECPCT" and dcVal = 0.00 Then
					sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
					if sPos ="" Then
						sPos = sCols[iPos]
					End if
				End if
			End if
		Case 24 // TX_TVA
			dcVal=idw_1.GetItemDecimal(1, sCols[iPos])
			If uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos) Then
				If dcVal = 0.00 Then
					sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
					if sPos ="" Then
						sPos = sCols[iPos]
					End if
				End if
			End if
	End Choose
Next

If	sPos <> "" Then
	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des tarifs de reprise"
	stMessage.Icon		= Information!
	stMessage.sCode	= "GENE001"
	stMessage.berreurg = FALSE
	
	stMessage.sVar[1] = sErr + sNouvelleLigne
	
	f_Message ( stMessage )
End if


Return sPos
end function

public subroutine uf_reinitialiser ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_reinitialiser
//* Auteur			: F. Pinon
//* Date				:  02/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value u_transaction atrtrans	 */
/* 	ref u_datawindow adwdatawindow	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Datawindowchild dwChild
Long lNull
String sNull, sReinit

SetNull(lNull)

sReinit="N"

If idw_1.RowCount() > 0 Then
	sReinit=idw_1.GetItemString(1,"ALT_REINIT")
end if

idw_1.Reset()
idw_1.InsertRow(0)

idw_1.SetItem(1,"ALT_REINIT",sReinit)
idw_1.SetItem(1,"ALT_SANS_VALIDITE",'N')
idw_1.SetItem(1,"ALT_SANS_FIN_VALIDE",'N')

idw_1.SetItem(1,"ID_PROD",lNull)

idw_1.getchild( "ID_REV", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_REV",lNull)

idw_1.getchild( "ID_GTI", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_GTI",lNull)

idw_1.SetItem(1, "ID_METHODE",lNull)
idw_1.SetItem(1, "ID_BRK",sNull)

idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_FOUR",sNull)

idw_1.getchild( "ID_FOUR_FORFAIT", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_FOUR_FORFAIT",sNull)

idw_1.getchild( "ID_TYP_ART", dwChild )	
dwChild.Reset()
idw_1.SetItem(1, "ID_TYP_ART",sNull)

idw_1.getchild( "ID_MARQ_ART", dwChild )	
dwChild.Reset()
idw_1.SetItem(1, "ID_MARQ_ART",sNull)

idw_1.getchild( "ID_MODL_ART", dwChild )	
dwChild.Reset()
idw_1.SetItem(1, "ID_MODL_ART",sNull)

idw_1.SetItem(1, "DTE_DEB_EFF",lNull)
idw_1.SetItem(1, "DTE_FIN_EFF",lNull)
idw_1.SetItem(1, "TYP_EFF",lNull)

idw_1.SetItem(1, "DTE_DEB_EFF",lNull)
idw_1.SetItem(1, "DTE_FIN_EFF",lNull)
idw_1.SetItem(1, "TYP_EFF",lNull)

idw_1.SetItem(1, "TYP_VETUSTE",lNull)
idw_1.SetItem(1, "PER_CPLT",0)
idw_1.SetItem(1, "PER_CPLT_UT","J")

idw_1.SetItem(1, "TYP_MT_PIVOT",lNull)
idw_1.SetItem(1, "MT_PIVOT",0.00)
idw_1.SetItem(1, "HTTC_PIVOT","TTC")

idw_1.SetItem(1, "HTTC_DECOTE","TTC")
idw_1.SetItem(1, "TYP_DECOTE","AUCUNE")
idw_1.SetItem(1, "MT_DECOTE",0.00)

idw_1.SetItem(1, "TX_DECOTE",0.00)

idw_1.SetItem(1, "MT_FORFAITAIRE",0.00)
idw_1.SetItem(1, "HTTC_FORFAIT","TTC")

idw_1.SetItem(1, "ID_FOUR_FORFAIT",lNull)

idw_1.uf_proteger( {"ID_FOUR_FORFAIT","TX_DECOTE", "MT_PIVOT", "HTTC_PIVOT","MT_DECOTE","HTTC_DECOTE","ID_FOUR_FORFAIT","HTTC_FORFAIT"},"1")
idw_1.uf_proteger({"ALT_SANS_VALIDITE","ALT_SANS_FIN_VALIDE"},"0")

idw_1.SetItem(1, "TX_TVA",idctauxtva )
idw_1.SetItem(1, "PARAM_CPLT",lNull)

idw_grille_pivot.Reset()
idw_grille_pivot.enabled=FALSE


end subroutine

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_initialisation
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value u_transaction atrtrans	 */
/* 	ref u_datawindow adwdatawindow	 */
/* 	ref u_datawindow adw_grille	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Datawindowchild dwChild, dwChild2

itrtrans		= atrTrans					// Objet de transaction $$HEX2$$e0002000$$ENDHEX$$utiliser.
iDw_1			= adwDatawindow			

iDw_1.SetTransobject( itrTrans)

iDw_1.Getchild("id_prod",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve()

idw_1.getchild( "ID_REV", dwChild )		
dwChild.SetTransobject( atrTrans)
	
idw_1.getchild( "ID_GTI", dwChild )		
dwChild.SetTransobject( atrTrans)
		
idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.SetTransobject( atrTrans)

idw_1.getchild( "ID_FOUR_FORFAIT", dwChild )		
dwChild.SetTransobject( atrTrans)

idw_1.getchild( "ID_METHODE", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-06")

idw_1.getchild( "ID_BRK", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-01")

idw_1.getchild( "ID_TYP_ART", dwChild )	
dwChild.SetTransobject( atrTrans)

idw_1.getchild( "ID_MARQ_ART", dwChild )	
dwChild.SetTransobject( atrTrans)

idw_1.getchild( "ID_MODL_ART", dwChild )	
dwChild.SetTransobject( atrTrans)

idw_1.getchild( "TYP_EFF", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-02")

idw_1.getchild( "TYP_VETUSTE", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-03")

idw_1.getchild( "PER_CPLT_UT", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-04")

idw_1.getchild( "TYP_MT_PIVOT", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-05")

idw_1.getchild( "HTTC_PIVOT", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-09")

idw_1.getchild( "TYP_DECOTE", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-07")

idw_1.getchild( "HTTC_DECOTE", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-09")

idw_1.getchild( "HTTC_FORFAIT", dwChild )	
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve("-09")

idw_1.uf_initialisercouleur( {"ID_PROD", "ID_REV",  "ID_GTI", "ID_FOUR", "ID_METHODE", "ID_BRK", "ID_TYP_ART", "ID_MARQ_ART", "ID_MODL_ART"})
idw_1.uf_initialisercouleur( {"DTE_DEB_EFF", "DTE_FIN_EFF", "TYP_EFF"})

idw_1.uf_initialisercouleur( {"HTTC_PIVOT", "MT_PIVOT"})
idw_1.uf_initialisercouleur( { "MT_DECOTE"})
idw_1.uf_initialisercouleur( {"HTTC_DECOTE", "TX_DECOTE"})
idw_1.uf_initialisercouleur( 	{"PARAM_CPLT","HTTC_FORFAIT","ID_FOUR_FORFAIT"})

uf_resize_ddw(TRUE)

end subroutine

public function long uf_controlerzone_vts (long alrow, string asnomcol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controlerzone_vts
//* Auteur			: F. Pinon
//* Date				:  02/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asnomcol	 */
/* 	value string asval	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long  lRet, lRow, lPeriode
Decimal	dcMt, dcIdProd

lRet=0

// Si vide, OK
If isNull(asVal) Then Return 0
If Len(Trim(asVal)) = 0 Then Return 0

// Contr$$HEX1$$f400$$ENDHEX$$le par zone
Choose Case Upper(asNomCol)
	Case "MT_PIVOT_MIN"
		lRet = uf_zn_mt( asVal,TRUE,"MT_PIVOT_MIN")
		
		If lRet=0 Then
			if Dec(asVal) > idcmtfintranche Then lRet=1
		End if
		
		If lRet=0 Then
			If Dec(asVal) = -1.00 Then 
				dcMt = -1.00
			Else
				dcMt=  idw_grille_pivot.GetItemDecimal(alRow,"MT_PIVOT_MAX")
			End if
			
			If dcMt = -1.00 Then 
				dcMt =  Dec(asVal)
				idw_grille_pivot.SetItem(alRow,"MT_PIVOT_MAX",dcMt)
			End if
			
			if (Not isNull(dcMt)) and dcMt < Dec(asVal) Then lRet=1
			
			If Dec(asVal) = -1 and dcMt=-1 Then
				idw_grille_pivot.SetItem(alRow,"IE_MT_PIVOT_MIN","E")
				idw_grille_pivot.SetItem(alRow,"IE_MT_PIVOT_MAX","E")
			End if
		End if
		
	Case "MT_PIVOT_MAX"
		lRet = uf_zn_mt( asVal,TRUE,"MT_PIVOT_MAX")

		If lRet=0 Then
			if Dec(asVal) > idcmtfintranche Then lRet=1
		End if

		If lRet=0 Then
			If Dec(asVal) = -1.00 Then 
				dcMt = -1.00
			Else
				dcMt=  idw_grille_pivot.GetItemDecimal(alRow,"MT_PIVOT_MIN")
			End if
			
			If dcMt = -1.00 Then 
				dcMt =  Dec(asVal)
				idw_grille_pivot.SetItem(alRow,"MT_PIVOT_MIN",dcMt)
			End if
			
			if (Not isNull(dcMt)) and dcMt > Dec(asVal) Then lRet=1

			If Dec(asVal) = -1 and dcMt=-1 Then
				idw_grille_pivot.SetItem(alRow,"IE_MT_PIVOT_MIN","E")
				idw_grille_pivot.SetItem(alRow,"IE_MT_PIVOT_MAX","E")
			End if
		End if
		
	Case "IE_MT_PIVOT_MIN"
	Case "IE_MT_PIVOT_MAX"

	Case "PERIODE_MIN_J"
		if not isNull(asVal) Then
			lRet = uf_zn_periode(asval)
	
			If lRet=0 Then
				if Long(asVal) = -1 Then idw_grille_pivot.SetItem(alRow,"PERIODE_MAX_J",-1)
				
				lPeriode = idw_grille_pivot.GetItemNumber(alRow,"PERIODE_MAX_J")
				if (Not isNull(lPeriode)) Then
					if lPeriode=-1 Then 
						idw_grille_pivot.SetItem(alRow,"PERIODE_MAX_J",Long(asVal) )
					Else
						If lPeriode < Long(asVal) Then lRet=1
					End if
				End if
			End if
		
		End if
		
	Case "PERIODE_MAX_J"
		if not isNull(asVal) Then
			lRet = uf_zn_periode(asval)
	
			If lRet=0 Then
				lPeriode = idw_grille_pivot.GetItemNumber(alRow,"PERIODE_MIN_J")
				if (Not isNull(lPeriode)) and lPeriode > Long(asVal) Then lRet=1
			End if
	
		End if
	
	Case "TX_REPRISE"
		dcMt = Dec(asVal)
		if dcMt < 0 or dcMt > 1 Then lRet=1
		
End choose

Return lRet

end function

public function string uf_controler_oblig_vts ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controler_oblig_vts
//* Auteur			: F. Pinon
//* Date				: 14/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
// 			FPI	03/06/2011	[PM02.RetourNC] 
//*-----------------------------------------------------------------

String sPos, sVal, sErr,sErrTemp, sNouvelleLigne
Integer iPos
Decimal dcVal
Datetime dtVal
Long lRow, lVal
Boolean bPasVide, bErr

String sCols[]={"IE_MT_PIVOT_MIN", "MT_PIVOT_MIN", "MT_PIVOT_MAX", "IE_MT_PIVOT_MAX",&
	"PERIODE_MIN_J", "PERIODE_MAX_J", &
	"TX_REPRISE"}
	
String sLibCols[]={"l'inclusion du montant pivot minimum", "le montant pivot minimum","le montant pivot maximum","l'inclusion du montant pivot maximum", &
	"la p$$HEX1$$e900$$ENDHEX$$riode minimum","la p$$HEX1$$e900$$ENDHEX$$riode maximum", &
	"le taux de reprise"}


sNouvelleLigne	= "~r~n"

sPos=""
sErr=""

// Controle de saisie 
lRow=1

Do While lRow <= idw_grille_pivot.RowCount() 

	bPasVide=FALSE
	sErrTemp = ""
	
	
	For iPos = 1 To UpperBound(sCols)
		bErr=FALSE
		
		Choose case iPos
			Case 2,3,7
			dcVal= idw_grille_pivot.getItemDecimal(lRow,sCols[iPos])
			if isNull(dcVal) Then
				berr=TRUE
			Else
				bPasVide=TRUE
				if iPos=3 and dcVal=0.0 Then // [PM02.RetourNC]
					bErr=TRUE
				End if
			End if
						
			If bErr Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErrTemp +=sNouvelleLigne + " - " + sLibCols[iPos] + " - ligne " + string(lRow)
			End if
			
		Case 5,6
			lVal= idw_grille_pivot.GetItemNumber(lRow,sCols[iPos])
			if isNull(lVal) Then
				berr=TRUE
			Else
				bPasVide=TRUE
				if iPos=6 and lVal=0.0 Then  // [PM02.RetourNC]
					bErr=TRUE
				End if
			End if
			
			if bErr Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErrTemp +=sNouvelleLigne + " - " + sLibCols[iPos] + " - ligne " + string(lRow)
			End if
			
		Case 1,4
			sVal= idw_grille_pivot.GetItemString(lRow,sCols[iPos])
			if isNull(sVal) or Len(Trim(sVal)) = 0 Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErrTemp +=sNouvelleLigne + " - " + sLibCols[iPos] + " - ligne " + string(lRow)
			Else
				bPasVide=TRUE
			End if
		End Choose
		
	Next
	
	If bPasVide  Then
		if sErr<> "" Then sErr+=sNouvelleLigne
		sErr+=sErrTemp
		lRow++
	Else
		idw_grille_pivot.DeleteRow(lRow)
		sPos=""
	End if
Loop

If	sErr <> "" Then
	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des tarifs de reprise"
	stMessage.Icon		= Information!
	stMessage.sCode	= "GENE001"
	stMessage.berreurg = FALSE
	
	stMessage.sVar[1] = sErr + sNouvelleLigne
	
	f_Message ( stMessage )
End if


Return sPos
end function

public subroutine uf_initialisation (ref u_transaction atrtrans, ref u_datawindow adwdatawindow, ref u_datawindow_detail adw_grille);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_initialisation
//* Auteur			: F. Pinon
//* Date				: 02/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value u_transaction atrtrans	 */
/* 	ref u_datawindow adwdatawindow	 */
/* 	ref u_datawindow adw_grille	 */
/* 	ref datawindow adw_cree_le	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Datawindowchild dwChild, dwChild2

uf_initialisation( atrtrans, adwdatawindow)

idw_grille_pivot = adw_grille
idw_grille_pivot.SetTransobject( itrTrans)

idw_grille_pivot.GetChild("IE_MT_PIVOT_MIN",dwChild)
dwChild.SetTransObject( itrTrans)
dwChild.Retrieve("-08")

idw_grille_pivot.GetChild("IE_MT_PIVOT_MAX",dwChild2)
dwChild.Sharedata( dwChild2 )

end subroutine

private subroutine uf_resize_ddw (boolean aball);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_resize_ddw
//* Auteur			: F. Pinon
//* Date				: 29/03/2011 17:54:21
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


String sCols[]={"ID_REV","ID_GTI","ID_FOUR","ID_TYP_ART","ID_MARQ_ART","ID_MODL_ART","ID_FOUR_FORFAIT", &
	"ID_METHODE", "ID_BRK", "TYP_VETUSTE","PER_CPLT_UT","TYP_MT_PIVOT", &
	"HTTC_PIVOT","TYP_DECOTE","HTTC_DECOTE","HTTC_FORFAIT", "TYP_EFF"}
Long lCol, lNbRows

DatawindowChild dwc

For lCol=1 To UpperBound(sCols)
	if lCol > 7 and (not abAll) Then Exit
	
	idw_1.GetChild( sCols[lCol] ,dwc)
	
	lNbRows = dwc.RowCount()
	if lNbRows > 7 Then lNbRows=8
	
	idw_1.Modify(sCols[lCol] + ".dddw.Lines=" + string(lNbRows))
Next

end subroutine

private function long uf_zn_periode (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_periode
//* Auteur			: F. Pinon
//* Date				: 30/03/2011 09:28:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lRet, lPeriode

lRet = 0

if Not IsNumber(asVal) Then
	lRet=1
Else
	lPeriode=Long(asVal)
	if lPeriode < 0 And lPeriode <> -1.00 Then lRet=1
	if lPeriode > ilperiodefintranche Then lRet=1
End if

Return lRet
end function

private function integer uf_zn_mt (string asval, boolean bmoinsun, string asnomcol);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_mt
//* Auteur			: F. Pinon
//* Date				: 15/03/2011 15:02:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Integer iRet
Decimal dcMt

iRet=0

if (not isNull(asVal)) and asVal <> "" Then
	if Not IsNumber(asVal) Then
		iRet=1
	Else
		dcMt=Dec(asVal)
		if dcMt < 0 And Not (dcMt = -1.00 and bMoinsUn) Then iRet=1
	End if
Else
	Choose case asNomCol
		Case "MT_PIVOT_MAX","MT_PIVOT_MIN"
		Case Else
			idw_1.SetItem( 1, asnomcol, 0.00	)
			idw_1.uf_reinitialiser( )
	End choose
End if

Return iRet
end function

private function boolean uf_controler_oblig_dc (string asnomcol, string aslibcol, ref string aserr, ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_controler_oblig_dc
//* Auteur			: F. Pinon
//* Date				: 31/03/2011 11:38:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asnomcol	 */
/* 	value string aslibcol	 */
/* 	ref string aserr	 */
/* 	ref string aspos	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bRet
String sNouvelleLigne	
Decimal dcVal

sNouvelleLigne	= "~r~n"
bRet=TRUE

dcVal= idw_1.getItemDecimal(1,asnomcol)
if isNull(dcVal) Then
	if asPos ="" Then
		asPos = asnomcol
	End if
	asErr +=sNouvelleLigne + " - " + aslibcol
	bRet=FALSE
End if

Return bRet



end function

private subroutine uf_zn_alt_sans_validite (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_alt_sans_validite
//* Auteur			: F. Pinon
//* Date				: 08/04/2011 14:51:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Date dtMin,dtMax
String sNull

SetNull(sNull)

If asVal='O' Then
	dtMin=Date("01/01/1980")
	dtMax=Date("01/01/3000")
	idw_1.SetItem(1,"TYP_EFF","DTESRV")
	//idw_1.SetItem(1,"TYP_VETUSTE","ACHSRV") // [PM02.RetourNC]
	idw_1.uf_proteger({ "ALT_SANS_FIN_VALIDE"}, "1")
Else
	SetNull(dtMax)
	SetNull(dtMin)
	idw_1.SetItem(1,"TYP_EFF",sNull)
	idw_1.uf_proteger({ "ALT_SANS_FIN_VALIDE"}, "0")
End if

idw_1.SetItem(1,"DTE_DEB_EFF",dtMin)
idw_1.SetItem(1,"DTE_FIN_EFF",dtMax)
idw_1.SetItem(1,"ALT_SANS_FIN_VALIDE","N")




end subroutine

public subroutine uf_proteger_modif ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_proteger_modif
//* Auteur			: F. Pinon
//* Date				: 14/04/2011 14:27:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Protection des zones en modif
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

String sVal

idw_1.uf_proteger ( {"ID_PROD","ID_REV","ID_GTI","ID_BRK","ID_TYP_ART","ID_MARQ_ART","ID_MODL_ART", &
	"DTE_DEB_EFF","DTE_FIN_EFF","TYP_EFF","ID_FOUR","ID_METHODE","ALT_SANS_VALIDITE","ALT_SANS_FIN_VALIDE"}, "1")

if idw_1.GetItemDecimal(1,"MT_FORFAITAIRE") = 0.00 Then idw_1.uf_proteger( {"HTTC_FORFAIT","ID_FOUR_FORFAIT"},"1")

// Groupe d$$HEX1$$e900$$ENDHEX$$cote
sVal=idw_1.GetItemString(1,"TYP_DECOTE")

Choose Case sVal
	Case "DECFIX"
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE"},"0")
		idw_1.uf_proteger( {"TX_DECOTE"},"1")
		
	Case "DECPCT"
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE"},"1")
		idw_1.uf_proteger( {"TX_DECOTE"},"0")
		Case "AUCUNE"
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE","TX_DECOTE"},"1")
End Choose

// Groupe Mt_pivot
sVal=idw_1.GetItemString(1,"TYP_MT_PIVOT")

if sVal="FX" Then
	idw_1.uf_proteger( {"MT_PIVOT"},"0")
	idw_grille_pivot.enabled=FALSE
Else
	idw_1.uf_proteger( {"MT_PIVOT"},"1")
	idw_grille_pivot.enabled=TRUE
End if

Choose case sVal
	Case "VA","VP"
		idw_1.uf_proteger( {"HTTC_PIVOT"},"1")
	Case Else
		idw_1.uf_proteger( {"HTTC_PIVOT"},"0")	
End choose
end subroutine

private function integer uf_zn_typ_decote (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_typ_decote
//* Auteur			: F. Pinon
//* Date				: 15/03/2011 14:35:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Integer iRet = 0
String sNull

SetNull(sNull)

Choose Case asVal
	Case "DECFIX"
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE"},"0")
		idw_1.uf_proteger( {"TX_DECOTE"},"1")
		
	Case "DECPCT"
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE"},"1")
		idw_1.uf_proteger( {"TX_DECOTE"},"0")
		idw_1.SetItem(1,"MT_DECOTE",0.00)
	Case "AUCUNE"
		idw_1.SetItem(1,"MT_DECOTE",0.00)
		idw_1.uf_proteger( {"MT_DECOTE","HTTC_DECOTE","TX_DECOTE"},"1")
End Choose

idw_1.SetItem(1,"TX_DECOTE",0.00)
idw_1.SetItem(1,"HTTC_DECOTE","TTC")

Return iRet



end function

private function integer uf_zn_typ_mt_pivot (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_typ_mt_pivot
//* Auteur			: F. Pinon
//* Date				: 15/03/2011 10:27:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Integer iRet = 0
Integer iReponse
String sNull

SetNull(sNull)

if asVal="FX" Then
	If idw_grille_pivot.RowCount() > 0 Then
		stMessage.berreurg=FALSE
		stMessage.bouton=YesNo!
		stMessage.icon=Question!
		stMessage.sTitre="Modification du type de vetust$$HEX1$$e900$$ENDHEX$$"
		stMessage.scode="PATF002"
		iReponse=f_message(stMessage)
		if iReponse=1 Then
			idw_grille_pivot.Reset()
		Else
			Return 1
		End if
	End if
	
	If iRet=0 Then
		idw_1.uf_proteger( {"MT_PIVOT"},"0")
		idw_grille_pivot.enabled=FALSE
	End if
Else
	idw_1.uf_proteger( {"MT_PIVOT"},"1")
	idw_1.SetItem(1,"mt_pivot",0.00)
	idw_grille_pivot.enabled=TRUE
End if

Choose case asVal
	Case "VA","VP"
		idw_1.uf_proteger( {"HTTC_PIVOT"},"1")
		idw_1.SetItem(1,"HTTC_PIVOT","TTC")
	Case Else
		If idw_1.Describe("httc_pivot.protect")="1" Then 	idw_1.SetItem(1,"HTTC_PIVOT","TTC")
		idw_1.uf_proteger( {"HTTC_PIVOT"},"0")	
End choose

Return iRet
end function

private function integer uf_zn_idprod (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_ftu_brk::uf_zn_idprod
//* Auteur			: F. Pinon
//* Date				: 29/06/2011 11:22:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM02.29062011]
//*
//* Arguments		: value string asval	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DatawindowChild dwcChild
Long lRow
Integer iRet=0


idw_1.getchild( "ID_PROD", dwcChild )		
lRow= dwcChild.Find ( "id_prod=" + asVal, 1, dwcChild.RowCount () ) 

if lRow<=0 Then Return 1

If dwcChild.getItemString(lRow,"dp175")="OUI" Then
	idw_1.iiErreur=1
	stMessage.sVar[1]=asVal
	stMessage.sVar[2]=dwcChild.getItemString(lRow,"LIB_LONG")
	Return 1
End if

Return 0


end function

on u_sp_gs_param_ftu_brk.create
call super::create
end on

on u_sp_gs_param_ftu_brk.destroy
call super::destroy
end on

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_sp_gs_param_ftu_brk
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 10/03/2011 12:22:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   19/11/2013 [DT_60_AUGM_TVA]
//* 
//*-----------------------------------------------------------------

// [DT_60_AUGM_TVA] 1.196 0.196
idcTauxTva = 0.2

end event

