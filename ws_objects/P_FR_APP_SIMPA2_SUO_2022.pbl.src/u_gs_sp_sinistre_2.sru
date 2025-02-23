$PBExportHeader$u_gs_sp_sinistre_2.sru
$PBExportComments$Cause objet Trop grand en taille, je déporte des fonction
forward
global type u_gs_sp_sinistre_2 from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_2 from nonvisualobject
end type
global u_gs_sp_sinistre_2 u_gs_sp_sinistre_2

type variables
Private :

u_gs_sp_sinistre iuoSpGsSinistre

u_DataWindow idw_WSin
u_DataWindow idw_wDivSin

u_DataWindow_Detail idw_LstwCommande
u_DataWindow_Detail idw_wDivDet
u_DataWindow_Detail idw_LstGti
u_DataWindow_Detail idw_LstInter

DataWindow idw_DetPro
DataWindow idw_wDetail
DataWindow idw_wPiece
DataWindow idw_wRefus

StaticText		istAttenteDiverse

Boolean			ibCodicDartyValide
Boolean			ibMIG1_CourEmailing // [MIG1_COUR_EMAILING]

String isTypeTrt
String isReferentielApp


integer K_MAJZONE // constant 
end variables

forward prototypes
public function long uf_zn_trt_divsin_typeapp (string asdata, string asnomcol, long alrow, boolean abforcer)
public function long uf_zn_trt_divsin_accessoire (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_accord_chubb (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_bloquedretude (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_choixpack (string asdata, string asnomcol, long alrow, boolean abforcer)
public function long uf_zn_trt_divsin_coqneprotgpas (string asdata, string asnomcol, long alrow)
public function integer uf_zn_trt_divsin_personne_sin (string asdata, string asnomcol, long alrow)
public subroutine uf_set_valinstance (string ascas, string asval)
public function long uf_zn_trt_divsin_cra_ctrl_imei (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_cra_suivi_imei (string asdata, string asnomcol, long alrow)
public function string uf_controlergestion_emailingksl ()
public subroutine uf_initialiser_1 (ref u_gs_sp_sinistre auospgssinistre, ref datawindow adw_detpro, ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdet, ref boolean abcodicdartyvalide, ref string astypetrt, ref string asreferentielapp, integer ak_majzone, ref datawindow adw_wdetail, u_datawindow_detail adw_lstgti, ref statictext astattentediverse, ref boolean abmig1_couremailing, ref u_datawindow_detail adw_lstinter, ref datawindow adw_wpiece, ref datawindow adw_wrefus)
public function long uf_zn_trt_divsin_ech_express_48h (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_modepaiementpaybox (string asdata, string asnomcol, long alrow)
public function boolean uf_validation_finale_trt_partaprescommit ()
end prototypes

public function long uf_zn_trt_divsin_typeapp (string asdata, string asnomcol, long alrow, boolean abforcer);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_TypeApp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/09/2004
//* Libellé			: Contrôle de la zone TYPE_APP
//* Commentaires	: 	Gestion des différents référentiel
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Boolean		abForcer			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    PHG    23/06/2009   [O2M_DIAG_NOMADE] GEstion de l'interdiction
//*                          de modification de type_app si on est en
//*                          process CDiscount et type_app = 'AUT'
//* #2    JFF   07/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090807110518433]
//* #3    JFF   07/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090807135106933]
//* #4	 PHG   07/01/2010	[O2M_DIAG_NOMADE].Lot2 GEneralisation du controle
//*									de modification de TYP_APP, si typapp= 'AUT' et AUT plus autorisé.
//        JFF   03/06/2010 [PC397/443_IPAD]
//			FPI	29/05/2013	[PC845]
//			FPI	07/10/2013	[PC954].Mantis8916
//       JFF   02/06/2014 [PC929_CDISCOUNT][PC929-2-V3]
//			FPI	19/08/2015	[DT167]
//       JFF   11/05/2022   [RS2980_IFR]
//       JFF   06/04/2023 [PMO139_RS4926]
//        JFF   05/08/2024  [MCO602_PNEU]
//*-----------------------------------------------------------------

String sTypeApp, sIdMarq, sVal

//* #2 [O2M_DIAG_NOMADE].[JFF].[20090807110518433]
String sTypeAppActuel 
// #4	PHG 07/01/2010	[O2M_DIAG_NOMADE].Lot2
//n_cst_attrib_key lnvKey[]
boolean bDp25_no_Aut
DataWindowChild dwChild
Integer iAction, iIdNatSin
Long lRow
n_cst_string nvString
Long lDeb, lFin, lIdProd // #1 [O2M_DIAG_NOMADE]



lIdProd = long(idw_wSin.object.id_prod[1]) // #1 [O2M_DIAG_NOMADE]
sTypeApp = Upper ( asData )

//* #2 [O2M_DIAG_NOMADE].[JFF].[20090807110518433]
If Not abForcer Then
   sTypeAppActuel = idw_wDivSin.GetItemString ( alRow, asnomcol )
Else
   sTypeAppActuel = sTypeApp
End If
//* :#2 [O2M_DIAG_NOMADE].[JFF].[20090807110518433]

iAction = 0

/*------------------------------------------------------------------*/
/* Pour Modifier lle Type d'app., il faut qu'aucun détail soit 'à   */
/* régler' ou 'réglé' ET qu'aucune Prestation non annulée n'existe. */
/*------------------------------------------------------------------*/
// #1 [O2M_DIAG_NOMADE] Est-on en process Cdiscount et type_app a 'AUT' ?
// Si oui, on autorise une fois le changement de type d'appareil.
// Si non, controle existant cité ci-dessus.
//F_Rechdetpro(lDeb, lFin,idw_DetPro, lIdProd, "-DP", 37)

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 25 )
if lDeb > 0 Then
	// Si Option 25 et Type Appareil  'Autre' non présent en paramétrage det_pro
	bDp25_no_Aut = idw_detpro.Find ( "ID_PROD="+string(idw_WSin.GetItemNumber( 1, "ID_PROD" ))+&
							" AND ID_CODE_DP=25" + &
							" AND UPPER(ID_CODE_CAR)= 'AUT'", lDeb, lFin ) = 0
End If

//* #2 [O2M_DIAG_NOMADE].[JFF].[20090807110518433]
// if lDeb > 0 and sTypeApp = "AUT" And Not abForcer Then
//if lDeb > 0 and sTypeAppActuel = "AUT" And Not abForcer Then
//* :#2 [O2M_DIAG_NOMADE].[JFF].[20090807110518433]
if bDp25_no_Aut and ( sTypeAppActuel = "AUT" Or IsNull (sTypeAppActuel) ) And Not abForcer Then // #4	PHG 07/01/2010	[O2M_DIAG_NOMADE].Lot2

// #3 [O2M_DIAG_NOMADE].[JFF].[20090807135106933]
/*
   stMessage.sTitre      = "Régularisation Dossier CDiscount"
   stMessage.Icon         = Information!
   stMessage.bErreurG   = FALSE
   stMessage.sCode      = "WSIN680" //#1 [O2M_DIAG_NOMADE] : Message : Vous devez régulariser ce dossier en choisissant un type d'appareil précis.
                                                                  //     ATTENTION : Choisissez bien, car une fois validé, aucune modification ultérieure ne sera possible.
   F_Message ( stMessage )
   iAction = 0
*/
//   stMessage.sTitre      = "Régularisation Dossier CDiscount"
   stMessage.sTitre      = "Régularisation Dossier"// #4	PHG 07/01/2010	[O2M_DIAG_NOMADE].Lot2
   stMessage.Icon         = Information!
   stMessage.bErreurG   = FALSE
   stMessage.sCode      = "WSIN681" //#1 [O2M_DIAG_NOMADE] : Message : Vous devez régulariser ce dossier en choisissant un type d'appareil précis.
   stMessage.Bouton      = YesNo!

   If F_Message ( stMessage ) = 1 Then
      iAction = 0
   Else
      iAction = 1
      idw_wDivSin.SetItem ( alRow, asnomcol, sTypeAppActuel )
   End If
   stMessage.Bouton      = Ok!

// :#3 [O2M_DIAG_NOMADE].[JFF].[20090807135106933]
Else
	
	If idw_wDetail.Find ( "COD_ETAT = 600 OR COD_ETAT = 500", 1, idw_wDetail.RowCount () ) + &
		idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' ", 1, idw_LstwCommande.RowCount () ) + &
		idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC' AND ( VAL_LST_CAR = 'O' Or VAL_CAR = 'O' )", 1, idw_wDivDet.Rowcount () ) > 0 And Not abForcer Then
			idw_wDivSin.iiErreur = 1
			iAction = 1
	End If
End If

// :#1 [O2M_DIAG_NOMADE] ci-dessous ancien code
//If idw_wDetail.Find ( "COD_ETAT = 600 OR COD_ETAT = 500", 1, idw_wDetail.RowCount () ) + &
//   idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' ", 1, idw_LstwCommande.RowCount () ) > 0 And Not abForcer Then
//   idw_wDivSin.iiErreur = 1
//   iAction = 1
//End If

/*------------------------------------------------------------------*/
/* Pour DARTY (Profuit Mobile) Si CODIC trouvé ET Valide, alors     */
/* tout est déterminé automatiquement, don interdiction de          */
/* modifier la Marque/modele.                                       */
/*------------------------------------------------------------------*/
If iAction = 0 And Not abForcer Then
	lRow = idw_WDivSin.Find ( "NOM_ZONE = 'codic'", 1,  idw_WDivSin.RowCount () ) 
	If lRow > 0 And ibCodicDartyValide Then
		iAction = 1
		idw_wDivSin.iiErreur = 2
	End If
End If

// [DT167]
If iAction = 0 And Not abForcer Then
	lRow=idw_detpro.Find ( "ID_PROD="+string(idw_WSin.GetItemNumber( 1, "ID_PROD" ))+&
							" AND ID_CODE_DP=25" + &
							" AND UPPER(ID_CODE_CAR)= '" + asData + "'",1, idw_detpro.RowCount( ))
	if lRow > 0 Then
		if nvString.of_getkeyvalue( idw_detpro.GetItemString(lRow,"VAL_CAR"), "EXCLU_DECLA", ";") = "OUI" Then
			iAction = 1
			idw_wDivSin.iiErreur = 8
		End if
	End if
End if
// :[DT167]

If iAction = 0 Then

/*------------------------------------------------------------------*/
/* Quel référentiel utiliser ? Armement de isReferentielApp         */
/*------------------------------------------------------------------*/
	iuoSpGsSinistre.uf_Determiner_Referentiel ( sTypeApp )

/*------------------------------------------------------------------*/
/* Si l'on est en saisi, on masque tout les référentiels avant de   */
/* rendre visible le bon.                                           */
/*------------------------------------------------------------------*/
	If isTypeTrt = "S" Then
		idw_Wsin.Modify ( "marq_port.visible = 0" ) 
		idw_Wsin.Modify ( "modl_port.visible = 0" ) 

		idw_Wsin.Modify ( "marq_port2.visible = 0" ) 
		idw_Wsin.Modify ( "modl_port2.visible = 0" ) 

		idw_Wsin.Modify ( "marq_port3.visible = 0" ) 
		idw_Wsin.Modify ( "modl_port3.visible = 0" ) 

	End If

	Choose Case isReferentielApp 

/*------------------------------------------------------------------*/
/* Référentiel IFR pour les téléphones uniquement => table IFR      */
/*------------------------------------------------------------------*/
		Case "IFR"

			If isTypeTrt = "S" Then
				idw_Wsin.Modify ( "marq_port2.visible = 1" ) 
				idw_Wsin.Modify ( "modl_port2.visible = 1" ) 
			End If

			idw_Wsin.Modify ( "marq_port_t.text = 'Marque (IFR)'" ) 
			idw_Wsin.Modify ( "modl_port_t.text = 'Modèle (IFR)'" ) 

			// [PC397/443_IPAD]
			Choose Case sTypeApp
				Case "TEL", "PC1", "PC2", "PC3"
					idw_Wsin.Modify ( "num_imei_port_t.text = 'n° IMEI'" ) 
				Case Else
					idw_Wsin.Modify ( "num_imei_port_t.text = 'n° Série'" ) 
			End Choose
			// [PC397/443_IPAD]			


			sIdMarq = Trim ( Upper ( idw_Wsin.GetItemString ( 1, "MARQ_PORT2" ) )) 
			If IsNull ( sIdMarq ) Then sIdMarq = ""
			idw_Wsin.Getchild ( "MODL_PORT2", dwChild ) 
			dwChild.SetFilter ( "MARQUE = '" + Upper ( sIdMarq ) + "'" )
			dwChild.Filter ()
			dwChild.Sort ()

/*---------------------------------------------------------------------*/
/* Référentiel DARTY pour autres types d'appareils sauf les téléphones */
/* => table REF_CODIC_DARTY														  */
/*---------------------------------------------------------------------*/
		Case "REF_CODIC_DARTY"

			If isTypeTrt = "S" Then
				idw_Wsin.Modify ( "marq_port3.visible = 1" ) 
				idw_Wsin.Modify ( "modl_port3.visible = 1" ) 
			End If

			idw_Wsin.Modify ( "marq_port_t.text = 'Marque (DARTY)'" ) 
			idw_Wsin.Modify ( "modl_port_t.text = 'Modèle (DARTY)'" ) 
			idw_Wsin.Modify ( "num_imei_port_t.text = 'n° Série'" ) 

			idw_Wsin.Getchild ( "MARQ_PORT3", dwChild ) 
			dwChild.SetFilter ( "TYPE_APP = '" + sTypeApp + "'")
			dwChild.Filter ()
			dwChild.Sort ()

			sIdMarq = Trim ( Upper ( idw_Wsin.GetItemString ( 1, "MARQ_PORT3" ) )) 
			If IsNull ( sIdMarq ) Then sIdMarq = ""
			idw_Wsin.Getchild ( "MODL_PORT3", dwChild ) 

			dwChild.SetFilter ( "MARQUE = '" + Upper ( sIdMarq ) + "' AND TYPE_APP = '" + sTypeApp + "'")
			dwChild.Filter ()
			dwChild.Sort ()

/*---------------------------------------------------------------------*/
/* Référentiel SPB pour tout autres types d'appareils       			  */
/* => table CODE (-MB)																  */
/*---------------------------------------------------------------------*/
		Case "REF_SIMPA2_CODE_MB"

			If isTypeTrt = "S" Then
				idw_Wsin.Modify ( "marq_port.visible = 1" ) 
				idw_Wsin.Modify ( "modl_port.visible = 1" ) 
			End If

			idw_Wsin.Modify ( "marq_port_t.text = 'Marque'" ) 
			idw_Wsin.Modify ( "modl_port_t.text = 'Modèle'" ) 
			idw_Wsin.Modify ( "num_imei_port_t.text = 'n° Série'" ) 

/*---------------------------------------------------------------------*/
/* Référentiel SPB par défaut pour tout autres types d'appareils       */
/* => table CODE (-MB)																  */
/*---------------------------------------------------------------------*/
		Case Else

			If isTypeTrt = "S" Then
				idw_Wsin.Modify ( "marq_port.visible = 1" ) 
				idw_Wsin.Modify ( "modl_port.visible = 1" ) 
			End If

			idw_Wsin.Modify ( "marq_port_t.text = 'Marque'" ) 
			idw_Wsin.Modify ( "modl_port_t.text = 'Modèle'" ) 
			idw_Wsin.Modify ( "num_imei_port_t.text = 'n° Série'" ) 

	End Choose
End If

// [PC845]
/* 
If sTypeApp="PNE" Then
	// [MCO602_PNEU]
	If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
		sVal = idw_Wsin.GetItemString ( 1, "num_imei_port" )
		idw_Wsin.SetItem ( 1, "num_imei_port", "AUCUN" )
	Else 	
		idw_Wsin.Modify ( "num_imei_port_t.text = 'Immat.'" ) 
	End If 
End If 
*/

// [PC954].Mantis8916
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 141 )
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 212 ) // Mantis 9148

If lDeb > 0 Then
	
	iIdNatSin=idw_WSin.GetItemNumber ( 1, "ID_NATSIN" )
	if iIdNatSin=0 or iIdNatSin=28 Then // Message d'info si Panne
		
		sVal = nvString.of_getkeyvalue( idw_detpro.GetItemString(lDeb, "VAL_CAR"), "APP_NON_GERE_PANNE", ";")
		If Pos(sVal,"#" + asData + "#") > 0 Then
		
			stMessage.sTitre      = "Gestion de sinistres SIMPA2"
			stMessage.Icon         = Information!
			stMessage.bErreurG   = FALSE
			stMessage.sCode      = "WSIN758"
			stMessage.Bouton      = OK!
			
			f_message(stMessage)
		End if
	End if 
End if

// [PC929_CDISCOUNT][PC929-2-V3]
If isTypeTrt = "S" Then
	sVal = iuoSpGsSinistre.uf_Gestong_Divers_Trouver ( "TV_SUPEG_32P" )
	If IsNull ( sVal ) Then sVal = ""	
	If sVal = "O" Then
		Choose Case asData
			Case "TL7", "TLO", "TPS"  // Les TV >= 32 pouces
				// Cest ok
			Case Else
				If Not IsNull ( asData ) And len ( trim ( asData )) > 0 Then
					stMessage.sTitre      = "Alerte non bloquante !!"
					stMessage.Icon         = Exclamation!
					stMessage.bErreurG   = FALSE
					stMessage.sCode      = "WSIN773"
					stMessage.Bouton      = OK!
					
					f_message(stMessage)
				End If
		End Choose
	End If

	If sVal <> "O" Then
		If idw_wDivSin.Find ( "UPPER ( NOM_ZONE ) = 'TV_SUPEG_32P'", 1, idw_wDivSin.RowCount () ) > 0 Then
			Choose Case asData
				Case "TL7", "TLO", "TPS"  // Les TV >= 32 pouces
					stMessage.sTitre      = "Alerte non bloquante !!"
					stMessage.Icon         = Exclamation!
					stMessage.bErreurG   = FALSE
					stMessage.sCode      = "WSIN774"
					stMessage.Bouton      = OK!
					
					f_message(stMessage)
			End Choose
		
		End If

	End If
End If		
// [PC929_CDISCOUNT][PC929-2-V3]

If iAction = 0	Then
	lRow = idw_WDivSin.Find ( "NOM_ZONE = 'mt_val_publique'", 1,  idw_WDivSin.RowCount () ) 
	If lRow > 0 Then 
		iuoSpGsSinistre.uf_gestong_divers_majzone( "MT_VAL_PUBLIQUE", lRow, K_MAJZONE, 0 )
	End If
End If

// [RS2980_IFR]
gsCodeRetPrixIfr = ""


// [PMO139_RS4926]
If iAction = 0 And Not abForcer Then
	// On appelle l'API
	lRow = idw_WDivSin.Find ( "NOM_ZONE = 'taille_tv'", 1,  idw_WDivSin.RowCount () )
	If lRow > 0 Then
		iuoSpGsSinistre.uf_gestong_divers_majzone( "TAILLE_TV", lRow, K_MAJZONE, "AUC" )
	End If	
End If 


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivSin.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

public function long uf_zn_trt_divsin_accessoire (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_Accessoire (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 03/11/2008
//* Libellé			: Contrôle de 3 zones App_Sin, Batt_sin, Alim_sin, Aut_Acc_Sin 
//* Commentaires	: [FNAC_PROD_ECH_TECH][BLCODE]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    07/12/2009  [DCMP090327].[SBETV]
//* #2    JFF    25/11/2009  [MSS_DIAG]
//*-----------------------------------------------------------------

Integer iAction

Long lRow, lDeb, lFin

asData = Upper ( asData )
iAction = 0

lRow = idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' AND ID_FOUR IN ( 'BLC', 'O2M', 'SB1', 'MS1')", 1, idw_LstwCommande.RowCount () ) 

If lRow > 0 Then
	idw_wDivSin.iiErreur = 3
	iAction = 1
End If

Return iAction

end function

public function long uf_zn_trt_divsin_accord_chubb (string asdata, string asnomcol, long alrow);
//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_accord_chubb (PRIVATE)
//* Auteur			: FPI
//* Date				: 14/08/2013
//* Libellé			: Contrôle de la zone ACCORD_CHUBB
//* Commentaires	: 	[DT058]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*					  Boolean		abForcer			Val
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Integer iAction
Long lRow
Long lValActuel, lVal
Long lDeb, lFin, lIdProd // #1 [O2M_DIAG_NOMADE]

lVal=Long(asData)
lValActuel = idw_wDivSin.GetItemNumber ( alRow, asnomcol )
iAction = 0

Choose Case lVal
	Case 0,1
		// Non renseigné / Demande en cours
	Case 2,3
		stMessage.sTitre      = "Régularisation Dossier"
		stMessage.Icon         = Information!
		stMessage.bErreurG   = FALSE
		stMessage.sCode      = "WSIN681" 
		stMessage.Bouton      = YesNo!
	
		If F_Message ( stMessage ) = 1 Then
			iAction = 0
			idw_wDivSin.SetItem ( alRow,"ALT_PROT","O")
		Else
			iAction = 2
			idw_wDivSin.SetItem ( alRow, asnomcol, lValActuel )
		End If
		stMessage.Bouton      = Ok!
	Case 4
		idw_wDivSin.iiErreur =7
		iAction =1
End Choose

Return iAction


end function

public function long uf_zn_trt_divsin_bloquedretude (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_BloqueDRetude (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 28/02/2019
//* Libellé			: 
//* Commentaires	: [VDOC27557]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Integer iAction

Long lRow, lDeb, lFin, lVal1, lVal2

asData = Upper ( asData )
iAction = 0

If Pos ( gsDroitDosBloqueDR, "#" + stGlb.sCodOper + "#" ) <= 0 Then
		idw_wDivSin.iiErreur = 16
		iAction = 1
End If

Return iAction


end function

public function long uf_zn_trt_divsin_choixpack (string asdata, string asnomcol, long alrow, boolean abforcer);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_ChoixPack (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/06/2006
//* Libellé			: Contrôle de la zone virtuelle ChoixPack
//* Commentaires	: 	
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*					  Boolean		abForcer			Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    09/01/2009  [20090109130126653]
//        JFF    02/04/2011  [PC694][SFR2012]
//*-----------------------------------------------------------------

String sTypeApp, sIdMarq 
DataWindowChild dwChild
Integer iAction
Long lRow, lDeb, lFin

sTypeApp = Upper ( asData )
iAction = 0

/*------------------------------------------------------------------*/
/* Pour Modifier lle Type d'app., il faut qu'aucun détail soit 'à   */
/* régler' ou 'réglé' ET qu'aucune Prestation non annulée n'existe. */
/*------------------------------------------------------------------*/
//If idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' ", 1, idw_LstwCommande.RowCount () ) > 0 And Not abForcer Then
// [20090109130126653]
If idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' AND ID_TYP_ART NOT IN ( 'EDI', 'PRS') ", 1, idw_LstwCommande.RowCount () ) > 0 And Not abForcer Then
	idw_wDivSin.iiErreur = 3
	iAction = 1
End If

// [PC301].[LOT2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
If lDeb > 0 Then
	idw_wDivSin.iiErreur = 4
	iAction = 1
End If
// [PC301].[LOT2]

// [PC694][SFR2012]
lRow = idw_WDivSin.Find ( "NOM_ZONE = 'classe_ctg_sfr'", 1,  idw_WDivSin.RowCount () )
If lRow > 0 Then
	idw_wDivSin.iiErreur = 5
	iAction = 1
End If
// [PC694][SFR2012]


Return iAction


end function

public function long uf_zn_trt_divsin_coqneprotgpas (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_CoqNeProtgPas (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 28/12/2006
//* Libellé			: 
//* Commentaires	: [PC947&977]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Integer iAction

Long lRow, lDeb, lFin, lVal1, lVal2

asData = Upper ( asData )
iAction = 0

lVal1 = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_CAR = 'O'", 1, idw_wDivDet.RowCount () )
lVal2 = idw_LstGti.Find ( "COD_ETAT IN ( 500, 550, 600 )", 1, idw_LstGti.RowCount () )

If lVal1 > 0 Or lVal2 > 0 Then
		idw_wDivSin.iiErreur = 7
		iAction = 1
End If

Return iAction

end function

public function integer uf_zn_trt_divsin_personne_sin (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_Personne_Sin (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 16/10/2018
//* Libellé			: 
//* Commentaires	: [PC171999]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Integer iAction
String sVariante 
n_cst_string lnvPFCString

Long lRow, lDeb, lFin, lVal1, lVal2, lVal3, lTot, lCpt

asData = Upper ( asData )
iAction = 0

lVal1 = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_CAR = 'O'", 1, idw_wDivDet.RowCount () )
lVal2 = idw_LstGti.Find ( "COD_ETAT IN ( 500, 550, 600 )", 1, idw_LstGti.RowCount () )
lVal3 = idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' ", 1, idw_LstwCommande.RowCount () ) 

If lVal1 > 0 Or lVal2 > 0 Or lVal3 > 0 Then
		idw_wDivSin.iiErreur = 11
		iAction = 1
End If

If iAction = 0 Then
	idw_LstGti.SetFilter ( "COD_ETAT IN ( 100, 200)" )
	idw_LstGti.Filter ()
	
	lTot = idw_LstGti.RowCount ()
	
	For lCpt = 1 To lTot
		idw_LstGti.SetItem ( lCpt, "COD_ETAT", 0 )
	Next 

	idw_LstGti.SetFilter ( "" )
	idw_LstGti.Filter ()
	
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 330 )	
	If lDeb > 0 Then
		sVariante = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
		If sVariante = "FAMILLE" Then
			Choose Case asData
				Case "ASS"
		
					stMessage.sTitre		= "PC171999 / Assuré principal"
					stMessage.Icon		= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WSIN833"
					
					F_Message ( stMessage )
					
				Case "AUP"
		
					stMessage.sTitre		= "PC171999 / Autres assurés"
					stMessage.Icon		= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WSIN834"
					
					F_Message ( stMessage )
				
			End Choose 
		End If
	End If 	

End If

Return iAction


end function

public subroutine uf_set_valinstance (string ascas, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_set_valinstance (Public)
//* Auteur			: FABRY JF
//* Date				: 12/11/2024
//* Libellé			: 
//* Commentaires	: Valeur d'instance changeante
//*
//* Arguments		: Voir arguments
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   19/12/2024 [MIG1_COUR_EMAILING]
//*-----------------------------------------------------------------


If IsNull ( asCas ) Then Return

asCas = Trim ( asCas ) 

If asCas = "" Then Return

Choose Case asCas 

	Case "isReferentielApp"
		isReferentielApp = asVal
		
	Case "ibMIG1_CourEmailing"
		ibMIG1_CourEmailing = Upper ( asVal ) = "TRUE" // [MIG1_COUR_EMAILING]
			
		
End Choose 
end subroutine

public function long uf_zn_trt_divsin_cra_ctrl_imei (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_Cra_Ctrl_Imei (PRIVATE)
//* Auteur			: PHG
//* Date				: 28/12/2006
//* Libellé			: Contrôle de la zone CRA_CTRL_IMEI ( [CRAO_LOT1]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*					  Boolean		abForcer			Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../.... 
//* #1	 PHG	 09/09/2008		[DCMP080625] Désactivation controle 
//*										Marque/modele Obligatoire
//*									- Si marq/modele non saisi, on ne
//*										peut demander un ctrl IMEI.
//*									Note : fonction vide auparavant => PAs de tag.
//        JFF   18/11/2024   [KSV649_ORREUCARA]
//*-----------------------------------------------------------------

String sCraCtrlImei, sModl, sMArq, sIMEI, sIdAdh, sVal
Integer iAction
Long lRow, lDeb, lFin, lIdSin
Date dDteSurv
Boolean bStopTrt 
n_cst_string lnvString
n_cst_gs_appel_api_generique ObjAppelAPI

sCraCtrlImei = Upper ( Trim(asData ))
bStopTrt = False

// [KSV649_ORREUCARA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 387)
If lDeb <= 0 Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 388)
End If 

// Code existant, non lié à Orange Réunion&Caraïbes 2025
If lDeb <= 0 Then 

	sModl = Trim ( Upper ( idw_wSin.GetItemString ( 1, "MODL_PORT" ) ) )
	sMarq = Trim ( Upper ( idw_wSin.GetItemString ( 1, "MARQ_PORT" ) ) )
	
	if ( lnvString.of_IsEmpty(sModl) or lnvString.of_IsEmpty(sMarq) ) and sCraCtrlImei = 'O' Then
		idw_wDivSin.iiErreur = 2 // Voir w_tm_spsinistre.dw_w_div_sin::itemerror => Cas "VAL_ALT", Case 2
		iAction = 1
	Else
		iAction = 0
	End If

End If 

// [KSV649_ORREUCARA] Orange Réunion&Caraïbes 2025
If lDeb > 0 Then
	
	sVal = iuoSpGsSinistre.uf_GestOng_Divers_Trouver ( "CRA_SUIVI_IMEI" )
	If IsNull ( sVal) Or sVal = "" Then sVal = "0"
	
	If sVal <> "5" Then
		stMessage.sTitre		= "URL API ORANGE REUNION"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "API0008"
		
		F_Message ( stMessage )
		bStopTrt = True
		iAction = 2
	End If 
	
	
	// Chargement données
	If iAction = 0 Then	
		lIdSin = idw_WSin.GetItemNumber ( 1, "ID_SIN" )
		sIMEI  = Trim ( idw_WSin.GetItemString ( 1, "NUM_IMEI_PORT" ) )
		sIdAdh = Trim ( idw_WSin.GetItemString ( 1, "ID_ADH" ) )
		dDteSurv = idw_WSin.GetItemDate ( 1, "DTE_SURV_DATE" ) 
		
		IF IsNull ( sIMEI ) Or sIMEI = "" Or IsNull ( sIdAdh ) Or sIdAdh = "" OR IsNull ( dDteSurv ) OR  dDteSurv = 1900-01-01 Then
			idw_wDivSin.iiErreur = 18
			iAction = 1
		End If 
	End If 
	
	// Message d'alerte, plus aucune modif sur ces champs
	If iAction = 0 Then
		stMessage.sTitre		= "URL API ORANGE REUNION"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YesNo!
		stMessage.sVar [1]   = "API_ORANGE_REUNION"
		stMessage.sCode		= "API0002"
		
		If F_Message ( stMessage ) = 2 Then
			bStopTrt = True
			iAction = 2
		End If 
	End If 
	
	
	// APPEL APi Orange Réunion
	If iAction = 0 And Not bStopTrt Then
		
		ObjAppelAPI = Create n_cst_gs_appel_api_generique
	
		ObjAppelAPI.uf_api_orange_reunion_caller ( iuoSpGsSinistre, istAttenteDiverse, idw_wDivSin, lIdSin, sIMEI, dDteSurv, sIdAdh )
		
		If IsValid ( ObjAppelAPI ) Then Destroy ( ObjAppelAPI )
		
		iAction = 2
		
	End If 	
End IF 


Return iAction

end function

public function long uf_zn_trt_divsin_cra_suivi_imei (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_cra_suivi_imei (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/06/2013
//* Libellé			: Contrôle de la zone 
//* Commentaires	: 	
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   18/11/2024   [KSV649_ORREUCARA]
//*-----------------------------------------------------------------

String sEtatSuiviChgt, sIdMarq, sVal, sEtatSuiviActuel
DataWindowChild dwChild
Integer iAction
Long lRow, lDeb, lFin, lRowCount, lCpt, lVal
n_cst_string lnvPFCString

sEtatSuiviChgt = Upper ( asData )
sEtatSuiviActuel = iuoSpGsSinistre.uf_GestOng_Divers_Trouver ( "CRA_SUIVI_IMEI" )

iAction = 0

F_RechdetPro (lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ),"-DP",239)
sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")			

If lDeb > 0 And sVal = "ORANGE_OPEN_PRO" Then
	
	lRowCount = idw_LstGti.RowCount()
	
	For lCpt = 1 To lRowCount 
		lVal = idw_LstGti.GetItemNumber ( lCpt, "COD_ETAT" )
		
		Choose Case lVal
			Case 600
				// On ne touche plus
			Case Else
				idw_LstGti.SetItem ( lCpt, "COD_ETAT", 0 ) 
		End Choose
		
	Next 
End If

// [KSV649_ORREUCARA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 387)
If lDeb <= 0 Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 388)
End If 

If lDeb > 0 Then
	Choose Case sEtatSuiviActuel
		Case "20"
			
			Choose Case sEtatSuiviChgt
				Case "2", "100"
					stMessage.sTitre		= "URL API ORANGE REUNION"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= YesNo!
					stMessage.sCode		= "API0009"
					
					If F_Message ( stMessage ) = 2 Then
						iAction = 2
						iuoSpGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", alrow, 2, Long ( sEtatSuiviActuel ) )
					Else
						idw_wDivSin.SetItem ( alrow, "ALT_PROT", "O" )
						idw_WSin.SetFocus ()
					End If
					
				Case Else 	
					iAction = 1
					idw_wDivSin.iiErreur = 8
			End Choose 
			
		Case Else 	
			iAction = 1
			idw_wDivSin.iiErreur = 8			
	End Choose 
End If 
// /[KSV649_ORREUCARA]

Return iAction


end function

public function string uf_controlergestion_emailingksl ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_controlergestion_EmailingKSL (PRIVATE)
//* Auteur			: JFF
//* Date				: 07/01/2025
//* Libellé			:  [MIG1_COUR_EMAILING]
//* Commentaires	:  Contrôle de gestion lié au courrier Emailing KSL
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ 					PAR		Date		  Modification
//                   JFF     19/02/2025  [202502191703] J'autorise pour tout inter, un contrôle sur le courrier existant à présent.
//*-----------------------------------------------------------------
Boolean bAMU_Regl, bAMU_ReglV, bAMU_ReglC, bAMU_Pce, bAMU_Ref, bMaqG, bMaqV, bMaqC, bMaqP, bMaqR, bFin, bAMUPT_Courrier, bCtrleAltEdit
Long lDeb, lFin, lCpt, lTotInter, lCpt2
Int iNbreRef, iIdInter
String sAdrMail, sCodInter, sNomInter, sPos, sLibCodInter, sTypeMail, sRegl, sPce, sRef, sCodModeReg, sChaineEnvCourrier, sCodInterSeria
Decimal {2} dcMtARegInter

sPos = ""
bAMUPT_Courrier = False
sChaineEnvCourrier = ""
bCtrleAltEdit = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 390 )
if lDeb <=0 Then return ""


// Contrôle mail
lTotInter = idw_lstinter.RowCount () 
For lCpt=1 To lTotInter
	sAdrMail = idw_lstinter.GetItemstring ( lCpt, "ADR_MAIL")
	sCodInter = idw_lstinter.GetItemstring ( lCpt, "COD_INTER")	 // [MIG1_COUR_EMAILING]
	sNomInter = idw_lstinter.GetItemstring ( lCpt, "NOM")	 // [MIG1_COUR_EMAILING]
	iIdInter  = idw_lstinter.GetItemNumber ( lCpt, "ID_I")	 // [MIG1_COUR_EMAILING]
	sTypeMail = idw_lstinter.GetItemstring ( lCpt, "ID_COUR")	 

	If Not bAMUPT_Courrier Then bAMUPT_Courrier = Not ( IsNull ( sTypeMail ) Or sTypeMail = "" ) 

	If idw_Wsin.GetItemString ( 1, "ALT_EDIT" ) <> "O" And bAMUPT_Courrier And Not bCtrleAltEdit Then
		bCtrleAltEdit = True
		stMessage.sTitre		= "Emailing KSL : Pas de génération de courrier"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YesNo!
		stMessage.sCode		= "WSIN918"
		If F_Message ( stMessage ) = 1 Then 
			For lCpt2 = 1 To idw_lstinter.RowCount ()
				idw_lstinter.SetItem ( lCpt2, "ID_COUR", stNul.str ) 
				idw_lstinter.SetItem ( lCpt2, "ID_NAT_COUR", stNul.str ) 				
			Next 
			
			Return ""		
		End If
		
		Return "ALT_BLOC"
	End IF 

	Choose Case sCodInter
		Case "A" 
			sLibCodInter = "Assuré"
		Case "B"
			sLibCodInter = "Banque"
		Case "F" 			
			sLibCodInter = "Fourn."
			Continue
		Case "T"
			sLibCodInter = "Autre"
		Case Else
			sLibCodInter = sCodInter
	End Choose 
	
	// Pour l'instant les courriers Emailing ne sont que pour l'assuré
	/* [202502191703]
	Choose Case sCodInter
		Case "A"
			// Ok
		Case Else 
			If Not IsNull ( sTypeMail ) And sTypeMail <> ""	Then
				stMessage.sTitre		= "Emailing KSL : Courrier<=>Typ Inter"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "WSIN916"
				stMessage.sVar[1] = "(" + sLibCodInter + ") " + sNomInter		
				F_Message ( stMessage ) 
				Return "ALT_BLOC"
			End If 
			
	End Choose
	*/ 	
	
	// y a-t-il AMU un Règlement pour cet inter ?
	dcMtARegInter = idw_lstinter.GetItemDecimal ( lCpt, "MT_A_REG")	 // [MIG1_COUR_EMAILING]
	bAMU_Regl = dcMtARegInter > 0 

	// Et par quel mode ?
	sCodModeReg = idw_lstinter.GetItemString ( lCpt, "COD_MODE_REG")
	bAMU_ReglV = bAMU_Regl And sCodModeReg = "VA"
	bAMU_ReglC = bAMU_Regl And sCodModeReg = "C"	

	// y a-t-il AMU une dde pce affecté pour cet inter ?
	bAMU_Pce = idw_wPiece.Find ( "ALT_RECLAME = 'O' AND ID_I = " + String ( iIdInter ) , 1, idw_wPiece.RowCount ()) > 0 

	// y a-t-il AMU un refus affecté ? et combien ?
	idw_wRefus.SetFilter ( " (ALT_OPE = 'O' OR ALT_MAC = 'O') AND ID_I = " + String ( iIdInter ) ) 
	idw_wRefus.Filter ()
	iNbreRef = idw_wRefus.RowCount()
	bAMU_Ref = iNbreRef > 0 
	idw_wRefus.SetFilter ( "" ) 
	idw_wRefus.Filter ()
	idw_wRefus.Sort ()
	
	// Contrôle mail	
	if not isnull(sAdrMail) Then
		If not f_mail_valide(sAdrMail) Then
			stMessage.sTitre		= "Emailing KSL : Contrôle adresse mail"
			stMessage.bErreurG	= false
			stMessage.Icon			= Exclamation!
			stMessage.sCode		= "WINT305"
			stMessage.sVar[1] = "(" + sLibCodInter + ") " + sNomInter
			sPos="ALT_BLOC"
			f_Message ( stMessage )
			
			Return "ALT_BLOC"
			
		End if
	End if
	
	IF IsNull ( sAdrMail )Then
		bFin = False
		Do While Not bFin
			stMessage.sTitre		= "Emailing KSL : Contrôle adresse mail"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "WSIN911"
			stMessage.sVar[1] = "(" + sLibCodInter + ") " + sNomInter
			If sCodInter = "A" Then stMessage.sCode = "WSIN910"
			If F_Message ( stMessage ) = 1 Then bFin = TRUE
		Loop

	End If 

	// Contrôle cohérence courrier et contexte
	
	// Pas de courrier et AMU Regl ou pce ou refus
	if ( IsNull ( sTypeMail ) Or sTypeMail = "" ) And ( bAMU_Regl Or bAMU_Pce Or bAMU_Ref ) Then
		stMessage.sTitre		= "Emailing KSL : Pas de courrier"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "WSIN913"
		stMessage.sVar[1] = "(" + sLibCodInter + ") " + sNomInter		
		stMessage.sVar[2] = ""
		If bAMU_Regl Then stMessage.sVar[2] = ", présence de règlement(s)" 
		If bAMU_Pce Then stMessage.sVar[2] += ", présence de demande de pièce(s)" 
		If bAMU_Ref Then stMessage.sVar[2] += ", présence de refus" 		
		stMessage.sVar[2] = Right ( stMessage.sVar[2], Len ( stMessage.sVar[2] ) - 2 )
		
		If F_Message ( stMessage ) = 2 Then Return "ALT_BLOC"		
	End If 
	
	// Un courrier présent Mais ne correspondant pas au contexte
	sRegl = space ( 1 ); sPce = space ( 1 ); sRef = space ( 1 ) ; sCodInterSeria = Space ( 35 ) 
	SQLCA.PS_MIG1_S_TYPE_COUR_EMAILING_KSL ( sTypeMail, sRegl, sPce, sRef, sCodInterSeria ) 
	bMaqG = sRegl = "G" ; bMaqV = sRegl = "V" ; bMaqC = sRegl = "C" ; bMaqP = sPce = "P" ; bMaqR = sRef = "R"

	if Not IsNull ( sTypeMail ) And sTypeMail <> ""	And ( & 
		( Not bAMU_Regl And ( bMaqG Or bMaqV Or bMaqC ) ) Or &
		( bAMU_ReglV And ( Not bMaqV And Not bMaqG ) ) Or &	
		( bAMU_ReglC And ( Not bMaqC And Not bMaqG ) ) Or &			
		( Not bAMU_Pce And bMaqP ) Or &
		( bAMU_Pce And Not bMaqP ) Or &
		( Not bAMU_Ref And bMaqR ) Or &
		( bAMU_Ref And Not bMaqR ) ) &
	Then
		stMessage.sTitre		= "Emailing KSL : courrier<=>contexte"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "WSIN914"
		stMessage.sVar[1] = sTypeMail
		stMessage.sVar[2] = "(" + sLibCodInter + ") " + sNomInter		
		If F_Message ( stMessage ) = 2 Then Return "ALT_BLOC"		
	End If 


	// On ne peut avoir qu'un seul refus affecté à un inter
	If Not IsNull ( sTypeMail ) And sTypeMail <> ""	And bAMU_Ref And iNbreRef > 1 and bMaqR Then
		stMessage.sTitre		= "Emailing KSL : courrier<=>Nbre de refus"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "WSIN915"
		stMessage.sVar[1] = "(" + sLibCodInter + ") " + sNomInter		
		stMessage.sVar[2] = sTypeMail
		stMessage.sVar[3] = "(" + sLibCodInter + ") " + sNomInter		
		F_Message ( stMessage ) 
		Return "ALT_BLOC"		
		
	End IF 

	If Not IsNull ( sTypeMail ) Then
		sChaineEnvCourrier += "- Courrier " + sTypeMail + " pour (" + sLibCodInter + ") " + sNomInter	+ Char ( 10 )
	End If 
	
Next


// Pas de courrier
If Not bAMUPT_Courrier Then
	stMessage.sTitre		= "Emailing KSL : Pas de courrier"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "WSIN912"
	If F_Message ( stMessage ) = 2 Then Return "ALT_BLOC"
Else 
	stMessage.sTitre		= "Emailing KSL : Résumé des courriers"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sVar [1]   = sChaineEnvCourrier
	stMessage.sCode		= "WSIN917"
	If F_Message ( stMessage ) = 2 Then Return "ALT_BLOC"
End IF 

Return sPos
end function

public subroutine uf_initialiser_1 (ref u_gs_sp_sinistre auospgssinistre, ref datawindow adw_detpro, ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdet, ref boolean abcodicdartyvalide, ref string astypetrt, ref string asreferentielapp, integer ak_majzone, ref datawindow adw_wdetail, u_datawindow_detail adw_lstgti, ref statictext astattentediverse, ref boolean abmig1_couremailing, ref u_datawindow_detail adw_lstinter, ref datawindow adw_wpiece, ref datawindow adw_wrefus);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_initialiser_1 (Public)
//* Auteur			: FABRY JF
//* Date				: 12/11/2024
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour l'objet numéro 2
//*
//* Arguments		: Voir arguments
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   19/12/2024 [MIG1_COUR_EMAILING]
// TOTO
//*-----------------------------------------------------------------

iuoSpGsSinistre		= auoSpGsSinistre

idw_detpro 				= adw_detpro
idw_wsin   				= adw_wsin
idw_lstwcommande 		= adw_lstwcommande
idw_wdivsin 			= adw_wdivsin
idw_wdivdet 			= adw_wdivdet

ibCodicDartyValide	= abCodicDartyValide
isTypeTrt				= asTypeTrt
isReferentielApp		= asReferentielApp
K_MAJZONE				= aK_MAJZONE
idw_wDetail				= adw_wDetail

idw_LstGti				= adw_LstGti

istAttenteDiverse    = astAttenteDiverse

ibMIG1_CourEmailing  = abMIG1_CourEmailing // [MIG1_COUR_EMAILING]

idw_LstInter			= adw_LstInter

idw_wPiece				= adw_wPiece
idw_wRefus				= adw_wRefus


end subroutine

public function long uf_zn_trt_divsin_ech_express_48h (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_Ech_express_48h (PRIVATE)
//* Auteur			: FPI
//* Date				: 07/07/2014
//* Libellé			: 
//* Commentaires	: [PC13442]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Integer iAction

Long lRow, lDeb, lFin, lVal1, lVal2

asData = Upper ( asData )
iAction = 0

if idw_wDetail.Find ( "COD_ETAT = 600 OR COD_ETAT = 500", 1, idw_wDetail.RowCount () ) + &
		idw_LstwCommande.Find ( "COD_ETAT <> 'ANN' ", 1, idw_LstwCommande.RowCount () ) > 0 Then 
		idw_wDivSin.iiErreur = 7
		iAction = 1
End If

Return iAction

end function

public function long uf_zn_trt_divsin_modepaiementpaybox (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivSin_ModePaiementPayBox (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 03/11/2013
//* Libellé			: 
//* Commentaires	: [FNAC_PROD_ECH_TECH]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   09/01/2009   [FNAC_PROD_ECH_TECH].[20090112170517890]
//* #2    JFF   08/01/2010   [FNAC_TV_BGE]
//        JFF   26/09/2023   [RS5928_FRCH_CHQ]
//*-----------------------------------------------------------------

Integer iAction
Boolean bFnacTV
Long lRow, lDeb, lFin, lCpt
String sVal, sDataActuelle

asData = Upper ( asData )
iAction = 0

If asData = "CB" Then
	idw_wDivSin.iiErreur = 7
	Return 1
End If

// [RS5928_FRCH_CHQ]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 298)
If lDeb > 0 Then

	sVal = iuoSpGsSinistre.uf_GestOng_Divers_Trouver ( "DTE_CMPLT_ADH_PAYE_ASS_PAYBOX" )
	sDataActuelle = iuoSpGsSinistre.uf_GestOng_Divers_Trouver ( "MODE_PAIEMENT" )

	If IsNull ( sVal ) Then sVal = ""
	If sVal <> "" Then
		idw_wDivSin.iiErreur = 12
		Return 1
	End If 
	
	If asData = "CHQ" Then 

		stMessage.sTitre  	= "Confirmation demandée"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode = "WSIN896"		

		If F_Message ( stMessage ) = 2 Then
			idw_wDivSin.iiErreur = 0
			iuoSpGsSinistre.uf_gestong_divers_majzone( "MODE_PAIEMENT", alRow, K_MAJZONE, sDataActuelle)
			Return 2
		End IF

		iuoSpGsSinistre.uf_gestong_divers_majzone( "MODE_PAIEMENT", alRow, K_MAJZONE, asData )
		idw_wDivSin.SetItem ( alRow,"ALT_PROT", "O" )					
		idw_wDivSin.SetRow ( idw_wDivSin.GetRow() + 1 ) 

		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode = "WSIN898"		
		F_Message ( stMessage )

		lRow = idw_wPiece.Find ( "ID_PCE = 629" , 1, idw_wPiece.RowCount () ) 
		If lRow > 0 Then
			idw_wPiece.DeleteRow ( lRow ) 
		End If 

		lRow = idw_WDivSin.Find ( "NOM_ZONE = 'dte_cmplt_adh_paye_ass_paybox'", 1,  idw_WDivSin.RowCount () )					
		If lRow > 0 Then
			iuoSpGsSinistre.uf_gestong_divers_majzone( "DTE_CMPLT_ADH_PAYE_ASS_PAYBOX", lRow, K_MAJZONE, String ( Today()) )
		End If

	End If 

End If 

Return iAction

end function

public function boolean uf_validation_finale_trt_partaprescommit ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre::uf_Validation_Finale_Trt_PartApresCommit (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 12/03/2019 16:43:53
//* Libellé       : Traitement validation post commit
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   11/03/2019   [DT339]
//        JFF   18/02/2025   [PMO268_MIG48]
//*-----------------------------------------------------------------

n_cst_string lnvPFCString
DateTime dtCreeLeDos, dtPivotCourHTMLviaWSSaga2
Boolean  bRet
Long     lDeb, lFin, lRow, lIdContrantAbonne, lIdProd, lIdSin 
n_cst_gs_appel_api_generique ObjAppelAPI
String sAdrMail, sMarqModlApp 
Integer iMtCmde, iIdSeq 

dtCreeLeDos = idw_WSin.GetItemDateTime ( 1, "CREE_LE")

bRet=TRUE // [PC846/864]

// [DT339]
/* Obsolète
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 333 )	
If bRet and lDeb > 0 Then
	dtPivotCourHTMLviaWSSaga2 = DateTime ( lnvPFCString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "DTE_PIVOT", ";") )
	If dtCreeLeDos >= dtPivotCourHTMLviaWSSaga2 Then
		bRet = This.uf_Validation_Finale_CourHTMLviaWSSaga2 ()
		asCasRetour = "CARMA_WS_SAGA2"
	End If
End If 
*/

// [PMO268_MIG48]
lDeb = idw_LstwCommande.Find("ID_FOUR='BTE' AND COD_ETAT IN ( 'CNV', 'ECT' ) ", 1, idw_LstwCommande.rowCount())
If lDeb > 0 Then 
	// Obtention des données
		iIdSeq = lDeb
		lRow = idw_LstInter.Find ( "COD_INTER = 'A'", 1, idw_LstInter.Rowcount () )
		sAdrMail = idw_LstInter.GetItemString ( lRow, "ADR_MAIL" )
		iMtCmde  = idw_LstwCommande.GetItemDecimal ( iIdSeq, "MT_TTC_CMDE" ) * 100 // En centimes
		lIdContrantAbonne = Long ( idw_WSin.GetItemString ( 1, "ID_CONTRAT_ABONNE" ) )
		sMarqModlApp = Trim ( idw_WSin.GetItemString ( 1, "MARQ_PORT" ) ) + " " + Trim (  idw_WSin.GetItemString ( 1, "MODL_PORT" ) )
		lIdProd = idw_WSin.GetItemNumber ( 1, "ID_PROD" )  
		lIdSin = idw_WSin.GetItemNumber ( 1, "ID_SIN" )  
		
	
	// APPEL APi MAxi Coffee
		ObjAppelAPI = Create n_cst_gs_appel_api_generique
	
		bRet = ObjAppelAPI.uf_api_maxi_coffee_caller ( & 
				idw_LstwCommande, &
				iIdSeq, &
				istAttenteDiverse, &
				sAdrMail, iMtCmde, &
				lIdContrantAbonne, &
				sMarqModlApp, &
				lIdProd, &
				lIdSin &
		)
		
		If IsValid ( ObjAppelAPI ) Then Destroy ( ObjAppelAPI )
	

End If 	

Return bRet

end function

on u_gs_sp_sinistre_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

