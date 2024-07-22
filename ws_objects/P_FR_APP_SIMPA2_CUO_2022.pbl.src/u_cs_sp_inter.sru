HA$PBExportHeader$u_cs_sp_inter.sru
forward
global type u_cs_sp_inter from u_cs_sp_ancetre
end type
end forward

global type u_cs_sp_inter from u_cs_sp_ancetre
end type
global u_cs_sp_inter u_cs_sp_inter

forward prototypes
private function boolean uf_initialiser_dddw ()
public function boolean uf_preparer_consulter ()
private subroutine uf_copier_frais ()
public subroutine uf_init_inter (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref u_datawindow_detail adw_si_inter, u_datawindow adw_detpro, ref datawindow adw_si_frais, ref u_datawindow adw_in_inter, ref u_datawindow_detail adw_in_frais, ref u_onglets auo_in_onglet)
end prototypes

private function boolean uf_initialiser_dddw ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Inter
//* Fonction		:	uf_Initialiser_DdDw	(Private)
//* Auteur			:	PLJ
//* Date				:	22/05/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						de idw_In_Inter et idw_In_Frais
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True 
//*
//*-----------------------------------------------------------------
//* #1
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

/*------------------------------------------------------------------*/
/* DropDown DataWindow sur DW des Interlocuteurs					     */
/*------------------------------------------------------------------*/

idw_Si_Inter.GetChild ( "COD_INTER", dwChild )
idw_In_Inter.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Inter.GetChild ( "COD_CIV", dwChild )
idw_In_Inter.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Inter.GetChild ( "COD_MODE_REG", dwChild )
idw_In_Inter.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Inter.GetChild ( "ADR_MAIL", dwChild )
idw_In_Inter.GetChild ( "ADR_MAIL", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* DropDown DataWindow sur DW des Frais								     */
/*------------------------------------------------------------------*/


idw_In_Frais.GetChild ( "ID_TYP_FRAIS", dwChild )
dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve ( "+NF" )

idw_Si_Sinistre.GetChild ( "COD_ETAT", dwChild )				
idw_In_Frais.GetChild  ( "COD_ETAT", dwChild1)
dwChild.ShareData ( dwChild1 )


Return True
end function

public function boolean uf_preparer_consulter ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_sinistre
//* Fonction		:	uf_preparer_Consulter	(Public)
//* Auteur			:	PLJ
//* Date				:	22/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation des interlocuteurs
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True / False
//*
//*-----------------------------------------------------------------
//       JFF   05/02/2018 [PM360-2]
//*-----------------------------------------------------------------

Boolean 	bRet
String 	sOnglet
Long     lDeb, lFin

bRet = True

uf_Initialiser_DdDw ()				// Initialisation des DdDw pour idw_In_Inter et idw_In_Frais


/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans la dw    */
/* de la fen$$HEX1$$ea00$$ENDHEX$$tre Interlocureur												  */
/*------------------------------------------------------------------*/
bRet = idw_In_Inter.Uf_CopierLigne ()


/*------------------------------------------------------------------*/
/* On recopie les frais															  */
/*------------------------------------------------------------------*/
Uf_Copier_Frais ()


/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet (DataWindow Interlocuteur) */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/

sOnglet = iUo_Onglet.Uf_RecupererOngletCourant ()			
If sOnglet <> "01" Then											
	iUo_Onglet.Uf_ChangerOnglet ("01")						
End If	

// [PM360-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro,  idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" ), '-DP', 324 )
If lDeb <= 0 Then	
	idw_In_Inter.Modify ( "rib_cpt.format='[GENERAL]~tfill (~~'XX~~', 9) + right (rib_cpt, 2)'" )
Else 
	idw_In_Inter.Modify ( "rib_cpt.format='[GENERAL]'" )		
End If

Return bRet
end function

private subroutine uf_copier_frais ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Inter
//* Fonction		:	uf_Copier_Frais	(Private)
//* Auteur			:	PLJ
//* Date				:	22/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie les frais de la fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre  sur  la
//*						fen$$HEX1$$ea00$$ENDHEX$$tre interlocuteur, pour l'inter s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long 		lTot, lCpt

String 	sFiltre


/*------------------------------------------------------------------*/
/* On pose le filtre sur idw_Si_Frais.		                          */
/*------------------------------------------------------------------*/
sFiltre = "ID_I = " + String ( idw_In_Inter.GetItemNumber ( 1, "ID_I" ) ) 
idw_Si_Frais.SetFilter ( sFiltre )
idw_Si_Frais.Filter ()


/*------------------------------------------------------------------*/
/* On effectue la copie de dw_SI_Frais  -->  dw_In_Frais            */
/*------------------------------------------------------------------*/
lTot = idw_Si_Frais.RowCount ()

idw_In_Frais.Reset ()	
idw_Si_Frais.RowsCopy ( 1, lTot, Primary!, idw_In_Frais, 1, Primary! )
idw_In_Frais.Sort ()


/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wFrais.                               */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_Si_Frais.SetFilter ( sFiltre )
idw_Si_Frais.Filter ()
idw_Si_Frais.Sort ()

/*------------------------------------------------------------------*/
/* Le 29/03/1999. DGA                                               */
/* Modification pour la consultation de l'EURO.                     */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		idw_In_Frais.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
		idw_In_Frais.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
Next

end subroutine

public subroutine uf_init_inter (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref u_datawindow_detail adw_si_inter, u_datawindow adw_detpro, ref datawindow adw_si_frais, ref u_datawindow adw_in_inter, ref u_datawindow_detail adw_in_frais, ref u_onglets auo_in_onglet);//*-----------------------------------------------------------------
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
//*						u_DataWinDow_Detail			adw_Si_Inter			
//*						DataWindow						adw_Si_Frais	
//*						u_DataWindow					adw_In_Inter
//*						u_DataWindow_Detail			adw_In_Frais
//*						u_onglets						auo_In_Onglet
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

itrTrans     		= atrTrans					// ... Transaction

idw_Si_Sinistre	= adw_Si_Sinistre			// ... Dw Sinistre sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Inter	   = adw_Si_Inter				// ... Dw Inter     "     "       "			
idw_Si_Frais 		= adw_Si_Frais				// ... Dw Frais     "     "       "

idw_In_Inter		= adw_In_Inter				// ... Dw Inter sur fen$$HEX1$$ea00$$ENDHEX$$tre Interlocuteur
idw_In_Frais		= adw_In_Frais				// ... Dw Frais  "     "          "

iuo_onglet			= auo_In_Onglet			// ... Onglet    "     "          " 
idw_Detpro 			= adw_Detpro				// [PM360-2]

/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$cise la datawindow source detail li$$HEX4$$e9002000e0002000$$ENDHEX$$idw_In_Inter           */
/*------------------------------------------------------------------*/

idw_In_Inter.uf_DetailParent( idw_Si_Inter )
end subroutine

on u_cs_sp_inter.create
call super::create
end on

on u_cs_sp_inter.destroy
call super::destroy
end on

