HA$PBExportHeader$w_trt_sp_ifr_saisie_article.srw
forward
global type w_trt_sp_ifr_saisie_article from w_8_traitement
end type
type pb_enregistrer from picturebutton within w_trt_sp_ifr_saisie_article
end type
type p_select from picture within w_trt_sp_ifr_saisie_article
end type
type st_information from statictext within w_trt_sp_ifr_saisie_article
end type
type dw_trt_critere from u_datawindow within w_trt_sp_ifr_saisie_article
end type
type dw_2 from u_datawindow within w_trt_sp_ifr_saisie_article
end type
type dw_trt_critere_marge from u_datawindow within w_trt_sp_ifr_saisie_article
end type
type pb_filtrer from picturebutton within w_trt_sp_ifr_saisie_article
end type
type p_effacer_critere from picture within w_trt_sp_ifr_saisie_article
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_trt_sp_ifr_saisie_article
end type
type st_modlobserv from statictext within w_trt_sp_ifr_saisie_article
end type
end forward

global type w_trt_sp_ifr_saisie_article from w_8_traitement
integer x = 0
integer y = 0
integer width = 4590
integer height = 1868
pb_enregistrer pb_enregistrer
p_select p_select
st_information st_information
dw_trt_critere dw_trt_critere
dw_2 dw_2
dw_trt_critere_marge dw_trt_critere_marge
pb_filtrer pb_filtrer
p_effacer_critere p_effacer_critere
st_avertissement_monnaie st_avertissement_monnaie
st_modlobserv st_modlobserv
end type
global w_trt_sp_ifr_saisie_article w_trt_sp_ifr_saisie_article

type variables
String	isRepExcel

String	isTabCritere [5,14]
Long	ilNbCritere

Boolean	ibOcc

DateTime  idtMaxMajLeArticle


Constant int iMdiX = 50   // Position
Constant int iMdiY = 50   // Position	
Constant int iMdiWidth = 3750  // Ajout
Constant int iMdiHeigth = 1500  // Ajout

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
private subroutine wf_enregistrer ()
private subroutine wf_afficher_compteur ()
private subroutine wf_proteger ()
private subroutine wf_preparer_recherche ()
private function string wf_construire_critere (string asvariable, string asoperateur, string asvaleur, string asquote)
private subroutine wf_filtrer_modl_ifr (long alligne)
public subroutine wf_interroarticle (long alnumlig, string ascas)
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_SaisieArticle::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 11/08/2004
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

This.Width += iMdiWidth - 1013   // 1100
This.Height+= iMdiHeigth - 100   // 1100

dw_1.X							=   5
dw_1.Y							=  444
dw_1.Width       				= 2050 //1829
dw_1.Height						= 2650

dw_2.X							= dw_1.X + dw_1.Width
dw_2.Y							= dw_1.Y 
dw_2.Width						= 5245
dw_2.Height						= dw_1.Height + 68

dw_trt_critere_marge.X		= 69
dw_trt_critere_marge.Y		= 156
dw_trt_critere_marge.Width	= dw_1.Width
dw_trt_critere_marge.Height= 132

dw_trt_critere.X				= dw_2.X
dw_trt_critere.Y				= 156
dw_trt_critere.Width			= dw_2.Width
dw_trt_critere.Height		= 200

st_information.X				= 1184
st_information.Y				= dw_1.Y + dw_1.Height 
st_information.Width			= 626
st_information.Height		= 72

st_modlobserv.X				= 494
st_modlobserv.Y				= 368
st_modlobserv.Width			= 6798	
st_modlobserv.Height			= 64

end subroutine

private subroutine wf_enregistrer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Enregistrer (PRIVATE)
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
//* 
//*-----------------------------------------------------------------

Long lRet
String	sTexte
DateTime dtMaxMajLeNow

/*-------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification qu'il n'y a pas eu de mises $$HEX2$$e0002000$$ENDHEX$$jour depuis le dernier */
/* retrieve.                                                         */
/*-------------------------------------------------------------------*/
If F_CLE_A_TRUE ( "RS6244_FEN_ART" ) Then

	SQLCA.PS_S_MAX_MAJ_LE  ( dtMaxMajLeNow ) 

Else 
	SELECT Max (maj_le) INTO :dtMaxMajLeNow
	FROM sysadm.article
	USING SQLCA;
End If 


If idtMaxMajLeArticle = dtMaxMajLeNow Then

	sTexte = st_information.text
	st_information.Text = "ENREGISTREMENT EN COURS..."

	dw_1.Update ()
	f_commit (SqlCa, True)

	If F_CLE_A_TRUE ( "RS6244_FEN_ART" ) Then

		SQLCA.PS_S_MAX_MAJ_LE  ( idtMaxMajLeArticle ) 
	
	Else
		SELECT Max ( maj_le) INTO :idtMaxMajLeArticle
		  FROM sysadm.article
		 USING SQLCA;
	End IF 
	
	st_information.Text = sTexte
Else

	stMessage.sTitre	= "Gestion des sinistres - SIMPA2"
	stMessage.Icon		= Information!
	stMessage.sCode	= "IFR0070"
		
	F_Message ( stMessage )

	If F_CLE_A_TRUE ( "RS6244_FEN_ART" ) Then

		SQLCA.PS_S_MAX_MAJ_LE  ( idtMaxMajLeArticle ) 
	
	Else
		SELECT Max ( maj_le) INTO :idtMaxMajLeArticle
		  FROM sysadm.article
		 USING SQLCA;
	End IF 

	dw_1.Retrieve ()
	dw_1.Setrow   (dw_2.GetRow())

	Wf_Filtrer_Modl_Ifr (dw_2.GetRow())

End If


pb_enregistrer.Enabled = False


end subroutine

private subroutine wf_afficher_compteur ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie_Article::Wf_Afficher_Compteur (PRIVATE)
//* Auteur			: PLJ
//* Date				: 12/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affiche le nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es dans la datawindow de saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


st_Information.Text = 'Nb lignes: ' + String ( dw_1.RowCount() )
end subroutine

private subroutine wf_proteger ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Proteger (PRIVATE)
//* Auteur			: PLJ
//* Date				: 12/08/2004
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

ibOcc = False

/*--------------------------------------------------------------------*/
/* La pr$$HEX1$$e900$$ENDHEX$$sence d'une ligne 203(droit d'$$HEX1$$e900$$ENDHEX$$criture ARTICLE) pour         */
/* l'op$$HEX1$$e900$$ENDHEX$$rateur connect$$HEX48$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/   
/*--------------------------------------------------------------------*/

SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper = 203		AND
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
	sCodParam = 'ART_' + stGlb.sCodOper

	INSERT INTO sysadm.parametre VALUES ( :sCodParam, -1, -1 )
   USING SQLCA;

	SELECT count(*) INTO :lTotLigne
     FROM sysadm.parametre 
    WHERE ref_cpt <> :sCodParam    AND
			 ref_cpt like 'ART_%'
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
		
		SELECT min(ref_cpt) INTO :sUser
		  FROM sysadm.parametre 
       WHERE ref_cpt <> :sCodParam    AND
			    ref_cpt like 'ART_%'
		 USING SQLCA;

		sUser = Mid ( sUser, 5 )

		stMessage.sTitre	= "Gestion des sinistres - SIMPA2"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = sUser				
		stMessage.sCode	= "IFR0060"

		F_Message ( stMessage )

									/*-------------------------------------------------*/
	Else							/* La fen$$HEX1$$ea00$$ENDHEX$$tre n'est pas occup$$HEX1$$e900$$ENDHEX$$e                    */
									/*-------------------------------------------------*/
		bProtect = False
		f_commit (SQLCA,TRUE)
		ibOcc = True

	End If


End If


/*---------------------------------------------------------------------*/
/* Protection de toutes les zones et boutons.                          */
/* Je ne peux uniquement proteger les boutons, car des 'itemchanged'   */
/* provoquent des enabled sur le bouton Enregistrer.                   */
/*---------------------------------------------------------------------*/
If bProtect Then

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

	This.Title = "Traitement - Consulattion Table ARTICLE"
Else
	This.Title = "Traitement - Modification Table ARTICLE"
End If




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
//* 
//*-----------------------------------------------------------------

Long					lCpt, lTotLigne, lRet, lRow
DatawindowChild	dwChild, dwChild2	
Datawindow			dwTemp, dwTemp2		

/*---------------------------------------------------*/
/* Initialisation des DDDW des crit$$HEX1$$e800$$ENDHEX$$res de recherche */
/*---------------------------------------------------*/
For lCpt = 1 To ilNbCritere

	If isTabCritere [2,lCpt] = '1' Then
		dwTemp  = dw_trt_critere_marge
		dwTemp2 = dw_1
	Else
		dwTemp = dw_trt_critere
		dwTemp2 = dw_2
	End If

	CHOOSE CASE isTabCritere [5,lCpt]
		
		/*-----------------------------*/
		/* AUCUN PARAMETRE DE RETRIEVE */
		/*-----------------------------*/
		CASE ''
			lRet = dwTemp.GetChild       ( isTabCritere [1,lCpt], dwChild )
			lRet = dwChild.SetTransObject(SQLCA)
			lRet = dwChild.Retrieve      ()

			lRet = dwTemp2.GetChild		 ( isTabCritere [1,lCpt], dwChild2 )
//Migration PB8-WYNIWYG-03/2006 FM
			//lRet = dwChild.Sharedata		 (dwChild2)
			if lRet = 1 then lRet = dwChild.Sharedata		 (dwChild2)
//Fin Migration PB8-WYNIWYG-03/2006 FM


			// [20230307180537933]
			Choose Case isTabCritere [1,lCpt]
				Case "id_marq_art_ifr"
					lRow = dwChild2.InsertRow (2)
					dwChild2.SetItem ( lRow, "MARQUE", "(vide)" )
					
			End Choose 

		/*-----------------------------*/
		/* PAS DE DDDW                 */
		/*-----------------------------*/
		CASE '/\'
			// On ne fait rien
	
		/*-----------------------------*/
		/* RETRIEVE AVEC NOM DE COLONNE*/
		/*-----------------------------*/
		Case Else
			lRet = dwTemp.GetChild       ( isTabCritere [1,lCpt], dwChild )
			lRet = dwChild.SetTransObject(SQLCA)
			lRet = dwChild.Retrieve      (isTabCritere [5,lCpt])

			lRet = dwTemp2.GetChild		 ( isTabCritere [1,lCpt], dwChild2 )
//Migration PB8-WYNIWYG-03/2006 FM
//			lRet = dwChild.Sharedata		 (dwChild2)
			if lRet = 1 then lRet = dwChild.Sharedata		 (dwChild2)
//Fin Migration PB8-WYNIWYG-03/2006 FM
			
	End Choose
		
Next

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
Decimal {2} dcVal

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

private subroutine wf_filtrer_modl_ifr (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_Filtrer_Modl_Ifr (PRIVATE)
//* Auteur			: PLJ
//* Date				: 04/09/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long		alLigne
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------
String 				sVal, sFiltre
DatawindowChild	dwChild


If alLigne > 0 Then

	sVal = dw_2.GetItemString ( alLigne, "ID_MARQ_ART_IFR" )

	dw_2.GetChild ( "ID_MODL_ART_IFR", dwChild )
	
	If isNull (sVal) Or sVal = "" Then 
		sFiltre = "MARQUE = ''" 
	Else 
		sFiltre = "MARQUE = '" + sVal + "'"
	End IF

	dwChild.SetFilter ( sFiltre )
	dwChild.Filter    ()	
	dwChild.Sort      ()

End If

end subroutine

public subroutine wf_interroarticle (long alnumlig, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::Wf_InterroArticle
//* Auteur			: JFF
//* Date				: 10/06/2021
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Protection de la grille en fonction des droits de l'utilisateur
//* Commentaires	: [BTRUN_344_REF_BYGUES]
//*
//* Arguments		: alnumlig
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*     JFF   30/08/2021   [RS972][OPTIM_MB3&4]
//*-----------------------------------------------------------------

String sIdFour, sIdRefFour, sIdModlArt, sObservFrn

If asCas = "INIT" Then 
	st_ModlObserv.Text = ""
	Return
End If 

sIdFour = dw_1.GetItemString ( alnumlig, "ID_FOUR" ) 

// [RS972][OPTIM_MB3&4]
Choose Case sIdFour
	Case "BYG", "BST", "FRE"
		// Ok
	Case Else
		st_ModlObserv.Text = ""
		Return
End CHoose 

sIdRefFour = Trim ( dw_1.GetItemString ( alnumlig, "ID_REF_FOUR" ) )
sIdModlArt = Trim ( dw_1.GetItemString ( alnumlig, "ID_MODL_ART" ) )
sObservFrn = Trim ( dw_1.GetItemString ( alnumlig, "OBSERV_FRN" ) )

sIdModlArt = Left ( sIdModlArt, Len ( sIdModlArt ) - 1 ) // Supprimer le # qui sert $$HEX2$$e0002000$$ENDHEX$$conserver le/les espace(s ) de fin

If IsNull ( sIdRefFour  ) Then sIdRefFour  = ""
If IsNull ( sIdModlArt ) Then sIdModlArt = ""
If IsNull ( sObservFrn ) Then sObservFrn = ""

st_ModlObserv.Text = "[" + sIdRefFour + "] " + sIdModlArt + sObservFrn

	



end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 09/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

//u_DeclarationFuncky 	uoDeclarationFuncky //[I037] Migration FUNCKy
DatawindowChild		dwChild


dw_1.SetTransObject ( SQLCA)
//Migration PB8-WYNIWYG-03/2006 FM
//Il faut r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les donn$$HEX1$$e900$$ENDHEX$$es de la Child avant le partage!!
DataWindowChild	ldwc_1
long	ll_ret
ll_ret = dw_2.GetChild ( "COD_ETAT", ldwc_1 )
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve("-EI")
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.ShareData      ( dw_2 )

/*--------------------------*/
/* Initialisation des DDDW  */
/*--------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//le champ COD_ETAT n'apparait pas, il ne peut y avoir de DDDW dessus...
//ll_ret = dw_1.GetChild ( "CODE_ETAT", dwChild )
//ll_ret = dwChild.SetTransObject(SQLCA)
//ll_ret = dwChild.Retrieve      ()
//Fin Migration PB8-WYNIWYG-03/2006 FM


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
isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )


// _____________________
// Ensemble des crit$$HEX1$$e800$$ENDHEX$$res
// $$HEX21$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00$$ENDHEX$$

// Colonne 1 nom du crit$$HEX1$$e800$$ENDHEX$$re
// Colonne 2 r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la datawindow ( 1:dw_trt_ifr_critere_article_marge 2:dw_trt_ifr_critere_article )
// Colonne 3 type                       ( NUMBER, CHAR, DATE, DATETIME                    )
// Colonne 4 op$$HEX1$$e900$$ENDHEX$$rateur de comparaison   ( =, <=, >=, <, >, pos                            )
// Colonne 5 valeur de retrieve         ( '' pour un retrieve sans valeur   '/\' pas de retrieve de DDDW

isTabCritere = {	'id_four',			'1',	'STRING',	'=',	   '-FR',		  			&
						'id_ref_four',		'2',	'STRING',	'=',		'/\',						&
						'id_typ_art',		'1',	'STRING',	'=',		'-AR',					&
						'id_marq_art',		'1',	'STRING',	'=',		'',						&
						'id_modl_art',		'1',	'STRING',	'POS',	'',						&
						'mt_prix_ht',		'2',	'NUMBER',	'%',		'/\',						&
						'tva',		   	'2',	'NUMBER',	'=',		'/\',						&
						'mt_prix_ttc',		'2',  'NUMBER',   '%',     '/\',						&
						'qt_disp',			'2',	'NUMBER',	'=',		'/\',						&
						'observ_frn',		'2',	'STRING',	'=',		'/\',						&
						'alt_dispo',		'2', 	'STRING',	'=',		'/\',						&
						'id_marq_art_ifr','2',	'STRING',	'=',		'',						&
						'id_modl_art_ifr','2',	'STRING',	'=',		'',						&
						'cod_etat',			'2',	'NUMBER',	'=',		'-EI'							}

ilNbCritere = 14

/*------------------------------------------------------------------*/
/* Ne pas Oublier de redimmensionner le tableau au niveau de la     */
/* d$$HEX1$$e900$$ENDHEX$$claration.                                                     */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event show;call super::show;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 09/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

wf_Preparer_recherche()

/*-----------------------------------------------------------------*/
/* Je charge le max ( maj_le) d'article, pour empecher toute       */
/* modification au cas o$$HEX2$$f9002000$$ENDHEX$$la table aurait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$remise $$HEX2$$e0002000$$ENDHEX$$jour par    */
/* un batch.                                                       */
/* Je fais l'affectation de la variable avant le retrieve au cas   */
/* o$$HEX2$$f9002000$$ENDHEX$$une mise $$HEX2$$e0002000$$ENDHEX$$jour serait faites juste apr$$HEX1$$e800$$ENDHEX$$s le chargement      */
/*-----------------------------------------------------------------*/
If F_CLE_A_TRUE ( "RS6244_FEN_ART" ) Then

	SQLCA.PS_S_MAX_MAJ_LE  ( idtMaxMajLeArticle ) 

Else 
	SELECT Max ( maj_le) INTO :idtMaxMajLeArticle
	  FROM sysadm.article
	 USING SQLCA;
End If 

dw_1.Retrieve ()
dw_1.Setrow   (dw_2.GetRow())

Wf_Filtrer_Modl_Ifr (dw_2.GetRow())

wf_Afficher_Compteur ()
wf_Proteger ()

/*
gWMdi.Width += 1100
gWMdi.Height += 100
*/
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

/*
gWMdi.Width -= 1100
gWMdi.Height -= 100
*/

gWMdi.Width  -= iMdiWidth   // 1100
gWMdi.Height -= iMdiHeigth   // 1100

/*----------------------------------------------------------------------*/
/* Si la personne avait le droit d'$$HEX1$$ea00$$ENDHEX$$tre en modification sur la fen$$HEX1$$ea00$$ENDHEX$$tre  */
/* c'est qu'elle l'avait bloqu$$HEX1$$e900$$ENDHEX$$e lors l'ouverture (wf_proteger) en      */ 
/* ins$$HEX1$$e900$$ENDHEX$$rant une ligne dans parametre, on se charge donc dans ce cas de  */
/* supprimer la ligne.                                                  */
/*----------------------------------------------------------------------*/
If ibOcc = True Then

	sCodParam = 'ART_' + stGlb.sCodOper

	DELETE FROM sysadm.parametre
         WHERE ref_cpt = :sCodParam
		   USING SQLCA;

	f_commit (SQLCA,TRUE)

End IF
end event

on w_trt_sp_ifr_saisie_article.create
int iCurrent
call super::create
this.pb_enregistrer=create pb_enregistrer
this.p_select=create p_select
this.st_information=create st_information
this.dw_trt_critere=create dw_trt_critere
this.dw_2=create dw_2
this.dw_trt_critere_marge=create dw_trt_critere_marge
this.pb_filtrer=create pb_filtrer
this.p_effacer_critere=create p_effacer_critere
this.st_avertissement_monnaie=create st_avertissement_monnaie
this.st_modlobserv=create st_modlobserv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_enregistrer
this.Control[iCurrent+2]=this.p_select
this.Control[iCurrent+3]=this.st_information
this.Control[iCurrent+4]=this.dw_trt_critere
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_trt_critere_marge
this.Control[iCurrent+7]=this.pb_filtrer
this.Control[iCurrent+8]=this.p_effacer_critere
this.Control[iCurrent+9]=this.st_avertissement_monnaie
this.Control[iCurrent+10]=this.st_modlobserv
end on

on w_trt_sp_ifr_saisie_article.destroy
call super::destroy
destroy(this.pb_enregistrer)
destroy(this.p_select)
destroy(this.st_information)
destroy(this.dw_trt_critere)
destroy(this.dw_2)
destroy(this.dw_trt_critere_marge)
destroy(this.pb_filtrer)
destroy(this.p_effacer_critere)
destroy(this.st_avertissement_monnaie)
destroy(this.st_modlobserv)
end on

event open;call super::open;// FPI - 20/05/2016 - Correction tri
dw_1.istri="id_four A, id_marq_art A, id_modl_art A, id_ref_four a"


end event

type cb_debug from w_8_traitement`cb_debug within w_trt_sp_ifr_saisie_article
end type

type dw_1 from w_8_traitement`dw_1 within w_trt_sp_ifr_saisie_article
integer x = 5
integer y = 444
integer width = 1829
integer height = 1184
integer taborder = 70
string dataobject = "d_trt_sp_ifr_saisie_article_marge"
boolean border = false
end type

on dw_1::rowfocuschanged;call w_8_traitement`dw_1::rowfocuschanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_1
//* Evenement 		: RowFocusChanged
//* Auteur			: PLJ
//* Date				: 04/09/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation du rowfocus entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
long 		lCpt, lTot, lPrixMin
String 	sMarque, sRef
lTot = dw_1.RowCount()
boolean 	bOk = True

dw_1.AcceptText()
dw_2.AcceptText()

If pb_enregistrer.enabled = True Then

	dw_2.SetRow ( dw_1.getRow () )
	wf_enregistrer ()

Else

	dw_2.SetRow ( dw_1.getRow () )

End If
end on

event dw_1::scrollvertical;call super::scrollvertical;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_1
//* Evenement 		: ScrollVertical
//* Auteur			: PLJ
//* Date				: 11/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_1.Describe("DataWindow.VerticalScrollPosition")

sMod = "DataWindow.VerticalScrollPosition=" + spos
dw_2.Modify( sMod)
end event

event dw_1::doubleclicked;call super::doubleclicked;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::doubleclicked
//* Auteur			: JFF
//* Date				: 10/06/2021
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Protection de la grille en fonction des droits de l'utilisateur
//* Commentaires	: [BTRUN_344_REF_BYGUES]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


Parent.Wf_InterroArticle ( row, "AFFICHAGE" ) 




end event

type st_titre from w_8_traitement`st_titre within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 2633
integer y = 28
integer width = 229
end type

type pb_retour from w_8_traitement`pb_retour within w_trt_sp_ifr_saisie_article
integer x = 14
integer y = 8
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_valider from w_8_traitement`pb_valider within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 2994
integer y = 92
integer taborder = 90
boolean enabled = false
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 3493
integer y = 92
integer width = 274
integer height = 160
integer taborder = 110
boolean enabled = false
end type

type pb_controler from w_8_traitement`pb_controler within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 2747
integer y = 92
integer taborder = 80
boolean enabled = false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 3241
integer y = 92
integer taborder = 100
boolean enabled = false
end type

type pb_enregistrer from picturebutton within w_trt_sp_ifr_saisie_article
integer x = 270
integer y = 8
integer width = 251
integer height = 136
integer taborder = 50
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

on clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::pb_enregistrer
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 13/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

dw_1.AcceptText ()
dw_2.AcceptText ()

wf_enregistrer  ()
end on

type p_select from picture within w_trt_sp_ifr_saisie_article
boolean visible = false
integer x = 1152
integer y = 1644
integer width = 55
integer height = 44
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\8_verte.bmp"
boolean focusrectangle = false
end type

type st_information from statictext within w_trt_sp_ifr_saisie_article
integer x = 1184
integer y = 1628
integer width = 626
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
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_trt_critere from u_datawindow within w_trt_sp_ifr_saisie_article
integer x = 1833
integer y = 156
integer width = 2638
integer height = 200
integer taborder = 20
string dataobject = "d_trt_sp_ifr_critere_article"
boolean hscrollbar = true
end type

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_2
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 11/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_2 et dw_trt_critere
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = This.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_2.Modify (sMod)
end on

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_trt_critere_marge
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 13/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre de la liste des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences en fonctions de la marque
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sVal, sFiltre, sNull
DatawindowChild	dwChild
sVal = GetText()
SetNull ( sNull )


If This.isNomCol = "ID_MARQ_ART_IFR" Then

	This.GetChild ( "ID_MODL_ART_IFR", dwChild )

	If isNull (sVal) Or sVal = "" Then 
		sFiltre = "" 
	Else 
		sFiltre = "MARQUE = '" + sVal + "'"
	End IF

	dwChild.SetFilter ( sFiltre )
	dwChild.Filter ()	
	dwChild.Sort   ()
	
	This.SetItem ( 1, "ID_MODL_ART_IFR", sNull )
	
End If
end event

type dw_2 from u_datawindow within w_trt_sp_ifr_saisie_article
integer x = 1833
integer y = 444
integer width = 2647
integer height = 1252
integer taborder = 10
string dataobject = "d_trt_sp_ifr_saisie_article"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_2
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 13/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* 			FPI	15/09/2014	[OPTIM_SQL]
//          JFF   20/02/2023  [RS4616_RET_TLS]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

boolean				bOk = True
String 				sVal, sFiltre
DateTime				dtJour
DatawindowChild	dwChild
Long					lLigne

String				sMArqueIfr, sModeleIfr

// [BTRUN_344_REF_BYGUES]
If This.isNomCol = "ID_MODL_ART_IFR" Then
	Parent.Wf_InterroArticle ( row, "INIT" ) 
End IF 

If pb_Enregistrer.Enabled = False Then
	pb_Enregistrer.Enabled = True
End If


sVal = GetText()

lLigne = This.GetRow()

If This.isNomCol = "ID_MARQ_ART_IFR" Then

	// [20230307180537933]
	If Upper ( sVal ) = "(VIDE)" Then
		This.iiErreur = 1
		ll_ret = 1
		bOk = False
	Else 

		This.GetChild ( "ID_MODL_ART_IFR", dwChild )
		
		If isNull (sVal) Or sVal = "" Then 
			sFiltre = ""
			This.SetItem ( lLigne, "ALT_DISPO", 'N' ) 
		Else 
			sFiltre = "MARQUE = '" + sVal + "'"
		End IF
	
		dwChild.SetFilter ( sFiltre )
		dwChild.Filter ()	
		dwChild.Sort   ()
	End If 
End If

If This.isNomCol = "ID_MODL_ART_IFR" Then
	If isNull (sVal) Or sVal = "" Then 
		This.SetItem ( lLigne, "ALT_DISPO", 'N' )
	End If
End If 

If This.isNomCol = "ALT_DISPO" Then

	sMarqueIfr = This.GetItemString ( lLigne, "ID_MARQ_ART_IFR" )
	sModeleIfr = This.GetItemString ( lLigne, "ID_MODL_ART_IFR" )

	If ( isNull ( sMarqueIfr ) Or isNull ( sModeleIfr ) ) And sVal = 'O' Then
		This.iiErreur = 0
//Migration PB8-WYNIWYG-03/2006 FM
//		This.SetActionCode (1)
		ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		bOk = False
	End If

	// [RS4616_RET_TLS]
	If ll_ret = 0 and This.GetItemString ( lLigne, "ID_FOUR" ) = "TLS" Then
		This.iiErreur = 1
		ll_ret = 1
		bOk = False
	End If 		

End If



If bOk Then
	// [OPTIM_SQL]
	dtJour=Datetime( Today(), Now() )
	// :[OPTIM_SQL]
	
	dw_2.SetItem ( lLigne, "MAJ_LE", dtJour 			 )
	dw_2.SetItem ( lLigne, "MAJ_PAR", stGlb.sCodOper )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_2
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 03/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//          JFF   20/02/2023  [RS4616_RET_TLS]
//*-----------------------------------------------------------------

stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
stMessage.Icon			= Information!

stMessage.bErreurG	= TRUE


Choose Case UPPER(isErrCol)
	Case "ALT_DISPO"
		Choose Case iiErreur
			Case 0
				stMessage.sVar[1] = "Disponibilit$$HEX1$$e900$$ENDHEX$$"				
				stMessage.sCode	= "GENE002"
			Case 1 
				// [RS4616_RET_TLS]
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "IFR0112"
		End Choose
		
	Case "ID_MARQ_ART_IFR"
		Choose Case iiErreur
			Case 1 
				stMessage.bErreurG	= FALSE				
				stMessage.sVar[1] = "marque IFR"				
				stMessage.sCode	= "GENE002"
		End Choose 
End Choose

F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//This.Uf_Reinitialiser ()
return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on rowfocuschanged;call u_datawindow::rowfocuschanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_2
//* Evenement 		: RowFocusChanged
//* Auteur			: PLJ
//* Date				: 11/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation du rowfocus entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String 				sVal, sFiltre
DatawindowChild	dwChild
Long					lLigne


dw_1.AcceptText()
dw_2.AcceptText()

If pb_enregistrer.enabled = True Then
	wf_enregistrer ()
End If

dw_1.SetRow ( dw_2.getRow () )


Wf_Filtrer_Modl_Ifr ( This.GetRow() )





end on

on scrollvertical;call u_datawindow::scrollvertical;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_2
//* Evenement 		: ScrollVertical
//* Auteur			: PLJ
//* Date				: 11/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_1 et dw_2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_2.Describe("DataWindow.VerticalScrollPosition")

sMod = "DataWindow.VerticalScrollPosition=" + spos
dw_1.Modify( sMod)
end on

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::dw_2
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 11/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_2 et dw_trt_critere
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_2.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_trt_critere.Modify (sMod)
end on

event doubleclicked;call super::doubleclicked;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Sp_Ifr_Saisie::doubleclicked
//* Auteur			: JFF
//* Date				: 10/06/2021
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Protection de la grille en fonction des droits de l'utilisateur
//* Commentaires	: [BTRUN_344_REF_BYGUES]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


Parent.Wf_InterroArticle ( row, "AFFICHAGE" ) 

end event

type dw_trt_critere_marge from u_datawindow within w_trt_sp_ifr_saisie_article
integer x = 69
integer y = 156
integer width = 1769
integer height = 132
integer taborder = 30
string dataobject = "d_trt_sp_ifr_critere_article_marge"
end type

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::dw_trt_critere_marge
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 13/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre de la liste des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences en fonctions de la marque
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sVal, sFiltre
DatawindowChild	dwChild
sVal = GetText()

If This.isNomCol = "ID_MARQ_ART" Then

	This.GetChild ( "ID_MODL_ART", dwChild )
	
	If isNull (sVal) Or sVal = "" Then 
		sFiltre = "" 
	Else 
		sFiltre = "ID_MARQ_ART = '" + sVal + "'"
	End IF

	dwChild.SetFilter ( sFiltre )
	dwChild.Filter ()	
	dwChild.Sort   ()
End If
end on

type pb_filtrer from picturebutton within w_trt_sp_ifr_saisie_article
integer x = 69
integer y = 296
integer width = 233
integer height = 136
integer taborder = 60
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Filtrer"
string picturename = "k:\pb4obj\bmp\8_filtre.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Article::pb_filtrer
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 30/07/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


Long		lCpt
String	sFiltre,  sAnd

Datawindow			dwTemp		

Decimal	dcCritere
String	sCritere

sAnd = ''

dw_1.AcceptText  ()
dw_2.AcceptText  ()

dw_trt_critere_marge.AcceptText ()
dw_trt_critere.AcceptText       ()


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
		dwTemp = dw_trt_critere_marge
	Else
		dwTemp = dw_trt_critere
	End If



	Choose Case isTabCritere [3,lCpt]
		Case 'STRING'
			sCritere = dwTemp.GetItemString ( 1, isTabCritere [1,lCpt] )
		
			If isTabCritere [1,lCpt] = "poids" Then sCritere = LeftTrim (sCritere)
			If NOT ( isNull ( sCritere) OR sCritere = '' ) Then
				
				sFiltre += sAnd + wf_construire_critere ( isTabCritere [1,lCpt],  isTabCritere [4,lCpt], sCritere, "'" ) 
				sAnd    = " AND "
			End If

		Case 'NUMBER'
			dcCritere = dwTemp.GetItemNumber ( 1, isTabCritere [1,lCpt] )
			If NOT isNull (dcCritere) Then
				sFiltre += sAnd + wf_construire_critere (isTabCritere [1,lCpt],  isTabCritere [4,lCpt], String (dcCritere), "" ) 
				sAnd    = " AND "
			End If	


	End Choose
		
Next

// [20230307180537933]
If Pos ( sFiltre, "id_marq_art_ifr = '(VIDE)'" ) > 0 Then
	sFiltre = F_REMPLACE ( sFiltre, "id_marq_art_ifr = '(VIDE)'", "Not ( trim ( id_marq_art_ifr ) <> '')" )
End If 

dw_1.Setredraw (False)
dw_2.Setredraw (False)

dw_1.ShareDataOff ()

dw_1.SetFilter ( sFiltre )
dw_1.Filter ()


dw_1.ShareData (dw_2)


dw_1.Setredraw (True)
dw_2.Setredraw (True)


wf_Afficher_Compteur ()

end event

type p_effacer_critere from picture within w_trt_sp_ifr_saisie_article
integer x = 270
integer y = 304
integer width = 206
integer height = 112
string picturename = "k:\pb4obj\bmp\8_gomme.bmp"
boolean focusrectangle = false
end type

on clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie::p_effacer_critere
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 10/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
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


NExt

end on

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_trt_sp_ifr_saisie_article
integer x = 549
integer y = 32
integer width = 1161
boolean bringtotop = true
string text = "Les montant sont exprim$$HEX1$$e900$$ENDHEX$$s en "
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
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

type st_modlobserv from statictext within w_trt_sp_ifr_saisie_article
integer x = 494
integer y = 368
integer width = 3973
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

