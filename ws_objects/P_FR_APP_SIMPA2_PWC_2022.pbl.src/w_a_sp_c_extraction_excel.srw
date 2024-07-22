HA$PBExportHeader$w_a_sp_c_extraction_excel.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation du param$$HEX1$$e900$$ENDHEX$$trage du produit sous excel
forward
global type w_a_sp_c_extraction_excel from w_8_accueil_consultation
end type
type cb_lancer from commandbutton within w_a_sp_c_extraction_excel
end type
type st_1 from statictext within w_a_sp_c_extraction_excel
end type
type st_2 from statictext within w_a_sp_c_extraction_excel
end type
type dw_trt from datawindow within w_a_sp_c_extraction_excel
end type
type hpb_extract2excel from hprogressbar within w_a_sp_c_extraction_excel
end type
type st_4 from statictext within w_a_sp_c_extraction_excel
end type
type em_produit from editmask within w_a_sp_c_extraction_excel
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_a_sp_c_extraction_excel
end type
end forward

global type w_a_sp_c_extraction_excel from w_8_accueil_consultation
integer width = 3808
integer height = 1996
string title = "Extraction param$$HEX1$$e800$$ENDHEX$$trage des produits"
cb_lancer cb_lancer
st_1 st_1
st_2 st_2
dw_trt dw_trt
hpb_extract2excel hpb_extract2excel
st_4 st_4
em_produit em_produit
st_avertissement_monnaie st_avertissement_monnaie
end type
global w_a_sp_c_extraction_excel w_a_sp_c_extraction_excel

type variables
private:
constant integer K_XLS_LIMIT = 65535
constant char K_DataObjDyn	 ='D'
constant string K_PStyle	 ='style(type=grid)'
end variables

forward prototypes
private subroutine wf_lancer ()
end prototypes

private subroutine wf_lancer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_a_sp_c_Extraction_Excel::wf_Lancer ()
//* Auteur        : Fabry JF
//* Date          : 28/08/2002 15:00:56
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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
//* [EXPPARMBOUT]	PHG	06/09/2006 Ajout de la table boutique dans l'export
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//	 #2 [DCMP-060749]-18/10/2006-PHG EXtraction complete du parametrage
//		 ATTENTION : Afin d'alleger le code, les codes mort de #1 on $$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$
//		 enlev$$HEX1$$e900$$ENDHEX$$.
//  #3 [DCMP060405] 06/12/2006 Ajout de famill et famille_car $$HEX2$$e0002000$$ENDHEX$$l'extraction
//* #4	JCA	21/09/2007		DCMP 70410 - Ajout du code produit pour l'extraction de [cour_prod]
//* #5	JCA	02/10/2007		DCMP 70705 - Ajout de l'extraction de [cour_prod] pour les courriers par produit
//* #6   PHG   28/01/2009		A la parlote => Ajout Ref_codic_darty
//* #7 	FPI	28/01/2010		[20100128.FPI] Correction Extraction Excel de plus de 65000 lignes 
//			FPI	28/02/2013		[ITSM201601] Ajout de la colonne id_nat_cour dans l'extraction de cour_prod
//*-----------------------------------------------------------------

String	sNomDw, sExtFic
//String   sTabDw [17,2]
//String   sTabDw [24,2]
// [EXPPARMBOUT]
String   sTabDw [39,4]
Long		lMaxDw, lCpt, lStep
Boolean  lb_DataObjDyn 	// DCMP060749
String 	ls_error			// DCMP060749
String	ls_datasource	// DCMP060749
Long lRowDeb, lRowFin, lIndexFic // #7
Long lNbMaxLigExcel = 65530		// #7
datastore dsData						// #7
String sNomFic							// #7

string	sIdProd // #4

sNomDw  = "d_sp_consparam_"
lMaxDw  = 39
sExtFic = ".xls"
lStep	= hpb_extract2excel.MaxPosition/(lMaxDw*2)

sIdProd = em_produit.text

/*----------------------------------------------------------------------------*/
/* Armement des noms de dataobjects et nom de fichier de sortie					*/
/*----------------------------------------------------------------------------*/
sTabDw [1,1] = "code"
sTabDw [1,2] = "code"

sTabDw [2,1] = "code_car"
sTabDw [2,2] = "code_car"

sTabDw [3,1] = "produit"
sTabDw [3,2] = "produit"

sTabDw [4,1] = "code_garantie"
sTabDw [4,2] = "codegti"

sTabDw [5,1] = "code_condition"
sTabDw [5,2] = "codecond"

sTabDw [6,1] = "piece"
sTabDw [6,2] = "piece"

sTabDw [7,1] = "motif"
sTabDw [7,2] = "refus"

sTabDw [8,1] = "groupe"
sTabDw [8,2] = "groupe"

sTabDw [9,1] = "etablissement"
sTabDw [9,2] = "ets"

sTabDw [10,1] = "carte"
sTabDw [10,2] = "carte"

sTabDw [11,1] = "police"
sTabDw [11,2] = "police"

sTabDw [12,1] = "compagnie"
sTabDw [12,2] = "cie"

sTabDw [13,1] = "departement"
sTabDw [13,2] = "dept"

sTabDw [14,1] = "tarif_papier"
sTabDw [14,2] = "tarifpap"

sTabDw [15,1] = "paragraphe"
sTabDw [15,2] = "paragrap"

sTabDw [16,1] = "courrier"
sTabDw [16,2] = "courrier"

sTabDw [17,1] = "composition"
sTabDw [17,2] = "composit"

/*----------------------------------------------------------------------------*/
/* Armement des Nouveaux noms de dataobjects et nom de fichier de sortie		*/
/* Suite DCMP 050470																				*/
/*----------------------------------------------------------------------------*/
sTabDw [18,1] = "affilier"
sTabDw [18,2] = "affilier"

sTabDw [19,1] = "det_pro"
sTabDw [19,2] = "det_pro"

sTabDw [20,1] = "div_pro"
sTabDw [20,2] = "div_pro"

sTabDw [21,1] = "div_pdet"
sTabDw [21,2] = "div_pdet"

sTabDw [22,1] = "commande_type"
sTabDw [22,2] = "cmd_type"

sTabDw [23,1] = "autorisation"
sTabDw [23,2] = "autorisa"

sTabDw [24,1] = "revision"
sTabDw [24,2] = "revision"

/*------------------------------------------------------------------*/
/* [EXPPARMBOUT] On ajoute la table boutique dans le param$$HEX1$$e900$$ENDHEX$$trage    */
/*------------------------------------------------------------------*/
sTabDw [25,1] = "boutique"
sTabDw [25,2] = "boutique"

/*------------------------------------------------------------------*/
/* #2 [DCMP-060749]-17/10/2006-PHG Extraction complete du           */
/* parametrage.                                                     */
/*------------------------------------------------------------------*/
/* On a ajout$$HEX2$$e9002000$$ENDHEX$$une colonne au tableau									     */
/*																						  */
/* 3 eme colonne contient des parametre d'execution :               */
/*																						  */
/* D : k_DataObjDyn : Dataobject dynamique, construit $$HEX2$$e0002000$$ENDHEX$$la vol$$HEX1$$e900$$ENDHEX$$e    */
/*	d'autre indicateurs pourraient etre ajout$$HEX2$$e9002000$$ENDHEX$$ult$$HEX1$$e900$$ENDHEX$$rieurement		  */
/*                                                                  */
/* 4 eme colonne contient l'ordre SQL a executer si K_DataObjDyn	  */
/*                                                                  */
/* Si ces colonnes suppl$$HEX1$$e900$$ENDHEX$$mentaire sont nulle, mode de fonctionnement*/
/* historique ( dataobject statique et 1 seul fichier )             */
/*																						  */
/* Dernier point : on est en PB8+WIN32, la limitation aux format de */
/* 8.3 n'existe plus pour les nome de fichier.							  */
/*------------------------------------------------------------------*/

sTabDw [26,1] = "court_type"
sTabDw [26,2] = "court_type"
sTabDw [26,3] = K_DataObjDyn
sTabDw [26,4] = 'execute sysadm.DW_S26_PARAM_COUR_TYPE'

sTabDw [27,1] = "para_prod"
sTabDw [27,2] = "para_prod"
sTabDw [27,3] = K_DataObjDyn
sTabDw [27,4] = 'execute sysadm.DW_S27_PARAM_PARA_PROD'

sTabDw [28,1] = "garantie"
sTabDw [28,2] = "garantie"
sTabDw [28,3] = K_DataObjDyn
sTabDw [28,4] = 'execute sysadm.DW_S28_PARAM_GARANTIE'

sTabDw [29,1] = "delai"
sTabDw [29,2] = "delai"
sTabDw [29,3] = K_DataObjDyn
sTabDw [29,4] = 'execute sysadm.DW_S29_PARAM_DELAI'

sTabDw [30,1] = "franchise"
sTabDw [30,2] = "franchise"
sTabDw [30,3] = K_DataObjDyn
sTabDw [30,4] = 'execute sysadm.DW_S30_PARAM_FRANCHISE'

// table Condition scind$$HEX1$$e900$$ENDHEX$$e en deux fichiers
sTabDw [31,1] = "condition"
sTabDw [31,2] = "condition-01"
sTabDw [31,3] = K_DataObjDyn
sTabDw [31,4] = 'execute sysadm.DW_S31_PARAM_CONDITION 0, 9000'

sTabDw [32,1] = "condition"
sTabDw [32,2] = "condition-02"
sTabDw [32,3] = K_DataObjDyn
sTabDw [32,4] = 'execute sysadm.DW_S31_PARAM_CONDITION 9001, 9999999'

sTabDw [33,1] = "plafond"
sTabDw [33,2] = "plafond"
sTabDw [33,3] = K_DataObjDyn
sTabDw [33,4] = 'execute sysadm.DW_S32_PARAM_PLAFOND'

sTabDw [34,1] = "corb_oper"
sTabDw [34,2] = "corb_oper"
sTabDw [34,3] = K_DataObjDyn
sTabDw [34,4] = 'execute sysadm.DW_S33_PARAM_CORB_OPER'

//#3 [DCMP060405]
sTabDw [35,1] = "famille"
sTabDw [35,2] = "famille"
sTabDw [35,3] = K_DataObjDyn
sTabDw [35,4] = 'execute sysadm.DW_S34_FAMILLE'

sTabDw [36,1] = "famille_car"
sTabDw [36,2] = "famille_car"
sTabDw [36,3] = K_DataObjDyn
sTabDw [36,4] = 'execute sysadm.DW_S35_FAMILLE_CAR'
// Fin #3

// #4
sTabDw [37,1] = "cour_prod"
sTabDw [37,2] = "cour_prod"
sTabDw [37,3] = K_DataObjDyn
sTabDw [37,4] = "execute sysadm.DW_S36_COUR_PROD_V01 " + sIdProd // [ITSM201601]
// Fin #4

// #5
sTabDw [38,1] = "produit_courrier"
sTabDw [38,2] = "produit_courrier"
sTabDw [38,3] = K_DataObjDyn
sTabDw [38,4] = 'execute sysadm.DW_S37_COUR_PROD'
// Fin #5

// #6
sTabDw [39,1] = "ref_codic_darty"
sTabDw [39,2] = "ref_codic_darty"
sTabDw [39,3] = K_DataObjDyn
// Pas besoin de PS, select brut de fonderie suffit, la table $$HEX1$$e900$$ENDHEX$$tant un r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel
sTabDw [39,4] = "select * from sysadm.ref_codic_darty"
// Fin #6

/*----------------------------------------------------------------------------*/
/* Suppression des fichiers existants														*/
/*----------------------------------------------------------------------------*/
hpb_extract2excel.position = 0
hpb_extract2excel.Show()
For lCpt = 1 To lMaxDw
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	sTabDw [lCpt, 2] = stGlb.sRepTempo + sTabDw [lCpt, 2] + sExtFic

	//Migration PB8-WYNIWYG-03/2006 FM
	If f_FileExists ( sTabDw [lCpt, 2] ) then
		If Not FileDelete ( sTabDw [lCpt, 2] ) Then
			stMessage.sTitre = "Suppression fichier impossible"
			stMessage.sCode = "GENE013"
			stMessage.icon = StopSign!
			stMessage.bErreurG = True
			stMessage.bouton = Ok!
			stMessage.sVar[1] = Upper ( sTabDw [lCpt, 2] )
			F_Message ( stMessage )		
			Return
		End If
	End If
	hpb_extract2excel.position += lStep
Next
hpb_extract2excel.position = 50

/*----------------------------------------------------------------------------*/
/* Extraction																						*/
/*----------------------------------------------------------------------------*/
For lCpt = 1 To lMaxDw
	// #2 [DCMP060749]- Gestion du Mode DataWindows Dynamique
	SetNull(ls_error)
	lb_DataObjDyn = Pos(sTabDw[lCpt,3],K_DataObjDyn)>0 
	if lb_DataObjDyn then
		ls_datasource = SQLCA.SyntaxFromSQL(sTabDw[lCpt,4], K_PStyle, ls_error )
		if isnull(ls_error) or ls_error='' then
			dw_Trt.Create(ls_datasource, ls_error)
		end If
	Else
		dw_Trt.dataobject = sNomDw + sTabDw [lCpt, 1]
	End If
	if isnull(ls_error) or ls_error='' then
		dw_Trt.SetTransObject ( SQLCA )
		dw_Trt.Retrieve ()
		
		// #7 - [20100128.FPI] Correction Extraction Excel de plus de 65000 lignes 
		// On d$$HEX1$$e900$$ENDHEX$$coupe en +ieurs fichiers xxx_1.xls, xxx_2.xls ...
		// On utilise un datastore "tampon" dans lequel on recopie le r$$HEX1$$e900$$ENDHEX$$sultat par groupe de 65000 lignes
		// C'est ce datastore qui est enregistr$$HEX2$$e9002000$$ENDHEX$$dans les fichiers xls
		if dw_Trt.RowCount() > lNbMaxLigExcel Then
			dsData = CREATE datastore
		
			if lb_DataObjDyn then
				dsData.Create(ls_datasource, ls_error)
			Else
				dsData.dataobject = dw_Trt.dataobject
			End if
		
			lRowDeb = 1
			lRowFin = lNbMaxLigExcel
			lIndexFic = 1
			Do
				dsData.Reset()

				if lRowFin > dw_Trt.RowCount() Then lRowFin=dw_Trt.RowCount()
				
				dw_Trt.Rowscopy( lRowDeb, lRowFin, Primary!, dsData,1, Primary!)
				
				sNomFic = Left(sTabDw [lCpt, 2] ,Len(sTabDw [lCpt, 2] ) - 4)
				sNomFic +="_" + String(lIndexFic) + ".xls"
				dsData.saveas( Upper ( sNomFic) , Excel!, True )
				
				lIndexFic++ 
				lRowDeb+=lNbMaxLigExcel
				lRowFin+=lNbMaxLigExcel
				
			Loop Until lRowDeb > dw_Trt.RowCount()
			
			Destroy dsData
		Else
			dw_Trt.SaveAs ( Upper ( sTabDw [lCpt, 2] ) , Excel!, True ) 
		End if
		
		//dw_Trt.SaveAs ( Upper ( sTabDw [lCpt, 2] ) , Excel!, True ) 
		// Fin #7
	End If
	hpb_extract2excel.position += lStep
Next
hpb_extract2excel.position = 100

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
st_2.Text = "Extraction des " + String ( lMaxDw ) + " fichiers termin$$HEX1$$e900$$ENDHEX$$e sur " + Upper ( stGlb.sRepTempo ) + "..."
hpb_extract2excel.Hide()
st_2.Show ()

end subroutine

on show;call w_8_accueil_consultation::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_a_sp_c_Extraction_Excel
//* Evenement     : Show
//* Auteur        : Fabry JF
//* Date          : 28/08/2002 15:35:28
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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


st_2.Hide()
end on

on w_a_sp_c_extraction_excel.create
int iCurrent
call super::create
this.cb_lancer=create cb_lancer
this.st_1=create st_1
this.st_2=create st_2
this.dw_trt=create dw_trt
this.hpb_extract2excel=create hpb_extract2excel
this.st_4=create st_4
this.em_produit=create em_produit
this.st_avertissement_monnaie=create st_avertissement_monnaie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lancer
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_trt
this.Control[iCurrent+5]=this.hpb_extract2excel
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.em_produit
this.Control[iCurrent+8]=this.st_avertissement_monnaie
end on

on w_a_sp_c_extraction_excel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_lancer)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_trt)
destroy(this.hpb_extract2excel)
destroy(this.st_4)
destroy(this.em_produit)
destroy(this.st_avertissement_monnaie)
end on

type cb_debug from w_8_accueil_consultation`cb_debug within w_a_sp_c_extraction_excel
end type

type pb_retour from w_8_accueil_consultation`pb_retour within w_a_sp_c_extraction_excel
integer width = 242
integer height = 144
integer taborder = 120
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_a_sp_c_extraction_excel
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_a_sp_c_extraction_excel
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 110
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_a_sp_c_extraction_excel
integer x = 3058
integer y = 72
integer width = 439
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_a_sp_c_extraction_excel
integer x = 3429
integer y = 1100
integer width = 334
integer height = 312
integer taborder = 90
end type

type dw_2 from w_8_accueil_consultation`dw_2 within w_a_sp_c_extraction_excel
integer x = 3296
integer y = 208
integer width = 247
integer height = 184
integer taborder = 80
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_a_sp_c_extraction_excel
integer x = 3067
integer y = 780
integer width = 206
integer height = 248
integer taborder = 70
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_a_sp_c_extraction_excel
integer x = 3058
integer y = 480
integer width = 357
integer height = 276
integer taborder = 60
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_a_sp_c_extraction_excel
integer x = 3045
integer y = 1072
integer width = 325
integer height = 248
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_a_sp_c_extraction_excel
integer x = 3369
integer y = 792
integer width = 366
integer height = 248
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_a_sp_c_extraction_excel
boolean visible = false
integer x = 3049
integer y = 1368
integer width = 215
integer height = 216
integer taborder = 100
end type

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_a_sp_c_extraction_excel
integer width = 242
integer height = 144
end type

type cb_lancer from commandbutton within w_a_sp_c_extraction_excel
integer x = 1216
integer y = 780
integer width = 1381
integer height = 316
integer taborder = 140
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer l~'extraction"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_a_sp_c_Extraction::cb_Lancer
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 28/08/2002 14:44:57
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

This.Enabled = False
st_2.Hide ()
Parent.wf_Lancer ()
This.Enabled = True


end on

type st_1 from statictext within w_a_sp_c_extraction_excel
integer x = 919
integer y = 408
integer width = 1678
integer height = 284
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Extraction du param$$HEX1$$e800$$ENDHEX$$trage de tous les produits SIMPA2 en fichiers excel. Chaque zone poss$$HEX1$$e800$$ENDHEX$$de un alias clair et significatif."
boolean focusrectangle = false
end type

type st_2 from statictext within w_a_sp_c_extraction_excel
boolean visible = false
integer x = 1125
integer y = 1176
integer width = 1275
integer height = 180
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_trt from datawindow within w_a_sp_c_extraction_excel
boolean visible = false
integer x = 3488
integer y = 536
integer width = 210
integer height = 132
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
end type

type hpb_extract2excel from hprogressbar within w_a_sp_c_extraction_excel
boolean visible = false
integer x = 1120
integer y = 1396
integer width = 1275
integer height = 64
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_4 from statictext within w_a_sp_c_extraction_excel
integer x = 498
integer y = 796
integer width = 549
integer height = 164
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Num$$HEX1$$e900$$ENDHEX$$ro de produit pour cour_prod"
boolean focusrectangle = false
end type

type em_produit from editmask within w_a_sp_c_extraction_excel
integer x = 567
integer y = 1008
integer width = 402
integer height = 80
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_a_sp_c_extraction_excel
integer x = 763
integer y = 188
integer width = 2121
boolean bringtotop = true
integer weight = 700
string text = "Les montants dans les fichiers Excel sont exprim$$HEX1$$e900$$ENDHEX$$s en"
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: (OVERRIDE)
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

this.text += " " +stGlb.sMonnaieLitteralDesire+"s"
end event

