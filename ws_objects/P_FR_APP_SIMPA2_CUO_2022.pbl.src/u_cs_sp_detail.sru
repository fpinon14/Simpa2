HA$PBExportHeader$u_cs_sp_detail.sru
forward
global type u_cs_sp_detail from u_cs_sp_ancetre
end type
end forward

global type u_cs_sp_detail from u_cs_sp_ancetre
end type
global u_cs_sp_detail u_cs_sp_detail

type variables
Private :

long	ilCodTel

u_DataWindow	idw_DivDetsin
end variables

forward prototypes
public function boolean uf_preparer_consulter ()
private subroutine uf_initialiser_dddw ()
private subroutine uf_initialiser_refus ()
private subroutine uf_copier_refus ()
private subroutine uf_changer_produit ()
private subroutine uf_gestion_zones_telephonie (long alidevt)
private subroutine uf_gestong_divers ()
public subroutine uf_init_detail (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref datawindow adw_si_codecondition, ref datawindow adw_si_codegarantie, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref datawindow adw_si_codecar, ref datawindow adw_in_inter, ref u_datawindow_detail adw_ga_detail, ref u_datawindow adw_dt_detail, ref u_tagger auo_dt_refus, ref u_onglets auo_dt_onglet, ref datawindow adw_si_produit, ref u_datawindow adw_div_det, ref u_datawindow adw_divdetsin, ref datawindow adddw_code_divsin_charg_tempo, ref datawindow adddw_codecar_divsin_charg_tempo, u_datawindow adw_detpro)
end prototypes

public function boolean uf_preparer_consulter ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Detail
//* Fonction		:	uf_preparer_Consulter	(Public)
//* Auteur			:	PLJ
//* Date				:	29/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation des d$$HEX1$$e900$$ENDHEX$$tails
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True / False
//*
//*-----------------------------------------------------------------
//			FPI	24/08/2011	[VDoc5059]
//*-----------------------------------------------------------------

Boolean bRet
String sCol[]
Long lDeb, lFin
n_cst_string nvstring
Integer iPos
String sNomCol, sVal
String sOnglet

bRet = True

ilCodTel = idw_Si_Produit.GetItemNumber ( 1, "COD_TEL" ) 

uf_Initialiser_Refus ()
uf_Initialiser_DdDw ()				// Initialisation des DdDw pour idw_Dt_Detail + 


uf_Changer_Produit ()	

/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans la dw    */
/* de la fen$$HEX1$$ea00$$ENDHEX$$tre Interlocureur												  */
/*------------------------------------------------------------------*/
bRet = idw_Dt_Detail.Uf_CopierLigne ()


Uf_Copier_Refus  ()

If IsNull ( idw_Dt_Detail.GetItemNumber ( 1, "ID_EVT" ) ) Then
	Uf_Gestion_Zones_Telephonie ( -1 )
Else
	Uf_Gestion_Zones_Telephonie ( idw_Dt_Detail.GetItemNumber ( 1, "ID_EVT" ) )
End If


/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet (DataWindow Interlocuteur) */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/

sOnglet = iUo_Onglet.Uf_RecupererOngletCourant ()			
If sOnglet <> "01" Then											
	iUo_Onglet.Uf_ChangerOnglet ("01")						
End If	

// 	[VDoc5059]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" ), '-DP', 178 )
If lDeb > 0 Then
	idw_Dt_Detail.Modify("mt_prej_t.Text='Surconsommation'")
End if

uf_GestOng_Divers ()

Return bRet
end function

private subroutine uf_initialiser_dddw ();//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Garantie
//* Fonction		:	uf_Initialiser_DdDw
//* Auteur			:	PLJ
//* Date				:	27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						de idw_Dt_Detail + ????
//* Commentaires	:	
//*
//* Arguments		:	Aucun			
//*								
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long lRet

DataWindowChild		dwChild, dwChild1


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes COD_MOT_SSUI, COD_DEC_MAC, COD_DEC_OPE, COD_ETAT.       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec idw_wSin.   */
/*------------------------------------------------------------------*/
idw_Si_Sinistre.GetChild ( "COD_MOT_SSUI", dwChild )
idw_Dt_Detail.GetChild ( "COD_MOT_SSUI", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_DEC_MAC", dwChild )
idw_Dt_Detail.GetChild ( "COD_DEC_MAC", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_DEC_OPE", dwChild )
idw_Dt_Detail.GetChild ( "COD_DEC_OPE", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_ETAT", dwChild )
idw_Dt_Detail.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour le libell$$HEX2$$e9002000$$ENDHEX$$de la garantie.             */
/*------------------------------------------------------------------*/
lRet = idw_Dt_Detail.GetChild ( "ID_GTI", dwChild )
lRet = idw_Si_CodeGarantie.ShareData ( dwChild )


/*------------------------------------------------------------------*/
/* On fait un ShareData pour la d$$HEX1$$e900$$ENDHEX$$signation des interlocuteurs      */
/* pour les pi$$HEX1$$e800$$ENDHEX$$ces, les refus et le destinataire du r$$HEX1$$e900$$ENDHEX$$glement.      */
/*------------------------------------------------------------------*/
//iuoTagPiece.dw_Trt.GetChild ( "ID_I", dwChild )
//idw_LstInter.ShareData ( dwChild )
//
//iuoTagRefus.dw_Trt.GetChild ( "ID_I", dwChild )
//idw_LstInter.ShareData ( dwChild )
//
//idw_wDetailFF.GetChild ( "ID_I_REG", dwChild )
//idw_LstInter.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la liste des conditions.                */
/*------------------------------------------------------------------*/
idw_Dt_Detail.GetChild ( "ID_EVT", dwChild )
idw_Si_CodeCondition.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la liste des Type de carte. (CodeCar)  */
/*------------------------------------------------------------------*/
idw_Dt_Detail.GetChild ( "ID_TYPE_CARTE", dwChild )
idw_Si_CodeCarTc.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la liste des Interlocuteurs. (Inter)   */
/*------------------------------------------------------------------*/
idw_Dt_Detail.GetChild ( "ID_I_REG", dwChild )
idw_In_Inter.ShareData ( dwChild )

iuo_Dt_Refus.dw_Trt.GetChild ( "ID_I", dwChild )
idw_In_Inter.ShareData ( dwChild )


end subroutine

private subroutine uf_initialiser_refus ();//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Detail       ( Private )
//* Fonction		:	uf_Initialiser_Refus
//* Auteur			:	PLJ
//* Date				:	30/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DataWindows de l'objet Tagger Refus
//*						
//* Commentaires	:	
//*
//* Arguments		:	Aucun			
//*								
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------


iuo_Dt_Refus.dw_Trt.DataObject		= "d_Lst_Refus_Affecte"
iuo_Dt_Refus.dw_Source.DataObject 	= idw_Si_Motif.DataObject
end subroutine

private subroutine uf_copier_refus ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Detail
//* Fonction		:	uf_Copier_Refus	(Private)
//* Auteur			:	PLJ
//* Date				:	28/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie les refus de la fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre sur la
//*						l'objet u_tagger de la fen$$HEX1$$ea00$$ENDHEX$$tre D$$HEX1$$e900$$ENDHEX$$tail,
//*						pour la garantie, et le d$$HEX1$$e900$$ENDHEX$$tail s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------


Long		lTotRefusTag, lTotMotif, lCpt

String 	sFiltre, sBitMap, sLigne, sTab, sNew


sTab		= "~t"
sNew		= "~r~n"

iuo_Dt_Refus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re dans DW_TRT les refus d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$positionn$$HEX1$$e900$$ENDHEX$$s. Pour cela on   */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
sFiltre = "ID_GTI = " + String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_GTI" ) ) + &
			 " AND ID_DETAIL = " + String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_DETAIL" ) )

idw_Si_Refus.SetFilter ( sFiltre )
idw_Si_Refus.Filter ()
idw_Si_Refus.Sort ()
lTotRefusTag = idw_Si_Refus.RowCount ()

If	lTotRefusTag > 0 Then
	sBitMap = "K:\PB4OBJ\BMP\8_REF.BMP"
Else
	sBitMap = ""
End If

iuo_Onglet.Uf_ChangerBitmap ( "02", sBitMap )
	
	
idw_Si_Refus.RowsCopy ( 1, lTotRefusTag, Primary!, iuo_Dt_Refus.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wRefus.                               */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_Si_Refus.SetFilter ( sFiltre )
idw_Si_Refus.Filter ()
idw_Si_Refus.Sort ()

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re maintenant les refus non positionn$$HEX1$$e900$$ENDHEX$$s. Pour cela on     */
/* filtre dw_Source sur ID_GTI et COD_TYP_MOTIF. On n'oublie pas de */
/* filtrer les motifs d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sents dans dw_Trt.                    */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTotRefusTag
		sFiltre = sFiltre + "ID_MOTIF <> " + String ( iuo_Dt_Refus.dw_Trt.GetItemNumber ( lCpt, "ID_MOTIF" ) ) + " AND "
Next

sFiltre = sFiltre + "ID_GTI = " + String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'E'"

iuo_Dt_Refus.dw_Source.SetFilter ( sFiltre )
iuo_Dt_Refus.dw_Source.Filter ()
iuo_Dt_Refus.dw_Source.Sort ()
lTotMotif = iuo_Dt_Refus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne avec la valeur du d$$HEX1$$e900$$ENDHEX$$tail en cours      */
/* ID_MOTIF                                                         */
/* ALT_MAC                                                          */
/* ALT_OPE                                                          */
/* ID_I      : Positionn$$HEX4$$e9002000e0002000$$ENDHEX$$""                                      */
/* ID_PARA                                                          */
/* CREE_LE	: Cette valeur sera positionn$$HEX1$$e900$$ENDHEX$$e sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionn$$HEX1$$e900$$ENDHEX$$e sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* CPT_VER                                                          */
/* LIB_MOTIF                                                        */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTotMotif
		sLigne = sLigne 																										+ &
					String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_SIN" ) )							+ sTab	+ &
					String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_GTI" ) )							+ sTab	+ &
					String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_DETAIL" ) )						+ sTab	+ &
					String ( iuo_Dt_Refus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )			+ sTab	+ &
					"N"																								+ sTab	+ &
					"N"																								+ sTab	+ &
																														+ sTab	+ &
					iuo_Dt_Refus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 						+ sTab	+ &
																														+ sTab	+ &
																														+ sTab	+ &
					stGLB.sCodOper																					+ sTab	+ &
					iuo_Dt_Refus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 						+ sTab	+ &
					iuo_Dt_Refus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 						+ sNew
Next
iuo_Dt_Refus.dw_Trt.ImportString ( sLigne )

sFiltre = ""

iuo_Dt_Refus.dw_Source.SetFilter ( sFiltre )
iuo_Dt_Refus.dw_Source.Filter ()
iuo_Dt_Refus.dw_Source.Sort ()

iuo_Dt_Refus.dw_Trt.Sort ()
end subroutine

private subroutine uf_changer_produit ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerProduit (PRIVATE)
//* Auteur			: PLJ
//* Date				: 30/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: A t-on chang$$HEX2$$e9002000$$ENDHEX$$de produit ou de r$$HEX1$$e900$$ENDHEX$$vision ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* L'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Initialiser est d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$e qu'une seule fois      */
/* fois. Or la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation a besoin de savoir si        */
/* le produit a chang$$HEX1$$e900$$ENDHEX$$. Il faut donc faire le test sur              */
/* Uf_Preparer_Consulter.							                       */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Les initialisations relatives au Produit/R$$HEX1$$e900$$ENDHEX$$vision auront lieu    */
/* ici.                                                             */
/*------------------------------------------------------------------*/
Long lIdProd, lIdRev

lIdProd		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )
lIdRev		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )

If	lIdProd <> ilDernierIdProd Or lIdRev <> ilDernierIdRev	Then
	iuo_Dt_Refus.dw_Source.Reset ()
	idw_Si_Motif.RowsCopy ( 1, 999, Primary!, iuo_Dt_Refus.dw_Source, 1, Primary! )
End If

end subroutine

private subroutine uf_gestion_zones_telephonie (long alidevt);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Zones_Telephonie (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 21/05/2001 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: alIdEvt	Long		val		Evenement
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean	bAltTel
String	sMod, sVisible, sCol []

bAltTel = ilCodTel > 0
sVisible = "0"

If bAltTel Then

	CHOOSE CASE alIdEvt

		// 841 Remplacement du T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone  
		// 932 R$$HEX1$$e900$$ENDHEX$$paration du  t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone   
		CASE 841, 932
			sVisible = "1"

		Case Else
			sVisible = "0"
	
	END CHOOSE

End If
/*----------------------------------------------------------------------------*/
/* Visible si le produit g$$HEX1$$e800$$ENDHEX$$re la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                                  */
/*----------------------------------------------------------------------------*/
idw_dt_Detail.Modify ( "t_dte_cmd.visible = " + sVisible + " dte_cmd.visible = " + sVisible + &
							  " t_dte_livr.visible = " + sVisible + " dte_livr.visible = " + sVisible ) 


end subroutine

private subroutine uf_gestong_divers ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_cs_sp_detail::uf_GestOng_Divers (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/06/2004 11:13:57
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de l'onglet DIVERS
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long lTotParam, lCptParam, lCptDivS, lRowDS, lRowDP, lTotDivS, lNull, lTotVal, lCptVal, lRowChild, lCptDiv, lTotDiv
String	sNomZoneP, sNomZoneS, sIdTypListe, sNull, sAltLstCodeCar, sFiltre
Decimal  dcNull
Date		dNull
DataWindowChild	dwChildCodeCar, dwChildCode 

SetNull ( dNull )
SetNull ( lNull )
SetNull ( sNull )
SetNull ( dcNull )


sFiltre = "ID_GTI = " + String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_GTI" ) ) + &
			 " AND ID_DETAIL = " + String ( idw_Dt_Detail.GetItemNumber ( 1, "ID_DETAIL" ) )

idw_DivDet.SetFilter  ( sFiltre )
idw_DivDet.Filter ( )
idw_DivDet.SetSort ( "ID_GTI A, ID_DETAIL A, CPT_TRI A" )
idw_DivDet.Sort ( )

lTotDivS  = idw_DivDet.RowCount ()

idw_DivDet.GetChild ( "VAL_LST_CAR", dwChildCodeCar )
dwChildCodeCar.Reset ()

idw_DivDet.GetChild ( "VAL_LST_NBRE", dwChildCode )
dwChildCode.Reset ()

For lCptDivS = 1 To lTotDivS
	sIdTypListe = idw_DivDet.GetItemString ( lCptDivS, "ID_TYP_LISTE" ) 

	idw_DivDet.SetItem ( lCptDivS, "ALT_PROT", "O" )

	/*---------------------------------------------------------------------*/
	/* Liste $$HEX2$$e0002000$$ENDHEX$$charger (on ne peut en charger qu'une seule de chaque type!)*/
	/*---------------------------------------------------------------------*/
	If sIdTypListe <> "-1" Then
		Choose Case idw_DivDet.GetItemString ( lCptDivS, "ALT_LISTE_CODECAR" ) 

			// Retrieve sur Code_Car
			Case "O"

				idddw_CodeCar_DivSin_Charg_Tempo.Retrieve ( sIdTypListe )

				lTotVal = idddw_CodeCar_DivSin_Charg_Tempo.RowCount ()

				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCodeCar.InsertRow ( 0 )
					dwChildCodeCar.SetItem ( lRowChild, "ID_CODE", idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "ID_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "LIB_CODE", idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "NOM_ZONE", idw_DivDet.GetItemString ( lCptDivS, "NOM_ZONE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
				Next

			// Retrieve sur Code
			Case "N"			
				idddw_Code_DivSin_Charg_Tempo.Retrieve ( sIdTypListe )

				lTotVal = idddw_Code_DivSin_Charg_Tempo.RowCount ()

				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCode.InsertRow ( 0 )
					dwChildCode.SetItem ( lRowChild, "ID_CODE", idddw_Code_DivSin_Charg_Tempo.GetItemNumber ( lCptVal, "ID_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "LIB_CODE", idddw_Code_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "NOM_ZONE", idw_DivDet.GetItemString ( lCptDivS, "NOM_ZONE" ) )
					dwChildCode.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
				Next


		End Choose
	End If

Next

idw_DivDet.Sort ()



end subroutine

public subroutine uf_init_detail (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref datawindow adw_si_codecondition, ref datawindow adw_si_codegarantie, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref datawindow adw_si_codecar, ref datawindow adw_in_inter, ref u_datawindow_detail adw_ga_detail, ref u_datawindow adw_dt_detail, ref u_tagger auo_dt_refus, ref u_onglets auo_dt_onglet, ref datawindow adw_si_produit, ref u_datawindow adw_div_det, ref u_datawindow adw_divdetsin, ref datawindow adddw_code_divsin_charg_tempo, ref datawindow adddw_codecar_divsin_charg_tempo, u_datawindow adw_detpro);//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Sinistre
//* Fonction		:	uf_Init_Sinistre
//* Auteur			:	PLJ
//* Date				:	16/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences aux objets de 
//*                  de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation SINISTRE
//* Commentaires	:	
//*
//* Arguments		:	u_Transaction					atrTrans	
//*						u_DataWindow					adw_Si_Sinistre
//*						DataWindow						adw_Si_CodeCondition
//*						DataWindow						adw_Si_CodeGarantie
//*						DataWindow						adw_Si_Refus
//*                  DataWindow						adw_Si_Motif
//*						DataWindow						adw_Si_codecar
//*						u_DataWindow					adw_Si_Inter
//*						u_DataWinDow_Detail			adw_Ga_Detail			
//*						u_DataWindow					adw_Dt_Detail
//*						u_Tagger							auo_Dt_Refus
//*						u_onglets						auo_Dt_Onglet
//*						u_DataWindow					adw_Div_Det
//*						u_datawindow					adw_DivDetsin
//*						
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
// 		FPI		24/08/2011	[VDoc5059]
//*-----------------------------------------------------------------

itrTrans     			= atrTrans						// ... Transaction

idw_Si_Sinistre		= adw_Si_Sinistre				// ... Dw Sinistre 		 sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_CodeCondition	= adw_Si_CodeCondition		// ... Dw Code condition  "     "       "
idw_Si_CodeGarantie	= adw_Si_CodeGarantie		// ... Dw Code Garantie   "     "       "
idw_Si_Refus			= adw_Si_Refus				   // ... Dw Refus      	  "     "       "
idw_Si_Motif			= adw_Si_Motif				   // ... Dw Motif      	  "     "       "
idw_Si_CodeCarTC		= adw_Si_CodeCar			   // ... Dw CodeCar      	  "     "       "
idw_Si_Produit			= adw_Si_Produit			   // ... Dw Produit      	  "     "       "

idw_In_Inter			= adw_In_Inter			  		// ... Dw Inter			 sur fen$$HEX1$$ea00$$ENDHEX$$tre Inter

idw_Ga_Detail			= adw_Ga_Detail				// ... Dw Detail   		 sur fen$$HEX1$$ea00$$ENDHEX$$tre Garantie

idw_Dt_Detail			= adw_Dt_Detail				// ... Dw Detail    		 sur fen$$HEX1$$ea00$$ENDHEX$$tre D$$HEX1$$e900$$ENDHEX$$tail
iuo_Dt_Refus			= auo_Dt_Refus					// ... Dw Refus			  "     "      "

iuo_onglet				= auo_Dt_Onglet				// ... Onglet     		  "     "      " 

idw_DivDet				= aDw_Div_Det
idw_DivDetsin			= adw_DivDetsin

idw_detpro 				= adw_detpro // [VDoc5059]

//Migration PB8-WYNIWYG-03/2006 FM
//avant le ShareData, il faut s'occupper des la Child sur val_lst_car et val_lst_nbre
DataWindowChild	ldwc_1, ldwc_2
long	ll_ret
ll_ret = idw_DivDetsin.GetChild("val_lst_car", ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = idw_DivDet.GetChild("val_lst_car", ldwc_2)
ll_ret = ldwc_2.SetTransObject(SQLCA)
ll_ret = ldwc_1.ShareData(ldwc_2)

ll_ret = idw_DivDetsin.GetChild("val_lst_nbre", ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = idw_DivDet.GetChild("val_lst_nbre", ldwc_2)
ll_ret = ldwc_2.SetTransObject(SQLCA)
ll_ret = ldwc_1.ShareData(ldwc_2)
//Fin Migration PB8-WYNIWYG-03/2006 FM
idw_DivDetsin.ShareData ( idw_DivDet )

idddw_code_divsin_charg_tempo 	= adddw_code_divsin_charg_tempo
idddw_codecar_divsin_charg_tempo	= adddw_codecar_divsin_charg_tempo

/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$cise la datawindow source detail li$$HEX4$$e9002000e0002000$$ENDHEX$$idw_Dt_Detail          */
/*------------------------------------------------------------------*/

idw_Dt_Detail.uf_DetailParent( idw_Ga_Detail )
end subroutine

on u_cs_sp_detail.create
call super::create
end on

on u_cs_sp_detail.destroy
call super::destroy
end on

