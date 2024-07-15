HA$PBExportHeader$w_trt_sp_ifr_saisie.srw
forward
global type w_trt_sp_ifr_saisie from w_8_traitement
end type
type dw_stk_liste_val from datawindow within w_trt_sp_ifr_saisie
end type
type pb_enregistrer from picturebutton within w_trt_sp_ifr_saisie
end type
type pb_filtrer from picturebutton within w_trt_sp_ifr_saisie
end type
type p_inserer_ligne from picture within w_trt_sp_ifr_saisie
end type
type st_inserer_1 from statictext within w_trt_sp_ifr_saisie
end type
type st_inserer_2 from statictext within w_trt_sp_ifr_saisie
end type
type p_supprimer_ligne from picture within w_trt_sp_ifr_saisie
end type
type st_supprimer_1 from statictext within w_trt_sp_ifr_saisie
end type
type st_supprimer_2 from statictext within w_trt_sp_ifr_saisie
end type
type st_information from statictext within w_trt_sp_ifr_saisie
end type
type p_select from picture within w_trt_sp_ifr_saisie
end type
type dw_trt_critere_marge from u_datawindow within w_trt_sp_ifr_saisie
end type
type st_excel1 from statictext within w_trt_sp_ifr_saisie
end type
type st_excel2 from statictext within w_trt_sp_ifr_saisie
end type
type p_excel from picture within w_trt_sp_ifr_saisie
end type
type p_effacer_critere from picture within w_trt_sp_ifr_saisie
end type
type dw_trt_critere from u_datawindow within w_trt_sp_ifr_saisie
end type
type dw_2 from u_datawindow within w_trt_sp_ifr_saisie
end type
end forward

global type w_trt_sp_ifr_saisie from w_8_traitement
integer x = 0
integer y = 0
integer width = 4695
integer height = 1868
dw_stk_liste_val dw_stk_liste_val
pb_enregistrer pb_enregistrer
pb_filtrer pb_filtrer
p_inserer_ligne p_inserer_ligne
st_inserer_1 st_inserer_1
st_inserer_2 st_inserer_2
p_supprimer_ligne p_supprimer_ligne
st_supprimer_1 st_supprimer_1
st_supprimer_2 st_supprimer_2
st_information st_information
p_select p_select
dw_trt_critere_marge dw_trt_critere_marge
st_excel1 st_excel1
st_excel2 st_excel2
p_excel p_excel
p_effacer_critere p_effacer_critere
dw_trt_critere dw_trt_critere
dw_2 dw_2
end type
global w_trt_sp_ifr_saisie w_trt_sp_ifr_saisie

type variables
String 	isTabCritere [4,34]
Long	ilNbCritere

String	isRepExcel
String	K_TEMP = "\TEMP\"

Constant int iMdiX = 50   // Position
Constant int iMdiY = 50   // Position	
Constant int iMdiWidth = 3750  // Ajout
Constant int iMdiHeigth = 1500  // Ajout

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
private subroutine wf_preparer_recherche ()
private subroutine wf_proteger ()
private function string wf_construire_critere (string asvariable, string asoperateur, string asvaleur, string asquote)
private function boolean wf_verifier_saisie ()
private subroutine wf_maj_le (long alligne)
public subroutine wf_afficher_compteur ()
public function boolean wf_enregistrer ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


gWMdi.X = iMdiX
gWMdi.Y = iMdiY
gWMdi.Width += iMdiWidth   // 1100
gWMdi.Height+= iMdiHeigth   // 1100

This.Width += iMdiWidth - 1118   // 1100
This.Height+= iMdiHeigth - 100   // 1100

dw_1.X							=   14
dw_1.Y							=  394
dw_1.Width       				= 1646 + 600
dw_1.Height						+= iMdiHeigth - 100 

dw_2.X							= 1659 + 600
dw_2.Y							= dw_1.Y 
dw_2.Width						= iMdiWidth + 1870 - 600
dw_2.Height						= dw_1.Height + 68

dw_trt_critere_marge.X		= dw_1.X + 379
dw_trt_critere_marge.Y		= 161
dw_trt_critere_marge.Width	= dw_1.Width - 324
dw_trt_critere_marge.Height= 150

dw_trt_critere.X				= dw_2.X
dw_trt_critere.Y				= dw_trt_critere_marge.Y
dw_trt_critere.Width			= dw_2.Width
dw_trt_critere.Height		= 221

pb_filtrer.X					= 19
pb_filtrer.Y					= 169

p_inserer_ligne.X				= dw_1.X + 36
p_inserer_ligne.Y				= dw_1.Y + dw_1.Height + 19

st_inserer_1.X					= p_inserer_ligne.X + 18
st_inserer_1.Y					= p_inserer_ligne.Y + 68

st_inserer_2.X					= p_inserer_ligne.X + 27
st_inserer_2.Y					= p_inserer_ligne.Y + 116

p_supprimer_ligne.X			= p_inserer_ligne.X + 237
p_supprimer_ligne.Y			= p_inserer_ligne.Y

st_supprimer_1.X				= st_inserer_1.X + 237
st_supprimer_1.Y				= st_inserer_1.Y

st_supprimer_2.X				= st_inserer_2.X + 237
st_supprimer_2.Y				= st_inserer_2.Y


p_excel.X						= p_inserer_ligne.X + 570
p_excel.Y						= p_inserer_ligne.Y

st_excel1.X						= p_inserer_ligne.X + 530
st_excel1.Y						= st_inserer_1.Y + 20

st_excel2.X						= p_inserer_ligne.X + 500
st_excel2.Y						= st_inserer_2.Y + 20

st_information.X				= p_inserer_ligne.X + 700
st_information.Y				= p_inserer_ligne.Y 
end subroutine

private subroutine wf_preparer_recherche ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_PreparerRecherche
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 		FPI		15/09/2014	 [PM251-1] Ajout d'un crit$$HEX1$$e800$$ENDHEX$$re
//*-----------------------------------------------------------------

Long					lCpt, lTotLigne
DatawindowChild	dwChild, dwChild2	
Datawindow			dwTemp, dwTemp2		


/*---------------------------------------------------*/
/* Initialisation des DDDW des crit$$HEX1$$e800$$ENDHEX$$res de recherche */
/* CAS Sp$$HEX1$$e900$$ENDHEX$$cifiques :                                 */
/* marque  (1), reference(2),                        */
/* freqence(4), prix_min (5), prix max(6)            */
/*---------------------------------------------------*/
For lCpt = 1 To ilNbCritere

	If isTabCritere [2,lCpt] = '1' Then
		dwTemp  = dw_trt_critere_marge
		dwTemp2 = dw_1
	Else
		dwTemp = dw_trt_critere
		dwTemp2 = dw_2
	End If

	CHOOSE CASE lCpt
		
		/*-----------------------------*/
		/* AUCUN PARAMETRE DE RETRIEVE */
		/*-----------------------------*/
		CASE 1, 2
			dwTemp.GetChild       ( isTabCritere [1,lCpt], dwChild )
			dwChild.SetTransObject(SQLCA)
			dwChild.Retrieve      ()

			dwTemp2.GetChild		 ( isTabCritere [1,lCpt], dwChild2 )
			dwChild.Sharedata		 (dwChild2)

		/*-----------------------------*/
		/* PAS DE DDDW                 */
		/*-----------------------------*/
		CASE 4, 5, 6, 28, 30 // [PM251-1]
			// On ne fait rien
	
		/*-----------------------------*/
		/* RETRIEVE AVEC NOM DE COLONNE*/
		/*-----------------------------*/
		Case Else
			
			dwTemp.GetChild       ( isTabCritere [1,lCpt], dwChild )
			dwChild.SetTransObject(SQLCA)
			dwChild.Retrieve      ( isTabCritere [1,lCpt])

			dwTemp2.GetChild		 ( isTabCritere [1,lCpt], dwChild2 )
			dwChild.Sharedata		 (dwChild2)
			
	End Choose
		
Next



end subroutine

private subroutine wf_proteger ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Proteger (PRIVATE)
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Protection de la grille en fonction des droits de l'utilisateur
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

Long 		lTotLigne
String 	sProtect, sCodParam, sUser
Long		lCpt


Boolean bProtect = False



/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 202(droit d'$$HEX1$$e900$$ENDHEX$$criture IFR) pour l'op$$HEX1$$e900$$ENDHEX$$rateur */
/* connect$$HEX60$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 202		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;



If lTotLigne = 0 Then
   bProtect = True
Else
	/*--------------------------------------------------------------*/
	/* Est-ce qu'une autre personne est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$sur la fen$$HEX1$$ea00$$ENDHEX$$tre         */
   /* Avant de v$$HEX1$$e900$$ENDHEX$$rifier sans la table parametre qu'il n'existe pas */
   /* d'autres personnes ayant ouvert la fen$$HEX1$$ea00$$ENDHEX$$tre j'ins$$HEX1$$e800$$ENDHEX$$re tout de  */
   /* suite l'op$$HEX1$$e900$$ENDHEX$$rateur en cours au cas ou une autre personne      */
   /* essaierait de se connecter entre le select et l'update       */
	/*--------------------------------------------------------------*/
	sCodParam = 'IFR_' + stGlb.sCodOper

	INSERT INTO sysadm.parametre VALUES ( :sCodParam, -1, -1 )
   USING SQLCA;

	SELECT count(*) INTO :lTotLigne
     FROM sysadm.parametre 
    WHERE ref_cpt <> :sCodParam    AND
			 ref_cpt like 'IFR_%'
    USING SQLCA; 



										/*-------------------------------------------------*/
	If lTotLigne > 0 Then 		/* Il y a d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un autre utilisateur sur la fen$$HEX1$$ea00$$ENDHEX$$tre */
										/*-------------------------------------------------*/
		bProtect = True
		DELETE
        FROM sysadm.parametre
       WHERE ref_cpt = :sCodParam
		 USING SQLCA;

		f_commit (SQLCA,TRUE)

		stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
		stMessage.Icon			= Information!

		SELECT min(ref_cpt) INTO :sUser
		  FROM sysadm.parametre 
       WHERE ref_cpt <> :sCodParam    AND
			    ref_cpt like 'IFR_%'
		 USING SQLCA;

		sUser = Mid ( sUser, 5 )

		stMessage.sVar[1] = sUser				
		stMessage.sCode	= "IFR0060"

		F_Message ( stMessage )

									/*-------------------------------------------------*/
	Else							/* La fen$$HEX1$$ea00$$ENDHEX$$tre n'est pas occup$$HEX1$$e900$$ENDHEX$$e                    */
									/*-------------------------------------------------*/
		bProtect = False
		f_commit (SQLCA,TRUE)
	End If


End If


/*---------------------------------------------------------------------*/
/* Protection de toutes les zones et boutons.                          */
/* Je ne peux uniquement proteger les boutons, car des 'itemchanged' et*/
/* 'insertrow' provoquent des enabled sur le bouton Enregistrer.       */
/* De plus des itemchanged sur marque et reference, peuvent d$$HEX1$$e900$$ENDHEX$$clencher */
/* des 'update' sur article.                                           */ 
/*---------------------------------------------------------------------*/
If bProtect = True Then

	/*----------------------------------------------------------*/
	/* Protection de toutes les zones des datawindows de saisie */
	/*----------------------------------------------------------*/
	For lCpt = 1 To ilNbCritere
		sProtect = isTabCritere [1,lCpt] + ".protect='1'"

		If isTabCritere [2,lCpt] = '1' Then
			dw_1.Modify (sProtect)
		Else
			dw_2.Modify (sProtect)
		End If

	Next

	/*----------------------------------------------------------*/
	/* Protection des boutons                                   */
	/*----------------------------------------------------------*/
	p_inserer_ligne.enabled   = False
	p_supprimer_ligne.enabled = False

	p_inserer_ligne.PictureName   = "k:\pb4obj\bmp\ins_OFF.bmp"
	p_supprimer_ligne.PictureName = "k:\pb4obj\bmp\supp_OFF.bmp"

	st_inserer_1.TextColor   = 8421504
	st_inserer_2.TextColor   = 8421504

	st_supprimer_1.TextColor = 8421504
	st_supprimer_2.TextColor = 8421504

	This.Title = "Traitement - Consultation Table IFR"

Else
	This.Title = "Traitement - Modification Table IFR"
End If


end subroutine

private function string wf_construire_critere (string asvariable, string asoperateur, string asvaleur, string asquote);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Construire_Critere (PRIVATE)
//* Auteur			: PLJ
//* Date				: 02/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String		asVariable
//*					  String		asOperateur
//*					  String		asvaleur
//*					  String		asquote
//*
//* Retourne		: String
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

String	sCritere
Decimal{2}		dcVal, dcValMin, dcValMax

Choose Case asOperateur
	Case '=', '<=', '>='
		sCritere = asVariable + ' ' + asOperateur + ' ' + asQuote + asValeur + asQuote
	Case 'POS'
		sCritere = "pos(" + asVariable + ", '" + asValeur + "') > 0"
	Case '%'
		dcVal = Dec( asValeur )
		sCritere = asVariable + ' >= ' + String ( dcVal * 0.9 ) + ' AND ' + asVariable + ' <= ' + String ( dcVal * 1.1 )

End Choose

Return sCritere
end function

private function boolean wf_verifier_saisie ();


String	sMarque, sReference
Long		lPrix, lLigne

If dw_1.RowCount() > 0 Then

	lLigne     = dw_1.GetRow ()
	sMarque    = dw_1.GetItemString ( lLigne, "MARQUE" )
	sReference = dw_1.GetItemString ( lLigne, "REFERENCE" )
	lPrix      = dw_1.GetItemNumber ( lLigne, "FREQUENCE" )

	If isNull (sMarque) Or isNull (sReference) Or isNull (lPrix) Then
		Return False
	End If

	If sMArque = "" Or sReference = "" Then 
		Return False
	End If

End If

Return True


end function

private subroutine wf_maj_le (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Maj_Le (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/12/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Affectation des zones Maj_Le et Maj_Par avant enregistrement
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 			FPI	15/09/2014	[OPTIM_SQL]
//*-----------------------------------------------------------------

Datetime dtNow

// [OPTIM_SQL]
dtNow=Datetime( Today(), Now() )
// :[OPTIM_SQL]

dw_1.SetItem ( alLigne, "MAJ_LE",  dtNow )
dw_1.SetItem ( alLigne, "MAJ_PAR", stGlb.sCodOper )
end subroutine

public subroutine wf_afficher_compteur ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Afficher_Compteur (PUBLIC)
//* Auteur			: PLJ
//* Date				: 04/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affiche le nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es dans la datawindow de saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA	28/06/2006	Modification en fonction public
//*-----------------------------------------------------------------


st_Information.Text = 'Nb lignes: ' + String ( dw_1.RowCount() )
end subroutine

public function boolean wf_enregistrer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Enregistrer (PUBLIC)
//* Auteur			: PLJ
//* Date				: 02/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA	28/06/2006	Modification en fonction public
//			FPI	05/02/2015 [TRIM_IFR] Trim avant enreg
//*-----------------------------------------------------------------

String	sTexte, sVal
Boolean bRet
Long lRow

sTexte = st_information.text
st_information.Text = "ENREGISTREMENT EN COURS..."

// [TRIM_IFR]
For lRow=1 to dw_1.RowCount()
	if dw_1.getItemStatus( lRow, 1, Primary!) <> NotModified!	Then
		sVal=dw_1.GetItemString(lRow,"MARQUE")
		sVal=Trim(sVal)
		dw_1.SetItem(lRow,"MARQUE",sVal)
		sVal=dw_1.GetItemString(lRow,"REFERENCE")
		sVal=Trim(sVal)
		dw_1.SetItem(lRow,"REFERENCE",sVal)
	End if
Next
// :[TRIM_IFR]

bRet = dw_1.Update () > 0 

f_commit (SqlCa, bRet  )

pb_enregistrer.Enabled = False

st_information.Text = sTexte

Return bRet 
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//*		FPI	15/09/2014	[PM251-1] Ajout de la colonne "sku_saga"
//       JFF   16/03/2020  [DT469]
//       JFF   11/05/2022 [RS2980_IFR]
//*-----------------------------------------------------------------

//u_DeclarationFuncky 	uoDeclarationFuncky //[I037] Migration FUNCKy

dw_1.SetTransObject ( SQLCA)
//Migration PB8-WYNIWYG-03/2006 FM
DataWindowChild	ldwc_1
long	ll_ret
ll_ret = dw_2.GetChild('battsupl', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('battsupl')

ll_ret = dw_2.GetChild('voxfunc', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('voxfunc')

ll_ret = dw_2.GetChild('scrncol', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('scrncol')

ll_ret = dw_2.GetChild('infred', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('infred')

ll_ret = dw_2.GetChild('wireless', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('wireless')

ll_ret = dw_2.GetChild('modem', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('modem')

ll_ret = dw_2.GetChild('digicam', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('digicam')

ll_ret = dw_2.GetChild('mp3wma', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('mp3wma')

ll_ret = dw_2.GetChild('systeme', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('systeme')

ll_ret = dw_2.GetChild('commstnd', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('commstnd')

ll_ret = dw_2.GetChild('webconn', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('webconn')

ll_ret = dw_2.GetChild('java', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('java')

ll_ret = dw_2.GetChild('talktime', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('talktime')

ll_ret = dw_2.GetChild('message', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('message')

ll_ret = dw_2.GetChild('stndby', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('stndby')

ll_ret = dw_2.GetChild('commpaym', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('commpaym')

ll_ret = dw_2.GetChild('provider', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('provider')

ll_ret = dw_2.GetChild('packtype', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('packtype')

ll_ret = dw_2.GetChild('gps', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('gps')

ll_ret = dw_2.GetChild('mep', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('mep')

// [DT469]
/*
ll_ret = dw_2.GetChild('sku_saga', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('sku_saga')
PostEvent ("ue_chgt_child_recalcitrante") // car la child se trouve $$HEX1$$e900$$ENDHEX$$cras$$HEX1$$e900$$ENDHEX$$, ej ne sais pas pourquoi.


// [DT469]
ll_ret = dw_2.GetChild('dern_maj_prix_trt', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('dern_maj_prix_trt' )

// [DT469]
ll_ret = dw_2.GetChild('dern_maj_prix_par', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('dern_maj_prix_par' )

// [DT469]
ll_ret = dw_2.GetChild('maj_par', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('maj_par' )

*/

//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.ShareData      ( dw_2 )

dw_Stk_Liste_Val.SetTransObject ( SQLCA )

dw_trt_critere_marge.InsertRow (0)
dw_trt_critere.InsertRow       (0)

dw_1.SetRowFocusIndicator ( p_select )

wf_PositionnerObjets ()

/*----------------------------------------------------------*/
/* Initialisation des variables d'intance                   */
/*----------------------------------------------------------*/

// __________________
// R$$HEX1$$e900$$ENDHEX$$pertoire WINDOWS
// $$HEX18$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00$$ENDHEX$$
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//isRepWin	= uoDeclarationFuncky.Uf_WinDir () 
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy uoDeclarationFuncky
//If IsValid(uoDeclarationFuncky) Then Destroy uoDeclarationFuncky
//Fin Migration PB8-WYNIWYG-03/2006 FM

// __________________________________
// R$$HEX1$$e900$$ENDHEX$$pertoire o$$HEX2$$f9002000$$ENDHEX$$se situe l'exe Excel
// $$HEX34$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00$$ENDHEX$$
//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel = F_GetExcelPath() //[PI037]

// _____________________
// Ensemble des crit$$HEX1$$e800$$ENDHEX$$res
// $$HEX21$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00$$ENDHEX$$

// Colonne 1 nom du crit$$HEX1$$e800$$ENDHEX$$re
// Colonne 2 r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la datawindow ( 1:dw_trt_ifr_critere_marge 2:dw_trt_ifr_critere )
// Colonne 3 type                       ( NUMBER, CHAR, DATE, DATETIME                    )
// Colonne 4 op$$HEX1$$e900$$ENDHEX$$rateur de comparaison   ( =, <=, >=, <, >, pos                            )

isTabCritere = {	'marque',		'1',	'STRING',	'=',	   &
						'reference',	'1',	'STRING',	'POS',	&
						'provenance',	'1',	'STRING',	'=',		&
						'frequence',	'2',	'NUMBER',	'=',		&
						'prix_bas',	   '2',	'NUMBER',	'>=',		&
						'prix_haut',	'2',	'NUMBER',	'<=',		&
						'poids',		   '2',	'STRING',	'=',		&
						'battsupl',		'2',	'STRING',	'=',		&
						'voxfunc',		'2',	'STRING',	'=',		&
						'scrncol',		'2', 	'STRING',	'=',		&
						'infred',		'2',	'STRING',	'=',		&
						'wireless',		'2',	'STRING',	'=',		&
						'modem',			'2',	'STRING',	'=',		&
						'digicam',		'2',	'STRING',	'=',		&
						'mp3wma',		'2',	'STRING',	'=',		&
						'systeme',		'2',	'STRING',	'=',		&
						'commstnd',		'2',	'STRING',	'=',		&
						'webconn',		'2',	'STRING',	'=',		&
						'java',			'2',	'STRING',	'=',		&
						'talktime',		'2',	'STRING',	'=',		&
						'message',		'2',	'STRING',	'=',		&
						'stndby',		'2',	'STRING',	'=',		&
						'commpaym', 	'2',	'STRING',	'=',		&
						'provider',		'2',	'STRING',	'=',		&
						'packtype',		'2',	'STRING',	'=',		&
						'gps', 			'2',  'STRING',	'=',		&
						'mep',			'2',	'STRING',	'=',     &
						'alt_dispo',   '1',  'STRING',   '=' ,     &
						'sku_saga',	   '2',	'STRING',	'=',     &
						'maj_prix_auto', '2', 'STRING',   '=',  &
						'dern_maj_prix_trt', '2', 'STRING',   '=',  &
						'dern_maj_prix_par', '2', 'STRING',   '=',  &
						'maj_par',           '2', 'STRING',   '=', &						
						'per_rev_prix_mois', '2', 'STRING',	'=' &
						}  // [PM251-1]


// [PM251-1]	Changer aussi dans les variables d'instance !!	
ilNbCritere = 34
// :[PM251-1]		

/*------------------------------------------------------------------*/
/* Ne pas Oublier de redimmensionner le tableau au niveau de la     */
/* d$$HEX1$$e900$$ENDHEX$$claration.                                                     */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event show;call super::show;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//       JFF   16/03/2020 [DT469]
//       JFF   11/05/2022 [RS2980_IFR]
//*-----------------------------------------------------------------


dw_1.Retrieve ()


wf_Afficher_Compteur ()

wf_Preparer_recherche()

wf_Proteger ()

dw_trt_critere_marge.SetItem ( 1, "ALT_DISPO", 'A' )

// [DT469] // [RS2980_IFR]
// dw_trt_critere.SetItem ( 1, "MAJ_PRIX_AUTO", 'A' )

dw_1.SetRow (1)
dw_1.ScrollToRow (1)



end event

event hide;call super::hide;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie
//* Evenement 		: Hide
//* Auteur			: PLJ
//* Date				: 14/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sCodParam

gWMdi.Width  -= iMdiWidth   // 1100
gWMdi.Height -= iMdiHeigth   // 1100

/*----------------------------------------------------------------------*/
/* Si la personne avait le droit d'$$HEX1$$ea00$$ENDHEX$$tre en modification sur la fen$$HEX1$$ea00$$ENDHEX$$tre  */
/* c'est qu'elle l'avait bloqu$$HEX1$$e900$$ENDHEX$$e lors l'ouverture (wf_proteger) en      */ 
/* ins$$HEX1$$e900$$ENDHEX$$rant une ligne dans parametre, on se charge donc dans ce cas de  */
/* supprimer la ligne.                                                  */
/*----------------------------------------------------------------------*/
If p_inserer_ligne.enabled = True Then

	sCodParam = 'IFR_' + stGlb.sCodOper

	DELETE FROM sysadm.parametre
         WHERE ref_cpt = :sCodParam
		   USING SQLCA;

	f_commit (SQLCA,TRUE)



End IF
end event

on ue_retour;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie
//* Evenement 		: ue_retour
//* Auteur			: PLJ
//* Date				: 04/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Boolean	bQuitter = True
Long lRet

/*--------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification qu'il n'ya pas d'enregistrement en cours  */
/*--------------------------------------------------------*/

dw_1.AcceptText()
dw_2.AcceptText()

If pb_Enregistrer.Enabled = True Then
	stMessage.Bouton	= YesNo!
	stMessage.sTitre	= "Saisie IFR"
	stMessage.Icon		= QUESTION!
	stMessage.sCode	= "IFR0020"

	lRet	= f_Message ( stMessage )

	If lRet = 2 Then bQuitter = False

End If

If bQuitter = True Then	Call Super::Ue_Retour


end on

on w_trt_sp_ifr_saisie.create
int iCurrent
call super::create
this.dw_stk_liste_val=create dw_stk_liste_val
this.pb_enregistrer=create pb_enregistrer
this.pb_filtrer=create pb_filtrer
this.p_inserer_ligne=create p_inserer_ligne
this.st_inserer_1=create st_inserer_1
this.st_inserer_2=create st_inserer_2
this.p_supprimer_ligne=create p_supprimer_ligne
this.st_supprimer_1=create st_supprimer_1
this.st_supprimer_2=create st_supprimer_2
this.st_information=create st_information
this.p_select=create p_select
this.dw_trt_critere_marge=create dw_trt_critere_marge
this.st_excel1=create st_excel1
this.st_excel2=create st_excel2
this.p_excel=create p_excel
this.p_effacer_critere=create p_effacer_critere
this.dw_trt_critere=create dw_trt_critere
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_stk_liste_val
this.Control[iCurrent+2]=this.pb_enregistrer
this.Control[iCurrent+3]=this.pb_filtrer
this.Control[iCurrent+4]=this.p_inserer_ligne
this.Control[iCurrent+5]=this.st_inserer_1
this.Control[iCurrent+6]=this.st_inserer_2
this.Control[iCurrent+7]=this.p_supprimer_ligne
this.Control[iCurrent+8]=this.st_supprimer_1
this.Control[iCurrent+9]=this.st_supprimer_2
this.Control[iCurrent+10]=this.st_information
this.Control[iCurrent+11]=this.p_select
this.Control[iCurrent+12]=this.dw_trt_critere_marge
this.Control[iCurrent+13]=this.st_excel1
this.Control[iCurrent+14]=this.st_excel2
this.Control[iCurrent+15]=this.p_excel
this.Control[iCurrent+16]=this.p_effacer_critere
this.Control[iCurrent+17]=this.dw_trt_critere
this.Control[iCurrent+18]=this.dw_2
end on

on w_trt_sp_ifr_saisie.destroy
call super::destroy
destroy(this.dw_stk_liste_val)
destroy(this.pb_enregistrer)
destroy(this.pb_filtrer)
destroy(this.p_inserer_ligne)
destroy(this.st_inserer_1)
destroy(this.st_inserer_2)
destroy(this.p_supprimer_ligne)
destroy(this.st_supprimer_1)
destroy(this.st_supprimer_2)
destroy(this.st_information)
destroy(this.p_select)
destroy(this.dw_trt_critere_marge)
destroy(this.st_excel1)
destroy(this.st_excel2)
destroy(this.p_excel)
destroy(this.p_effacer_critere)
destroy(this.dw_trt_critere)
destroy(this.dw_2)
end on

event open;call super::open;dw_1.istri="marque A, reference A"
end event

type cb_debug from w_8_traitement`cb_debug within w_trt_sp_ifr_saisie
end type

type dw_1 from w_8_traitement`dw_1 within w_trt_sp_ifr_saisie
integer x = 18
integer y = 380
integer width = 1646
integer height = 1124
integer taborder = 100
string dataobject = "d_trt_sp_ifr_saisie_marge"
boolean border = false
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*	JFF   28/07/2010  [20100728140726080]			  
// FPI - 27/04/2011	 [VDoc3926] Contr$$HEX1$$f400$$ENDHEX$$le de mise en indispo
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

Boolean				bEnregistrer = False
Long					lLigne, lTot, lRet, lFind
String 				sMarque, sReference, sNewVal, sRecherche, sFiltre, sVal

DataWindowChild	dwChild
DateTime				dtJour

lLigne  = dw_1.GetRow()
sNewVal = This.GetText ()

// [20100728140726080]
sVal = dw_1.GetItemString ( lLigne, isNomCol )
If ( isNomCol = "REFERENCE" Or isNomCol = "MARQUE" ) And Not IsNull ( sVal ) And Len ( Trim ( sVal ) ) > 0 Then

	stMessage.sTitre		= "Ifr"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode 		= "GENE013"
	StMessage.sVar[1]		= "Modification interdite"
	
	F_Message ( stMessage )

	Return 2 
End If
// [20100728140726080]

If UPPER (isNomCol) = "ALT_SELECT" Then
//Migration PB8-WYNIWYG-03/2006 OR
//	This.SetActionCode (0)
	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR
End If

/*-------------------------------------------------*/
/* Les zones MARQUE et r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sont obligatoires */
/* +                                               */
/* V$$HEX1$$e900$$ENDHEX$$rification que la nouvelle valeur n'existe pas*/
/* d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$dans la table IFR                          */
/*-------------------------------------------------*/	
If UPPER (isNomCol) = "REFERENCE" Then

	If isNull (sNewVal) Or sNewVal = '' Then
		This.iiErreur = 0
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

	sMarque =  dw_1.GetItemString ( lLigne, "MARQUE" )
	sRecherche = "marque='" + sMarque + "' AND reference = '" + sNewVal + "'"
	lFind = dw_1.Find ( sRecherche, 1, dw_1.RowCount() )

	If lFind > 0 Then
		This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

End If

If UPPER (isNomCol) = "MARQUE" Then

	// Filtre des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences en fonction de la marque
	This.GetChild ( "reference", dwChild )
	
	If isNull (sNewVal) Or sNewVal = "" Then 
		sFiltre = "" 
	Else 
		sFiltre = "marque = '" + sNewVal + "'"
	End IF

	dwChild.SetFilter ( sFiltre )
	dwChild.Filter ()	
	dwChild.Sort   ()


	If isNull (sNewVal) Or sNewVal = '' Then
		This.iiErreur = 0
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If


	sReference =  dw_1.GetItemString ( lLigne, "REFERENCE" )
	sRecherche = "marque='" + sNewVal + "' AND reference = '" + sReference + "'"
	lFind = dw_1.Find ( sRecherche, 1, dw_1.RowCount() )

	If lFind > 0 Then
		This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		return
		ll_ret = 1
		return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

End If


/*------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification qu'il n'y a pas d'article avec la */
/* marque et la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence dans le cas o$$HEX2$$f9002000$$ENDHEX$$l'on     */
/* mofifierait la marque ou la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence          */
/*------------------------------------------------*/

If UPPER (isNomCol) = "REFERENCE" OR UPPER (isNomCol) = "MARQUE"	Then

	sMarque    = dw_1.GetItemString ( lLigne, "MARQUE"    )
	sReference = dw_1.GetItemString ( lLigne, "REFERENCE" )

	If isNull (sMarque) Or isNull (sReference) Then 
		wf_maj_le ( lLigne )
		Return
	End If

	SELECT count(*) INTO :lTot
	  FROM sysadm.article
	 WHERE id_marq_art_ifr = :sMarque	 AND
			 id_modl_art_ifr = :sReference
	 USING SQLCA;

	/*------------------------------------------------*/
	/* Les anciennes r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences sont utilis$$HEX1$$e900$$ENDHEX$$e dans la */
   /* table ARTICLE                                  */
	/*------------------------------------------------*/			
	If lTot > 0 Then
/*// [20100728140726080]			  
		OpenWithPArm ( w_Trt_Sp_IFR_confirm_maj, sMarque + " " + sReference )
		lRet = Message.DoublePArm
		
		/*---------------------------------------------------------------*/
		/* Les 3 valeurs possibles de retour sont :                      */
      /* 1 : Mettre $$HEX2$$e0002000$$ENDHEX$$jour la table article avec la nouvelle r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence */
		/*	2 : Supprimer la valeur de la table article                   */
		/* 3 : Ne rien faire                                             */
		/*                                                               */
		/* Pour les cas 1 et 2 on d$$HEX1$$e900$$ENDHEX$$clenche aussitot la mise $$HEX2$$e0002000$$ENDHEX$$jour de   */
		/* dw_1 pour qu'il n'y ait pas d$$HEX1$$e900$$ENDHEX$$phasage, celui-ci r$$HEX1$$e900$$ENDHEX$$alisant le  */
		/* commit                                                        */
		/*---------------------------------------------------------------*/

		Choose Case lRet
			Case 1

				SELECT min ( getdate() ) INTO : dtJour
	  			  FROM sysadm.parametre
				 USING SQLCA;

				If UPPER(isNomCol) = "REFERENCE" Then
					Update sysadm.article
						SET id_modl_art_ifr = :sNewVal,
							 maj_le          = :dtJour,
							 maj_par			  = :stGlb.sCodOper
					 WHERE id_marq_art_ifr = :sMarque	 AND
			 				 id_modl_art_ifr = :sReference 
					 USING SQLCA;
				End IF

				If Upper(isNomCol) = "MARQUE" Then
					Update sysadm.article
						SET id_marq_art_ifr = :sNewVal,
							 maj_le          = :dtJour,
							 maj_par			  = :stGlb.sCodOper
					 WHERE id_marq_art_ifr = :sMarque	 AND
			 				 id_modl_art_ifr = :sReference 
					 USING SQLCA;
				End IF

				wf_maj_le ( lLigne )
				wf_enregistrer ()

			Case 2
				SELECT min ( getdate() ) INTO : dtJour
				  FROM sysadm.parametre
				 USING SQLCA;

				UPDATE sysadm.article
					SET id_marq_art_ifr = null,
						 id_modl_art_ifr = null,
						 alt_dispo       = 'N',
						 maj_le          = :dtJour,
						 maj_par			  = :stGlb.sCodOper 
				 WHERE id_marq_art_ifr = :sMarque	 AND
			 			 id_modl_art_ifr = :sReference 
				 USING SQLCA; 

				wf_maj_le ( lLigne )
				wf_enregistrer ()

			Case 3
//Migration PB8-WYNIWYG-03/2006 OR
//				This.SetActionCode (2)

				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 OR
		End Choose		
		// [20100728140726080]			  
*/	
	Else
	/*------------------------------------------------*/
	/* Les anciennes r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences ne sont pas utilis$$HEX1$$e900$$ENDHEX$$e  */
   /* dans la table ARTICLE                          */
	/*------------------------------------------------*/
		wf_maj_le ( lLigne )			
		If pb_Enregistrer.Enabled = False Then
			pb_Enregistrer.Enabled = True
		End If

	End If

End If

// [VDoc3926]
If UPPER (isNomCol) = "ALT_DISPO"  And data="N" Then
	sMarque    = dw_1.GetItemString ( lLigne, "MARQUE"    )
	sReference = dw_1.GetItemString ( lLigne, "REFERENCE" )

	If SQLCA.PS_S01_VERIF_MODIF_MARQ_MODL(sMarque, sReference ) > 0 Then
		This.iiErreur = 3
		ll_Ret=1
	End if
End if

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_1
//* Evenement 		: RowFocusChanged
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation du rowfocus entre dw_1 et dw_2
//* Commentaires	: 
//*-----------------------------------------------------------------
//*	JFF  15/06/2011  [PM82][LOT3]
// 		FPI	16/09/2014	[PM251-1]
//*-----------------------------------------------------------------
long 		lCpt, lTot, lPrixMin
String 	sMarque, sRef, sSkuSaga
lTot = dw_1.RowCount()
boolean 	bOk = True
Boolean bMsgInfo=FALSE

String	sTexte

sTexte = st_information.text
st_information.Text = "VERIFICATION EN COURS..."

dw_1.AcceptText()
dw_2.AcceptText()

stMessage.sCode	= "IFR0040" // [PM251-1]


//MessageBox ( "", String (dw_1.getRow ()) + "/" + String (dw_2.getRow ()) )

If pb_enregistrer.enabled = True Then

	For lCpt = lTot To 1 Step -1
		sMarque = dw_1.GetItemString ( lCpt, "MARQUE")
		sRef    = dw_1.GetItemString ( lCpt, "REFERENCE")

		If ( isNull (sMarque) Or isNull (sRef) ) And ( sMarque <> "PAS DE MARQUE" ) Then
			bOk = FAlse
			Exit
		End If

		lPrixMin= dw_1.GetItemNumber ( lCpt, "PRIX_BAS" )
		If ( isNull (sMarque) Or isNull (sRef) ) And ( sMarque <> "PAS DE MARQUE" ) Then
			bOk = FAlse
			Exit
		End If

		If ( isNull (lPrixMin) Or lPrixMin <= 0 )  And ( sMarque <> "PAS DE MARQUE" ) Then
			bOk = False
			Exit
		End If

		// [PM251-1]
		if dw_2.GetItemStatus(lCpt, 0,Primary!) <> NotModified!	 Then // Contr$$HEX1$$f400$$ENDHEX$$le sur ligne modifi$$HEX1$$e900$$ENDHEX$$e
			sSkuSaga=dw_2.GetItemString ( lCpt, "SKU_SAGA")
	
			If ( isNull (sSkuSaga) Or Trim(sSkuSaga)="" ) And ( sMarque <> "PAS DE MARQUE" ) Then
				bMsgInfo=TRUE
			End If
		End if
		// :[PM251-1]
	Next

	// [PM251-1]
	if bOk and bMsgInfo Then
		stMessage.Bouton	= Ok!
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Information!
		stMessage.sCode	= "IFR0103"

		f_Message ( stMessage )
	End if
	// :[PM251-1]

	If bOk Then
		dw_2.SetRow ( dw_1.getRow () )
		wf_enregistrer ()
	Else
		stMessage.Bouton	= Ok!
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Exclamation!
		f_Message ( stMessage )

		dw_1.SetRow ( lCpt )
		dw_2.SetRow ( lCpt )
		dw_1.ScrollToRow ( lCpt )
	End If

Else
	dw_2.SetRow ( dw_1.getRow () )
	dw_2.ScrollToRow ( dw_1.getRow () )
End If


dw_1.SetRedraw (True)

st_information.Text = stexte



end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_1
//* Evenement 		: ItemError
//* Auteur			: PLJ
//* Date				: 06/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

// [MIGPB8COR]
ll_ret = AncestorReturnValue

Choose Case This.iiErreur
	Case 0
		stMessage.Bouton	= Ok!
		stMessage.bErreurG= False
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "IFR0040"

		f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
		ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 OR
	Case 1

		stMessage.Bouton	= Ok!
		stMessage.bErreurG= False
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "IFR0030"

		f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
		ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 OR
	Case 3 // [VDoc3936]

		stMessage.Bouton	= Ok!
		stMessage.bErreurG= False
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "IFR0100"

		f_Message ( stMessage )
		ll_ret = 1
End Choose

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on dw_1::scrollvertical;call w_8_traitement`dw_1::scrollvertical;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_1
//* Evenement 		: ScrollVertical
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMAx, sMod

spos = dw_1.Describe("DataWindow.VerticalScrollPosition")
smax = dw_1.Describe("DataWindow.VerticalScrollMaximum")

sMod = "DataWindow.VerticalScrollPosition=" + spos
dw_2.Modify( sMod)


end on

type st_titre from w_8_traitement`st_titre within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 3794
integer y = 60
integer width = 393
end type

type pb_retour from w_8_traitement`pb_retour within w_trt_sp_ifr_saisie
integer x = 18
integer y = 8
integer width = 242
integer height = 144
integer taborder = 10
end type

type pb_valider from w_8_traitement`pb_valider within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 2267
integer y = 16
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 2766
integer y = 16
integer width = 242
integer height = 144
end type

type pb_controler from w_8_traitement`pb_controler within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 2021
integer y = 16
integer width = 242
integer height = 144
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 2514
integer y = 16
integer width = 242
integer height = 144
end type

type dw_stk_liste_val from datawindow within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 64
integer y = 1424
integer width = 288
integer height = 216
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_stk_sp_ifr_liste_val"
boolean livescroll = true
end type

type pb_enregistrer from picturebutton within w_trt_sp_ifr_saisie
integer x = 274
integer y = 8
integer width = 242
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Enregistrer"
string picturename = "k:\pb4obj\bmp\8_savfil.bmp"
string disabledname = "k:\pb4obj\bmp\8_savoff.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::pb_enregistrer
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*-----------------------------------------------------------------
//*	JFF  15/06/2011  [PM82][LOT3]
// 		FPI	16/09/2014	[PM251-1]
//*-----------------------------------------------------------------

Boolean	bOk, bMsgInfo
Long		lCpt, lTot, lPrixMin
String	sMarque, sRef, sSkuSaga

bOk = True

dw_1.AcceptText ()
dw_2.AcceptText ()

lTot = dw_1.RowCount()

bMsgInfo=FALSE
stMessage.sCode	= "IFR0040" // [PM251-1]

For lCpt = lTot To 1 Step -1

	sMarque = dw_1.GetItemString ( lCpt, "MARQUE")
	sRef    = dw_1.GetItemString ( lCpt, "REFERENCE")
		
	If ( isNull (sMarque) Or isNull (sRef) ) And ( sMarque <> "PAS DE MARQUE" ) Then
		bOk = FAlse
		Exit
	End If

	lPrixMin= dw_1.GetItemNumber ( lCpt, "PRIX_BAS" )
	If ( isNull (lPrixMin) Or lPrixMin <= 0 ) And ( sMarque <> "PAS DE MARQUE" ) Then
		bOk = False
		Exit
	End If

	// [PM251-1]
	sSkuSaga=dw_2.GetItemString ( lCpt, "SKU_SAGA")

	If ( isNull (sSkuSaga) Or Trim(sSkuSaga)="" ) And ( sMarque <> "PAS DE MARQUE" ) Then
		bMsgInfo=TRUE
	End If
	// :[PM251-1]
	
Next

// [PM251-1]
if bOk and bMsgInfo Then
	stMessage.Bouton	= Ok!
	stMessage.sTitre	= "Saisie IFR"
	stMessage.Icon		= Information!
	stMessage.sCode	= "IFR0103"

	f_Message ( stMessage )
End if
// :[PM251-1]


If bOk Then
		wf_enregistrer ()
Else
	This.enabled = False
	stMessage.Bouton	= Ok!
	stMessage.sTitre	= "Saisie IFR"
	stMessage.Icon		= Exclamation!

	f_Message ( stMessage )

	dw_2.SetRow ( lCpt )
	dw_1.SetRow ( lCpt )
	dw_2.ScrollToRow ( lCpt )

End If




end event

type pb_filtrer from picturebutton within w_trt_sp_ifr_saisie
integer x = 18
integer y = 168
integer width = 233
integer height = 136
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Filtrer"
string picturename = "k:\pb4obj\bmp\8_filtre.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::pb_filtrer
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//       JFF   16/03/2020 [DT469]
//*-----------------------------------------------------------------


Long		lCpt
String	sFiltre,  sAnd

Datawindow			dwTemp		

Long		lCritere
String	sCritere

sAnd = ''

dw_1.AcceptText  ()
dw_2.AcceptText  ()


dw_trt_critere_marge.AcceptText ()
dw_trt_critere.AcceptText       ()

If wf_verifier_saisie () = False Then Return 

/*--------------------------------------------------------------*/
/* Initialisation des DDDW des crit$$HEX1$$e800$$ENDHEX$$res de recherche            */
/* CAS Sp$$HEX1$$e900$$ENDHEX$$cifiques :                                            */
/* marque  (1), reference(2),                                   */
/* freqence(4), prix_min (5), prix max(6)                       */
/*                                                              */
/* Cas particulier du poids o$$HEX2$$f9002000$$ENDHEX$$la DDDW poss$$HEX1$$e800$$ENDHEX$$de des blancs devant*/
/*--------------------------------------------------------------*/
dw_1.SetFilter ( "" )
dw_1.Filter ()

For lCpt = 1 To ilNbCritere

	If isTabCritere [2,lCpt] = '1' Then
		dwTemp  = dw_trt_critere_marge
	Else
		dwTemp = dw_trt_critere
	End If

	

	Choose Case isTabCritere [3,lCpt]
		Case 'STRING'
			sCritere = dwTemp.GetItemString ( 1, isTabCritere [1,lCpt] )
			If isTabCritere [1,lCpt] = "poids" Then sCritere = LeftTrim (sCritere)

//			If sCritere = 'A' AND isTabCritere [1,lCpt] = "alt_dispo" Then sCritere = ''

			// [DT469]
			If sCritere = 'A' Then
				Choose Case isTabCritere [1,lCpt] 
					Case "alt_dispo", "maj_prix_auto"
						sCritere = ''			
				End Choose 
			End If 

			If NOT ( isNull (sCritere) OR sCritere = '' ) Then 
				sFiltre += sAnd + wf_construire_critere ( isTabCritere [1,lCpt],  isTabCritere [4,lCpt], sCritere, "'" ) 
				sAnd    = " AND "
			End If

		Case 'NUMBER'
			lCritere = dwTemp.GetItemNumber ( 1, isTabCritere [1,lCpt] )
			If NOT isNull (lCritere) Then
				sFiltre += sAnd + wf_construire_critere (isTabCritere [1,lCpt],  isTabCritere [4,lCpt], String (lCritere), "" ) 
				sAnd    = " AND "
			End If	


	End Choose
		
Next

dw_1.Setredraw (False)
dw_2.Setredraw (False)

dw_1.ShareDataOff ()


dw_1.SetFilter ( sFiltre )
dw_1.Filter ()

dw_1.ShareData (dw_2)

dw_1.Setredraw (True)
dw_2.Setredraw (True)


dw_2.SetRow (1)
dw_2.ScrollToRow (1)

dw_1.SetRow (1)
dw_1.ScrollToRow (1)


wf_Afficher_Compteur ()
end event

type p_inserer_ligne from picture within w_trt_sp_ifr_saisie
integer y = 1512
integer width = 206
integer height = 112
integer taborder = 130
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\ins_l.bmp"
boolean focusrectangle = false
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::p_inserer_ligne
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* 			FPI	15/09/2014	[OPTIM_SQL]
//          JFF   16/03/2020  [DT469]
//    	   JFF   11/05/2022 [RS2980_IFR]
//*-----------------------------------------------------------------

long		lLigne, lIdTrait
DateTime		dtJour


dw_1.SetRedraw (False)
dw_2.SetRedraw (False)

// [OPTIM_SQL]
dtJour=Datetime( Today(), Now() )
// :[OPTIM_SQL]

lIdTrait = Year ( date(dtJour) ) * 1000000 + Month ( Date(dtJour) ) * 10000

lLigne = dw_1.insertrow (0)

dw_1.SetItem ( lLigne, 'PROVENANCE', 'SPB'    )
dw_1.SetItem ( lLigne, 'ID_TRAIT',   lIdTrait )
dw_1.SetItem ( lLigne, 'FREQUENCE',  1        )
dw_1.SetItem ( lLigne, 'PRIX_HAUT',  1        )
dw_1.SetItem ( lLigne, 'PRIX_BAS',   1        )
dw_1.SetItem ( lLigne, 'ALT_DISPO',  'O'      )

// [RS2980_IFR]
dw_1.SetItem ( lLigne, "PER_REV_PRIX_MOIS", "3" ) 
dw_1.SetItem ( lLigne, "MAJ_PRIX_AUTO", "N" ) 
dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "ENCO" ) 
dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_DTE", dtJour ) 
dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_PAR", stGlb.sCodOper ) 

/*
	// [DT469]
	dw_1.SetItem ( lLigne, "MAJ_PRIX_AUTO", "O" ) 
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "MANU" ) 
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_DTE", dtJour ) 
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_PAR", stGlb.sCodOper ) 
*/

dw_1.ScrolltoRow  ( lLigne )
dw_1.SetRow 		( lLigne )

dw_2.ScrolltoRow  ( lLigne )
dw_2.SetRow 		( lLigne )

pb_enregistrer.enabled = True

wf_Afficher_Compteur ()

dw_1.SetRedraw (True)
dw_2.SetRedraw (True)
end event

type st_inserer_1 from statictext within w_trt_sp_ifr_saisie
integer x = 27
integer y = 1580
integer width = 192
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ins$$HEX1$$e900$$ENDHEX$$rer"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_inserer_2 from statictext within w_trt_sp_ifr_saisie
integer x = 37
integer y = 1628
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ligne"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_supprimer_ligne from picture within w_trt_sp_ifr_saisie
integer x = 247
integer y = 1516
integer width = 206
integer height = 112
integer taborder = 140
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\supp_l.bmp"
boolean focusrectangle = false
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::p_supprimer_ligne
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* Modification:
//* FPI	27/04/2011	[VDoc3936] - possibilit$$HEX2$$e9002000$$ENDHEX$$de fusionner des IFR
// 	FPI	21/10/2011	[VDoc5678] - d$$HEX1$$e900$$ENDHEX$$sactivation du bouton de suppression de ligne IFR
//*-----------------------------------------------------------------

Boolean	bOk = True
Long		lLigne, lTot, lRet
String 	sMarque, sReference, sProvenance

// [VDoc5678] - d$$HEX1$$e900$$ENDHEX$$sactivation du bouton
/* Vu avec S$$HEX1$$e900$$ENDHEX$$b, je r$$HEX1$$e900$$ENDHEX$$ouvre, mais S$$HEX1$$e900$$ENDHEX$$b et Emilie devront juste me pr$$HEX1$$e900$$ENDHEX$$venir pour que je browse si 
le mod$$HEX1$$e800$$ENDHEX$$le est dans le code PB
Choose Case stGlb.sCodOper
	Case "JFF", "FPI"

	Case Else
		stMessage.Bouton	= Ok!
		stMessage.bErreurG= False
		stMessage.sTitre	= "Saisie IFR"
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "IFR0101"
		f_message (stMessage)
		Return 0

End Choose
*/
// :[VDoc5678]

dw_1.SetRedraw (False)
dw_2.SetRedraw (False)

lLigne = dw_2.GetRow()
/*------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que la ligne n'est pas une ligne  */
/* IFR                                            */
/*------------------------------------------------*/
/*	[VDoc3936] - Mise en commentaire
sProvenance = dw_1.GetItemString ( lLigne, "PROVENANCE")
If sProvenance = 'IFR' Then
	dw_1.SetRedraw (True)
	dw_2.SetRedraw (True)
	Return
End If
*/
/*------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification qu'il n'y a pas d'article avec la */
/* marque et la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence                         */
/*------------------------------------------------*/
sMarque    = dw_1.GetItemString ( lLigne, "MARQUE"    )
sReference = dw_1.GetItemString ( lLigne, "REFERENCE" )

s_pass stPassSupp

stPassSupp.stab[1] = sMarque
stPassSupp.stab[2] = sReference
stPassSupp.dwNorm[1] = dw_1
stPassSupp.dwNorm[2] = dw_2
stPassSupp.wparent = parent

OpenWithParm(w_trt_sp_ifr_saisie_suppression, stPassSupp)


end event

type st_supprimer_1 from statictext within w_trt_sp_ifr_saisie
integer x = 238
integer y = 1580
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Supprimer"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_supprimer_2 from statictext within w_trt_sp_ifr_saisie
integer x = 270
integer y = 1632
integer width = 165
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ligne"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_information from statictext within w_trt_sp_ifr_saisie
integer x = 718
integer y = 1508
integer width = 658
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type p_select from picture within w_trt_sp_ifr_saisie
boolean visible = false
integer x = 754
integer y = 1652
integer width = 55
integer height = 44
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\8_verte.bmp"
boolean focusrectangle = false
end type

type dw_trt_critere_marge from u_datawindow within w_trt_sp_ifr_saisie
integer x = 398
integer y = 160
integer width = 1271
integer height = 148
integer taborder = 80
string dataobject = "d_trt_sp_ifr_critere_marge"
boolean livescroll = false
end type

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_trt_critere_marge
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre de la liste des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences en fonctions de la marque
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sVal, sFiltre
DatawindowChild	dwChild
sVal = GetText()

If This.isNomCol = "MARQUE" Then

	This.GetChild ( "reference", dwChild )
	
	If isNull (sVal) Or sVal = "" Then 
		sFiltre = "" 
	Else 
		sFiltre = "marque = '" + sVal + "'"
	End IF

	dwChild.SetFilter ( sFiltre )
	dwChild.Filter ()	
	dwChild.Sort   ()
End If
end on

type st_excel1 from statictext within w_trt_sp_ifr_saisie
integer x = 512
integer y = 1592
integer width = 192
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Export"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_excel2 from statictext within w_trt_sp_ifr_saisie
integer x = 480
integer y = 1644
integer width = 247
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Excel"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_excel from picture within w_trt_sp_ifr_saisie
integer x = 544
integer y = 1508
integer width = 105
integer height = 92
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\excel.bmp"
boolean focusrectangle = false
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::p_excel
//* Evenement 		: clicked
//* Auteur			: PLJ
//* Date				: 09/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* #1 [DCMP-O60643]-19/06/2006-PHG Gestion des r$$HEX1$$e900$$ENDHEX$$pertoires temporaires
//* #2	FPI	13/10/2009	Tri dans l'export Excel
//       JFF   28/09/2015 [PM319-1]
//*-----------------------------------------------------------------

String	sFichier
String 	sSortOrig // #2
Datastore	dsExcel

/*------------------------------------------------------------------*/
/* #1 -19/06/2006-PHG Gestion des r$$HEX1$$e900$$ENDHEX$$pertoires temporaires           */
/* par c:\temp\%USERNAME%\CODEAPPLI au lieu de c\temp               */
/*------------------------------------------------------------------*/
//sFichier = isRepWin + K_TEMP + "IFR.XLS"
sFichier = stglb.sRepTempo + "IFR.XLS"

// #1
dsExcel = CREATE datastore

// [PM319-1]
dsExcel.dataobject = "d_stk_extrac_ifr"
dsExcel.SetTransObject ( SQLCA )
dsExcel.Retrieve ()

/* Old Code
	dsExcel.dataobject = "d_trt_sp_ifr_saisie_marge"
	DW_1.Rowscopy( 1, dw_1.rowcount( ) , Primary!, dsExcel , 1, Primary!)
*/

dsExcel.SetSort("MAJ_LE A")
dsExcel.Sort( )
dsExcel.SaveAs ( sFichier, Excel!, True )

RUN ( isRepExcel + " " + sFichier )

// #1
Destroy dsExcel
// Fin #1



end event

type p_effacer_critere from picture within w_trt_sp_ifr_saisie
integer x = 233
integer y = 236
integer width = 206
integer height = 112
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_gomme.bmp"
boolean focusrectangle = false
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::p_effacer_critere
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 10/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*-----------------------------------------------------------------
//       JFF   16/03/2020 [DT469]
//*-----------------------------------------------------------------


String	sNull
Long		lNull, lCpt

Datawindow	dwTemp


SetNull (sNull)
SetNull (lnull)

For lCpt = 1 To ilNbCritere

	If isTabCritere [2,lCpt] = '1' Then
		dwTemp = dw_trt_critere_marge
	Else
		dwTemp = dw_trt_critere
	End IF

	If isTabCritere [3,lCpt] = 'STRING' Then
		dwTemp.SetItem ( 1, isTabCritere [1,lCpt], sNull )
	Else
		dwTemp.SetItem ( 1, isTabCritere [1,lCpt], lNull )
	End IF
	
	// [DT469]
	Choose Case lCpt 
		Case 28, 30 
			dwTemp.SetItem ( 1, isTabCritere [1,lCpt], 'A' )	
	End choose 



Next

end event

type dw_trt_critere from u_datawindow within w_trt_sp_ifr_saisie
integer x = 1664
integer y = 160
integer width = 3003
integer height = 196
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_trt_sp_ifr_critere"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_trt_critere
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

String	sNewVal

sNewVal = This.GetText ()

/*------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que les zones suivantes sont num$$HEX1$$e900$$ENDHEX$$riques */
/*------------------------------------------------------*/
If UPPER (isNomCol) = "FREQUENCE" Or UPPER (isNomCol) = "PRIX_MIN" Or UPPER (isNomCol) = "PRIX_MAX" Then

	If Not (isNull (sNewVal) Or sNewVal ='' ) Then
		If Not isNumber (sNewVal) And Not isNull (sNewVal)  Then
			This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//			This.SetActionCode (1)
//			Return
			ll_ret = 1
			Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
		End If
	End IF

End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_Trt_Critere
//* Evenement 		: ItemError
//* Auteur			: PLJ
//* Date				: 06/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

// [MIGPB8COR]
ll_ret = AncestorReturnValue

If iiErreur = 1 Then
	stMessage.Bouton	= Ok!
	stMessage.sTitre	= "Saisie IFR"
	stMessage.Icon		= Exclamation!
	stMessage.sCode	= "GENE002"
	stMessage.sVar[1]= 'Saisie'

	f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//	This.SetActionCode (1)
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 OR
End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_trt_critere
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_trt_critere.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_2.Modify(sMod)
end on

type dw_2 from u_datawindow within w_trt_sp_ifr_saisie
integer x = 1659
integer y = 380
integer width = 3013
integer height = 1188
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_trt_sp_ifr_saisie"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//*		FPI	15/09/2014	[PM251-1] Ajout de la colonne "sku_saga"
//			FPI	09/09/2016  [FPI.20160909] Ajout contr$$HEX1$$f400$$ENDHEX$$le saisie frequence > 2000
//       JFF   16/03/2020  [DT469]
//       JFF   11/05/2022  [RS2980_IFR]
//*-----------------------------------------------------------------

long	ll_ret = 0
Long			lLigne, lRet
String 		sNewVal
Datetime dtNow

dtNow=Datetime( Today(), Now() )

lLigne  = dw_2.GetRow()
sNewVal = This.GetText ()


/*-------------------------------------------------*/
/* Controle du prix FREQUENCE                      */
/* +                                               */
/* Affectation de la valeur $$HEX2$$e0002000$$ENDHEX$$prix min et max      */
/*-------------------------------------------------*/	
If UPPER (isNomCol) = "FREQUENCE" Then

	If isNull (sNewVal) Or sNewVal = '' Then
		This.iiErreur = 0
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

	If Not isNumber (sNewVal) Then
		This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

	If Long (sNewVal) <= 0 Then
		This.iiErreur = 3
//Migration PB8-WYNIWYG-03/2006 OR
//		This.SetActionCode (1)
//		Return
		ll_ret = 1
		Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If

	// [FPI.20160909]
	If  Long(sNewVal) >= 2000 Then
		stMessage.bouton=YesNo!
		stmessage.berreurg=FALSE
		stMessage.scode="IFR0109"
		stMessage.icon=Question!
		stMessage.sTitre	= "Saisie IFR"
		
		if (f_message(stMessage) = 2)Then
			ll_ret=1
			Return ll_ret
		End if
	End if
	
	lRet = dw_1.SetItem ( lLigne, "PRIX_BAS",  long(sNewVal) )
	lRet = dw_1.SetItem ( lLigne, "PRIX_HAUT", long(sNewVal) )

	wf_maj_le ( lLigne )
	
	// [RS2980_IFR]
	dw_1.SetItem ( lLigne, "MAJ_PRIX_AUTO", "N" ) // Ferm$$HEX2$$e9002000$$ENDHEX$$= N
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "ENCO" ) 
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_DTE", dtNow ) 
	dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_PAR", stGlb.sCodOper ) 
		
/*
		// [DT469]
		stMessage.bouton=YesNo!
		stmessage.berreurg=FALSE
		stMessage.scode="IFR0111"
		stMessage.icon=Question!
		stMessage.sTitre	= "Modification manuelle"
	
		dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "MANU" ) 
		dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_DTE", dtNow ) 
		dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_PAR", stGlb.sCodOper ) 
	
		if (f_message(stMessage) = 2)Then
			dw_1.SetItem ( lLigne, "MAJ_PRIX_AUTO", "N" ) 
		Else 
			dw_1.SetItem ( lLigne, "MAJ_PRIX_AUTO", "O" ) 
		End IF 
		// /[DT469]
*/
End If

// [RS2980_IFR]
If UPPER (isNomCol) = "MAJ_PRIX_AUTO" Then
	If sNewVal = "O" Then
		dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "FERM" )
	Else
		dw_1.SetItem ( lLigne, "DERN_MAJ_PRIX_TRT", "ENCO" )
	End If 
End IF 

If UPPER (isNomCol) = "POIDS" 	OR UPPER (isNomCol) = "BATTSUPL" 	OR UPPER (isNomCol) = "VOXFUNC" 		OR &
   UPPER (isNomCol) = "SCRNCOL" 	OR UPPER (isNomCol) = "INFRED"   	OR UPPER (isNomCol) = "WIRELESS"		OR &
   UPPER (isNomCol) = "MODEM" 	OR UPPER (isNomCol) = "DIGICAM" 		OR UPPER (isNomCol) = "MP3WMA" 		OR &
	UPPER (isNomCol) = "SYSTEME" 	OR UPPER (isNomCol) = "COMMSTND" 	OR UPPER (isNomCol) = "WEBCONN" 		OR &
	UPPER (isNomCol) = "JAVA" 		OR UPPER (isNomCol) = "TALKTIME" 	OR UPPER (isNomCol) = "MESSAGE" 		OR &
	UPPER (isNomCol) = "STNDBY" 	OR UPPER (isNomCol) = "COMMPAYM" 	OR UPPER (isNomCol) = "PROVIDER"		OR &
	UPPER (isNomCol) = "PACKTYPE"	OR UPPER (isNomCol) = "GPS"		 	OR UPPER (isNomCol) = "MEP"	 			 	OR &
	UPPER (isNomCol) = "SKU_SAGA"	THEN // [PM251-1] ajout de SKU_SAGA

End IF

// [DT469] je sors la maj qui ne se faisait que pour le prix
wf_maj_le ( lLigne )

If pb_Enregistrer.Enabled = False Then
	pb_Enregistrer.Enabled = True
End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on rowfocuschanged;call u_datawindow::rowfocuschanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: RowFocusChanged
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation du rowfocus entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

long lCpt, lTot, lPrixMin, lLigne
String sMarque, sRef
lTot = dw_1.RowCount()
boolean bOk = True

String	sTexte

sTexte = st_information.text
st_information.Text = "VERIFICATION EN COURS..."

dw_1.AcceptText()
dw_2.AcceptText()



//If pb_enregistrer.enabled = True Then
//
//	For lCpt = lTot To 1 Step -1
//
//		sMarque = dw_1.GetItemString ( lCpt, "MARQUE")
//		sRef    = dw_1.GetItemString ( lCpt, "REFERENCE")
//		
//		If isNull (sMarque) Or isNull (sRef) Then
//			bOk = FAlse
//			Exit
//		End If
//
//		lPrixMin= dw_1.GetItemNumber ( lCpt, "PRIX_BAS" )
//		If isNull (lPrixMin) Or lPrixMin <= 0 Then
//			bOk = False
//			Exit
//		End If
//
//	Next
//
//	If bOk Then
//		dw_1.SetRow ( dw_2.getRow () )
//		wf_enregistrer ()
//	Else
//		stMessage.Bouton	= Ok!
//		stMessage.sTitre	= "Saisie IFR"
//		stMessage.Icon		= Exclamation!
//		stMessage.sCode	= "IFR0040"
//
//		f_Message ( stMessage )
//
//		dw_2.SetRow ( lCpt )
//		dw_1.SetRow ( lCpt )
//		dw_2.ScrollToRow ( lCpt )
//	End If
//
//Else
	dw_1.SetRow ( dw_2.getRow () )
	dw_1.ScrollToRow ( dw_2.getRow () )
//End If


dw_1.SetRedraw (True)
st_information.Text = sTexte
end on

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE

Choose Case UPPER(isErrCol)

	Case 'FREQUENCE'
			stMessage.sVar[1] = "frequence"				
			stMessage.sCode	= "GENE002"
			F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//			This.Uf_Reinitialiser ()
			return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_2 et dw_trt_critere
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_2.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_trt_critere.Modify (sMod)
end on

on scrollvertical;call u_datawindow::scrollvertical;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: ScrollVertical
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_2.Describe("DataWindow.VerticalScrollPosition")

sMod = "DataWindow.VerticalScrollPosition=" + spos
dw_1.Modify( sMod)
end on

