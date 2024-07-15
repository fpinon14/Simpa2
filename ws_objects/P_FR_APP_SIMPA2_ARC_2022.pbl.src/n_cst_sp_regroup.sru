HA$PBExportHeader$n_cst_sp_regroup.sru
forward
global type n_cst_sp_regroup from nonvisualobject
end type
end forward

global type n_cst_sp_regroup from nonvisualobject
end type
global n_cst_sp_regroup n_cst_sp_regroup

type variables
Private:
String			isTypeTrt
u_datawindow		idwTrtRegroup
u_datawindow		idwStkRegroup

long			ilLignePrec, ilLigneOrigine

PictureButton		iPbControler
PictureButton		iPbSupprimer
staticText		istMessage

int			iiErreur


end variables

forward prototypes
public function boolean uf_preparer (string astypetrt, ref s_pass astpass)
public function integer uf_controlerzone (string ascol, string asval)
private subroutine uf_filtrerdddw (string assource, string asvaleur)
public function string uf_controlersaisie ()
public function string uf_controlergestion ()
public subroutine uf_initialiser (ref u_datawindow adwtrtregroup, ref u_datawindow adwstkregroup, ref picturebutton apbcontroler, ref picturebutton apbsupprimer, statictext astmessage)
public function boolean uf_preparervalider ()
public function boolean uf_preparersupprimer ()
public function long uf_gerermessage (string asobjet, string asnomcol, string astaberr[])
end prototypes

public function boolean uf_preparer (string astypetrt, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_regroup::Uf_Preparer (Public)
//* Auteur			: PLJ
//* Date				: 21/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Chargement 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 		lIdProd, lIdEts, lIdCie, lIdProfil, lTot
Long		lnbLigne
Date		dDteValDeb 
String	sRech
Boolean  bOk = True

isTypeTrt = asTypeTrt


If isTypeTrt = 'M' Then

	/*----------------------------------------------*/
   /* Chargement du Profil                         */
	/*----------------------------------------------*/
	lIdProd    = astPass.lTab [ 1 ]
	lIdEts     = astPass.lTab [ 2 ]
	lIdCie  	  = astPass.lTab [ 3 ]
	dDteValDeb = astPass.dTab [ 1 ]

	idwTrtRegroup.Retrieve ( lIdProd, lIdEts, lIdCie, DateTime(dDteValDeb) ) // [PI056]
	idwStkRegroup.Retrieve ( lIdProd )
	idwStkRegroup.SetSort ("ID_PROD A,ID_ETS A,ID_CIE A,DTE_VAL_DEB A" )
	idwStkRegroup.Sort ()
	ilLignePrec = 0

	lIdProfil = idwTrtRegroup.GetItemNumber ( 1, "ID_PROFIL" ) 


	/*----------------------------------------------------------*/
   /* Si le profil est pr$$HEX1$$e900$$ENDHEX$$sent sur une bo$$HEX1$$ee00$$ENDHEX$$te on interdit toutes*/
   /* modification et suppression                              */
	/*----------------------------------------------------------*/
	SELECT count(*) INTO :lNbLigne
     FROM sysadm.wkfs_boite
    WHERE id_profil = :lIdProfil 
    USING SQLCA;

	If SqlCa.SqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then
		uf_GererMessage ( "n_cst_sp_regroup", "PREPARER", { String(SqlCa.SqlCode), String(SqlCa.SqlDbCode), SqlCa.SqlErrText} )
		bOk = False
	End IF

	If bOk = True And lNbLigne > 0 Then
		idwTrtRegroup.uf_proteger ( {"ID_PROD","ID_ETS","ID_CIE","ID_PROFIL","DTE_VAL_DEB"}, '1' )
		istMessage.Text      = "Le profil " + String ( lIdProfil ) + " est utilis$$HEX2$$e9002000$$ENDHEX$$par au moins une bo$$HEX1$$ee00$$ENDHEX$$te."
		isTMessage.Visible   = True
		ipbControler.Enabled = False
		ipbSupprimer.Enabled = False
	Else
		idwTrtRegroup.uf_proteger ( {"ID_ETS","ID_CIE","ID_PROFIL","DTE_VAL_DEB"}, '0' )
		isTMessage.Visible   = False
//		ipbControler.Enabled = True
//		ipbSupprimer.Enabled = True
	End If


	/*-------------------------------------------------------*/
	/* Affectation de ilLigneOrigine, ligne de idwStkRegroup */
   /* Correspondant $$HEX2$$e0002000$$ENDHEX$$idwTrtRegroup                         */
   /* Variable utilis$$HEX1$$e900$$ENDHEX$$e sur uf_controler_gestion            */
	/*-------------------------------------------------------*/
	If bOk Then
		sRech 		= "ID_PROD = " + String ( lIdProd ) + " AND ID_ETS = " + String ( lIdEts ) + " AND ID_PROFIL = " + String ( lIdProfil )
		lTot			= idwStkRegroup.RowCount()

		ilLigneOrigine	= idwStkRegroup.Find ( sRech, 1, lTot )


		/*-------------------------------------------------------*/
   	/* On rend innaccessible la zone PRODUIT et accessible   */
      /* les autres                                            */
		/*-------------------------------------------------------*/
		idwTrtRegroup.uf_proteger ( {"ID_PROD"}, '1' )
		

	End If	

Else

	idwTrtRegroup.uf_proteger ( {"ID_PROD","ID_ETS","ID_CIE","ID_PROFIL","DTE_VAL_DEB"}, '0' )
	idwStkRegroup.Reset ()

	idwTrtRegroup.SetItem ( 1, "DTE_VAL_FIN", Date ('31/12/3000') )
	isTMessage.Visible   = False
	ilLigneOrigine = 0

End If


Uf_FiltrerDDDW ( "PROD", String (lIdProd) )
Uf_FiltrerDDDW ( "CIE",  String (lIdCie ) )

Return bOk
end function

public function integer uf_controlerzone (string ascol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_regroup::Uf_ControlerZone (Public)
//* Auteur			: PLJ
//* Date				: 21/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de la validit$$HEX2$$e9002000$$ENDHEX$$des informations saisies
//*
//* Arguments		: String	asCOl
//*					  String asVal
//*
//* Retourne		: ActionCode pour l'itemchanged
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild
Boolean				bOk = True
Integer				iActionCode
String				sNull, SIdProd, sIdEts
Long 					lNull, lLigne, lTot
Date					dDteValDeb

SetNull (sNull)
SetNull (lNull)
iActionCode = 0

Choose Case asCol 

	Case "ID_PROD"
		/*------------------------------------------------------------------*/
		/* Si la valeur saisie ne se trouve pas dans la DDDW on stop tout   */
		/*------------------------------------------------------------------*/
		idwTrtRegroup.GetChild ( "ID_PROD", dwChild )
		lTot = dwChild.RowCount()
		lLigne = dwChild.Find ( "ID_PROD = " + asVal, 1 , lTot )
		If lLigne < 1 Then
			iActionCode = 1
			bok = False
		End If 		


		If bOk Then
			idwTrtRegroup.SetItem ( 1, "ID_ETS",    lNull )
			idwTrtRegroup.SetItem ( 1, "ID_CIE",    lNull )
			idwTrtRegroup.SetItem ( 1, "ID_PROFIL", lNull )

			idwTrtRegroup.Uf_Proteger ( {"ID_PROD"}, '1' )

			idwStkRegroup.Retrieve ( Long ( asVal ) )
			idwStkRegroup.SetSort ("ID_PROD A,ID_ETS A,ID_CIE A,DTE_VAL_DEB A" )
			idwStkRegroup.Sort ()
			ilLignePrec = 0
	
			uf_FiltrerDDDW ( "PROD", asVal )
			uf_FiltrerDDDW ( "CIE",  sNull )
		End If

	Case "ID_ETS"	
		idwTrtRegroup.SetItem ( 1, "ID_CIE",    lNull )
		idwTrtRegroup.SetItem ( 1, "ID_PROFIL", lNull )

		sIdProd = String ( idwTrtRegroup.GetItemNumber ( 1, "ID_PROD" ) )

		/*---------------------------------------------------------------------*/
		/* Si le produit n'est pas renseign$$HEX1$$e900$$ENDHEX$$, on n'autorise pas la saisie      */
		/*---------------------------------------------------------------------*/
		If isNull ( sIdProd ) Then
			iActionCode = 2
		Else
			uf_FiltrerDDDW ( "PROD", sIdProd )
			uf_FiltrerDDDW ( "CIE",  sNull   )
		End If

	Case "ID_CIE"
		idwTrtRegroup.SetItem ( 1, "ID_PROFIL", lNull )

		sIdProd = String ( idwTrtRegroup.GetItemNumber ( 1, "ID_PROD" ) )
		sIdEts  = String ( idwTrtRegroup.GetItemNumber ( 1, "ID_ETS"  ) )

		/*----------------------------------------------------------------------------*/
		/* Si le produit et l'Ets ne sont pas renseign$$HEX1$$e900$$ENDHEX$$s, on n'autorise pas la saisie */
		/*----------------------------------------------------------------------------*/
		If isNull ( sIdProd ) Or isNull ( sIdEts ) Then
			iActionCode = 2
		Else
			uf_FiltrerDDDW ( "CIE",  asVal   )
		End If

		
	Case "DTE_VAL_DEB"

		If bOk Then
			dDteValDeb = Date ( asVal )
			If dDteValDeb <= Today() Then
				iActionCode = 1
				idwTrtRegroup.iiErreur  = 1
			End If 		
		End If


End Choose

Return iActionCode

end function

private subroutine uf_filtrerdddw (string assource, string asvaleur);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_regroup::Uf_FiltrerDDDW (Private)
//* Auteur			: PLJ
//* Date				: 23/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Filtre des DDDW de idwTrtRegroup en fonction 
//*					  du produit ou de la compagnie
//*
//* Arguments		: String asSource 	PROD ou CIE
//*					  String asValeur  	cl$$HEX4$$e9002000e0002000$$ENDHEX$$filtrer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


DatawindowChild	dwChild

If isNull ( asValeur ) Then asValeur = 'null'

/*-------------------------------------------------------------*/
/* Filtre des DDDW en fonction du produit                      */
/*-------------------------------------------------------------*/
If Upper (asSource) = "PROD"  Then

	idwTrtRegroup.GetChild ( "ID_ETS", dwChild  )
	dwChild.SetFilter ( "ID_PROD = " + asValeur  )
	dwChild.Filter    ()
	dwChild.Sort      ()

	idwTrtRegroup.GetChild ( "ID_CIE", dwChild  )
	dwChild.SetFilter ( "ID_PROD = " + asValeur )
	dwChild.Filter    ()
	dwChild.Sort      ()

End If


/*-------------------------------------------------------------*/
/* Filtre des DDDW en fonction de la cie                       */
/*-------------------------------------------------------------*/
IF Upper (asSource) = "CIE" Then

	idwTrtRegroup.GetChild ( "ID_PROFIL", dwChild )
	dwChild.SetFilter ( "ID_CIE = " + asValeur )
	dwChild.Filter    ()
   dwChild.Sort      ()

End IF
	


end subroutine

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_profil::Uf_ControlerSaisie
//* Auteur			:	PLJ
//* Date				: 	18/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le des zones obligatoires
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------


String sPos, sText, sVal

String sCrLf = "~r~n"



/*-------------------------------------------------------*/
/* Controle que la cie le type, la dte_val_deb, le profil*/
/* soient saisis                                         */
/*-------------------------------------------------------*/

sVal = String (idwTrtRegroup.GetItemNumber ( 1, "ID_PROD"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"	Then
	sPos  = "ID_PROD"
	Stext = " - Le produit" + sCrLf
End If


sVal = String (idwTrtRegroup.GetItemNumber ( 1, "ID_ETS"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"	Then
	If sPos = "" Then sPos = "ID_ETS"
	Stext += " - L'$$HEX1$$e900$$ENDHEX$$tablissement" + sCrLf
End If


sVal = String (idwTrtRegroup.GetItemNumber ( 1, "ID_PROFIL"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"  Then
	If sPos = "" Then sPos = "ID_PROFIL"
	Stext += " - Le profil" + sCrLf
End If


sVal = String (idwTrtRegroup.GetItemDateTime ( 1, "DTE_VAL_DEB"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"  Then
	If sPos = "" Then sPos = "DTE_VAL_DEB"
	Stext += " - La date de validit$$HEX2$$e9002000$$ENDHEX$$de d$$HEX1$$e900$$ENDHEX$$but" + sCrLf
End If


/*------------------------------------------------------*/
/* Affichage du message d'erreur                        */
/*------------------------------------------------------*/

If	( sPos <> "" ) Then

	uf_GererMessage ( "n_cst_sp_regroup", "CONTROLER_SAISIE", { sText } )

End If


Return sPos
end function

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_Regroup::uf_ControlerGestion
//* Auteur			:	PLJ
//* Date				:	25/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Colonne en erreur
//*
//*-----------------------------------------------------------------

n_cst_DateTime		nvDateTime
String 				sCol = ""

Boolean				bOk
Long					lIdProd, lIdEts, lIdProfil, lIdCie, lIdProfilBase
Date					dValDeb, dStkValDeb, dStkValFin
Long					lLigne, lTot
String				sRech

nvDateTime = Create n_cst_DateTime
bOk 		  = True

/*----------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des informations venant d'$$HEX1$$ea00$$ENDHEX$$tre saisies par l'utilisateur*/
/*----------------------------------------------------------------------*/
lIdProd		= idwTrtRegroup.GetItemNumber ( 1, "ID_PROD"     )
lIdEts		= idwTrtRegroup.GetItemNumber ( 1, "ID_ETS"      )
lIdProfil	= idwTrtRegroup.GetItemNumber ( 1, "ID_PROFIL"   )
lIdCie		= idwTrtRegroup.GetItemNumber ( 1, "ID_CIE"      )
dValDeb		= Date(idwTrtRegroup.GetItemDateTime   ( 1, "DTE_VAL_DEB" )) // [PI056]


/*----------------------------------------------------------------------*/
/* En Cr$$HEX1$$e900$$ENDHEX$$ation et Modification                                          */
/* Les cl$$HEX1$$e900$$ENDHEX$$s Id_Prod, id_Ets, id_cie, id_Profil ne doivent pas exister   */
/* exister en base.                                                     */
/* Pour cela nous pouvons nous appuyer sur idwStkRegroup                */
/* Je peux effectuer uniquement la recherche sur                        */
/* Id_Prod, id_Ets, Id_Profil (car Id_profil ==> Id_cie )               */
/*----------------------------------------------------------------------*/
sRech 		= "ID_PROD = " + String ( lIdProd ) + " AND ID_ETS = " + String ( lIdEts ) + " AND ID_PROFIL = " + String ( lIdProfil ) + " AND DTE_VAL_FIN = 3000-12-31"
lTot			= idwStkRegroup.RowCount()

lLigne		= idwStkRegroup.Find ( sRech, 1, lTot )


/*----------------------------------------------------------------------*/
/* ilLignePrec contient la pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente ligne de idwStkRegroup qui        */
/* montrait qu'il y a avait d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un doublon. Cette Valeur doit $$HEX1$$ea00$$ENDHEX$$tre     */
/* remise $$HEX2$$e0002000$$ENDHEX$$0 $$HEX2$$e0002000$$ENDHEX$$chaque fois que l'on recharge idwStkRegroup.            */
/*  ==> uf_preparer, uf_controler_zone                                  */
/*                                                                      */
/* ilLigneOrigine correspond la ligne des crit$$HEX1$$e800$$ENDHEX$$res de idwTrtRegroup     */
/* lorsque l'on a ouvert la fen$$HEX1$$ea00$$ENDHEX$$tre en modification. Cette valeur est   */
/* affect$$HEX1$$e900$$ENDHEX$$e sur uf_preparer                                             */
/*----------------------------------------------------------------------*/
If lLigne > 0 And lLigne <> ilLigneOrigine Then
	
	uf_GererMessage ( "n_cst_sp_regroup", "CONTROLER_GESTION", {""} )
	sCol = "ID_ETS"
	bOk = False
	If ilLignePrec > 0 Then
		idwStkRegroup.SetItem ( ilLignePrec, "ALT_ERREUR", 'N' )
	End If
	idwStkRegroup.SetItem ( lLigne, "ALT_ERREUR", 'O' )
	idwStkRegroup.ScrollToRow ( lLigne )
	iLLignePrec = lLigne
End IF



/*----------------------------------------------------------------------*/
/* On ne peut pas saisir pour un produit/Cie avec un ETS pr$$HEX1$$e900$$ENDHEX$$cis         */
/* tant qu'il n'existe pas de ligne avec Ets -1                         */
/*----------------------------------------------------------------------*/
If bOk And lIdEts <> -1 Then

	sRech  = "ID_PROD = " + String ( lIdProd ) + " AND ID_ETS = -1 AND ID_CIE = " +String ( lIdCie )
	lLigne = idwStkRegroup.Find ( sRech, 1, lTot )

	If lLigne < 1 Then 
		uf_GererMessage ( "n_cst_sp_regroup", "CONTROLER_GESTION2", {String(lIdEts)} )
		sCol = "ID_ETS"
		bOk  = False
	End If

End If


/*----------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation                                                          */
/* S'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$une ligne Produit Ets Cie, le profil doit $$HEX1$$ea00$$ENDHEX$$tre      */
/* diff$$HEX1$$e900$$ENDHEX$$rent, (cas de la modification d'une m$$HEX1$$e900$$ENDHEX$$thode sur un produit ets  */
/* donn$$HEX1$$e900$$ENDHEX$$).                                                              */
/* L'utilisateur a saisi sur dte_val_deb une date > Aujourd'hui.        */
/* Il faut alors fermer le pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent regroupement en mettant dans       */
/* dte_val_fin la date question -1j                                     */
/*----------------------------------------------------------------------*/
If bOk And isTypeTrt = 'C' Then

	sRech  = "ID_PROD = " + String ( lIdProd ) + " AND ID_ETS = " + String ( lIdEts ) + " AND ID_CIE = " + String ( lIdCie ) + " AND DTE_VAL_FIN = 3000-12-31"
	lLigne = idwStkRegroup.Find ( sRech, 1, lTot )


	If lLigne > 0 Then					// Nous avons trouv$$HEX2$$e9002000$$ENDHEX$$une ligne Id_prod, id_ets, id_cie d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$existante

		lIdProfilBase  = idwStkRegroup.GetItemNumber ( lLigne, "ID_PROFIL" )
	
		
		If lIdProfilBase = lIdProfil Then		// La ligne existe avec le m$$HEX1$$ea00$$ENDHEX$$me profil sur un regroupement ouvert ==> INTERDICTION

			If ilLignePrec > 0 Then
				idwStkRegroup.SetItem ( ilLignePrec, "ALT_ERREUR", 'N' )
			End If
			idwStkRegroup.SetItem ( lLigne, "ALT_ERREUR", 'O' )
			idwStkRegroup.ScrollToRow ( lLigne )
			iLLignePrec = lLigne
			uf_GererMessage ( "n_cst_sp_regroup", "CONTROLER_GESTION", {""} )
			bOk = False
			sCol = "ID_ETS"

		Else												// On ferme le profil pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent avant de cr$$HEX1$$e900$$ENDHEX$$er le nouveau

			dStkValDeb = Date(idwStkRegroup.GetItemDatetime ( lLigne, "DTE_VAL_DEB" ))  // [PI056]

			/*-------------------------------------------------------------------------------------------*/
			/* La nouvelle date de d$$HEX1$$e900$$ENDHEX$$but (dValDeb) doit $$HEX1$$ea00$$ENDHEX$$tre > $$HEX2$$e0002000$$ENDHEX$$la pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente date de d$$HEX1$$e900$$ENDHEX$$but (dstValDeb) */ 
			/*-------------------------------------------------------------------------------------------*/
			If dValDeb <= dStkValDeb Then
				If ilLignePrec > 0 Then
					idwStkRegroup.SetItem ( ilLignePrec, "ALT_ERREUR", 'N' )
				End If
				idwStkRegroup.SetItem ( lLigne, "ALT_ERREUR", 'O' )
				idwStkRegroup.ScrollToRow ( lLigne )
				iLLignePrec = lLigne
				uf_GererMessage ( "n_cst_sp_regroup", "CONTROLER_GESTION3", {String (dStkValDeb), String (dValDeb) } )
				bOk = False
				sCol = "DTE_VAL_DEB"
			End If 

		End If


		If bOk Then
			dStkValFin = nvDateTime.uf_PlusDate    ( dValDeb, -1, 'J'     )

			UPDATE sysadm.wkfs_regroup
			   SET dte_val_fin = :dStkValFin			
			 WHERE id_prod = :lIdProd  AND id_ets = :lIdEts AND id_cie = :lIdCie AND dte_val_deb = :dStkValDeb
			 USING SQLCA;

			If SqlCa.SqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then
				uf_GererMessage ( "n_cst_sp_regroup", "PREPARER", { String(SqlCa.SqlCode), String(SqlCa.SqlDbCode), SqlCa.SqlErrText} )
				sCol = "ID_ETS"
				bOk = False
			End IF

		End If


	End If

End If
	


Destroy nvDateTime

Return sCol
end function

public subroutine uf_initialiser (ref u_datawindow adwtrtregroup, ref u_datawindow adwstkregroup, ref picturebutton apbcontroler, ref picturebutton apbsupprimer, statictext astmessage);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_regroup::Uf_Initialiser (Public)
//* Auteur			: PLJ
//* Date				: 21/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adwTrtRegroup	(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement des regroupement
//*					  U_DataWindow				adwStkRegroup	(R$$HEX1$$e900$$ENDHEX$$f) Liste de tous les regroupement d$$HEX1$$e900$$ENDHEX$$fini pour un produit
//*					  PictureButton			acbControler   (R$$HEX1$$e900$$ENDHEX$$f)
//*					  PictureButton			acbSupprimer   (R$$HEX1$$e900$$ENDHEX$$f)
//*					  staticText				astMessage     (R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DatawindowChild	dwChild
String 				sCol[1]

/*------------------------------------------------------------------*/
/* Affectation des objets                                           */
/*------------------------------------------------------------------*/
idwTrtRegroup	= adwTrtRegroup
idwStkRegroup	= adwStkRegroup

ipbControler 	= apbControler
ipbSupprimer 	= apbSupprimer

istMessage	 	= astMessage

idwTrtRegroup.setTransObject ( SqlCa )
idwStkRegroup.setTransObject ( SqlCa )

idwStkRegroup.SetSort ( "ID_PROD A, ID_ETS A, ID_CIE A, DTE_VAL_DEB A" )
	

/*------------------------------------------------------------------*/
/* Initialisation des DropdownDatawindows                           */
/*------------------------------------------------------------------*/
idwTrtRegroup.GetChild ( "ID_PROD", dwChild )
dwChild.SetTransObject ( SqlCa              )
dwChild.Retrieve       ()

long lRet
lRet = idwTrtRegroup.GetChild ( "ID_ETS", dwChild  )
dwChild.SetTransObject ( SqlCa              )
lRet = dwChild.Retrieve       ()

idwTrtRegroup.GetChild ( "ID_CIE", dwChild  )
dwChild.SetTransObject ( SqlCa              )
dwChild.Retrieve       ()

idwTrtRegroup.GetChild ( "ID_PROFIL", dwChild)
dwChild.SetTransObject ( SqlCa               )
dwChild.Retrieve       ()

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
idwTrtRegroup.Uf_InitialiserCouleur ( {"ID_PROD","ID_ETS","ID_CIE","ID_PROFIL","DTE_VAL_DEB"} )
end subroutine

public function boolean uf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_regroup::Uf_PreparerValider (PUBLIC)
//* Auteur			: PLJ
//* Date				: 26/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fin de la validation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//*-----------------------------------------------------------------

Boolean bRet = True

Long	lIdProfil


f_MajPar (idwTrtRegroup, 1 )


Return bRet
end function

public function boolean uf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_Regroup::uf_PrepareSupprimer
//* Auteur			:	PLJ
//* Date				:	26/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$avant suppression
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

Boolean  bRet = True
Integer	iRet

/*---------------------------------------------------------------------*/
/* On ne peut pas supprimer un profil s'il poss$$HEX1$$e800$$ENDHEX$$de des enregistrements */
/* connexes sur wkfs_regroup ou wkfs_boite                             */ 
/* Le bouton supprimer est rendu inaccessible sur le uf_preparer.      */
/* Nous partons du principe que le param$$HEX1$$e900$$ENDHEX$$trage sera fait par une seule */
/* personne, nous ne v$$HEX1$$e900$$ENDHEX$$rifions donc pas qu'au moment de supprimer le   */
/* une personne l'a entre temps affect$$HEX4$$e9002000e0002000$$ENDHEX$$un regroupement.             */
/* De toute fa$$HEX1$$e700$$ENDHEX$$on la suppression ne pourra pas se faire car une        */
/* contrainte existe entre wkfs_profil et wkfs_regroup                 */
/*---------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Regroupement"
stMessage.sVar[ 1 ] 	= "ce regroupement"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.sCode		= "CONF001"
iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	If idwTrtRegroup.DeleteRow ( 0 ) < 0	Then
		bRet = False
	End If

End If



Return bRet


end function

public function long uf_gerermessage (string asobjet, string asnomcol, string astaberr[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_regroup::Uf_GereMessage
//* Auteur			:	PLJ
//* Date				: 	25/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages
//* Commentaires	:	
//*
//* Arguments		:	String	asObjet
//*						String	asNomCol
//*						String	asTabErr[]
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//* [MIGPB8COR]	: Parametre de retour chang$$HEX2$$e9002000$$ENDHEX$$en Long
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------

// [MIGPB8COR]
long ll_ret = 0

Choose Case Upper ( asObjet )

	Case	'N_CST_SP_REGROUP'
																		/*-------------------------------------*/
		Choose Case Upper ( asNomCol )						/* Appel sur une autre m$$HEX1$$e900$$ENDHEX$$thode du nvuo */
																		/*-------------------------------------*/
			Case 'PREPARER'
				stMessage.sTitre		= "Maj d'un regroupement"
				stMessage.Icon			= StopSign!
				stMessage.bErreurG	= False
				stMessage.sCode		= "PROF001"
			   stMessage.bTrace  	= False
				stMessage.sVar[1]    = "Uf_Preparer"
				stMessage.sVar[2] 	= asTabErr [1]			// SqlCa.SqlCode
				stMessage.sVar[3] 	= asTabErr [2]			// SqlCa.SqlDBCode
				stMessage.sVar[4] 	= asTabErr [3]			// SqlCa.SqlErrText
				f_Message ( stMessage )
				
			Case 'CONTROLER_SAISIE'
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie"
				stMessage.Icon			= Information!
				stMessage.sVar[1] 	= asTabErr [1]
				stMessage.sCode		= "GENE001"
				f_Message ( stMessage )

			Case 'CONTROLER_GESTION'
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion"
				stMessage.Icon			= Information!
				stMessage.sCode		= "PROF003"

				f_Message ( stMessage )

			Case 'CONTROLER_GESTION2'
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion"
				stMessage.Icon			= Information!
				stMessage.sCode		= "PROF004"
				stMessage.sVar[1] 	= asTabErr [1]	
				f_Message ( stMessage )

			Case 'CONTROLER_GESTION3'
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion"
				stMessage.Icon			= Exclamation!
				stMessage.sCode		= "PROF008"
				stMessage.sVar[1] 	= asTabErr [2]	
				stMessage.sVar[2] 	= asTabErr [1]
				f_Message ( stMessage )

			Case 'TERMINER_VALIDER'
				stMessage.sTitre		= "Maj d'un regroupement"
				stMessage.Icon			= StopSign!
				stMessage.sCode		= "PROF001"
			   stMessage.bTrace  	= False
				stMessage.sVar[1]    = "Uf_TerminerValider"
				stMessage.sVar[2] 	= asTabErr [1]			// SqlCa.SqlCode
				stMessage.sVar[3] 	= asTabErr [2]			// SqlCa.SqlDBCode
				stMessage.sVar[4] 	= asTabErr [3]			// SqlCa.SqlErrText

				f_Message ( stMessage )


		End Choose

																	/*-------------------------------*/
	CASE 'DW_TRT_REGROUP'									/* DW_1.ItemError                */
		Choose Case Upper ( asNomCol )               /*-------------------------------*/
			Case "DTE_VAL_DEB"
					
				If	idwTrtRegroup.iiErreur = 1  Then
					idwTrtRegroup.iiReset = 1				// On repositionnera la valeur $$HEX2$$e0002000$$ENDHEX$$NULL
					stMessage.Icon		= Exclamation!
					stMessage.sVar[1] = "date"
					stMessage.sVar[2] = "date du jour"
					stMessage.bErreurG= True
					stMessage.sCode	= "EWK0011"
				Else
					idwTrtRegroup.iiReset = 1				// On repositionnera la valeur $$HEX2$$e0002000$$ENDHEX$$NULL
					stMessage.sVar[1] = "date" 
					stMessage.Icon		= Exclamation!
					stMessage.sCode	= "GENE002"

				End If

			Case "ID_PROD"
					idwTrtRegroup.iiReset = 1				// On repositionnera la valeur $$HEX2$$e0002000$$ENDHEX$$NULL
					stMessage.sVar[1] = "saisie" 
					stMessage.Icon		= Exclamation!
					stMessage.sCode	= "GENE002"

		End Choose

		f_Message ( stMessage )
		ll_ret = idwTrtRegroup.uf_Reinitialiser ()


End Choose

return ll_ret // [MIGPB8COR]

end function

on n_cst_sp_regroup.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_regroup.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

