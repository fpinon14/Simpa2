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

DataWindow idw_DetPro
DataWindow idw_wDetail

Boolean			ibCodicDartyValide

String isTypeTrt
String isReferentielApp


integer K_MAJZONE // constant 
end variables

forward prototypes
public function long uf_zn_trt_divsin_typeapp (string asdata, string asnomcol, long alrow, boolean abforcer)
public subroutine uf_initialiser_1 (ref u_gs_sp_sinistre auospgssinistre, ref datawindow adw_detpro, ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdet, ref boolean abcodicdartyvalide, ref string astypetrt, ref string asreferentielapp, integer ak_majzone, ref datawindow adw_wdetail)
public function long uf_zn_trt_divsin_accessoire (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_accord_chubb (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_bloquedretude (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt_divsin_choixpack (string asdata, string asnomcol, long alrow, boolean abforcer)
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

public subroutine uf_initialiser_1 (ref u_gs_sp_sinistre auospgssinistre, ref datawindow adw_detpro, ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdet, ref boolean abcodicdartyvalide, ref string astypetrt, ref string asreferentielapp, integer ak_majzone, ref datawindow adw_wdetail);//*-----------------------------------------------------------------
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






end subroutine

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

on u_gs_sp_sinistre_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

