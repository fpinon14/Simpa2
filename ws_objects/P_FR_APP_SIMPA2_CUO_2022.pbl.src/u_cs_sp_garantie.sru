HA$PBExportHeader$u_cs_sp_garantie.sru
forward
global type u_cs_sp_garantie from u_cs_sp_ancetre
end type
end forward

global type u_cs_sp_garantie from u_cs_sp_ancetre
end type
global u_cs_sp_garantie u_cs_sp_garantie

forward prototypes
public function boolean uf_preparer_consulter ()
private subroutine uf_initialiser_dddw ()
private subroutine uf_copier_detail ()
private subroutine uf_copier_refus ()
private subroutine uf_initialiser_refus ()
private subroutine uf_changer_produit ()
public subroutine uf_init_garantie (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref u_datawindow_detail adw_si_gti, ref datawindow adw_si_detail, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref datawindow adw_si_codecondition, datawindow adw_si_inter, ref u_datawindow adw_ga_gti, ref u_datawindow_detail adw_ga_detail, ref u_tagger auo_ga_refus, ref u_onglets auo_ga_onglet)
end prototypes

public function boolean uf_preparer_consulter ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Garantie
//* Fonction		:	uf_preparer_Consulter	(Public)
//* Auteur			:	PLJ
//* Date				:	27/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation des garanties
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True / False
//*
//*-----------------------------------------------------------------


Boolean bRet

String sOnglet

bRet = True


uf_Initialiser_Refus ()
uf_Initialiser_DdDw  ()				// Initialisation des DdDw pour idw_Si_Sinistre


uf_Changer_Produit ()				


/*------------------------------------------------------------------*/
/* On bascule sur le premier Onglet										     */
/*------------------------------------------------------------------*/
sOnglet = iUo_Onglet.Uf_RecupererOngletCourant ()			
If sOnglet <> "01" Then											
	iUo_Onglet.Uf_ChangerOnglet ("01")						
End If	


/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans la dw    */
/* de la fen$$HEX1$$ea00$$ENDHEX$$tre Interlocureur												  */
/*------------------------------------------------------------------*/
bRet = idw_Ga_Gti.Uf_CopierLigne ()

Uf_Copier_Detail ()
Uf_Copier_Refus  ()


Return bRet
end function

private subroutine uf_initialiser_dddw ();//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Garantie
//* Fonction		:	uf_Initialiser_DdDw
//* Auteur			:	PLJ
//* Date				:	27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						de idw_Ga_Gti
//* Commentaires	:	
//*
//* Arguments		:	Aucun			
//*								
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild, dwChild1

/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec idw_wSin.   */
/*------------------------------------------------------------------*/
idw_Si_Sinistre.GetChild ( "COD_MOT_SSUI", dwChild )
idw_Ga_Gti.GetChild ( "COD_MOT_SSUI", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_DEC_MAC", dwChild )
idw_Ga_Gti.GetChild ( "COD_DEC_MAC", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_DEC_OPE", dwChild )
idw_Ga_Gti.GetChild ( "COD_DEC_OPE", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_ETAT", dwChild )
idw_Ga_Gti.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Gti.GetChild ( "ID_GTI", dwChild )
idw_Ga_Gti.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Ga_Detail.GetChild ( "ID_EVT", dwChild )
idw_Si_CodeCondition.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la d$$HEX1$$e900$$ENDHEX$$signation des interlocuteurs      */
/* pour les refus.                                                  */
/*------------------------------------------------------------------*/

iuo_ga_refus.dw_Trt.GetChild ( "ID_I", dwChild )
idw_Si_Inter.ShareData ( dwChild )

end subroutine

private subroutine uf_copier_detail ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Garantie
//* Fonction		:	uf_Copier_Detail	(Private)
//* Auteur			:	PLJ
//* Date				:	28/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie les Details de la fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre sur la
//*						fen$$HEX1$$ea00$$ENDHEX$$tre garantie, pour la garantie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long 		lTot, lret, lCpt

String 	sFiltre


/*------------------------------------------------------------------*/
/* On pose le filtre sur dw_Si_Detail	                             */
/*------------------------------------------------------------------*/

sFiltre = "ID_GTI = " + String ( idw_Ga_Gti.GetItemNumber ( 1, "ID_GTI" ) ) 
lret = idw_Si_Detail.SetFilter ( sFiltre )
lret = idw_Si_Detail.Filter ()


/*------------------------------------------------------------------*/
/* On effectue la copie de dw_Si_Detail -->  dw_Ga_Detail           */
/*------------------------------------------------------------------*/

lTot = idw_Si_Detail.RowCount ()

idw_Ga_Detail.Reset ()	
lret = idw_Si_Detail.RowsCopy ( 1, lTot, Primary!, idw_Ga_Detail, 1, Primary! )
lret = idw_Ga_Detail.Sort ()


/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_Si_Detail                             */
/*------------------------------------------------------------------*/

sFiltre = ""
idw_Si_Detail.SetFilter ( sFiltre )
idw_Si_Detail.Filter ()
//idw_Si_Detail.Sort ()


/*------------------------------------------------------------------*/
/* Le 29/03/1999. DGA                                               */
/* Modification pour la consultation de l'EURO.                     */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		idw_Ga_Detail.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
		idw_Ga_Detail.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
Next

end subroutine

private subroutine uf_copier_refus ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Garantie
//* Fonction		:	uf_Copier_Refus	(Private)
//* Auteur			:	PLJ
//* Date				:	28/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie les refus de la fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre sur la
//*						l'objet u_tagger de la fen$$HEX1$$ea00$$ENDHEX$$tre garantie,
//*						pour la garantie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------


Long		lTotRefusTag, lTotMotif, lCpt, lRet

String 	sFiltre, sBitMap, sLigne, sTab, sNew


sTab		= "~t"
sNew		= "~r~n"


iuo_Ga_Refus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re dans DW_TRT les refus d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$positionn$$HEX1$$e900$$ENDHEX$$s. Pour cela on   */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
sFiltre = "ID_GTI = " + String ( idw_Ga_Gti.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

idw_Si_Refus.SetFilter ( sFiltre )
idw_Si_Refus.Filter ()
lTotRefusTag = idw_Si_Refus.RowCount ()

If	lTotRefusTag > 0 Then
	sBitMap = "K:\PB4OBJ\BMP\8_REF.BMP"
Else
	sBitMap = ""
End If

iuo_onglet.Uf_ChangerBitmap ( "02", sBitMap )
	

lRet = idw_Si_Refus.RowsCopy ( 1, lTotRefusTag, Primary!, iuo_Ga_Refus.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wRefus.                               */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_Si_Refus.SetFilter ( sFiltre )
idw_Si_Refus.Filter ()
	

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re maintenant les refus non positionn$$HEX1$$e900$$ENDHEX$$s. Pour cela on     */
/* filtre dw_Source sur ID_GTI et COD_TYP_MOTIF. On n'oublie pas de */
/* filtrer les motifs d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sents dans dw_Trt.                    */
/*------------------------------------------------------------------*/
For lCpt = 1 To lTotRefusTag
	sFiltre = sFiltre + "ID_MOTIF <> " + String ( iuo_Ga_Refus.dw_Trt.GetItemNumber ( lCpt, "ID_MOTIF" ) ) + " AND "
Next

sFiltre = sFiltre + "ID_GTI = " + String ( idw_Ga_Gti.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'G'"

iuo_Ga_Refus.dw_Source.SetFilter ( sFiltre )
iuo_Ga_Refus.dw_Source.Filter ()
iuo_Ga_Refus.dw_Source.Sort ()
lTotMotif = iuo_ga_Refus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne -1                                     */
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
For lCpt = 1 To lTotMotif
	sLigne = sLigne 																								+ &
				String ( idw_Ga_Gti.GetItemNumber ( 1, "ID_SIN" ) )						+ sTab	+ &
				String ( idw_Ga_Gti.GetItemNumber ( 1, "ID_GTI" ) )						+ sTab	+ &
				"-1"																						+ sTab	+ &
				String ( iuo_Ga_Refus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )	+ sTab	+ &
				"N"																						+ sTab	+ &
				"N"																						+ sTab	+ &
																											+ sTab	+ &
				iuo_ga_Refus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 				+ sTab	+ &
																											+ sTab	+ &
																											+ sTab	+ &
				stGLB.sCodOper																			+ sTab	+ &
				iuo_ga_Refus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 				+ sTab	+ &
				iuo_ga_Refus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 				+ sNew
Next

iuo_ga_Refus.dw_Trt.ImportString ( sLigne )

sFiltre = ""

iuo_Ga_Refus.dw_Source.SetFilter ( sFiltre )
iuo_Ga_Refus.dw_Source.Filter ()
iuo_Ga_Refus.dw_Source.Sort ()
iuo_Ga_Refus.dw_Trt.Sort ()



end subroutine

private subroutine uf_initialiser_refus ();//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Garantie    ( Private )
//* Fonction		:	uf_Initialiser_Refus
//* Auteur			:	PLJ
//* Date				:	27/07/1998
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


iuo_Ga_Refus.dw_Trt.DataObject		= "d_Lst_Refus_Affecte"
iuo_Ga_Refus.dw_Source.DataObject 	= idw_Si_Motif.DataObject
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
/* L'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Initialiser est d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$e qu'une seule fois. Or  */
/* la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation a besoin de savoir si le  produit  a  */
/* chang$$HEX1$$e900$$ENDHEX$$. Il faut donc faire le test sur Uf_Preparer_Consulter.    */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Les initialisations relatives au Produit/R$$HEX1$$e900$$ENDHEX$$vision  auront  lieu  */
/* ici.                                                             */
/*------------------------------------------------------------------*/
Long lIdProd, lIdRev

lIdProd		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )
lIdRev		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )

If	lIdProd <> ilDernierIdProd Or lIdRev <> ilDernierIdRev	Then

	iuo_Ga_Refus.dw_Source.Reset ()
	idw_Si_Motif.RowsCopy ( 1, 999, Primary!, iuo_Ga_Refus.dw_Source, 1, Primary! )

End If

end subroutine

public subroutine uf_init_garantie (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref u_datawindow_detail adw_si_gti, ref datawindow adw_si_detail, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref datawindow adw_si_codecondition, datawindow adw_si_inter, ref u_datawindow adw_ga_gti, ref u_datawindow_detail adw_ga_detail, ref u_tagger auo_ga_refus, ref u_onglets auo_ga_onglet);//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Garantie
//* Fonction		:	uf_Init_Garantie
//* Auteur			:	PLJ
//* Date				:	27/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences aux objets de 
//*                  de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation GARANTIE
//* Commentaires	:	
//*
//* Arguments		:	u_Transaction					atrTrans
//*						u_DataWinDow					adw_Si_Sinistre			
//*						u_DataWinDow_Detail			adw_Si_Gti	
//*						u_DataWinDow_Detail			adw_Si_Inter
//*						DataWindow						adw_Si_Detail
//*						DataWindow						adw_Si_Refus
//*						DataWindow						adw_Si_Motif	
//*						DataWindow						adw_Si_CodeCondition
//*						DataWindows						adw_si_inter
//*						u_DataWindow					adw_Ga_Gti
//*						u_DataWindow_Detail			adw_Ga_Detail
//*                  u_Tagger							auo_Ga_Refus
//*						u_onglets						auo_Ga_Onglet
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

itrTrans     		= atrTrans					// ... Transaction

idw_Si_Sinistre		= adw_Si_Sinistre			// ... Dw Sinistre  		sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Gti		  		= adw_Si_Gti				// ... Dw Garantie   	"     "       "			
idw_Si_Detail			= adw_Si_Detail			// ... Dw Detail     	"     "		  "
idw_Si_Refus			= adw_Si_Refus				// ... Dw Refus     		"     "       "
idw_Si_Motif			= adw_Si_Motif				// ... Dw Motif      	"     "       "
idw_Si_CodeCondition = adw_Si_CodeCondition	// ... Dw CodeCondition "     "       "
idw_Si_Inter			= adw_si_inter				// ... Dw Inter			"		"		  "

idw_Ga_Gti				= adw_Ga_Gti				// ... Dw Gti       		sur fen$$HEX1$$ea00$$ENDHEX$$tre Garantie
idw_Ga_Detail			= adw_Ga_Detail			// ... Dw Detail     	"     "       "

iuo_Ga_Refus			= auo_Ga_Refus				// ... Tagger Refus  	"     "       "

iuo_onglet				= auo_Ga_Onglet			// ... Onglet        	"     "       " 



/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$cise la datawindow source detail li$$HEX4$$e9002000e0002000$$ENDHEX$$idw_Ga_Gti             */
/*------------------------------------------------------------------*/

idw_Ga_Gti.uf_DetailParent( idw_Si_Gti )
end subroutine

on u_cs_sp_garantie.create
TriggerEvent( this, "constructor" )
end on

on u_cs_sp_garantie.destroy
TriggerEvent( this, "destructor" )
end on

