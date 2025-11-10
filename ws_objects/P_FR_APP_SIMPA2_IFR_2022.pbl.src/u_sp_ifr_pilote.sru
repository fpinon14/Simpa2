HA$PBExportHeader$u_sp_ifr_pilote.sru
$PBExportComments$modify
forward
global type u_sp_ifr_pilote from userobject
end type
type cb_fiche_tech from commandbutton within u_sp_ifr_pilote
end type
type dw_trt_consult from u_datawindow within u_sp_ifr_pilote
end type
type st_1 from statictext within u_sp_ifr_pilote
end type
type st_titre from statictext within u_sp_ifr_pilote
end type
type st_legende from statictext within u_sp_ifr_pilote
end type
type dw_stk_code_equivalence from datawindow within u_sp_ifr_pilote
end type
type st_vetuste from statictext within u_sp_ifr_pilote
end type
type dw_trt_critere_marge from u_datawindow within u_sp_ifr_pilote
end type
type dw_trt_critere_chk_box from u_datawindow within u_sp_ifr_pilote
end type
type dw_trt_consult_marge from u_datawindow within u_sp_ifr_pilote
end type
type p_effacer_critere from picture within u_sp_ifr_pilote
end type
type dw_trt_critere from u_datawindow within u_sp_ifr_pilote
end type
end forward

global type u_sp_ifr_pilote from userobject
integer width = 3557
integer height = 1476
boolean border = true
long backcolor = 12632256
event ue_cocher pbm_custom75
event ue_mousse pbm_mousemove
cb_fiche_tech cb_fiche_tech
dw_trt_consult dw_trt_consult
st_1 st_1
st_titre st_titre
st_legende st_legende
dw_stk_code_equivalence dw_stk_code_equivalence
st_vetuste st_vetuste
dw_trt_critere_marge dw_trt_critere_marge
dw_trt_critere_chk_box dw_trt_critere_chk_box
dw_trt_consult_marge dw_trt_consult_marge
p_effacer_critere p_effacer_critere
dw_trt_critere dw_trt_critere
end type
global u_sp_ifr_pilote u_sp_ifr_pilote

type variables
String isFiltre=""
String isFiltreInit=""
String	isTabCritere [4,29]     // contient le nom des colonnes
Long	ilNbCritere

decimal{4} idcTauxPoids=0.1
end variables

forward prototypes
private subroutine uf_filtrer ()
public subroutine uf_initialiser (ref datawindow adwstkifr, ref datawindow adwstklibelle)
public subroutine uf_activer_affrech (boolean abok)
public subroutine uf_filtrerdwrech ()
private subroutine uf_afficher_legende (datawindow asdwsource)
public function boolean uf_filtrer_init ()
private function decimal uf_calculervetuste (decimal adcmontantorigine)
private subroutine uf_decocher ()
public subroutine uf_preparer (string asidaction, string asidmarque, string asidreference, decimal adcvalachat)
public function boolean uf_set_altvisible (long alligne, character acval, decimal adcmtprixfrn)
public function decimal uf_get_frequence_sinistre ()
public function string uf_getcommande_pdf (string asnomfic)
end prototypes

on ue_mousse;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

// On fait disparaitre le st_legende
st_legende.Visible = False
end on

private subroutine uf_filtrer ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_filtrer (Private)
//* Auteur			: PLJ
//* Date				: 21/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette m$$HEX1$$e900$$ENDHEX$$thode est priv$$HEX1$$e900$$ENDHEX$$e elle n'est appel$$HEX2$$e9002000$$ENDHEX$$que sur 
//*					  sur un itemchanged de dw_trt_critere_chk_box 
//*					  (cad lorsque l'on coche ou d$$HEX1$$e900$$ENDHEX$$coche une case des csrit$$HEX1$$e800$$ENDHEX$$res)
//*                 la fonction publique elle s'appelle uf_FiltrerDwRech()
//* Arguments		: 
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 		FPI	21/04/2011	[PM82.Lot3] - Changement du crit$$HEX1$$e800$$ENDHEX$$re poids en pixels
//*-----------------------------------------------------------------

Long			lCpt, lTot, lRet
String 		sVal
Decimal{2}  dcVal

isFiltre = ""

uf_Activer_AffRech(False)

/*-----------------------------------------------------------*/
/* Suprression du filtre sur la liste des enregistrements IFR*/
/* On remets tous les Alt_visible de toutes les lignes $$HEX2$$e0002000$$ENDHEX$$'N' */
/*-----------------------------------------------------------*/

lret = dw_trt_consult_marge.SetFilter ( "" )
lret = dw_trt_consult_marge.Filter ()

lTot = dw_trt_consult_marge.RowCount()

For lCpt = 1 To lTot
	dw_trt_consult_marge.SetItem ( lCpt, "ALT_VISIBLE", 'N' )
Next


/*----------------------------------------------------------*/
/* Constitution de la chaine de filtre suivant les cases    */
/* coch$$HEX1$$e900$$ENDHEX$$es. Le prix fait toujours partie des crit$$HEX1$$e800$$ENDHEX$$res de    */
/* filtre.                                                  */
/*----------------------------------------------------------*/
isFiltre = ""

For lCpt = 9 To ilNbCritere

	If istabcritere[2,lCpt] = 'O' Then

		sVal = dw_trt_critere_marge.GetItemString ( 1, istabcritere[1,lCpt] )
		
		// [PM82.Lot3] - Changement du crit$$HEX1$$e800$$ENDHEX$$re poids en pixels
		/*If istabcritere[1,lCpt] = 'poids' Then
			dcVal=Dec(sVal)
			isFiltre += " AND Number(" + istabcritere[1,lCpt] + ")>"+ String( dcVal * (1 - idcTauxPoids) ) + &
							" AND Number(" + istabcritere[1,lCpt] + ")<"+ String( dcVal * (1 + idcTauxPoids) ) 
		Else*/
			If isNull (sVal) Then
				isFiltre += " AND isNull(" + istabcritere[1,lCpt] + ")"
			Else
				isFiltre += " AND " + istabcritere[1,lCpt] + "='"+ sVal + "'"
			End If
//		End If

	End If

Next


/*-----------------------------------------------------------------*/
/* Dans le cas o$$HEX2$$f9002000$$ENDHEX$$des cases ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$coch$$HEX1$$e900$$ENDHEX$$e, on ajoute au filtre    */
/* obligatoirement un crit$$HEX1$$e800$$ENDHEX$$re de prix.                             */
/* Dans les autres cas la datawindow de recherche devra $$HEX1$$ea00$$ENDHEX$$tre vide  */
/* (pour cela j'utilise un crit$$HEX1$$e800$$ENDHEX$$re impossible ==> ALT_VISIBLE ='O' */
/*  en effet ils sont tous positionn$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$'N' au d$$HEX1$$e900$$ENDHEX$$but de cette     */
/*  m$$HEX1$$e900$$ENDHEX$$thode )                                                      */
/* J'ajoute volontairement le crit$$HEX1$$e800$$ENDHEX$$re de prix en premi$$HEX1$$e800$$ENDHEX$$re position */
/* pour ne pas g$$HEX1$$e900$$ENDHEX$$rer le AND des crit$$HEX1$$e800$$ENDHEX$$res de cases $$HEX2$$e0002000$$ENDHEX$$cocher         */
/*-----------------------------------------------------------------*/

If isFiltre <> "" Then
	dcVal = dw_trt_critere_marge.GetItemNumber ( 1, istabcritere[1,6] )
	isFiltre = istabcritere[1,6] + "<="+ String (dcVal) + isFiltre + &
				  " AND ( marque <> '"    + dw_trt_critere_marge.GetItemSTRING ( 1,"MARQUE" )    + "'" + &
				  " OR reference <> '" + dw_trt_critere_marge.GetItemString ( 1,"REFERENCE" ) + "')"
Else
	isFiltre = "ALT_VISIBLE='O'"
End If


dw_trt_consult_marge.SetFilter ( isFiltre )
dw_trt_consult_marge.Filter ()

lTot = dw_trt_consult_marge.RowCount()
For lCpt = 1 To lTot
	dw_trt_consult_marge.SetItem ( lCpt, "ALT_VISIBLE", 'O' )
Next



end subroutine

public subroutine uf_initialiser (ref datawindow adwstkifr, ref datawindow adwstklibelle);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_initialiser (Public)
//* Auteur			: PLJ
//* Date				: 21/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Datawindow	adwStkIfr	Datawindw contenant les lignes disctintes de la table IFR
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


/*-----------------------------------------------------------------------*/
/* Initialisation des datawindows de l'objet                             */
/*-----------------------------------------------------------------------*/
adwStkIfr.ShareData     ( dw_Trt_Consult_Marge   )
//Migration PB8-WYNIWYG-03/2006 OR
DataWindowChild	ldwc_1
long	ll_ret
ll_ret = dw_trt_consult.GetChild('battsupl', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('battsupl')

ll_ret = dw_trt_consult.GetChild('voxfunc', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('voxfunc')

ll_ret = dw_trt_consult.GetChild('scrncol', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('scrncol')

ll_ret = dw_trt_consult.GetChild('infred', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('infred')

ll_ret = dw_trt_consult.GetChild('wireless', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('wireless')

ll_ret = dw_trt_consult.GetChild('modem', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('modem')

ll_ret = dw_trt_consult.GetChild('digicam', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('digicam')

ll_ret = dw_trt_consult.GetChild('mp3wma', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('mp3wma')

ll_ret = dw_trt_consult.GetChild('systeme', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('systeme')

ll_ret = dw_trt_consult.GetChild('commstnd', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('commstnd')

ll_ret = dw_trt_consult.GetChild('webconn', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('webconn')

ll_ret = dw_trt_consult.GetChild('java', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('java')

ll_ret = dw_trt_consult.GetChild('talktime', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('talktime')

ll_ret = dw_trt_consult.GetChild('message', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('message')

ll_ret = dw_trt_consult.GetChild('stndby', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('stndby')

ll_ret = dw_trt_consult.GetChild('commpaym', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('commpaym')

ll_ret = dw_trt_consult.GetChild('provider', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('provider')

ll_ret = dw_trt_consult.GetChild('packtype', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('packtype')

ll_ret = dw_trt_consult.GetChild('gps', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('gps')

ll_ret = dw_trt_consult.GetChild('mep', ldwc_1)
ll_ret = ldwc_1.SetTransObject(SQLCA)
ll_ret = ldwc_1.Retrieve('mep')
//Fin Migration PB8-WYNIWYG-03/2006 OR
adwStkIfr.ShareData     ( dw_Trt_Consult         )
adwstklibelle.ShareData (dw_stk_code_equivalence )

dw_trt_critere_marge.ShareData ( dw_Trt_Critere )

/*-----------------------------------------------------------------------*/
/* Initialisation des crit$$HEX1$$e800$$ENDHEX$$res de s$$HEX1$$e900$$ENDHEX$$lection										 */
/* Correspond aux colonnes sur lesquelles il faudra effectuer un filtre  */
/* - La premiere colonne donne le nom de la "colonne" dans la datawindow */
/*   cad le nom permettant de faire le getitem.                          */
/* - La deuxi$$HEX1$$e800$$ENDHEX$$me colonne stock le fait que la colonne soit coch$$HEX1$$e900$$ENDHEX$$e ou non */
/* - La troisi$$HEX1$$e800$$ENDHEX$$me colonne contient le type pour d'$$HEX1$$e900$$ENDHEX$$ventuel GetItem       */
/* - La Quatri$$HEX1$$e800$$ENDHEX$$me colonne pr$$HEX1$$e900$$ENDHEX$$cise s'il faut g$$HEX1$$e900$$ENDHEX$$rer ou non l'affichage     */
/*   d'une l$$HEX1$$e900$$ENDHEX$$gende                                                       */
/*-----------------------------------------------------------------------*/




isTabCritere = {	'id_trait',		'N',  'NUMBER',	'N',	&
						'marque',		'N',	'STRING',	'N',	&
						'reference',	'N',	'STRING',	'N',	&
						'provenance',	'N',	'STRING',	'N',	&
						'centrales',	'N',	'STRING',	'N',  &
						'frequence',	'O',	'NUMBER',	'O',	&
						'prix_haut',	'N',	'NUMBER',	'O',	&
						'prix_bas',		'N',	'NUMBER',	'O',	&
						'poids',		 	'N',	'STRING',	'O',	&
						'battsupl',		'N',	'STRING',	'O',	&
						'voxfunc',		'N',	'STRING',	'O',	&
						'scrncol',		'N',	'STRING',	'O',	&
						'infred',		'N',	'STRING',	'O',	&
						'wireless',		'N',	'STRING',	'O',	&
						'modem',			'N',	'STRING',	'O',	&
						'digicam',		'N',	'STRING',	'O',	&
						'mp3wma',		'N',	'STRING',	'O',	&
						'systeme',		'N',	'STRING',	'O',	&
						'commstnd',		'N',	'STRING',	'O',	&
						'webconn',		'N',	'STRING',	'O',	&
						'java',			'N',	'STRING',	'O',	&
						'talktime',		'N',	'STRING',	'O',	&
						'message',		'N',	'STRING',	'O',	&
						'stndby',		'N',	'STRING',	'O',	&
						'commpaym', 	'N',	'STRING',	'O',	&
						'provider',		'N',	'STRING',	'O',	&
						'packtype',		'N',	'STRING',	'O',	&
						'gps', 			'N',	'STRING',	'O',	&
						'mep', 			'N',	'STRING',	'O'			}


ilNbCritere = 29

dw_trt_consult.uf_Activer_Menu         (False)
dw_trt_consult_marge.uf_Activer_Menu   (False)
dw_trt_critere.uf_Activer_Menu         (False)
dw_trt_critere_chk_box.uf_Activer_Menu (False)
dw_trt_critere_marge.uf_Activer_Menu   (False)
end subroutine

public subroutine uf_activer_affrech (boolean abok);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_Activer_AffRech (Public)
//* Auteur			: PLJ
//* Date				: 22/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: abOk true  on raffraichit les dw
//*							 false on fige        les dw
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

If abOk = True Then
	dw_trt_consult_marge.Sort ()
End If

dw_trt_consult_marge.SetRedraw (abOk)
dw_trt_consult.SetRedraw (abOk)

end subroutine

public subroutine uf_filtrerdwrech ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_FiltrerDwRech (Public)
//* Auteur			: PLJ
//* Date				: 22/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ajoute au filtre isFiltre les colonnes qui ont pu 
//*					  $$HEX1$$ea00$$ENDHEX$$tre laiss$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$'O' par la fonction uf_Set_Alt_Valide 
//*
//* Arguments		: 
//*						
//*
//* Retourne		: 
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

String sFiltre
sFiltre = isFiltre + " AND alt_visible = 'O'"

dw_trt_consult_marge.SetFilter ( sFiltre )
dw_trt_consult_marge.Filter    ()
end subroutine

private subroutine uf_afficher_legende (datawindow asdwsource);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_Afficher_legende (Public)
//* Auteur			: PLJ
//* Date				: 21/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Datawindow	adwsource  Datawindow ayant d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$le ue_mousse
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


String	sObjet, sObjetMouse, sRecherche, sLIbelle, sValCol, sTypeCol, sTextEtiquette 
Long		lPos, lTot, lLigne, lLigneMouse, lOrdreCodeSource


sObjet  = asdwsource.GetObjectAtPointer()


/*------------------------------------------------------------*/
/* Si nous ne sommes pas sur un objet valide de la datawindow */
/* On rend invisible st_Legende et rien d'autre               */
/*------------------------------------------------------------*/
If sObjet = "" Then
	st_Legende.visible = False
	Return
End If

/*----------------------------------------------------------------------*/
/* La m$$HEX1$$e900$$ENDHEX$$thode GetObjectAtPointer retourne une chaine de caract$$HEX1$$e800$$ENDHEX$$re       */
/* Constitu$$HEX2$$e9002000$$ENDHEX$$du nom de l'objet + tabulation (CHAR(9)) + num$$HEX1$$e900$$ENDHEX$$ro de ligne */
/* Premi$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e900$$ENDHEX$$tape je d$$HEX1$$e900$$ENDHEX$$compose la chaine en deux pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les deux*/
/* informations                                                         */
/*----------------------------------------------------------------------*/
lPos = POS ( sObjet, char(9) )

If lPos < 1 Then
	st_Legende.visible = False 		// normalement ce test ne sera jamais v$$HEX1$$e900$$ENDHEX$$rifier
	Return 									// car on est pass$$HEX2$$e9002000$$ENDHEX$$par sObjet = "" avant (ci-dessus)
End If


// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration nom de colonne
sObjetMouse = Left ( sObjet, lpos - 1 )

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration num$$HEX1$$e900$$ENDHEX$$ro de ligne
lLigneMouse = Long ( Mid (sObjet, lPos+1) )


/*----------------------------------------------------------------------*/
/* Traitement des objets actifs                                         */
/*----------------------------------------------------------------------*/

lTot   = dw_stk_code_equivalence.RowCount()	

/*----------------------------------------------------------------------*/
/* Nous sommes sur une etiquette                                        */
/* $$HEX69$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* /!\ Le nom des $$HEX1$$e900$$ENDHEX$$tiquette de la dawindow doit toujours s'$$HEX1$$e900$$ENDHEX$$crire:      */
/* t_ + nom de la colonne $$HEX2$$e0002000$$ENDHEX$$la quelle l'$$HEX1$$e900$$ENDHEX$$tiquette de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e800$$ENDHEX$$re             */
/*----------------------------------------------------------------------*/
If	UPPER (left ( sObjet,2 )) = 'T_' Then

		
		/*---------------------------------------------------------*/
		/* Recherche de l'$$HEX1$$e900$$ENDHEX$$tiquette dans la table code $$HEX1$$e900$$ENDHEX$$quivalence */ 
		/*---------------------------------------------------------*/
		sObjetMouse = Mid ( sObjetmouse, 3)
		sRecherche = "ID_COL='" + UPPER (sObjetMouse) + "' AND id_val='-1'"
		lLigne = dw_stk_code_equivalence.Find ( sRecherche, 1, lTot )

		
		If lLigne > 0 Then
			/*---------------------------------------------------------*/
			/* Gere-t-on l'affichage de la l$$HEX1$$e900$$ENDHEX$$gende                     */
			/*---------------------------------------------------------*/
			lOrdreCodeSource = dw_stk_code_equivalence.GetItemNumber ( lLigne, "ORDRE_COL_SOURCE" )
			If istabcritere [4,lOrdreCodeSource] = 'O' Then
				sLibelle = dw_stk_code_equivalence.GetItemString ( lLigne, "LIB_COL" )
				st_Legende.Text = sLibelle
				st_Legende.visible = True
			End If
		End IF

/*----------------------------------------------------------------------*/
/* Nous sommes sur une colonne                                          */
/* $$HEX69$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* Il faut rechercher la signification de la valeur d'une colonne       */
/*----------------------------------------------------------------------*/
ELSE
			
		/*---------------------------------------------------------*/
		/* Recherche de la colonne dans la table code $$HEX1$$e900$$ENDHEX$$quivalence  */ 
		/*---------------------------------------------------------*/
		sRecherche = "ID_COL='" + UPPER (sObjetMouse) + "' AND id_val='-1'"
		lLigne = dw_stk_code_equivalence.Find ( sRecherche, 1, lTot )

		If lLigne > 0 Then
			/*---------------------------------------------------------*/
			/* Gere-t-on l'affichage de la l$$HEX1$$e900$$ENDHEX$$gende                     */
			/*---------------------------------------------------------*/
			lOrdreCodeSource = dw_stk_code_equivalence.GetItemNumber ( lLigne, "ORDRE_COL_SOURCE" )
	
			If istabcritere [4,lOrdreCodeSource] = 'O' Then

				sTextEtiquette = dw_stk_code_equivalence.GetItemString ( lLigne, "LIB_COL" )


				/*-------------------------------------------------------------*/
				/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du type de la colonne pour effectuer un getitem*/
      	   /* de la valeur.                                               */
	        	/* M$$HEX1$$ea00$$ENDHEX$$me si pour le moment je n'ai que des types string sur les */
	         /* colonnes o$$HEX2$$f9002000$$ENDHEX$$je suis susceptible de faire un getitem.        */
	         /* je me sers du tableau d'instance istabcritere[] pour        */
	         /* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le type, et savoir s'il faut faire appara$$HEX1$$ee00$$ENDHEX$$tre une */
	         /* une l$$HEX1$$e900$$ENDHEX$$gende ou non.                                         */
	         /* La valeur ordre_col_source de table code_$$HEX1$$e900$$ENDHEX$$quivalence doit   */
	         /* correspondre $$HEX2$$e0002000$$ENDHEX$$l'indice du tableau istabcritere[]           */
				/*-------------------------------------------------------------*/
				sTypeCol = istabcritere [3,lOrdreCodeSource] 

				Choose Case sTypeCol
					Case "STRING"
						sValCol = asdwsource.GetItemString ( lLigneMouse, sObjetMouse )
					Case "NUMBER"
						sValCol = String ( asdwsource.GetItemNumber ( lLigneMouse, sObjetMouse ) )
				End Choose

				sRecherche = "ID_COL='" + UPPER (sObjetMouse) + "' AND id_val='" + sValCol +"'"

				lLigne = dw_stk_code_equivalence.Find ( sRecherche, 1, lTot )
				If lLigne > 0 Then
					sLibelle = dw_stk_code_equivalence.GetItemString ( lLigne, "LIB_VAL" )
					st_Legende.Text = sTextEtiquette + "~n~r" + sLibelle
					st_Legende.visible = True
				End If

			End If

		End If
		

End If
end subroutine

public function boolean uf_filtrer_init ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_filtrer_init (Public)
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Replace le filtre initial sur la datawindow de stockage IFR
//*
//* Arguments		: 
//*
//* Retourne		: Booleen
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

dw_trt_consult_marge.SetFilter ( isFiltreInit  )
dw_trt_consult_marge.Filter ()

Return True

end function

private function decimal uf_calculervetuste (decimal adcmontantorigine);

Decimal{4} dcMontantNouveau, dcVetuste

dcMontantNouveau = dw_trt_critere.GetItemNumber (1, "Frequence" )

If adcMontantOrigine = 0 Then
	dcVetuste = 0
Else
	dcVetuste = 1 - dcMontantNouveau / adcMontantOrigine 
End If

return dcVetuste
end function

private subroutine uf_decocher ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_decocher (Private)
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$coche toutes les cases des crit$$HEX1$$e800$$ENDHEX$$res de recherche
//*
//* Arguments		:  
//*						
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------
long	lCpt


/*-----------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$coche toutes les case de la dw de critere                  */
/*-----------------------------------------------------------------*/
For lCpt = 9 To ilNbCritere
	dw_trt_critere_chk_box.SetItem ( 1, istabcritere[1,lCpt], 'N' )
	istabcritere[2,lCpt] = 'N'
Next

/*-----------------------------------------------------------------*/
/* J'appelle la m$$HEX1$$e900$$ENDHEX$$thode uf_filter pour vider compl$$HEX1$$e800$$ENDHEX$$tement la dw de */
/* de r$$HEX1$$e900$$ENDHEX$$sultat, en effet $$HEX2$$e0002000$$ENDHEX$$ce stade aucune case n'est coch$$HEX1$$e900$$ENDHEX$$e       */
/*-----------------------------------------------------------------*/
uf_Filtrer ()
end subroutine

public subroutine uf_preparer (string asidaction, string asidmarque, string asidreference, decimal adcvalachat);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_preparer (Public)
//* Auteur			: PLJ
//* Date				: 21/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		:  String		asIdAction
//*						String		asIdMarque
//*						String		asIdReference
//*						Decimal		adcValAchat
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF    18/12/07 [O2M] ajout Type EDI (I)
//*-----------------------------------------------------------------
long	lLigne, lTot, lRet, lCpt
Decimal{4} dcTaux

/*-----------------------------------------------------------------------*/
/* Gestion de l'affichage de l'objet selon l'IdAction                    */
/*                                                                       */
/* C  Commande                                                           */
/* S  S$$HEX1$$e900$$ENDHEX$$lection                                                          */
/* R  R$$HEX1$$e900$$ENDHEX$$paration                                                         */
/* CS Consultation                                                       */
/*                                                                       */
/* Les diff$$HEX1$$e900$$ENDHEX$$rents objets se chevauchant, il est important de conserver   */
/* l'ordre d'apparition                                                  */
/*    __________________________________________________________________ */
/*    p_effacer_critere doit se situer en dessous dw_trt_critere_chk_box */
/*    dw_Trt_Critere    doit se situer en dessous dw_trt_critere_chk_box */
/*    $$HEX67$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af002000$$ENDHEX$$*/
/*-----------------------------------------------------------------------*/
Choose Case asIdAction
	Case 'R', 'I'  // #1
		p_effacer_critere.visible        = False						

	   dw_Trt_critere_marge.visible     = True
		dw_Trt_Critere.visible           = True
		dw_trt_critere_chk_box.Visible 	= False

		dw_trt_consult.Visible 				= False
		dw_trt_consult_marge.Visible 		= False

		st_Titre.Text 							= "Caract$$HEX1$$e900$$ENDHEX$$ristique du mobile sinistr$$HEX1$$e900$$ENDHEX$$"
		st_legende.y							= 305
		//st_vetuste.Visible               = True

		this.Height								= 435

		
	Case 'S', 'C'
		p_effacer_critere.visible        = True						

	   dw_Trt_critere_marge.visible     = True
		dw_Trt_Critere.visible           = True
		dw_trt_critere_chk_box.Visible 	= True

		dw_trt_consult.Visible 				= True
		dw_trt_consult_marge.Visible 		= True

		st_Titre.Text 							= "Choix des crit$$HEX1$$e800$$ENDHEX$$res d'$$HEX1$$e900$$ENDHEX$$quivalences fonctionnelles"
		st_legende.y							= 373
		//st_vetuste.Visible               = True

		this.Height								= 1444


	Case 'CS'
		p_effacer_critere.visible        = True						

	   dw_Trt_critere_marge.visible     = True
		dw_Trt_Critere.visible           = True
		dw_trt_critere_chk_box.Visible 	= True

		dw_trt_consult.Visible 				= True
		dw_trt_consult_marge.Visible 		= True

		st_Titre.Text 							= "Consultation des $$HEX1$$e900$$ENDHEX$$quivalences"
		
		st_legende.y							= 373
		//st_vetuste.Visible               = False

		this.Height								= 1444
	
End Choose


/*-----------------------------------------------------------------------*/
/* Stockage du filtre initiale de adwStkIfr, pour le remettre $$HEX2$$e0002000$$ENDHEX$$la       */
/* demande par l'appel de la m$$HEX1$$e900$$ENDHEX$$thode uf_filtrer_init                     */
/*-----------------------------------------------------------------------*/
isFiltreInit = dw_trt_consult.Describe ("DataWindow.Table.Filter")
If isFiltreInit = "?" Then isFiltreInit = ""


/*-------------------------------------------------------------------*/
/* La Marque et Mod$$HEX1$$e800$$ENDHEX$$le pass$$HEX1$$e900$$ENDHEX$$s en arguments correspondent au portable */
/* actuel du client.                                                 */
/* Je le recherche dans la table IFR pour l'affecter aux datawindows */
/* de crit$$HEX1$$e800$$ENDHEX$$re (partie haute)                                         */
/*-------------------------------------------------------------------*/
lTot   = dw_Trt_Consult_Marge.RowCount()
lLigne = dw_trt_consult_marge.Find ( "marque='"+ asidmarque + "' AND reference= '" + asidreference + "'", 1, lTot )

If lLigne > 0 Then
	dw_Trt_Critere_Marge.Reset ()
	lRet = dw_Trt_Consult_Marge.RowsCopy ( lLigne, lLigne, Primary!, dw_Trt_Critere_Marge, 2, Primary! )
	dw_trt_critere_chk_box.Reset()
	dw_trt_critere_chk_box.InsertRow(0)
Else

	stMessage.sTitre	= "Equivalence Fonctionnelle"
	stMessage.Icon		= Exclamation!
	stMessage.sCode	= "IFR0090"
	stMessage.sVar[1] = asIdreference
	stMessage.sVar[2] = asIdMarque
	
	F_Message ( stMessage )

	p_effacer_critere.visible        = False						// Doit $$HEX1$$ea00$$ENDHEX$$tre effectu$$HEX2$$e9002000$$ENDHEX$$en premier pour se trouver en dessous
	dw_trt_consult.Visible 				= False
	dw_trt_consult_marge.Visible 		= False
	dw_trt_critere_chk_box.Visible 	= False
	dw_trt_critere.Visible 				= False
	dw_trt_critere_marge.Visible 		= False
//	st_vetuste.Visible               = False
	Return

End If

/*-----------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$coche toutes les case de la dw de critere                  */
/*-----------------------------------------------------------------*/
uf_decocher ()


/*-----------------------------------------------------------------------*/
/* Calcul de la vetust$$HEX51$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/*-----------------------------------------------------------------------*/
//dcTaux = uf_CalculerVetuste ( adcValAchat )
//If dcTaux < 0 Then
//	st_Vetuste.Text = "Vetust$$HEX2$$e9002000$$ENDHEX$$incalculable"
//Else
//	st_Vetuste.Text = "Vetust$$HEX2$$e9002000$$ENDHEX$$mobile sinistr$$HEX2$$e9002000$$ENDHEX$$: " + String (dcTaux*100.00, "#0.00") + " %"
//End If


uf_Activer_AffRech(True)





end subroutine

public function boolean uf_set_altvisible (long alligne, character acval, decimal adcmtprixfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_Set_AltVisible (Public)
//* Auteur			: PLJ
//* Date				: 22/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionne $$HEX2$$e0002000$$ENDHEX$$'N' ou 'O' les lignes de la liste IFR
//*					  Pour $$HEX1$$ea00$$ENDHEX$$tre filtr$$HEX1$$e900$$ENDHEX$$es ensuite par uf_FiltrerDwRech () 
//*
//* Arguments		: Long		alLigne
//*					  Character acVal	
//*						
//*
//* Retourne		: Boolean
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lTot

acVal = Upper (acVal)

/*----------------------------------------------------------------------*/
/* On n'autorise que le parametre O ou N dans alt_visible               */
/*----------------------------------------------------------------------*/
If acVal <> 'O' AND acVal <> 'N' Then
	return False
End IF


/*----------------------------------------------------------------------*/
/* la ligne $$HEX2$$e0002000$$ENDHEX$$modifier doit $$HEX1$$ea00$$ENDHEX$$tre inf$$HEX1$$e900$$ENDHEX$$rieure                             */
/* au nombre total de ligne de la liste IFR                             */
/*----------------------------------------------------------------------*/
lTot = dw_trt_consult_marge.RowCount()
If alLigne > lTot Then
	Return False
End If


If alLigne = -1 Then
	/*------------------------------------------------*/
	/* Affectation de la valeur sur toutes les lignes */
	/*------------------------------------------------*/
	For lCpt = 1 To lTot
		dw_trt_consult_marge.SetItem ( lCpt, "ALT_VISIBLE", acVal )
		dw_trt_consult_marge.SetItem ( lCpt, "MT_PRIX_FRN", adcmtprixfrn )
	Next
	Return True
Else
	/*-----------------------------------------------*/
	/* Affectation de la valeur la ligne alLigne     */
	/*-----------------------------------------------*/
	dw_trt_consult_marge.SetItem ( alLigne, "ALT_VISIBLE", acVal )
	dw_trt_consult_marge.SetItem ( alLigne, "MT_PRIX_FRN", adcMtPrixFrn )
End If

Return True



end function

public function decimal uf_get_frequence_sinistre ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_get_Frequence_Sinistre (Public)
//* Auteur			: PLJ
//* Date				: 27/12/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*					  
//*
//* Arguments		:
//*					 
//*						
//*
//* Retourne		: Decimal
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------


Decimal {2} dcFreqence

If dw_trt_critere.RowCount() = 1 Then
	dcFreqence = dw_trt_critere.GetItemNumber ( 1, "FREQUENCE" )
Else
	dcFreqence = -1
End If	

Return dcFreqence 

end function

public function string uf_getcommande_pdf (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_pilote::uf_getcommande_pdf
//* Auteur			: F. Pinon
//* Date				: 13/08/2009 14:45:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP090458]
//*
//* Arguments		: value string asnomfic	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sRet

String		sClassePdf, sCommand 
n_cst_string 	nvstring		

// classe de fichier non d$$HEX1$$e900$$ENDHEX$$fini, on renvoie ""
if RegistryGet("HKEY_CLASSES_ROOT\.pdf", "", sClassePdf) = -1 Then return ""

// commande d'ouverture de fichier non d$$HEX1$$e900$$ENDHEX$$fini, on renvoie ""
if RegistryGet("HKEY_CLASSES_ROOT\"+sClassePdf + "\shell\open\command", "", sCommand) = -1 Then return ""

sRet= nvstring.of_globalreplace(sCommand, "%1", "~"" + asNomFic + "~"")

Return sRet
end function

on u_sp_ifr_pilote.create
this.cb_fiche_tech=create cb_fiche_tech
this.dw_trt_consult=create dw_trt_consult
this.st_1=create st_1
this.st_titre=create st_titre
this.st_legende=create st_legende
this.dw_stk_code_equivalence=create dw_stk_code_equivalence
this.st_vetuste=create st_vetuste
this.dw_trt_critere_marge=create dw_trt_critere_marge
this.dw_trt_critere_chk_box=create dw_trt_critere_chk_box
this.dw_trt_consult_marge=create dw_trt_consult_marge
this.p_effacer_critere=create p_effacer_critere
this.dw_trt_critere=create dw_trt_critere
this.Control[]={this.cb_fiche_tech,&
this.dw_trt_consult,&
this.st_1,&
this.st_titre,&
this.st_legende,&
this.dw_stk_code_equivalence,&
this.st_vetuste,&
this.dw_trt_critere_marge,&
this.dw_trt_critere_chk_box,&
this.dw_trt_consult_marge,&
this.p_effacer_critere,&
this.dw_trt_critere}
end on

on u_sp_ifr_pilote.destroy
destroy(this.cb_fiche_tech)
destroy(this.dw_trt_consult)
destroy(this.st_1)
destroy(this.st_titre)
destroy(this.st_legende)
destroy(this.dw_stk_code_equivalence)
destroy(this.st_vetuste)
destroy(this.dw_trt_critere_marge)
destroy(this.dw_trt_critere_chk_box)
destroy(this.dw_trt_consult_marge)
destroy(this.p_effacer_critere)
destroy(this.dw_trt_critere)
end on

type cb_fiche_tech from commandbutton within u_sp_ifr_pilote
integer x = 69
integer y = 308
integer width = 466
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fiche technique"
end type

event clicked;String sMarque, sReference
dwobject dwoNull

SetNull(dwoNull)

sMarque    = dw_trt_Critere_Marge.GetItemString ( 1, "MARQUE"    )
If isNull(sMarque) Then sMarque=""

sReference = dw_Trt_Critere_Marge.GetItemString ( 1, "REFERENCE" )
If isNull(sReference) Then sReference=""

If sMarque="" or sReference="" Then
	if dw_trt_consult_marge.GetSelectedRow (0) > 0 Then
		dw_trt_consult_marge.Event doubleclicked(0,0, dw_trt_consult_marge.GetSelectedRow (0), dwoNull)
	End if
Else
	dw_trt_critere_marge.Event doubleclicked(0,0, 1, dwoNull)
End if
end event

type dw_trt_consult from u_datawindow within u_sp_ifr_pilote
event ue_mouse pbm_dwnmousemove
integer x = 1170
integer y = 504
integer width = 2286
integer height = 940
integer taborder = 40
string dataobject = "d_trt_sp_ifr_consult"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on ue_mouse;call u_datawindow::ue_mouse;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_Trt_Consult
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

uf_Afficher_Legende (This)
end on

event doubleclicked;call super::doubleclicked;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_consult
//* Evenement 		: clicked
//* Auteur			: PLJ
//* Date				: 21/12/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* #1	JFF	03/12/2008	[DCMP080842]
//* #2	FPI	13/08/2009	[DCMP090458]
//*-----------------------------------------------------------------

Long		lTot, lCpt
String	sAppliExcel, sRepFiche, sAppliPDF, sNomFichier 
String	sMarque, sMarqueNv, sReference, sCommande
n_cst_string nvString 

//sAppliExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL",  "" )
sAppliExcel=F_GetExcelPath() //[PI037]
sRepFiche   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "FICHE_TECH", "" )

//* #1 [DCMP080842]
sAppliPDF   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_PDF",  "" )


//Migration PB8-WYNIWYG-03/2006 FM
//sMarque    = dw_trt_Consult_Marge.GetItemString ( This.GetRow(), "MARQUE"    )
//sReference = dw_Trt_Consult_Marge.GetItemString ( This.GetRow(), "REFERENCE" )
If Row > 0 Then
	sMarque    = dw_trt_Consult_Marge.GetItemString ( Row, "MARQUE"    )
	sReference = dw_Trt_Consult_Marge.GetItemString ( Row, "REFERENCE" )
else
	Return 0
end if
//Fin Migration PB8-WYNIWYG-03/2006 FM


lTot = Len ( sMarque )
sMarqueNv = ""

For lCpt = 1 To lTot
	If Mid ( sMarque, lCpt, 1 ) = ' ' Then
		sMArqueNv += '_'
	Else
		sMarqueNv += Mid ( sMarque, lCpt, 1 )
	End If
Next

//* #1 [DCMP080842]
//sNomFichier = sRepFiche + sMarqueNv + "_" + sReference 
sNomFichier = sRepFiche + sMarqueNv + "_" + nvString.of_globalreplace( sReference, " ", "_")
sNomFichier=nvString.of_globalreplace( sNomFichier, "/", "_")

//* #1 [DCMP080842]
sCommande = ""
If F_FileExists ( sNomFichier + ".PDF" ) Then
	//sCommande  = sAppliPDF + " " + sNomFichier + ".PDF"
	sCommande = uf_getcommande_pdf(sNomFichier + ".PDF") // #2
ElseIf F_FileExists ( sNomFichier + ".XLS" ) Then
	sCommande  = sAppliExcel + " " + sNomFichier + ".XLS"	
End If

//* #1 [DCMP080842]
If sCommande <> "" Then Run (sCommande)

end event

on scrollvertical;call u_datawindow::scrollvertical;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_consult
//* Evenement 		: ScrollVertical
//* Auteur			: PLJ
//* Date				: 20/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre  dw_trt_consult et dw_trt_consult_Marge
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_trt_consult.Describe("DataWindow.VerticalScrollPosition")

sMod = "DataWindow.VerticalScrollPosition=" + spos
dw_trt_consult_Marge.Modify(sMod)
end on

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_consult
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 20/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_trt_critere_chk_box dw_trt_critere et dw_trt_consult
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_trt_consult.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_trt_critere.Modify (sMod)
dw_trt_critere_chk_box.Modify (sMod)
end on

type st_1 from statictext within u_sp_ifr_pilote
integer x = 78
integer y = 1384
integer width = 1079
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "double-clique pour visualiser la fiche technique"
boolean focusrectangle = false
end type

type st_titre from statictext within u_sp_ifr_pilote
integer x = 73
integer y = 4
integer width = 3383
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "TITRE"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_legende from statictext within u_sp_ifr_pilote
boolean visible = false
integer x = 1170
integer y = 372
integer width = 2286
integer height = 124
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type dw_stk_code_equivalence from datawindow within u_sp_ifr_pilote
boolean visible = false
integer x = 640
integer y = 1396
integer width = 498
integer height = 360
integer taborder = 50
string dataobject = "d_lst_code_equivalence"
boolean livescroll = true
end type

type st_vetuste from statictext within u_sp_ifr_pilote
boolean visible = false
integer x = 78
integer y = 248
integer width = 123
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Vetust$$HEX2$$e9002000$$ENDHEX$$du mobile sinistr$$HEX2$$e9002000$$ENDHEX$$:"
boolean focusrectangle = false
end type

on clicked;long ltot


ltot = 1
end on

type dw_trt_critere_marge from u_datawindow within u_sp_ifr_pilote
event ue_mouse pbm_dwnmousemove
integer x = 69
integer y = 80
integer width = 1106
integer height = 148
integer taborder = 60
string dataobject = "d_trt_sp_ifr_consult_critere_marge"
end type

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_Trt_Critere_Marge
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

st_legende.Visible = False


end on

event doubleclicked;call super::doubleclicked;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_critere
//* Evenement 		: doubleclicked
//* Auteur			: JCA
//* Date				: 21/12/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* #1	JFF	03/12/2008	[DCMP080842]
//* #2	FPI	13/08/2009	[DCMP090458]
//*-----------------------------------------------------------------

Long		lTot, lCpt
String	sAppliExcel, sRepFiche, sAppliPDF, sNomFichier 
String	sMarque, sMarqueNv, sReference, sCommande
n_cst_string nvString

//sAppliExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL",  "" )
sAppliExcel = F_GetExcelPath() //[PI037]
sRepFiche   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "FICHE_TECH", "" )
//* #1 [DCMP080842]
sAppliPDF   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_PDF",  "" )
sCommande=""

//Migration PB8-WYNIWYG-03/2006 FM
//sMarque    = dw_trt_Consult_Marge.GetItemString ( This.GetRow(), "MARQUE"    )
//sReference = dw_Trt_Consult_Marge.GetItemString ( This.GetRow(), "REFERENCE" )
If Row > 0 Then
	sMarque    = dw_trt_Critere_Marge.GetItemString ( Row, "MARQUE"    )
	sReference = dw_Trt_Critere_Marge.GetItemString ( Row, "REFERENCE" )
else
	Return 0
end if
//Fin Migration PB8-WYNIWYG-03/2006 FM


lTot = Len ( sMarque )
sMarqueNv = ""

For lCpt = 1 To lTot
	If Mid ( sMarque, lCpt, 1 ) = ' ' Then
		sMArqueNv += '_'
	Else
		sMarqueNv += Mid ( sMarque, lCpt, 1 )
	End If
Next


//* #1 [DCMP080842]
//sNomFichier = sRepFiche + sMarqueNv + "_" + sReference 
sNomFichier = sRepFiche + sMarqueNv + "_" + nvString.of_globalreplace( sReference, " ", "_")
sNomFichier=nvString.of_globalreplace( sNomFichier, "/", "_")


//* #1 [DCMP080842]
sCommande = ""
If F_FileExists ( sNomFichier + ".PDF" ) Then
//	sCommande  = sAppliPDF + " " + sNomFichier + ".PDF"
	sCommande = uf_getcommande_pdf(sNomFichier + ".PDF") // #2
ElseIf F_FileExists ( sNomFichier + ".XLS" ) Then
	sCommande  = sAppliExcel + " " + sNomFichier + ".XLS"	
Else
	stMessage.sTitre	= "Fiche technique"
	stMessage.Icon		= Exclamation!
	stMessage.sCode	= "IFR0105"
	stMessage.bErreurG=FALSE
	F_Message ( stMessage )
End If

//* #1 [DCMP080842]
If sCommande <> "" Then Run (sCommande)


end event

type dw_trt_critere_chk_box from u_datawindow within u_sp_ifr_pilote
event ue_mouse pbm_dwnmousemove
integer x = 1170
integer y = 224
integer width = 2286
integer height = 140
integer taborder = 20
string dataobject = "d_trt_sp_ifr_consult_critere_chk_box"
boolean hscrollbar = true
end type

on ue_mouse;call u_datawindow::ue_mouse;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_Trt_Critere_Chk_box
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

st_legende.Visible = False
end on

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_critere_chk_box
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 22/08/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


Long 		lCpt
String	sVal

/*---------------------------------------------------------------*/
/* Je recherche la case qui vient d'$$HEX1$$ea00$$ENDHEX$$tre coch$$HEX2$$e9002000$$ENDHEX$$ou d$$HEX1$$e900$$ENDHEX$$coch$$HEX1$$e900$$ENDHEX$$e et    */
/* je l'ajoute ou enl$$HEX1$$e800$$ENDHEX$$ve du filtre                               */
/* Les cases $$HEX2$$e0002000$$ENDHEX$$cocher ayant la valeur O ou N sur le dataobject   */
/* dw_trt_critere_chk_box                                        */
/*---------------------------------------------------------------*/


sVal = This.GetText ()

For lCpt = 1 To ilNbCritere 

	If Upper(istabcritere[1,lCpt]) = Upper(This.isNomCol) Then
		istabcritere[2,lCpt] = sVal
	End If	

Next

uf_Filtrer ()

Parent.TriggerEvent ( "ue_cocher" )



end on

on scrollhorizontal;call u_datawindow::scrollhorizontal;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_critere_chk_box
//* Evenement 		: ScrollHorizontal
//* Auteur			: PLJ
//* Date				: 20/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronisation de la barre de scrolling entre dw_trt_critere_chk_box dw_trt_critere et dw_trt_consult
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

String sPos, sMod

spos = dw_trt_critere_chk_box.Describe("DataWindow.HorizontalScrollPosition")

sMod = "DataWindow.HorizontalScrollPosition=" + spos
dw_trt_critere.Modify (sMod)
dw_trt_consult.Modify (sMod)
end on

type dw_trt_consult_marge from u_datawindow within u_sp_ifr_pilote
event ue_mouse pbm_dwnmousemove
integer x = 5
integer y = 504
integer width = 1170
integer height = 876
integer taborder = 30
string dataobject = "d_trt_sp_ifr_consult_marge"
boolean border = false
end type

event doubleclicked;call super::doubleclicked;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_trt_consult_marge
//* Evenement 		: clicked
//* Auteur			: PLJ
//* Date				: 21/12/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* #1	JFF	03/12/2008	[DCMP080842]
//* #2	FPI	13/08/2009	[DCMP090458]
//*-----------------------------------------------------------------

Long		lTot, lCpt
String	sAppliExcel, sRepFiche, sAppliPDF, sNomFichier 
String	sMarque, sMarqueNv, sReference, sCommande
n_cst_string nvString

//sAppliExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL",  "" )
sAppliExcel = F_GetExcelPath() //[PI037]
sRepFiche   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "FICHE_TECH", "" )
sCommande=""

//* #1 [DCMP080842]
sAppliPDF   = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_PDF",  "" )

sMarque    = dw_trt_Consult_Marge.GetItemString ( This.GetRow(), "MARQUE"    )
sReference = dw_Trt_Consult_Marge.GetItemString ( This.GetRow(), "REFERENCE" )


lTot = Len ( sMarque )
sMarqueNv = ""

For lCpt = 1 To lTot
	If Mid ( sMarque, lCpt, 1 ) = ' ' Then
		sMArqueNv += '_'
	Else
		sMarqueNv += Mid ( sMarque, lCpt, 1 )
	End If
Next


//* #1 [DCMP080842]
//sNomFichier = sRepFiche + sMarqueNv + "_" + sReference 
sNomFichier = sRepFiche + sMarqueNv + "_" + nvString.of_globalreplace( sReference, " ", "_")
sNomFichier=nvString.of_globalreplace( sNomFichier, "/", "_")

//* #1 [DCMP080842]
sCommande = ""
If F_FileExists ( sNomFichier + ".PDF" ) Then
//	sCommande  = sAppliPDF + " " + sNomFichier + ".PDF"
	sCommande = uf_getcommande_pdf(sNomFichier + ".PDF") // #2
ElseIf F_FileExists ( sNomFichier + ".XLS" ) Then
	sCommande  = sAppliExcel + " " + sNomFichier + ".XLS"	
Else
	stMessage.sTitre	= "Fiche technique"
	stMessage.Icon		= Exclamation!
	stMessage.sCode	= "IFR0105"
	stMessage.bErreurG=FALSE
	F_Message ( stMessage )
End If

//* #1 [DCMP080842]
If sCommande <> "" Then Run (sCommande)

end event

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_Trt_Consult_Marge
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

st_legende.visible = False
end on

type p_effacer_critere from picture within u_sp_ifr_pilote
integer x = 1015
integer y = 236
integer width = 206
integer height = 112
string picturename = "k:\pb4obj\bmp\8_gomme.bmp"
boolean focusrectangle = false
end type

on clicked;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::p_effacer_critere
//* Evenement 		: clicked
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

uf_decocher ()

/*------------------------------------------------------------------------------*/
/* Suite au Clique de cette image, c'est au client de faire un Rafra$$HEX1$$ee00$$ENDHEX$$chissement */
/* Contrairement $$HEX2$$e0002000$$ENDHEX$$la m$$HEX1$$e900$$ENDHEX$$thode uf_preparer o$$HEX2$$f9002000$$ENDHEX$$c'est la fonction qui le fait      */
/*------------------------------------------------------------------------------*/
Parent.TriggerEvent ( "ue_cocher" )
end on

type dw_trt_critere from u_datawindow within u_sp_ifr_pilote
event ue_mouse pbm_dwnmousemove
integer x = 1170
integer y = 80
integer width = 2286
integer height = 220
integer taborder = 10
string dataobject = "d_trt_sp_ifr_consult_critere"
boolean hscrollbar = true
end type

on ue_mouse;call u_datawindow::ue_mouse;//*-----------------------------------------------------------------
//* Objet 			: u_sp_ifr_pilote::dw_Trt_Critere
//* Evenement 		: ue_mouse
//* Auteur			: PLJ
//* Date				: 26/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

uf_Afficher_Legende (This)


end on

