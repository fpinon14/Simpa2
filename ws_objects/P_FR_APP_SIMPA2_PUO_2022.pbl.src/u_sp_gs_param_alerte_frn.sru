HA$PBExportHeader$u_sp_gs_param_alerte_frn.sru
$PBExportComments$[PM95] User Object pour les contr$$HEX1$$f400$$ENDHEX$$les relatifs aux param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs
forward
global type u_sp_gs_param_alerte_frn from u_spb_gs_anc
end type
end forward

global type u_sp_gs_param_alerte_frn from u_spb_gs_anc
end type
global u_sp_gs_param_alerte_frn u_sp_gs_param_alerte_frn

type variables
String isMode

end variables

forward prototypes
public function integer uf_controlerzone (string asnomcol, string asval)
public function string uf_controler ()
public function string uf_controler_oblig ()
public subroutine uf_reinitialiser ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
private subroutine uf_resize_ddw (boolean aball)
private function boolean uf_controler_oblig_dc (string asnomcol, string aslibcol, ref string aserr, ref string aspos)
public subroutine uf_proteger_modif ()
private function integer uf_zn_idprod (string asval)
end prototypes

public function integer uf_controlerzone (string asnomcol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_controlerzone
//* Auteur			: F. Pinon
//* Date				:  17/11/2011
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
//*-----------------------------------------------------------------
DatawindowChild dwcChild
Long lNull, lRet, lRow
String sIdFour, sNull, sVal
Decimal	dcMt, dcIdProd
n_cst_string nvString

SetNull(lNull)
SetNull(sNull)

lRet=0

Choose Case Upper(asNomCol)
	Case "ID_PROD"
		
		if not isnull(asval) and trim(asVal)<> "" Then
			If uf_zn_idprod(asVal) = 1 Then Return 1 // [PM02.29062011]
		End if
		
		
		idw_1.getchild( "ID_GTI", dwcChild )		
		dwcChild.Retrieve(dec(asVal))
		idw_1.SetItem(1,"ID_GTI", -1)
	
		idw_1.getchild( "ID_FOUR", dwcChild )		
		dwcChild.Retrieve(dec(asVal), -1.00)
		idw_1.SetItem(1,"ID_FOUR", "-1")
		
		uf_resize_ddw( FALSE)
		
	Case "ID_GTI"
		dcIdProd =idw_1.GetItemNumber( 1, "ID_PROD")
		
		idw_1.getchild( "ID_FOUR", dwcChild )		
		dwcChild.Retrieve(dcIdProd, dec(asVal))
		idw_1.SetItem(1,"ID_FOUR", lNull)
		
		uf_resize_ddw( FALSE)
		
	Case "ID_FOUR"
	
	Case "ID_ALERTE"
		idw_1.getchild( "ID_ALERTE", dwcChild )		
		lRow = dwcChild.Find("ID_ALERTE=" + asVal, 1, dwcChild.RowCount())
		
		If lRow > 0 Then
			sVal=dwcChild.GetItemString(lRow, "NAT_ALERTE")
			sVal=nvString.of_globalreplace( sVal, "~'", "~~'")
			idw_1.Modify("t_nature_alerte.Text='" + sVal + "'")
			
			sVal=dwcChild.GetItemString(lRow, "LIB_ALERTE")
			sVal=nvString.of_globalreplace( sVal, "~'", "~~'")
			idw_1.Modify("t_desc_alerte.Text='" + sVal + "'")
		End if
		
	Case "ALT_ACTIF"
		
	Case "DEL_EXTR_J"
		If asVal="" or isNull(asVal) Then 
			idw_1.SetItem(1,"DEL_EXTR_J", 0)
			idw_1.uf_reinitialiser( )
		Else 
			If Long(asVal) < 0 Then
				Return 1
			End if
		End if
		
	Case "RELANCE_2"
		
End choose

Return lRet

end function

public function string uf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_controler
//* Auteur			: F. Pinon
//* Date				:  17/11/2011
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

String sPos, sFour
Integer iIdAlerte

sPos=""
stMessage.berreurg = FALSE
stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie du param$$HEX1$$e900$$ENDHEX$$trage des alertes fournisseurs"

iIdAlerte = idw_1.getItemNumber( 1, "ID_ALERTE")
sFour = idw_1.GetItemString(1, "ID_FOUR")

Choose Case iIdAlerte
	Case 6,8
		If sFour <> "SB1" Then
			sPos="ID_ALERTE"
			stmessage.scode="PAAF001"  
			stmessage.sVar[1] = String(iIdAlerte)
			stmessage.sVar[2] = "SBE (SB1)"
		End if
	Case 2
		If sFour <> "O2M" And sFour <> "MS1" Then
			sPos="ID_ALERTE"
			stmessage.scode="PAAF002" 
			stmessage.sVar[1] = String(iIdAlerte)
			stmessage.sVar[2] = "O2M et MSS (MS1)"
		End if
	Case 12
		If sFour <> "O2M" Then
			sPos="ID_ALERTE"
			stmessage.scode="PAAF001"  
			stmessage.sVar[1] = String(iIdAlerte)
			stmessage.sVar[2] = "O2M"
		End if
		
End Choose


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
//* Fonction		: u_sp_gs_param_alerte_frn::uf_controler_oblig
//* Auteur			: F. Pinon
//* Date				:  17/11/2011
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
Date dtVal

String sCols[]={"ID_PROD","ID_GTI","ID_FOUR","ID_ALERTE", "DEL_EXTR_J"}
	
String sLibCols[]={"le produit","la garantie","le prestataire","l'alerte", 	"le d$$HEX1$$e900$$ENDHEX$$lai d'extraction"}


sNouvelleLigne	= "~r~n"

sPos=""
sErr=""

// Controle de saisie 
For iPos = 1 To UpperBound(sCols)
	Choose case iPos
		Case 1,2
			uf_controler_oblig_dc( sCols[iPos] ,  sLibCols[iPos], sErr, sPos)
			
		Case 4, 5 //  "DEL_EXTR_J", "ID_ALERTE"
			iVal= idw_1.GetItemNumber(1,sCols[iPos])
			if isNull(iVal) Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
		Case 3
			sVal= idw_1.GetItemString(1,sCols[iPos])
			if isNull(sVal) or Len(Trim(sVal)) = 0 Then
				if sPos ="" Then
					sPos = sCols[iPos]
				End if
				sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
			End if
	End Choose
Next

If	sPos <> "" Then
	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des alertes fournisseurs"
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
//* Fonction		: u_sp_gs_param_alerte_frn::uf_reinitialiser
//* Auteur			: F. Pinon
//* Date				:   17/11/2011
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

idw_1.SetItem(1,"ID_PROD",lNull)


idw_1.getchild( "ID_GTI", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_GTI",lNull)

idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.Reset()
idw_1.SetItem(1, "ID_FOUR",sNull)

idw_1.uf_proteger ( {"ID_PROD","ID_GTI","ID_FOUR","ID_ALERTE","ALT_ACTIF","DEL_EXTR_J","RELANCE_2"}, "0")

end subroutine

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_initialisation
//* Auteur			: F. Pinon
//* Date				:  17/11/2011
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

Datawindowchild dwChild

itrtrans		= atrTrans					// Objet de transaction $$HEX2$$e0002000$$ENDHEX$$utiliser.
iDw_1			= adwDatawindow			

iDw_1.SetTransobject( itrTrans)

iDw_1.Getchild("id_prod",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve()

idw_1.getchild( "ID_GTI", dwChild )		
dwChild.SetTransobject( atrTrans)
		
idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.SetTransobject( atrTrans)

iDw_1.Getchild("id_alerte",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve()

idw_1.uf_initialisercouleur( {"ID_PROD","ID_GTI","ID_FOUR","ID_ALERTE","DEL_EXTR_J"})

uf_resize_ddw(TRUE)

end subroutine

private subroutine uf_resize_ddw (boolean aball);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_resize_ddw
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

public subroutine uf_proteger_modif ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_proteger_modif
//* Auteur			: F. Pinon
//* Date				: 17/11/2011
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


idw_1.uf_proteger ( {"ID_PROD","ID_GTI","ID_FOUR","ID_ALERTE"}, "1")
idw_1.uf_proteger ( {"ALT_ACTIF","DEL_EXTR_J","RELANCE_2"},"0")


end subroutine

private function integer uf_zn_idprod (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_alerte_frn::uf_zn_idprod
//* Auteur			: F. Pinon
//* Date				: 17/11/2011
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

DatawindowChild dwcChild
Long lRow
Integer iRet=0


idw_1.getchild( "ID_PROD", dwcChild )		
lRow= dwcChild.Find ( "id_prod=" + asVal, 1, dwcChild.RowCount () ) 

if lRow<=0 Then Return 1

Return 0


end function

on u_sp_gs_param_alerte_frn.create
call super::create
end on

on u_sp_gs_param_alerte_frn.destroy
call super::destroy
end on

event constructor
call super::constructor
end event

