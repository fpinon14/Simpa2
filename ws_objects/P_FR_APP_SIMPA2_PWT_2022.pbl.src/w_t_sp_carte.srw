HA$PBExportHeader$w_t_sp_carte.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des cartes
forward
global type w_t_sp_carte from w_8_traitement
end type
end forward

global type w_t_sp_carte from w_8_traitement
integer x = 631
integer y = 768
integer width = 2382
integer height = 856
string title = "Gestion des cartes"
event ue_droitecriture pbm_custom41
end type
global w_t_sp_carte w_t_sp_carte

type variables
u_sp_gs_carte		iuoGsCarte
u_sp_zn_carte		iuoZnCarte
end variables

forward prototypes
public function string wf_controlersaisie ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparervalider ()
public function string wf_controlergestion ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_carte
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
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

PictureButton TbPict []

TbPict[1] = pb_valider
TbPict[2] = pb_supprimer

F_Droit_Ecriture_Param ( tbPict, "" )


end on

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie
//* Auteur			: YP
//* Date				: 04/09/1997 16:02:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					  CARTE
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol[5]				//Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[5]				//Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String 		sNouvelleLigne		//Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText					//Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String		sPos					//Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$
String		sVal					//Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification
Long 			lCpt					//Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long			lNbrCol				//Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier


sNouvelleLigne			= "~r~n"
lNbrCol					= UpperBound ( sCol )
sPos						= ""
sText						= sNouvelleLigne

sCol[ 1 ]				= "lib_carte"
sCol[ 2 ]				= "id_type_carte"
sCol[ 3 ]				= "id_grp"
sCol[ 4 ]				= "val_rg_mini"
sCol[ 5 ]				= "val_rg_max"

sErr[ 1 ]				= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de la carte"
sErr[ 2 ]				= " - Le type de la carte"
sErr[ 3 ]				= " - L'$$HEX1$$e900$$ENDHEX$$tablissement"
sErr[ 4 ]				= " - Le rang mini"
sErr[ 5 ]				= " - Le rang maxi"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt = 3 Then

		sVal = String ( Dw_1.GetItemNumber ( 1 , sCol [ lCpt ] ) )

	Else

		sVal = Dw_1.GetItemString ( 1, sCol[ lCpt ] )

	End If

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Cartes"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If


Return ( sPos )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerInserer
//* Auteur			: YP
//* Date				: 04/09/1997 16:06:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$cise la premi$$HEX1$$e800$$ENDHEX$$re et la derni$$HEX1$$e800$$ENDHEX$$re colonne                       */
/*------------------------------------------------------------------*/

Dw_1.ilPremCol = 4
Dw_1.ilDernCol = 6
Dw_1.SetColumn ( Dw_1.ilPremCol )

Return ( TRUE )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerModifier
//* Auteur			: YP
//* Date				: 04/09/1997 16:06:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------

Dw_1.ilPremCol = 4
Dw_1.ilDernCol = 6

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


If Dw_1.Retrieve ( Dec ( istPass.sTab[1] ) ) <= 0 Then Return ( False )

Return ( TRUE )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerSupprimer
//* Auteur			: YP
//* Date				: 04/09/97 16:08:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Demande de confirmation avant suppression
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			//Variable de retour de la fonction 
Long	 	dcIdCarte	//Identifiant de la carte $$HEX2$$e0002000$$ENDHEX$$supprimer
Integer	iRet			//Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/

stMessage.sTitre 		= "Suppression d'une Carte"
stMessage.sVar[ 1 ] 	= "cette carte"
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

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rencielle vis $$HEX2$$e0002000$$ENDHEX$$vis de la table  */
	/* AFFILIER                                                         */
	/*------------------------------------------------------------------*/

	dcIdCarte 	= Dw_1.GetItemNumber ( 1, "ID_CARTE" )
	bRet 			= iuoGsCarte.uf_Gs_Sup_Carte ( dcIdCarte )

	If ( Not bRet ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'une Carte"
		stMessage.sVar[ 1 ] 	= "des garanties"
		stMessage.sVar[ 2 ] 	= "cette carte"
		stMessage.sCode		= "REFU002"

		f_Message ( stMessage )
		
	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/

		Dw_1.DeleteRow ( 0 )

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerValider
//* Auteur			: YP
//* Date				: 04/09/97 16:09:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Pr$$HEX1$$e900$$ENDHEX$$pare Les infos en cr$$HEX1$$e900$$ENDHEX$$ation.
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		 TRUE = La validation peut continuer
//*
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'une nouvelle carte                                 */
/*------------------------------------------------------------------*/

If ( istPass.bInsert ) Then

		f_Creele ( Dw_1, 1 )		

End If

f_MajPar ( Dw_1, 1 )

Return ( TRUE )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerGestion
//* Auteur			: YP
//* Date				: 04/09/1997 16:00:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de gestion des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					  CARTE
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------
Boolean     bChevauche			//Indique s'il y a chevauchement de plage de No ou non
Boolean     bRet 					//Valeur de retour de la fonction uf_zn_rangcarte
String		sPos			=""	//Nom du champ en erreur
Long      	dcIdCarte         //Carte sur laquelle on se trouve
String		sText					// Lib du cr$$HEX1$$e900$$ENDHEX$$neau de carte chevauch$$HEX1$$e900$$ENDHEX$$

/*------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le que le rang mini est inf$$HEX1$$e800$$ENDHEX$$rieur au rang maxi             */
/*------------------------------------------------------------------*/

bRet = iUoZnCarte.Uf_Zn_RangCarte( Dw_1.GetITemString(1,"VAL_RG_MINI"), &
	 										  Dw_1.GetITemString(1,"VAL_RG_MAX" )   )
 
If bRet = FALSE then

	sPos = "VAL_RG_MINI"
	stMessage.sTitre   = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Cartes"
	stMessage.Icon     = Information!
	stMessage.scode    = "REFU040"

	f_Message( stMessage )

Else

	/*------------------------------------------------------------------*/
	/* Contr$$HEX1$$f400$$ENDHEX$$le qu'il n'existe pas un rang mini ou un rang maxi dans la */
	/* plage que l'on d$$HEX1$$e900$$ENDHEX$$finit :                                         */
	/*------------------------------------------------------------------*/


	/*------------------------------------------------------------------*/
	/* En cas de cr$$HEX1$$e900$$ENDHEX$$ation, on initialise l'Id Carte $$HEX2$$e0002000$$ENDHEX$$0. En             */
	/* modification, on l'initialise $$HEX35$$e0002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
	/* la valeur courante.                                              */
	/* Ceci permet d'exclure la plage en cours du test de               */
	/* chevauchement en cas de modification ; sinon on trouverait       */
	/* toujours une plage existante avec chevauchement.                 */
	/*------------------------------------------------------------------*/

	dcIdCarte = Dw_1.GetItemNumber ( 1, "ID_CARTE" )

	If IsNull ( dcIdCarte ) then

		dcIdCarte = 0

	End If

	bChevauche = iUoGsCarte.Uf_Gs_Chevaucher( dcIdCarte                           ,    &
															Dw_1.GetITemString(1,"VAL_RG_MINI") ,    &
															Dw_1.GetItemString(1,"VAL_RG_MAX")  ,	  &
															sText  )


	/*------------------------------------------------------------------*/
	/* Si un rang mini ou maxi chevauche la plage d$$HEX1$$e900$$ENDHEX$$finie :             */
	/*------------------------------------------------------------------*/

	If bChevauche then

		sPos = "VAL_RG_MINI"
		stMessage.sTitre    = "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Cartes"
		stMessage.Icon      = Information!
		stMessage.sCode     = "GENE041"
		stMessage.sVar [1]  = "Carte         : " + Trim ( Left ( sText, Pos ( sText, ";", 1 ) - 1 ) ) + "~n~r"
		sText = Replace ( sText, 1, Pos ( sText, ";", 1 ), "" ) 
		stMessage.sVar [1] += "Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: " + Trim ( Left ( sText, Pos ( sText, ";", 1 ) - 1 ) )  + "~n~r"
		sText = Replace ( sText, 1, Pos ( sText, ";", 1 ), "" ) 
		stMessage.sVar [1] += "Rang min  : " + String ( Trim ( Left ( sText, Pos ( sText, ";", 1 ) - 1 ) ), "@@@@-@@@@-@@@@-@@@@" ) + "~n~r"
		sText = Replace ( sText, 1, Pos ( sText, ";", 1 ), "" ) 
		stMessage.sVar [1] += "Rang max : " + String ( Trim ( Left ( sText, Pos ( sText, ";", 1 ) - 1 ) ), "@@@@-@@@@-@@@@-@@@@" ) 

		f_Message( stMessage )

	End if

End If

Return ( sPos )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_terminervalider
//* Auteur			: YP
//* Date				: 04/09/97 16:11:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: termine la validation.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	OK, la validation peut continuer.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_terminerSupprimer
//* Auteur			: YP
//* Date				: 04/09/97 16:11:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: termine la suppression
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	OK, la validation peut continuer.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_carte
//* Evenement 		: Ue_Initialiser
//* Auteur			: YP
//* Date				: 04/09/97 15:30:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					  Cartes
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
DatawindowChild	DwcTypCarte
/*------------------------------------------------------------------*/
/* Initialisation des User Object de contr$$HEX1$$f400$$ENDHEX$$les de gestion et de     */
/* saisie                                                           */
/*------------------------------------------------------------------*/

iuoGsCarte = Create u_sp_gs_Carte
iuoGsCarte.uf_initialisation ( itrTrans, Dw_1 )

iuoZnCarte = Create u_sp_zn_Carte
iuoZnCarte.uf_initialisation ( itrTrans, Dw_1 )

/*------------------------------------------------------------------*/
/* Initialisation de la transaction de DW_1                         */
/*------------------------------------------------------------------*/

Dw_1.Uf_SetTransObject ( itrTrans )

Dw_1.GetChild ( "ID_TYPE_CARTE", DwcTypCarte )

DwcTypCarte.SetTransObject ( itrTrans )

If ( DwcTypCarte.Retrieve ( "-TC" ) <= 0  ) Then

	DwcTypCarte.InsertRow ( 0 )

End If
end on

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_carte
//* Evenement 		: ue_majaccueil
//* Auteur			: YP
//* Date				: 04/09/1997 15:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Long              lNumLigneGrp	// No de ligne dans la DDDW Etablissement
String 				sTab				// Code tabulation
String				sMajLe			// Variable tampon pour Maj_le
Long	   			dcIdGrp      	// Id de l'$$HEX1$$e900$$ENDHEX$$tablissement
String   			sLibGrp     	// Libell$$HEX2$$e9002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$tablissement
DataWindowChild 	dwGrp       	// DDDW de l'$$HEX1$$e900$$ENDHEX$$tablissement

sTab				= "~t"
sMajLe			= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

/*------------------------------------------------------------------*/
/* Recherche du libell$$HEX2$$e9002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$tablissement dans la DDDW.            */
/*------------------------------------------------------------------*/

Dw_1.GetChild ( "id_grp", dwGrp )

dcIdGrp         = dw_1.GetItemNumber ( 1, "ID_GRP" )

lNumLigneGrp   = dwGrp.Find ( "id_grp=" + String ( dcIdGrp ) , 1, dwGrp.RowCount() )

If lNumLigneGrp > 0 then
	sLibGrp        = dwGrp.GetItemString ( lNumLigneGrp, "LIB_GRP")

else
	sLibGrp			= "Introuvable"

End If


/*------------------------------------------------------------------*/
/* Initialisation de la chaine d'import                             */
/*------------------------------------------------------------------*/

isMajAccueil 	=	String ( dw_1.GetItemNumber ( 1, "ID_CARTE" ) )		+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_CARTE" ) 					+ sTab	+ &
 						sLibGrp 															+ sTab	+ &
 						dw_1.GetItemString ( 1, "VAL_RG_MINI" ) 				+ sTab	+ &
 						dw_1.GetItemString ( 1, "VAL_RG_MAX" ) 				+ sTab	+ &
						sMajLe								 							+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )


end on

on w_t_sp_carte.create
call super::create
end on

on w_t_sp_carte.destroy
call super::destroy
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_carte
//* Evenement 		: Close
//* Auteur			: YP
//* Date				: 04/09/1997 15:29:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des cartes                                   */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsCarte
//Destroy iuoZnCarte
If IsValid(iuoGsCarte) Then Destroy iuoGsCarte
If IsValid(iuoZnCarte) Then Destroy iuoZnCarte
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_1 from w_8_traitement`dw_1 within w_t_sp_carte
integer x = 18
integer y = 164
integer width = 2322
integer height = 596
string dataobject = "d_sp_carte"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1
//* Evenement 		: SQLPREVIEW
//* Auteur			: YP
//* Date				: 04/09/1997 15:35:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification du SqlPreview de la datawindow Dw_1
//*					  dans le cas de l'insertion ou de la suppression  
//*					  d'une Carte
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			// SqlPreview de la datawindow Dw_1
String		sDebSqlPreview 	// Debut du SqlPreview

Long			dcIdCarte			// Identifiant de la carte.
Long			dcIdGrp				// Identifiant de l'$$HEX1$$e900$$ENDHEX$$tablissement.
String		sLibCarte			// Libell$$HEX2$$e9002000$$ENDHEX$$de la carte.
String		sIdTypecarte		// Type de carte.
String		sValRgMini			// Rang Mini.
String		sValRgMax			// Rang Max.
String 		sMajPar				// Auteur de la mise $$HEX2$$e0002000$$ENDHEX$$jour.
DateTime		dtCreeLe				// Date de cr$$HEX1$$e900$$ENDHEX$$ation.
DateTime		dtMajLe				// Date de MAJ.

String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM

Long			lCpt					// Compteur de boucle.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "CARTE"

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview 		= Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
sDebSqlPreview 	= Left ( sSqlPreview, 4 )

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

Choose Case sDebSqlPreview

	Case	"INSE" 

		sIdTypeCarte	= Dw_1.GetItemString   ( 1, "ID_TYPE_CARTE" )
		dcIdGrp			= Dw_1.GetItemNumber   ( 1, "ID_GRP"        )
		sLibCarte  		= Dw_1.GetItemString   ( 1, "LIB_CARTE"     )
		sValRgMini		= Dw_1.GetItemString   ( 1, "VAL_RG_MINI"   )
		sValRgMax		= Dw_1.GetItemString   ( 1, "VAL_RG_MAX"    )
		dtCreele 		= Dw_1.GetItemDateTime ( 1, "CREE_LE"       )
		dtMajLe  		= Dw_1.GetItemDateTime ( 1, "MAJ_LE"        )
		sMajPar  		= Dw_1.GetItemString   ( 1, "MAJ_PAR"       )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_CARTE ( 		dcIdCarte  		, &
												sIdTypeCarte	, &
												dcIdGrp     	, &
										 	 	sLibCarte		, &
												sValRgMini		, &
												sValRgMax		, &
											 	dtCreeLe			, &
										 	 	dtMajLe 			, &
												sMajPar 					)

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			This.SetItem ( 1, "ID_CARTE", dcIdCarte )

			sCol = { "ID_CARTE", "ID_TYPE_CARTE", "ID_GRP", "LIB_CARTE", "VAL_RG_MINI", &
						"VAL_RG_MAX" }

			For lCpt = 1 To UpperBound ( sCol )
		
				sVal [ lCpt ] = f_GetItem ( Dw_1, 1, sCol [ lCpt ] )

			Next

			sCle [ 1 ]	= sVal [ 1 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If


	Case	"UPDA" 

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( GetItemNumber ( 1, "ID_CARTE" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		dcIdCarte = Dw_1.GetItemNumber ( 1, "ID_CARTE", DELETE!, FALSE )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_CARTE ( dcIdCarte )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + String ( dcIdCarte ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::Dw_1
//* Evenement 		: ItemError 
//* Auteur			: YP
//* Date				: 04/09/1997 15:34:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des messages d'erreur suite aux erreurs 
//*					  de saisies
//* Commentaires	: L'Erreur de type GENE003 est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par les r$$HEX1$$e800$$ENDHEX$$gles de validation.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Cartes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_TYPE_CARTE"
			stMessage.sVar[1] = "type de la carte"
			stMessage.sCode	= "GENE003"

		Case "LIB_CARTE"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$de la carte"
			stMessage.sCode	= "GENE003"

		Case "ID_GRP"
			stMessage.sVar[1] = "code de l'$$HEX1$$e900$$ENDHEX$$tablissement"
			stMessage.sCode	= "GENE003"

		Case "VAL_RG_MINI"


			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "rang mini"
					stMessage.sCode	= "GENE003"

				/*------------------------------------------------------------------*/
				/* Cas d'erreur lorsque le rang est compos$$HEX2$$e9002000$$ENDHEX$$de moins de 16          */
				/* chiffres.                                                        */
				/*------------------------------------------------------------------*/
				Case 1
					stMessage.sVar[1] = "mini"
					stMessage.sCode   = "REFU030"

			End Choose

		Case "VAL_RG_MAX"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "rang maxi"
					stMessage.sCode	= "GENE003"

				/*------------------------------------------------------------------*/
				/* Cas d'erreur lorsque le rang est compos$$HEX2$$e9002000$$ENDHEX$$de moins de 16          */
				/* chiffres.                                                        */
				/*------------------------------------------------------------------*/
				Case 1
					stMessage.sVar[1] = "maxi"
					stMessage.sCode   = "REFU030"
			End Choose
	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: dberror
//* Auteur			: YP
//* Date				: 04/09/97 15:33:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: YP
//* Date				: 04/09/97 15:34:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de champs
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String	sVal							//Valeur du champ saisi
Integer  iActionCode		= 0		//valeur du SetActionCode

sVal 		= This.GetText ( )

Choose Case isNomCol

	Case "VAL_RG_MINI", "VAL_RG_MAX"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le que le champ Rang Mini ou Maxi est bien compos$$HEX2$$e9002000$$ENDHEX$$de      */
		/*  16 chiffres.   																  */
 		/*------------------------------------------------------------------*/

		if iuoZnCarte.uf_Zn_LongueurRang ( sVal ) then

			iiErreur = 0

		Else

			iiErreur = 1

		End If

		If iiErreur > 0	Then &
			iActionCode =  1

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
//SetActionCode ( iActionCode )
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement`st_titre within w_t_sp_carte
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_carte
integer y = 24
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_carte
integer x = 283
integer y = 24
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_carte
boolean visible = false
integer y = 24
integer width = 229
boolean originalsize = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_carte
boolean visible = false
integer y = 24
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_carte
integer x = 530
integer y = 24
end type

