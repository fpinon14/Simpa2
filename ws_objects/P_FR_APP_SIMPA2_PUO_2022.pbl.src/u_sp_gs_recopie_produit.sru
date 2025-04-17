$PBExportHeader$u_sp_gs_recopie_produit.sru
$PBExportComments$---} User Object pour la recopie de produits
forward
global type u_sp_gs_recopie_produit from u_spb_gs_anc
end type
end forward

global type u_sp_gs_recopie_produit from u_spb_gs_anc
end type
global u_sp_gs_recopie_produit u_sp_gs_recopie_produit

type variables
u_DataWindow	iDw_2
end variables

forward prototypes
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
public function integer uf_zn_trt ()
public function integer uf_zn_cod_prod_src ()
public function string uf_gs_id_produit (decimal adcidprod)
public function boolean uf_zn_gestion_boutique (decimal adcidprod)
public subroutine uf_zn_suppr (string ascol)
public function integer uf_valider ()
public function integer uf_ps_suppr (string asnomproc, decimal adcidprod, string asvalues)
public subroutine uf_trace (long lidcle, string sresultat)
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow, u_datawindow adwdatawindow2)
public function string uf_controlergestion (boolean abrecopiebase)
public function integer uf_valider (boolean abinterbase)
end prototypes

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_initialisation
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 10:32:13
//* Libellé			: 
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

itrtrans		= atrTrans					// Objet de transaction à utiliser.
iDw_1			= adwDatawindow			// Datawindow à contrôler.

iDw_1.InsertRow(0)

iDw_1.Getchild("code_prod_src",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.SetSort("id_prod")
dwChild.Retrieve()

iDw_1.Getchild("code_rev_src",dwChild)
dwChild.SetTransobject( atrTrans)
dwChild.InsertRow(0)



end subroutine

public function integer uf_zn_trt ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_zn_trt
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 10:41:57
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lRet

lRet=0

Choose Case iDw_1.isnomcol
	Case "CODE_PROD_SRC"
		lRet=uf_zn_cod_prod_src()
	Case "SUPPR_GTI","SUPPR_OPT"
		uf_zn_suppr( iDw_1.isnomcol)
		lRet=2
End Choose

Return lRet
end function

public function integer uf_zn_cod_prod_src ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_zn_cod_prod_src
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 11:51:41
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Decimal dcIdProd
DatawindowChild dwChild
long lNull

setNull(lNull)

if idw_1.GetText () <> "" Then
	
	dcIdProd = dec(idw_1.GetText ())
	
	// Contrôle de validité de la saisie
	idw_1.getchild("code_prod_src",dwChild)
	if dwChild.find( "id_prod=" + string(dcIdProd), 1,dwChild.RowCount()) <=0 Then
		// Erreur
		Return 1
	end if

	// Mise à jour de la liste des révisions
	idw_1.getchild("rev_prod_src",dwchild)
	dwchild.SetTransObject(itrtrans)
	dwchild.Retrieve(dcIdProd)

	// Mise à jour de la boutique
	if uf_zn_gestion_boutique(dcIdProd) Then
		idw_1.SetItem(1,"PRES_BOUTIQUE","O")
	else
		idw_1.SetItem(1,"PRES_BOUTIQUE","N")
	end if
Else
	// Rien de saisie
	idw_1.SetItem(1,"PRES_BOUTIQUE","N")
	
	idw_1.getchild("rev_prod_src",dwchild)
	dwchild.Reset()
end if

idw_1.setitem(1,"rev_prod_src",lNull)

Return 0
end function

public function string uf_gs_id_produit (decimal adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	UF_GS_ID_PRODUIT
//* Auteur			:	FPI
//* Date				:	11/12/2008
//* Libellé			:	Vérification de l'unicité de l'identifiant des
//*					 	produits.
//* Commentaires	:	
//*
//* Arguments		:	Long		adcIdProd		//Identifiant du produit
//*
//* Retourne		:	String    "" s'il n'existe pas de produit avec cet Identifiant
//*									sLibProduit si un produit existe
//*
//*-----------------------------------------------------------------

String  sLibCourt		// Libellé du produit correspondant à l'identifiant 
							// passé en paramètre


sLibCourt	= space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe déjà un produit avec l'identifiant         */
/* passé en paramêtre                                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S03_PRODUIT ( adcIdProd, slibCourt )

Return ( Trim ( sLibCourt ) )
end function

public function boolean uf_zn_gestion_boutique (decimal adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_gestion_boutique
//* Auteur			:	FPI
//* Date				:	11/12/2008
//* Libellé			:	Controle l'existence de boutique
//*
//* Arguments		:	long		aiIdProd	
//*
//* Retourne		:	boolean
//*
//*-----------------------------------------------------------------

Integer iRetGef
Boolean bRet

bRet = true

iRetGef = SQLCA.PS_S01_GESTION_BOUTIQUE_V00 ( adcIdProd  )
if iRetGef <= 0 then	bRet = false

return bRet
end function

public subroutine uf_zn_suppr (string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_zn_suppr
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 10:48:00
//* Libellé			: Supprime les caractères invalides dans les zones de suppression de garantie et d'options
//* Commentaires	: 
//*
//* Arguments		: value string ascol	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sTexteSrc, sTexte
String sCar
Long lPos, lLen
n_cst_string uString

sTexteSrc = idw_1.GetText ()
lLen=Len(sTexteSrc)
sTexte=""

// 1. On supprime les caractères invalides
For lPos= 1 To lLen
	sCar=Mid(sTexteSrc,lPos,1)
	if IsNumber(sCar) Or sCar=',' Then sTexte +=sCar
Next

// 2. On supprime les ,,
Do While Pos(sTexte,",,") > 0
	sTexte=uString.of_globalreplace(sTexte,",,",",")
Loop

// 3. Suppression de la , au début et à la fin du texte
if Left(sTexte,1) = ',' Then sTexte=Right(sTexte,Len(sTexte) -1)
if Right(sTexte,1) = ',' Then sTexte=Left(sTexte,Len(sTexte) -1)

idw_1.SetItem(1,asCol,sTexte)


end subroutine

public function integer uf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_valider
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 13:52:32
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	FPI	28/01/2009		Correction bug d'apostrophe dans le lib
//*-----------------------------------------------------------------
Integer iRet=0
String sReq, sSuppr
Decimal dcIdProdDest, dcIdRevDest, dcIdProdSrc, dcIdRevSrc
String sLibLong, sLibCourt, sCodEffRev, sLibRev
datetime dtDateEff
String sMajPar, sCopieBoutique
Long lIdCle
String sErr, sProc
n_cst_string uString // #1

dcIdProdSrc = idw_1.getItemnumber(1,"CODE_PROD_SRC")
dcIdRevSrc = idw_1.getItemnumber(1,"REV_PROD_SRC")
dcIdProdDest = idw_1.getItemnumber(1,"CODE_PROD_DEST")
dcIdRevDest = idw_1.getItemnumber(1,"REVISION")

sLibLong = idw_1.GetItemString(1,"LIB_LONG")
sLibCourt = idw_1.GetItemString(1,"LIB_COURT")

// #1 - Correction erreur d'apostrophe dans les lib
sLibLong = uString.of_globalreplace( sLibLong, "'", "''")
sLibCourt = uString.of_globalreplace( sLibCourt, "'", "''")

sCodEffRev = idw_1.GetItemString(1,"EFF_REV")
sLibRev = idw_1.GetItemString(1,"LIB_REV")
dtDateEff = idw_1.GetItemDateTime(1,"DATE_EFF") // [PI056] date-> datetime
sMajPar = idw_1.GetItemString(1,"MAJ_PAR")
sCopieBoutique = idw_1.GetItemString(1,"COPIE_BOUTIQUE") 

// Trace
SQLCA.PS_I01_TRACE_RECOPIE_PRODUIT(dcIdProdSrc, dcIdRevSrc, &
	dcIdProdDest, dcIdRevDest, sLibLong, sLibCourt, sCodEffRev, sLibRev, &
	dtDateEff, sMajPar, sCopieBoutique, &
	 idw_1.GetItemString(1,"SUPPR_OPT") , idw_1.GetItemString(1,"SUPPR_GTI"), &
	 "Recopie en cours", lIdCle)

F_Commit  (SQLCA , SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 )
		
// Recopie
sErr = "PS_I01_RECOPIE_PRODUIT : "

sReq="EXECUTE sysadm.PS_I01_RECOPIE_PRODUIT " + &
	string(dcIdProdSrc,"#####") + "," + &
	string(dcIdRevSrc) + "," + &
	string(dcIdProdDest,"#####") + "," + &
	string(dcIdRevDest) + ",'" + &
	sLibLong + "','" + 	sLibCourt + "','" + &
	sCodEffRev + "','" + sLibRev + "','" + String(dtDateEff) + "','" + &
	sMajPar + "','" + sCopieBoutique + "'" 

If F_Execute ( sReq, SQLCA ) Then 
	If SQLCA.SQLCode <> 0 And SQLCA.SQLDBCode <> 0 Then
		iRet = -1
	End If
Else
	iRet=-1
End If

// Suppression des options
sSuppr=idw_1.GetItemString(1,"SUPPR_OPT") 

if iRet=0 And sSuppr <> "" Then
	sErr = "PS_D01_DET_PRO : "
	iRet=uf_ps_suppr("PS_D01_DET_PRO",dcIdProdDest,sSuppr)
end if

// Suppression des garanties
sSuppr=idw_1.GetItemString(1,"SUPPR_GTI") 

if iRet=0 And sSuppr <> "" Then
	sErr = "PS_D01_GARANTIE : "
	iRet=uf_ps_suppr("PS_D01_GARANTIE",dcIdProdDest,sSuppr)
end if

// Suppression dans commande_type [VDoc9112]
If iRet=0 And idw_1.GetItemString(1,"COPIE_CMDTYPE")="N" Then
	sProc="Exec sysadm.PS_D01_COMMANDE_TYPE " + string(dcIdProdDest,"#####") + "."
	
	If Not f_execute(sProc, SQLCA) Then iRet=-1
	If iRet=0 And SQLCA.SQLCode <> 0 And SQLCA.SQLDBCode <> 0 Then iRet = -1

	If iRet=-1 Then sErr = "PS_D01_COMMANDE_TYPE : "
End if

// Commit de la transaction
if iRet = -1 Then 
	f_commit(itrTrans,FALSE)
	uf_trace(lIdCle,sErr + SQLCA.sqlerrtext)
else
	f_commit(itrTrans,TRUE)
	uf_trace(lIdCle,"Recopie effectuée avec succès")
end if

Return iRet
end function

public function integer uf_ps_suppr (string asnomproc, decimal adcidprod, string asvalues);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_ps_suppr
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 14:02:25
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value string asnomproc	 */
/* 	value decimal adcidprod	 */
/* 	value string asvalues	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

integer iRet = 0
String sReq, sSql
String sValues[]
n_cst_string uString
long ll_index, ll_count

sReq="EXECUTE sysadm." + asnomproc + " "

uString.of_parsetoarray( asValues, ',', sValues)
ll_count = UpperBound(sValues)

For ll_index=1 to ll_Count
	sSql = sReq + string(adcIdProd,"#####") + "," + sValues[ll_index]
	
	If F_Execute ( sSql, SQLCA ) Then 
		If SQLCA.SQLCode <> 0 And SQLCA.SQLDBCode <> 0 Then
			iRet = -1
			Exit
		End If
	Else
		iRet=-1
		Exit
	End If

Next

Return iRet
end function

public subroutine uf_trace (long lidcle, string sresultat);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_trace
//* Auteur			: F. Pinon
//* Date				: 16/12/2008 11:05:26
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value long lidcle	 */
/* 	value string sresultat	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sSql

If lIdCle <> -1 Then
	sSql  =	" EXEC sysadm.PS_U01_TRACE_RECOPIE_PRODUIT "
	sSql +=	string(lIdCle) + ",'" + sResultat + "','" + stGlb.scodoper + "'"
	
	F_EXECUTE ( sSql, SQLCA)	
	F_Commit  (SQLCA , SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 )
End if
	
end subroutine

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow, u_datawindow adwdatawindow2);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_initialisation
//* Auteur			: F. Pinon
//* Date				: 19/04/2013
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value u_transaction atrtrans	 */
/* 	ref u_datawindow adwdatawindow	 */
/* 	ref u_datawindow adwdatawindow2	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
uf_initialisation(atrTrans, adwdatawindow)

idw_2=adwdatawindow2
idw_2.InsertRow(0)
end subroutine

public function string uf_controlergestion (boolean abrecopiebase);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_controlergestion
//* Auteur			: F. Pinon
//* Date				: 19/04/2013
//* Libellé			: 
//* Commentaires	: [RECOPIE_BASE]
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

String sCol, sLibProduit
Decimal dcidProd
datawindowchild dwChild
String sBaseSource
Integer iRet

sCol = ""

//--------------------------------
// Cas 1 : Recopie interbase
//--------------------------------
If abRecopieBase Then
	dcidProd	= idw_2.GetItemdecimal( 1, "ID_PROD" )
	sBaseSource=idw_2.getItemString( 1, "BASE_SOURCE")
	
	iRet=SQLCA.PS_V01_RECOPIE_PRODUIT(dcidProd, sBaseSource)
	
	If iRet=0 Then
		stMessage.sTitre  = "Contrôle de Gestion de Recopie de Produits"
		stMessage.sCode	= "REPR005"

		f_Message ( stMessage )

		sCol 		= "CODE_PROD_DEST"
	End if
	
	Return sCol
End if

//--------------------------------
// Cas 2 : Recopie de produit
//--------------------------------

// Contrôle d'unicité du code produit
dcidProd 		= idw_1.GetItemNumber ( 1, "CODE_PROD_DEST" )

sLibProduit = uf_gs_Id_Produit ( dcidProd )

/*------------------------------------------------------------------*/
/* Si l'identifiant existe déjà, on déclenche le message d'erreur   */
/*------------------------------------------------------------------*/
If ( sLibProduit <> "" ) Then

	stMessage.sTitre  = "Contrôle de Gestion de Recopie de Produits"
	stMessage.sVar[1] = String ( long(dcIdProd ))
	stMessage.sVar[2] = "au produit"
	stMessage.sVar[3] = sLibProduit
	stMessage.sCode	= "REFU001"

	f_Message ( stMessage )

	sCol 		= "CODE_PROD_DEST"

End If

// Contrôle du libellé
sLibProduit =  idw_1.GetItemString ( 1, "LIB_LONG" )

idw_1.getchild("CODE_PROD_SRC",dwChild)
dwChild.Retrieve( )

If dwChild.Find("LIB_LONG='" + sLibProduit + "'",1,dwChild.RowCount()) > 0 Then
	stMessage.sTitre  = "Contrôle de Gestion de Recopie de Produits"
	stMessage.sCode	= "REPR002"

	f_Message ( stMessage )

	sCol 		= "LIB_LONG"
End if

Return ( sCol )
end function

public function integer uf_valider (boolean abinterbase);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_recopie_produit::uf_valider
//* Auteur			: F. Pinon
//* Date				: 19/04/2013
//* Libellé			: [RECOPIE_BASE]
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Integer iRet, iReponse
Decimal dcIdProd
String sMajPar, sBaseSrc, sBaseDest
String sLibBaseSrc, sLibBaseDest

iRet=1

if abInterBase Then
	
	dcIdProd = idw_2.getItemnumber(1,"ID_PROD")
	sMajPar=stglb.scodoper
	sBaseSrc = idw_2.getItemString(1,"BASE_SOURCE")
	sBaseDest= idw_2.getItemString(1,"BASE_CIBLE")
	sLibBaseSrc = idw_2.describe("evaluate('lookupdisplay(base_source)',1)")
	sLibBaseDest = idw_2.describe("evaluate('lookupdisplay(base_cible)',1)")
	
	//
	Choose case sBaseDest
		Case "SIM"
			if sqlca.servername <> "S2K8RE\SIMSINISTRES2K8" And &
				sqlca.servername <> "SQL14DEV\SIMSINISTRES"  And &
				sqlca.servername <> "SQLDEV01\DEVINSTANCE006" Then  
				itrtrans.Autocommit=TRUE
			End if
		Case "REC"
			if sqlca.servername <> "S2K8RE\RECSINISTRES" And &
				sqlca.servername <> "SQL14DEV\RECSINISTRES" And &
				sqlca.servername <> "SQLDEV01\DEVINSTANCE006" Then 
				itrtrans.Autocommit=TRUE
			End if
	End Choose
	
	// Confirmation 
	stMessage.berreurg=FALSE
	stMessage.scode="REPR007"
	stMessage.sVar[1]=sLibBaseDest
	stMessage.sVar[2]=sLibBaseSrc
	stMessage.sVar[3]=sLibBaseDest
	stMessage.bouton=YesNo!
	stMessage.stitre="Recopie de produit d'une base à une autre"
	stMessage.Icon=Exclamation!
	
	iReponse=f_message(stMessage)
	
	If iReponse=1 Then
		stMessage.Icon=Question!
		stMessage.scode="REPR008"
		stMessage.sVar[1]="DPG"
		stMessage.sVar[2]="la recette du produit"
		stMessage.bouton=YesNo!
		iReponse=f_message(stMessage)
	End if
	
	If iReponse=1 Then
		stMessage.scode="REPR008"
		stMessage.sVar[1]="ES"
		stMessage.sVar[2]="le paramétrage quotidien sur ce produit"
		stMessage.bouton=YesNo!
		iReponse=f_message(stMessage)
	End if
	
	// Recopie
	If iReponse=1 Then
		iRet=itrtrans.PS_I02_RECOPIE_PRODUIT(dcIdProd,sBaseSrc, sBaseDest,sMajPar)
		
		If iRet > 0 Then
			If itrtrans.SQLcode <> 0 or itrtrans.SQLDBcode <> 0 Then
				iRet=-1
			Else
				iRet=0
			End if
		End if
		
		// Commit de la transaction
		If itrtrans.Autocommit Then
			iRet=3
		Else
			if iRet = -1 Then 
				f_commit(itrTrans,FALSE)
			else
				f_commit(itrTrans,TRUE)
				iRet=3
			end if
		End if
	Else 
		iRet=2
	End if
	
	itrtrans.Autocommit =FALSE
Else
	iRet=uf_valider()
End if

Return iRet
end function

on u_sp_gs_recopie_produit.create
call super::create
end on

on u_sp_gs_recopie_produit.destroy
call super::destroy
end on

