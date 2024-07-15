HA$PBExportHeader$n_cst_aidepapier.sru
$PBExportComments$-} NVUO permettant d'afficher une aide sur la tarification des papiers. (DCMP 010375)
forward
global type n_cst_aidepapier from nonvisualobject
end type
end forward

global type n_cst_aidepapier from nonvisualobject
end type
global n_cst_aidepapier n_cst_aidepapier

type variables
Private :
	DataWindow	idwBandeau
	DataWindow	idwPapier
end variables

forward prototypes
public function integer uf_initialiser (ref datawindow adwbandeau, ref datawindow adwpapier)
public function integer uf_controlerzone (string asnomcol, string asdata)
private function integer uf_zn_idtyppapier (string asdata)
private subroutine uf_filtrer_papier (string asfiltre)
private function integer uf_zn_iddept (string asdata)
public subroutine uf_sauvegarder_position (long alcoor[])
end prototypes

public function integer uf_initialiser (ref datawindow adwbandeau, ref datawindow adwpapier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_Initialiser	(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise l'objet pour la recherche du tarif de certains papiers
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow					adwBandeau
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow					adwPapier
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
Long lLig
DataWindowChild	dwChild
iRet = 1

/*------------------------------------------------------------------*/
/* On instancie les deux DW qui proviennent de la fen$$HEX1$$ea00$$ENDHEX$$tre           */
/* W_PopUp_Aide_Papier.                                             */
/*------------------------------------------------------------------*/
idwBandeau	= adwBandeau
idwPapier	= adwPapier
/*------------------------------------------------------------------*/
/* On populise le Bandeau. Ce bandeau contient deux DDDW. La        */
/* premi$$HEX1$$e800$$ENDHEX$$re sur les types de papier. La seconde sur les             */
/* d$$HEX1$$e900$$ENDHEX$$partements.                                                    */
/*------------------------------------------------------------------*/
idwBandeau.InsertRow ( 0 )
idwBandeau.GetChild ( "ID_TYP_PAPIER", dwChild )
/*------------------------------------------------------------------*/
/* On modifie l'apparence de la DDDW.                               */
/*------------------------------------------------------------------*/
dwChild.Modify ( "ID_CODE.Width = 161 LIB_CODE.X = 188 ID_CODE.Alignment='0'" )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les lignes de la table CODE_CAR.                     */
/*------------------------------------------------------------------*/
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-TP" )
/*------------------------------------------------------------------*/
/* On ajoute une ligne pour "TOUS".                                 */
/*------------------------------------------------------------------*/
lLig = dwChild.InsertRow ( 0 )
dwChild.SetItem ( lLig, "ID_CODE", "TOUS" )
dwChild.SetItem ( lLig, "LIB_CODE", "Tous les papiers" )
/*------------------------------------------------------------------*/
/* On populise maintenant la liste des d$$HEX1$$e900$$ENDHEX$$partements.                */
/*------------------------------------------------------------------*/
idwBandeau.GetChild ( "ID_DEPT", dwChild )
/*------------------------------------------------------------------*/
/* On modifie l'apparence de la DDDW.                               */
/*------------------------------------------------------------------*/
dwChild.Modify ( "ID_CODE.Width = 161 LIB_CODE.X = 188" )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les lignes de la table CODE_CAR.                     */
/*------------------------------------------------------------------*/
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-DP" )
/*------------------------------------------------------------------*/
/* On modifie de mani$$HEX1$$e800$$ENDHEX$$re dynamique l'ordre de tri. Tous les         */
/* ID_CODE sont de type num$$HEX1$$e900$$ENDHEX$$rique, sauf la CORSE 2A-2B qui va se    */
/* retrouver tout en haut de la DDDW.                               */
/*------------------------------------------------------------------*/
dwChild.SetSort ( "Long ( ID_CODE )" )
dwChild.Sort ()
/*------------------------------------------------------------------*/
/* On positionne l'objet de transaction sur la seconde DW.          */
/*------------------------------------------------------------------*/
idwPapier.SetTransObject ( SQLCA )
idwPapier.Retrieve ()
/*------------------------------------------------------------------*/
/* On positionne par d$$HEX1$$e900$$ENDHEX$$faut "TOUS" pour le type de papier afin de   */
/* ne rien filtrer.                                                 */
/*------------------------------------------------------------------*/
idwBandeau.SetItem ( 1, "ID_TYP_PAPIER", "TOUS" )
This.uf_Filtrer_Papier ( "" )

Return ( iRet )
end function

public function integer uf_controlerzone (string asnomcol, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_ControlerZone	(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re les zones en saisie
//*
//* Arguments		: (Val)		String						asNomCol
//*					  (Val)		String						asData
//*
//* Retourne		: Integer				 Valeur de retour pour ItemChanged
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
iRet = 0

Choose Case asNomCol
Case "ID_TYP_PAPIER"
	iRet = This.uf_Zn_IdTypPapier ( asData )

Case "ID_DEPT"
	iRet = This.uf_Zn_IdDept ( asData )

End Choose

Return ( iRet )
end function

private function integer uf_zn_idtyppapier (string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_Zn_IdTypPapier	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re la zone ID_TYP_PAPIER
//*
//* Arguments		: (Val)		String						asData
//*
//* Retourne		: Integer				 Valeur de retour pour ItemChanged
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
String sMod, sFiltre
iRet = 0

/*------------------------------------------------------------------*/
/* Si le type de papier est PC (Permis de conduire) ou CG (Carte    */
/* grise) ou TOUS (Tous les papiers), on peut rendre visible la     */
/* zone ID_DEPT.                                                    */
/*------------------------------------------------------------------*/
/* De plus, on positionne la zone ID_DEPT $$HEX2$$e0002000$$ENDHEX$$NULL.                   */
/*------------------------------------------------------------------*/
Choose Case asData
Case "PC", "CG", "TOUS"
	sMod		= "ID_DEPT.Visible = 1 ID_DEPT_T.Visible = 1"
	If	asData = "TOUS"	Then
		sFiltre	= ""
	Else
		sFiltre = "ID_TYP_PAPIER = '" + asData + "'"
	End If
Case Else
	sMod = "ID_DEPT.Visible = 0 ID_DEPT_T.Visible = 0"
	sFiltre = "ID_TYP_PAPIER = '" + asData + "'"
End Choose

idwBandeau.Modify ( sMod )
idwBandeau.SetItem ( 1, "ID_DEPT", stNul.str )
/*------------------------------------------------------------------*/
/* On filtre la DW qui contient tous les papiers en fonction de la  */
/* s$$HEX1$$e900$$ENDHEX$$lection pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente.                                            */
/*------------------------------------------------------------------*/
This.uf_Filtrer_Papier ( sFiltre )

Return ( iRet )
end function

private subroutine uf_filtrer_papier (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_Filtre_Papier	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va filtre la DW des papiers en fonctions des crit$$HEX1$$e900$$ENDHEX$$res
//*
//* Arguments		: (Val)		String						asFiltre
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

idwPapier.SetFilter ( asFiltre )
idwPapier.Filter ()
idwPapier.Sort ()
idwPapier.GroupCalc ()

end subroutine

private function integer uf_zn_iddept (string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_Zn_IdDept	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re la zone ID_DEPT
//*
//* Arguments		: (Val)		String						asData
//*
//* Retourne		: Integer				 Valeur de retour pour ItemChanged
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
String sIdTypPapier, sFiltre
iRet = 0

sIdTypPapier = idwBandeau.GetItemString ( 1, "ID_TYP_PAPIER" )
If	IsNull ( sIdTypPapier )	Then Return ( 0 )

sFiltre = ""
If	sIdTypPapier = "TOUS"	Then
	sFiltre = "( ID_TYP_PAPIER = 'PC' Or ID_TYP_PAPIER = 'CG' ) "
Else
	sFiltre = "ID_TYP_PAPIER = '" + sIdTypPapier + "'"
End If

sFiltre = sFiltre + " And ( ID_DEPT = '" + asData + "' )"

This.uf_Filtrer_Papier ( sFiltre )

Return ( iRet )
end function

public subroutine uf_sauvegarder_position (long alcoor[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_AidePapier::uf_Sauvegarder_Position	(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/11/2001 08:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On sauvegarde la position de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: (Val)		Long							alCoor[]
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//* #1 [DCMP-060643]-29/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String sSection, sFicConfig, sText, sRc, sPathSpb

// #1 [DCMP-060643]-29/09/2006-PHG Gestion repertoire temporaire
//sPathSpb = ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" )
//sFicConfig	= sPathSpb + "\INTERRO.INI"
sFicConfig	= stGlb.sRepTempo + "\INTERRO.INI"
sRc			= "~n~r"
/*------------------------------------------------------------------*/
/* On va enregistrer les coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre d'affichage des  */
/* papiers. Cela permettra de r$$HEX1$$e900$$ENDHEX$$ouvrir la fen$$HEX1$$ea00$$ENDHEX$$tre au m$$HEX1$$ea00$$ENDHEX$$me endroit.  */
/*------------------------------------------------------------------*/
/* Si le fichier n'existe pas, on le cr$$HEX3$$e900e9002000$$ENDHEX$$et on enregistre les      */
/* coordonn$$HEX1$$e900$$ENDHEX$$es.                                                     */
/*------------------------------------------------------------------*/
sSection = stGLB.sCodAppli + " " + "TARIF_PAPIER"

//Migration PB8-WYNIWYG-03/2006 FM
//If	Not FileExists ( sFicConfig ) Then
If	Not f_FileExists ( sFicConfig ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	sText = "[" + sSection + "]" + sRc + "X=" + String ( alCoor[1] ) + sRc + "Y=" + String ( alCoor[2] ) + sRc
	f_EcrireFichierText ( sFicConfig, sText )
Else
	SetProfileString ( sFicConfig, sSection, "X", String ( alCoor[1] ) )
	SetProfileString ( sFicConfig, sSection, "Y", String ( alCoor[2] ) )
End If

end subroutine

on n_cst_aidepapier.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_aidepapier.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

