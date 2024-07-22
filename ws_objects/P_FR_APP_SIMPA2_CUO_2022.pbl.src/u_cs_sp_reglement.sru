HA$PBExportHeader$u_cs_sp_reglement.sru
$PBExportComments$Objet Consulatation reglement
forward
global type u_cs_sp_reglement from u_cs_sp_ancetre
end type
end forward

global type u_cs_sp_reglement from u_cs_sp_ancetre
end type
global u_cs_sp_reglement u_cs_sp_reglement

forward prototypes
public function boolean uf_preparer_consulter ()
private subroutine uf_initialiser_dddw ()
private subroutine uf_copier_reggti ()
public subroutine uf_init_reglement (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref datawindow adw_si_reglement, ref datawindow adw_si_inter, ref datawindow adw_si_reggti, ref datawindow adw_si_gti, ref datawindow adw_si_frais, ref u_datawindow adw_rg_reglement, ref u_datawindow adw_rg_reggti, ref u_datawindow adw_rg_regfrais, ref u_datawindow adw_det_pro)
end prototypes

public function boolean uf_preparer_consulter ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Reglement
//* Fonction		:	uf_preparer_Consulter	(Public)
//* Auteur			:	JFF
//* Date				:	08/12/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation des r$$HEX1$$e900$$ENDHEX$$glements
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
Long lDeb, lFin


uf_Initialiser_DdDw ()				// Initialisation des DdDw pour idw_Rg_Reglement


/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans la dw    */
/* de la fen$$HEX1$$ea00$$ENDHEX$$tre r$$HEX1$$e900$$ENDHEX$$glement														  */
/*------------------------------------------------------------------*/
bRet = idw_Rg_Reglement.Uf_CopierLigne ()

This.Uf_Copier_RegGti ()


// [PM360-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro,  idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" ), '-DP', 324 )
If lDeb <= 0 Then	
	idw_Rg_Reglement.Modify ( "rib_cpt.format='[GENERAL]~tfill (~~'XX~~', 9) + right (rib_cpt, 2)'" )
Else 
	idw_Rg_Reglement.Modify ( "rib_cpt.format='[GENERAL]'" )		
End If


Return bRet
end function

private subroutine uf_initialiser_dddw ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Reglement
//* Fonction		:	uf_Initialiser_DdDw	(Private)
//* Auteur			:	JFF
//* Date				:	09/12/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						de idw_Rg_Reglement
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True 
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1


//*-----------------------------------------------------------------
//* Initialisation des DropDownDataWindow de la DW idw_Rg_Reglement
//*-----------------------------------------------------------------

idw_Si_Inter.GetChild ( "COD_INTER", dwChild )
idw_Rg_Reglement.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Inter.GetChild ( "COD_MODE_REG", dwChild )
idw_Rg_Reglement.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Rg_Reglement.GetChild ( "ID_I", dwChild )
idw_Si_Inter.shareData ( dwChild )

//*-----------------------------------------------------------------
//* Initialisation de la DataWindow dw_Reg_Gti sur fen$$HEX1$$ea00$$ENDHEX$$tre Reglement 
//*-----------------------------------------------------------------
idw_Si_Gti.GetChild ("ID_GTI", dwChild )
idw_Rg_RegGti.GetChild ( "ID_GTI", dwChild1 ) 
dwChild.ShareData ( dwChild1 )

end subroutine

private subroutine uf_copier_reggti ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Reglement
//* Fonction		:	uf_Copier_RegGti	(Private)
//* Auteur			:	PLJ
//* Date				:	28/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Copie les Details de la fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre sur la
//*						fen$$HEX1$$ea00$$ENDHEX$$tre garantie, pour la garantie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	On copie les R$$HEX1$$e800$$ENDHEX$$glements et les frais sur deux Dw Diff$$HEX1$$e900$$ENDHEX$$rentes
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//*	FPI	16/12/2015	[LIB_TYP_FRAIS] ajout du libell$$HEX2$$e9002000$$ENDHEX$$de type de frais
//*-----------------------------------------------------------------

Long 		lTot, lret, lCpt

String 	sFiltre, sVal


/*------------------------------------------------------------------*/
/* On copie tout d'abord les r$$HEX1$$e800$$ENDHEX$$glements									  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On pose le filtre sur dw_Si_RegGti	                             */
/* Rem : ID_RGPT <> -1, car pour les Frais de PV et d'envoi, il y   */
/*       une autre Dw en dessous de celle des r$$HEX1$$e900$$ENDHEX$$glements				  */
/*------------------------------------------------------------------*/

sFiltre = "ID_REG = " + String ( idw_Rg_Reglement.GetItemNumber ( 1, "ID_REG" ) ) + " AND ID_GTI <> -1"
lret 	  = idw_Si_RegGti.SetFilter ( sFiltre )
lret    = idw_Si_RegGti.Filter ()


/*------------------------------------------------------------------*/
/* On effectue la copie de dw_Si_RegGti -->  dw_Rg_RegGti           */
/*------------------------------------------------------------------*/

lTot = idw_Si_RegGti.RowCount ()

If lTot = 0 Then 
	iDw_Rg_RegGti.Hide ()
Else
	iDw_Rg_RegGti.Show ()
	idw_Rg_RegGti.Reset ()	
	lret = idw_Si_RegGti.RowsCopy ( 1, lTot, Primary!, idw_Rg_RegGti, 1, Primary! )
	lret = idw_Rg_RegGti.Sort ()
End IF

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_Si_RegGti                             */
/*------------------------------------------------------------------*/

sFiltre = ""
idw_Si_RegGti.SetFilter ( sFiltre )
idw_Si_RegGti.Filter ()

/*------------------------------------------------------------------*/
/* Le 29/03/1999. DGA                                               */
/* Modification pour la consultation de l'EURO.                     */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		idw_Rg_RegGti.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
		idw_Rg_RegGti.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
Next


/*------------------------------------------------------------------*/
/* On copie les frais ensuite 												  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On pose le filtre sur dw_Si_Frais	                             */
/*------------------------------------------------------------------*/

sFiltre = "ID_REG = " + String ( idw_Rg_Reglement.GetItemNumber ( 1, "ID_REG" ) )
lret 	  = idw_Si_Frais.SetFilter ( sFiltre )
lret    = idw_Si_Frais.Filter ()

lTot = idw_Si_Frais.RowCount ()

If lTot = 0 Then 
	iDw_Rg_RegFrais.Hide ()
Else
	iDw_Rg_RegFrais.Show ()
	idw_Rg_RegFrais.Reset ()	
	lret = idw_Si_Frais.RowsCopy ( 1, lTot, Primary!, idw_Rg_RegFrais, 1, Primary! )
	lret = idw_Rg_RegFrais.Sort ()
	
	// [LIB_TYP_FRAIS]
	For lCpt=1 to lTot
		sVal=idw_Rg_RegFrais.GetItemString(lCpt,"LIB_FRAIS")
		if isnull(sVal) Then sVal=""
		sVal+=" / " + idw_Rg_RegFrais.GetItemString(lCpt,"LIB_TYP_FRAIS")
		if Len(sVal) > 50 Then
			idw_Rg_RegFrais.SetDetailHeight(lCpt,lCpt,155)
		End if
	Next
End IF

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_Si_Frais										  */
/*------------------------------------------------------------------*/

sFiltre = ""
idw_Si_Frais.SetFilter ( sFiltre )
idw_Si_Frais.Filter ()

/*------------------------------------------------------------------*/
/* Le 29/03/1999. DGA                                               */
/* Modification pour la consultation de l'EURO.                     */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		idw_Rg_RegFrais.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
		idw_Rg_RegFrais.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
Next




end subroutine

public subroutine uf_init_reglement (ref u_transaction atrtrans, ref u_datawindow adw_si_sinistre, ref datawindow adw_si_reglement, ref datawindow adw_si_inter, ref datawindow adw_si_reggti, ref datawindow adw_si_gti, ref datawindow adw_si_frais, ref u_datawindow adw_rg_reglement, ref u_datawindow adw_rg_reggti, ref u_datawindow adw_rg_regfrais, ref u_datawindow adw_det_pro);//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Sinistre
//* Fonction		:	uf_Init_Reglement
//* Auteur			:	JFF
//* Date				:	07/12/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences aux objets de 
//*                  de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation SINISTRE
//* Commentaires	:	
//*
//* Arguments		:  u_transaction			atrtrans				    REF	
//* 						u_DataWindow			adw_Si_Sinistre	    REF
//* 						u_DataWindow			adw_Si_Inter		    REF
//*						u_DataWindow			adw_Si_Reglement	    REF 
//* 						u_DataWindow			adw_Si_RegGti		    REF
//*						u_DataWindow			adw_Si_Gti			    REF
//*						u_DataWindow			adw_Rg_Reglement	    REF
//*						DataWindow				adw_Rg_RegGti		    REF 
//*						DataWindow				adw_Rg_RegFrais       REF
//* 
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//       JFF   05/02/2018 [PM360-2]
//*-----------------------------------------------------------------



itrTrans     		 = atrTrans					// ... Transaction

idw_Si_Sinistre	 = adw_Si_Sinistre		// ... Dw Sinistre sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Inter		 = adw_Si_Inter			// ... Dw Inter sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Reglement	 = adw_Si_Reglement		// ... Dw Reglement sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_RegGti		 = adw_Si_RegGti			// ... Dw Reg_Gti sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Gti			 = adw_Si_Gti				// ... Dw Gti 	sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre
idw_Si_Frais		 = adw_Si_Frais			// ... Dw Frais 	sur fen$$HEX1$$ea00$$ENDHEX$$tre Sinistre

idw_Rg_Reglement	 = adw_Rg_Reglement		// ... Dw Reglement sur fen$$HEX1$$ea00$$ENDHEX$$tre Reglement
idw_Rg_RegGti		 = adw_Rg_RegGti			// ... Dw Reglement par Garantie sur fen$$HEX1$$ea00$$ENDHEX$$tre Reglement
idw_Rg_RegFrais 	 = adw_Rg_RegFrais 		// ... Dw des frais inclus dans un r$$HEX1$$e800$$ENDHEX$$glement sur fen$$HEX1$$ea00$$ENDHEX$$tre Reglement
idw_DetPro 			 = adw_det_pro 			// [PM360-2]

/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$cise la datawindow source detail li$$HEX4$$e9002000e0002000$$ENDHEX$$idw_In_Inter           */
/*------------------------------------------------------------------*/

idw_Rg_Reglement.uf_DetailParent( idw_Si_Reglement )

end subroutine

on u_cs_sp_reglement.create
call super::create
end on

on u_cs_sp_reglement.destroy
call super::destroy
end on

