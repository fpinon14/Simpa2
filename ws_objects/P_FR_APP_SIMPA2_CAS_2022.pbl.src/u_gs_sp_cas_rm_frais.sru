HA$PBExportHeader$u_gs_sp_cas_rm_frais.sru
$PBExportComments$[PM72.2]
forward
global type u_gs_sp_cas_rm_frais from nonvisualobject
end type
end forward

global type u_gs_sp_cas_rm_frais from nonvisualobject
end type
global u_gs_sp_cas_rm_frais u_gs_sp_cas_rm_frais

type variables
u_datawindow idw1
u_datawindow idw2

long ilTypeRbt
Decimal idcMtRbt
end variables

forward prototypes
public subroutine uf_reinit_dw2 (boolean abactiver)
public subroutine uf_initialiser (ref u_datawindow adw1, ref u_datawindow adw2)
public subroutine uf_charger ()
public function long uf_zn_mtreg ()
public subroutine uf_valider ()
end prototypes

public subroutine uf_reinit_dw2 (boolean abactiver);//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_cas_rm_frais::wf_reinit_dw2
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 14:43:32
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
//* 		FPI	07/06/2012	[PM103]
//*-----------------------------------------------------------------

idw2.Reset()
idw2.InsertRow(0)

if abActiver Then
	idw2.uf_proteger( {"MT_REG"} , "0")
	idw2.SetItem(1,"MT_REG",idcMtRbt)

	If gbModeReprise_223 Then
		idw2.SetItem(1,"LIB_REG","[RBM] SPB FRAIS " + String(idw1.GetItemDecimal(1,"ID_SIN"))) 	// [PM103]
	Else
		idw2.SetItem(1,"LIB_REG","SPB FRAIS " + String(idw1.GetItemDecimal(1,"ID_SIN")))
	End if
	
	idw2.Modify( "b_regler.Enabled='Yes'")
Else
	idw2.uf_proteger( {"MT_REG"} , "1")
	idw2.Modify( "b_regler.Enabled='No'")
	idw2.SetItem(1,"LIB_REG","")
End if

end subroutine

public subroutine uf_initialiser (ref u_datawindow adw1, ref u_datawindow adw2);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_cas_rm_frais::uf_initialiser
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 15:22:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: ref u_datawindow adw1	 */
/* 	ref u_datawindow adw2	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	07/06/2012	[PM103)
//*-----------------------------------------------------------------
Long iTrouve

This.idw1=adw1
This.idw2=adw2

adw1.setTransObject(SQLCA)
adw2.setTransObject(SQLCA)

adw1.insertrow(0)

adw2.uf_initialisercouleur( {"MT_REG"})

uf_reinit_dw2(FALSE)

If glIdSinMemPM72 > 0 Then
	idw1.SetItem ( 1, "ID_SIN", glIdSinMemPM72 )
	glIdSinMemPM72 = 0
End If

// [PM103]
gbModeReprise_223=FALSE
SQLCA.PS_S01_AUTORISATION(223, stGlb.sCodOper, -1, iTrouve )
gbModeReprise_223 = (iTrouve > 0)

end subroutine

public subroutine uf_charger ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_cas_rm_frais::uf_charger
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 15:32:22
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
//* 		FPI	18/10/2011	[PM72][Point13]
//*			FPI	26/12/2011	[PM72_DOMCOM] - VDoc 6404
// 			FPI	03/01/2012	[PM72_ES] R$$HEX1$$e900$$ENDHEX$$vision du PM 72
//			FPI	07/06/2012	[PM103]
// 		FPI	27/02/2015	[VDOC16821] On se base sur le cp de l'assur$$HEX2$$e9002000$$ENDHEX$$ald la caisse
//*-----------------------------------------------------------------

Decimal dcIdSin
Boolean bActiver=TRUE
long lRet
integer iIdCliBq
String sVal

dcIdSin=idw1.GetItemDecimal(1,"ID_SIN")

If isnull(dcIdSin) Then
	stMessage.sCode		= "GENE001"
	stMessage.sVar[1] = Char(13) + "- un num$$HEX1$$e900$$ENDHEX$$ro de sinistre" + Char(13)
	
	f_message(stmessage)
	
	return
End if

SetNull(idcMtRbt)

// Retrieve des infos
idw1.Retrieve(dcIdSin)

If idw1.RowCount() = 0 Then
	// Ne doit pas arriver		
	stmessage.berreurg=FALSE
	stmessage.stitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72"
	stmessage.scode="WFRA015 "
	
	idw1.InsertRow(0)
	f_message(stmessage)
	bActiver=FALSE
End if

If bActiver Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'$$HEX1$$e900$$ENDHEX$$ligibilit$$HEX1$$e900$$ENDHEX$$
	ilTypeRbt=0
	idcMtRbt=0
	
	lRet = SQLCA.PS_VERIF_SIN_PARAM_FRAIS(dcIdSin, ilTypeRbt , idcMtRbt) // [PM72_ES][MEP] cl$$HEX4$$e9002000e0002000$$ENDHEX$$enlever dans cette PS
	
	If lRet < 0 Then
		stmessage.berreurg=FALSE
		stmessage.stitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72"
			
		Choose case lRet
			Case -1
				// un frais vers O2M d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pass$$HEX1$$e900$$ENDHEX$$
				stMessage.sCode		= "WFRA008"
			Case -2
				// pas de commande de diag O2M non annul$$HEX1$$e900$$ENDHEX$$e
				stMessage.sCode		= "WFRA010"
			Case -3
				// DP "142 - PM72:frais manuels interdits si O2M" pr$$HEX1$$e900$$ENDHEX$$sente
				stMessage.sCode		= "WFRA001" 
			Case -4
				// param absent
				stMessage.sCode		= "WFRA007" 

			Case -5 // [PM72][Point13]
				stMessage.sCode		= "WFRA008" 
				
			Case -6 // [PM72_DOMCOM]
				stMessage.sCode = "WFRA016"
				
		End choose
		bActiver=FALSE
		
		f_message(stmessage)
	End if
	
End if

// [VDOC16821]
sVal=idw1.GetItemString(1,"ADR_CP")
if Len(trim(sVal)) = 5 Then 
	sVal=Left(sVal,3)
Else 
	sVal=""
End if

Choose case sVal
	Case "971","972","973","974","975","976","984","986","987","988"
		//(971) Guadeloupe 
		// (972) Martinique 
		// (973) Guyane 
		// (974) La R$$HEX1$$e900$$ENDHEX$$union 
		// (975) Saint-Pierre-et-Miquelon 
		// (976) Mayotte 
		// (984) Terres Australes et Antarctiques 
		// (986) Wallis et Futuna 
		// (987) Polyn$$HEX1$$e900$$ENDHEX$$sie Fran$$HEX1$$e700$$ENDHEX$$aise 
		// (988) Nouvelle-Cal$$HEX1$$e900$$ENDHEX$$donie 
		stmessage.berreurg=FALSE
		stmessage.stitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72"
		stMessage.sCode		= "WFRA009"
		f_message(stmessage)
End choose
// :[VDOC16821]

// [PM72_ES]
If ilTypeRbt = 1 And bActiver Then
	// Param r$$HEX1$$e800$$ENDHEX$$glement auto
	if stGlb.stypoper >= "3" Then
		// For$$HEX1$$e700$$ENDHEX$$age RE autoris$$HEX1$$e900$$ENDHEX$$
		stmessage.stitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72"
		stMessage.sCode="WFRA004"
		stMessage.berreurg=FALSE
		stMessage.Icon = Question!
		stMessage.bouton = YesNo!
		stmessage.svar[1] = String(idcMtRbt)

		If f_message(stMessage) = 2 Then bActiver=FALSE

	End if
End if

Uf_reinit_dw2(bActiver)

if bActiver then
	idw2.SetItem(1,"ID_SIN",dcIdSin)
	idw2.SetItem(1,"MAJ_PAR",stglb.sCodOper)
	If gbModeReprise_223 Then
		idw2.SetItem(1,"MODE_REPRISE","O")
	Else
		idw2.SetItem(1,"MODE_REPRISE","N")
	End if
End if

	
end subroutine

public function long uf_zn_mtreg ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_mtreg (PRIVATE)
//* Auteur			: FPI	
//* Date				: 17/08/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification de la zone MT_REG
//* Commentaires	: 	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer	iAction
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
// 			FPI	 26/12/2011	[PM72_DOMCOM] Sur les dom_com, pas de montant > $$HEX2$$e0002000$$ENDHEX$$50
//*-----------------------------------------------------------------

Integer				iAction, iIdCliBq
Decimal dcMtReg

iAction = 0
idw2.iiErreur = 1

dcMtReg = Dec ( idw2.GetText () )

If IsNull ( dcMtReg ) or dcMtReg=0 And iAction = 0 Then
	iAction = 1
	idw2.iiErreur = 1
End If 

If (dcMtReg < 0 or dcMtReg > 50.00) And iAction = 0 Then
	iAction = 1
	idw2.iiErreur = 2
End If 

if iAction=0 and dcMtReg <> idcMtRbt and not isnull(idcMtRbt) Then
	if stGlb.stypoper >= "3" Then
		// For$$HEX1$$e700$$ENDHEX$$age RE autoris$$HEX1$$e900$$ENDHEX$$
		stMessage.sCode="WFRA005"
		stMessage.berreurg=FALSE
		stMessage.Icon = Question!
		stMessage.bouton = YesNo!
		stmessage.svar[1] = String(idcMtRbt)
		If f_message(stMessage) = 2 Then
			iAction = 1
			idw2.iiErreur = 3
		End if
	Else
		// Refus
		iAction = 1
		idw2.iiErreur = 4
		stmessage.svar[1] = String(idcMtRbt,"0.00")
	End if
End if

Return (iAction)

end function

public subroutine uf_valider ();
//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_cas_rm_frais::uf_valider
//* Auteur			: F. Pinon
//* Date				: 17/08/2011 17:02:24
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
Decimal dcMtReg

dcMtReg=idw2.GetItemDecimal(1,"MT_REG")
If isnull(dcMtReg) Then
	stmessage.berreurg=FALSE

	stmessage.sTitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72 "
	stMessage.scode="GENE001"

	stMessage.sVar[1]=Char(13) + "- le montant du r$$HEX1$$e800$$ENDHEX$$glement" + Char(13)
	f_message(stMessage)
	
	Return
End if

idw2.Modify( "b_regler.Enabled='No'")

stmessage.berreurg=FALSE

stmessage.sTitre="R$$HEX1$$e800$$ENDHEX$$glement manuel frais d$$HEX1$$1920$$ENDHEX$$envoi PM72 "
stMessage.scode="WFRA011"

stMessage.sVar[1]=idw1.GetItemString(1,"nom_assure")
stMessage.sVar[2]=String(dcMtReg,"0.00")

stMessage.bouton=YesNo!
stMessage.icon=Question!

If f_message(stmessage) = 1 Then

	// Validation
	idw2.Update()
	
	If SQLCA.SQLCode<> 0 or SQLCA.SQLDBCode<> 0 Then
		f_commit(SQLCA,FALSE)
	Else
		f_commit(SQLCA,TRUE)
	End if
	
	//Message d'info
	stMessage.scode="WFRA012"
	stMessage.bouton=OK!
	stMessage.icon=Information!
	
	if not gbModeReprise_223 Then f_message(stmessage) 
	
	// R$$HEX1$$e900$$ENDHEX$$init total de la fen$$HEX1$$ea00$$ENDHEX$$tre
	uf_initialiser(idw1,idw2)
Else
	idw2.Modify( "b_regler.Enabled='Yes'")
End if
end subroutine

on u_gs_sp_cas_rm_frais.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_cas_rm_frais.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

