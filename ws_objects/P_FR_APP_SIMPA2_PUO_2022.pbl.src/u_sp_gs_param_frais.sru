HA$PBExportHeader$u_sp_gs_param_frais.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les relatifs aux param$$HEX1$$e900$$ENDHEX$$trage des frais
forward
global type u_sp_gs_param_frais from u_spb_gs_anc
end type
end forward

global type u_sp_gs_param_frais from u_spb_gs_anc
end type
global u_sp_gs_param_frais u_sp_gs_param_frais

forward prototypes
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
public function integer uf_controlerzone (string asnomcol, string asval)
public function string uf_controler ()
public function string uf_controler_oblig ()
public subroutine uf_reinitialiser ()
end prototypes

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_frais::uf_initialisation
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 09:58:39
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
//* 		FPI	07/10/2013	 [VDOC12347]
//*-----------------------------------------------------------------

Datawindowchild dwChild

itrtrans		= atrTrans					// Objet de transaction $$HEX2$$e0002000$$ENDHEX$$utiliser.
iDw_1			= adwDatawindow			// Datawindow $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.

iDw_1.SetTransobject( itrTrans)

iDw_1.Getchild("id_prod",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.Retrieve()

idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.SetTransobject( atrTrans)
	
idw_1.getchild( "ID_GTI", dwChild )		
dwChild.SetTransobject( atrTrans)
		
idw_1.getchild( "ID_PROCESS", dwChild )	
dwChild.SetTransobject( atrTrans)

// [VDOC12347]
idw_1.uf_initialisercouleur(  {"MT_RBT"})
idw_1.uf_proteger ({ "MT_RBT"}, "1") 





end subroutine

public function integer uf_controlerzone (string asnomcol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_frais::uf_controlerzone
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 11:19:27
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
//* 		FPI	11/12/2012	[PC877]
//* 		FPI	07/10/2013	 [VDOC12347]
//			FPI	07/01/2015	[VDOC16435]
// 			FPI	17/04/2015	[DT141]
//*-----------------------------------------------------------------
DatawindowChild dwcChild
Long lIdProd, lNull
String sIdFour, sNull
Decimal	dcMtRbt
String sOldIdFour
Long lOldIdGti, lOldIdProcess

SetNull(lNull)
SetNull(sNull)

// [VDOC16435] - contr$$HEX1$$f400$$ENDHEX$$le zone saisissable produit
if asVal <> "" Then
	Choose Case Upper(asNomCol)
		Case "ID_PROD"
			idw_1.getchild( "ID_PROD", dwcChild )	
			if dwcChild.Find("ID_PROD=" + asVal,1,dwcChild.RowCount()) <=0 Then
				Return 1
			End if
	End Choose
End if

sOldIdFour = idw_1.getItemString(1, "ID_FOUR")
lOldIdGti= idw_1.GetItemNumber( 1, "ID_GTI")
lOldIdProcess= idw_1.GetItemNumber( 1, "ID_PROCESS")
// [VDOC16435] 


Choose Case Upper(asNomCol)
	Case "ID_PROD"
		
		idw_1.getchild( "ID_FOUR", dwcChild )		
		dwcChild.Retrieve(long(asVal))
		
		// [DT141]

		// Filtre pour n'avoir qu'O2M & SBETV
		dwcChild.SetFilter("ID_CODE_FRN in ('O2M','SBE')")
		dwcChild.Filter()
		
		if dwcChild.Rowcount( ) =1 Then 
			// Si un seul item, on le met par d$$HEX1$$e900$$ENDHEX$$faut et on retrieve la garantie
			idw_1.SetItem(1,"ID_FOUR",dwcChild.GetItemString(1,"ID_CODE_FRN"))

			idw_1.getchild( "ID_GTI", dwcChild )		
			dwcChild.Retrieve(long(asVal), idw_1.GetItemString(1,"ID_FOUR"))
		End if
		// :[DT141]			
			
		// [VDOC16435] 
		If not isnull(lOldIdGti) Then
			If dwcChild.Find("ID_GTI=" + String(lOldIdGti),1,dwcChild.RowCount()) > 0 Then
				idw_1.SetItem(1,"ID_GTI", lOldIdGti)
			Else
				idw_1.SetItem(1,"ID_GTI", lNull)
				SetNull(lOldIdGti)
			End if
		End if
		// :[VDOC16435] 

		/*** Si on ne force pas O2M
		idw_1.getchild( "ID_GTI", dwcChild )		
		dwcChild.Reset()
		idw_1.SetItem(1,"ID_GTI", lNull)
		*/
		idw_1.getchild( "ID_PROCESS", dwcChild )		
		
		If isnull(lOldIdGti) Then
			dwcChild.Reset()
			idw_1.SetItem(1,"ID_PROCESS", lNull)
		ElseIf not isnull(lOldIdProcess) Then
			If dwcChild.Find("ID_PROCESS=" + String(lOldIdProcess),1,dwcChild.RowCount()) > 0 Then
				idw_1.SetItem(1,"ID_PROCESS", lOldIdProcess)
			Else
				idw_1.SetItem(1,"ID_PROCESS", lNull)
			End if
		End if		
		
	Case "ID_FOUR"
		lIdProd =idw_1.GetItemNumber( 1, "ID_PROD")
				
		idw_1.getchild( "ID_GTI", dwcChild )		
		dwcChild.Retrieve(lIdProd, asVal)
		idw_1.SetItem(1,"ID_GTI", lNull)
		
		idw_1.getchild( "ID_PROCESS", dwcChild )		
		dwcChild.Reset()
		idw_1.SetItem(1,"ID_PROCESS", lNull)

	Case "ID_GTI"
		lIdProd =idw_1.GetItemNumber( 1, "ID_PROD")
		sIdFour = idw_1.GetItemString( 1, "ID_FOUR")
		
		idw_1.getchild( "ID_PROCESS", dwcChild )		
		dwcChild.Retrieve(lIdProd, sIdFour, long(asVal))
		
		If not isnull(lOldIdProcess) Then
			If dwcChild.Find("ID_PROCESS=" + String(lOldIdProcess),1,dwcChild.RowCount()) > 0 Then
				idw_1.SetItem(1,"ID_PROCESS", lOldIdProcess)
			Else
				idw_1.SetItem(1,"ID_PROCESS", lNull)
			End if
		End if		
		
	Case "MT_RBT"
		dcMtRbt = idw_1.GetItemNumber( 1, "MT_RBT")
		If not isNull(dcMtRbt) and dcMtRbt < 0 Then
			stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des frais - SIMPA2"
			stMessage.Icon			= Information!

			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] = "montant de remboursement"
			stMessage.sCode	= "GENE003"
			
			f_Message(stMessage)
			
			idw_1.SetItem(1, "MT_RBT",0)
		End if
		
	Case "ID_PROCESS"
		//	[VDoc12347]
		if asVal<> "" Then
			itrtrans.PS_S01_PARAM_FRAIS_DEFAUT(Dec(asVal), dcMtRbt)
			idw_1.SetItem(1, "MT_RBT",dcMtRbt)
		End if

End choose

Return 0

end function

public function string uf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_frais::uf_controler
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 14:34:34
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
// 			FPI	17/04/2015	[DT141]
//*-----------------------------------------------------------------

String sPos, sFour
Decimal dcMtPec[], dcMtRbt, dcIdProd, dcIdGti, dcIdProcess
Integer iPos
Long lIdSeq

sPos=""


dcMtPec[1] = idw_1.getItemDecimal( 1, "COD_PEC_SPB")
dcMtPec[2] = idw_1.getItemDecimal( 1, "COD_PEC_ASSUREUR")
dcMtPec[3] = idw_1.getItemDecimal( 1, "COD_PEC_PRESTA")

If dcMtPec[1] + dcMtPec[2] +dcMtPec[3]  <> 100 Then
	stmessage.scode="PAFR001"
	sPos="COD_PEC_SPB"
End if

if sPos = "" Then
	dcMtRbt = idw_1.getItemDecimal( 1, "MT_RBT")
	If dcMtRbt <= 0 or dcMtRbt > 100 Then
		stmessage.scode="PAFR002"
		sPos="MT_RBT"
	End if
End if

if sPos = "" Then
	sFour = idw_1.getItemstring( 1, "ID_FOUR")
	
	// [DT141]
	Choose Case sFour
		Case "O2M","SBE"
			// On laisse
		Case else
			stmessage.scode="PAFR003"
			sPos="ID_FOUR"
	End choose
	// :[DT141]
	
End if

if sPos = "" and isNull(idw_1.getItemNumber(1,"ID_SEQ")) Then
	dcIdProd = idw_1.getItemDecimal( 1, "ID_PROD")
	dcIdGti = idw_1.getItemDecimal( 1, "ID_GTI")
	dcIdProcess = idw_1.getItemDecimal( 1, "ID_PROCESS")
	
	lIdSeq=-1
	
	itrtrans.PS_Verif_param_frais( dcidprod, sfour, dcidgti, dcidprocess, lidseq)
	If not isnull(lIdSeq) And lIdSeq > 0 Then
		stmessage.scode="PAFR004"
		sPos="ID_PROD"
	End if
End if

If	sPos <> "" Then
	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie du param$$HEX1$$e900$$ENDHEX$$trage des frais"
	stMessage.Icon		= Information!
	stMessage.berreurg = FALSE
	
	f_Message ( stMessage )
End if

Return sPos
end function

public function string uf_controler_oblig ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_param_frais::uf_controler_oblig
//* Auteur			: F. Pinon
//* Date				: 23/10/2009 09:16:10
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
//* 		FPI	16/09/2010	[PM72] Ajout de la colonne "TYP_RBT"
//*-----------------------------------------------------------------

String sPos, sVal, sErr, sNouvelleLigne
Integer iPos
Decimal dcVal
String sCols[]={"ID_PROD","ID_GTI","ID_PROCESS","COD_PEC_SPB","COD_PEC_ASSUREUR", &
	"COD_PEC_PRESTA", "MT_RBT","TYP_RBT"}
	
String sLibCols[]={"le produit","la garantie","le process","la prise en charge SPB", &
	"la prise en charge assureur","la prise en charge prestataire", "le montant du remboursement","le type de remboursement"}


sNouvelleLigne	= "~r~n"

sPos=""
sErr=""

// Contr$$HEX1$$f400$$ENDHEX$$le de saisie du fournisseur
sVal=idw_1.getItemString(1,"ID_FOUR")

if isNull(sVal) Then
	sErr="- le fournisseur"
	sPos="ID_FOUR"
End if

// Controle de saisie des valeurs d$$HEX1$$e900$$ENDHEX$$cimales
For iPos = 1 To UpperBound(sCols)
	dcVal= idw_1.getItemDecimal(1,sCols[iPos])
	if isNull(dcVal) Then
		if sPos ="" Then
			sPos = sCols[iPos]
		End if
		sErr +=sNouvelleLigne + " - " + sLibCols[iPos]
	End if
Next

If	sPos <> "" Then
	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie du param$$HEX1$$e900$$ENDHEX$$trage des frais"
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
//* Fonction		: u_sp_gs_param_frais::uf_reinitialiser
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 09:58:39
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

idw_1.getchild( "ID_FOUR", dwChild )		
dwChild.Reset()
	
idw_1.getchild( "ID_GTI", dwChild )		
dwChild.Reset()
		
idw_1.getchild( "ID_PROCESS", dwChild )	
dwChild.Reset()





end subroutine

on u_sp_gs_param_frais.create
call super::create
end on

on u_sp_gs_param_frais.destroy
call super::destroy
end on

