HA$PBExportHeader$w_t_sp_type_carte.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des types de cartes
forward
global type w_t_sp_type_carte from w_8_traitement
end type
end forward

global type w_t_sp_type_carte from w_8_traitement
integer x = 526
integer y = 481
integer width = 2587
integer height = 576
string title = "Gestion des types de carte"
end type
global w_t_sp_type_carte w_t_sp_type_carte

type variables
u_sp_gs_Type_Carte		iuoGsTypeCarte
end variables

forward prototypes
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
end prototypes

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie
//* Auteur			: YP
//* Date				: 04/09/1997 15:00:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					  TYPE_CARTE
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol[2]				//Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[2]				//Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String 		sNouvelleLigne		//Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText					//Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String		sPos					//Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$
String		sVal					//Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification
Long 			lCpt					//Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long			lNbrCol				//Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier

sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne

sCol[ 1 ]			= "id_type_carte"
sCol[ 2 ]			= "lib_type_carte"

sErr[ 1 ]			= " - Le code du type de carte"
sErr[ 2 ]			= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du type de carte"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	sVal = Dw_1.GetItemString ( 1, sCol[ lCpt ] )

	If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

		If sPos 	= "" Then sPos = sCol[ lCpt ]
		sText 	= sText + sErr[ lCpt ] + sNouvelleLigne
	End If
Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

If	sPos <> "" Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Types de Cartes"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ControlerGestion
//* Auteur			: YP
//* Date				: 04/09/1997 14:37:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de gestion de la saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: ""		->	Si contr$$HEX1$$f400$$ENDHEX$$le Ok
//*					  Nom de la colonne en Erreur	
//*
//*-----------------------------------------------------------------

String sCol = ""			//Nom de la colonne en Erreur
String sIdTypeCarte		//Identifiant du Type de Carte


If ( istPass.bInsert = True )  Then

	sIdTypeCarte 		= Dw_1.GetItemString ( 1, "ID_TYPE_CARTE" )

	If ( Not iuoGsTypeCarte.Uf_Gs_Id_Type_Carte ( sIdTypeCarte ) ) Then

		sCol 		= "ID_TYPE_CARTE"

	End If

End If

Return ( sCol )	

end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerValider
//* Auteur			: YP
//* Date				: 04/09/1997 15:04:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'un nouveau type de cartes.                         */
/*------------------------------------------------------------------*/

If ( istPass.bInsert ) Then

	f_Creele ( Dw_1, 1 )

End If

f_MajPar ( Dw_1, 1 )

Return ( TRUE )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerSupprimer
//* Auteur			: YP
//* Date				: 04/09/1997 15:03:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Demande de confirmation avant suppression
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*										
//*
//*-----------------------------------------------------------------

Boolean 	bRet 					//Variable de retour de la fonction 
String 	sIdTypeCarte		//Identifiant du type de cartes $$HEX2$$e0002000$$ENDHEX$$supprimer
Integer	iRet					//Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/

stMessage.sTitre 		= "Suppression d'un Type de Carte"
stMessage.sVar[ 1 ] 	= "ce type de carte"
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
	/* Carte                                                            */
	/*------------------------------------------------------------------*/

	sIdTypeCarte = Dw_1.GetItemString ( 1, "ID_TYPE_CARTE" )

	bRet = iuoGsTypeCarte.uf_Gs_Sup_TypeCarte ( sIdTypeCarte )

	If ( bRet = False ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression du Type de Carte"
		stMessage.sVar[ 1 ] 	= "des cartes"  
		stMessage.sVar[ 2 ] 	= "ce type de carte"
		stMessage.sCode		= "REFU002"

		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/

		dw_1.DeleteRow ( 0 )

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerInserer
//* Auteur			: YP
//* Date				: 04/09/1997 15:01:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------

String  	sCol[1]			//Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger

sCol[ 1 ] = "ID_TYPE_CARTE"

Dw_1.Uf_Proteger ( sCol, "0" )

Dw_1.ilPremCol = 1
Dw_1.ilDernCol = 2
Dw_1.SetColumn ( Dw_1.ilPremCol ) 

Return ( TRUE )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerModifier
//* Auteur			: YP
//* Date				: 04/09/1997 15:02:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------

String  	sCol[1]			//Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger


sCol[ 1 ] = "ID_TYPE_CARTE"

Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 2

Dw_1.Uf_Proteger ( sCol, "1" )

If Dw_1.Retrieve ( istPass.sTab[1] ) <= 0 Then Return ( false )

Return ( TRUE ) 

end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_terminervalider
//* Auteur			: YP
//* Date				: 04/09/97 15:06:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: termine la validation.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	si OK, la validation peut continuer.
//*										FALSE sinon.
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
//* Date				: 04/09/97 11:33:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: termine la suppression
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	si OK, la validation peut continuer.
//*										FALSE sinon.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_type_carte
//* Evenement 		: ue_majaccueil
//* Auteur			: YP
//* Date				: 04/09/1997 14:44:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation
String	sMajLe		// Variable tampon pour Maj_le

sTab				= "~t"
sMajLe			= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	dw_1.GetItemString ( 1, "ID_TYPE_CARTE" ) 	+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_TYPE_CARTE" )	+ sTab	+ &
						sMajLe								 					+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )

end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_type_carte
//* Evenement 		: Ue_Initialiser
//* Auteur			: YP
//* Date				: 04/09/1997 14:43:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					  Types de Cartes
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sCol[1]	//Tableau contenant les champs dont l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$

iuoGsTypeCarte = Create u_sp_gs_Type_Carte


Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/

sCol[1] 			= "ID_TYPE_CARTE"

Dw_1.Uf_InitialiserCouleur ( sCol )

iuoGsTypeCarte.uf_initialisation ( itrTrans, Dw_1 )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_type_carte
//* Evenement 		: Close
//* Auteur			: YP
//* Date				: 04/09/1997 14:43:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion pour le        */
/* param$$HEX1$$e900$$ENDHEX$$trage des types de cartes                                  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsTypeCarte
If IsValid(iuoGsTypeCarte) Then Destroy iuoGsTypeCarte
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_sp_type_carte.create
call super::create
end on

on w_t_sp_type_carte.destroy
call super::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_t_sp_type_carte
integer x = 27
integer y = 192
integer width = 2533
integer height = 328
string dataobject = "d_sp_type_carte"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1
//* Evenement 		: SQLPREVIEW
//* Auteur			: YP
//* Date				: 04/09/1997 14:47:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification du SqlPreview de la datawindow Dw_1
//*					  dans le cas de l'insertion d'un nouveau type carte.
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			//SqlPreview de la datawindow Dw_1
String		sDebSqlPreview 	//D$$HEX1$$e900$$ENDHEX$$but du SqlPreview

String		sIdTypeCarte		//Type de carte.
String		sLibTypeCarte		//Libell$$HEX2$$e9002000$$ENDHEX$$du Type de carte.
String		sMajPar				//Auteur de la MAJ.

DateTime		dtCreeLe				//Date de cr$$HEX1$$e900$$ENDHEX$$ation.
DateTime		dtMajLe				//Date de MAJ.

String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 5 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 5 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview 		= Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
sDebSqlPreview 	= Left ( sSqlPreview, 4 )

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "TYPE_CARTE"

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

Choose Case sDebSqlPreview

	Case	"INSE" 

		sIdTypeCarte	=	Dw_1.GetItemString  ( 1 , "ID_TYPE_CARTE" )
		sLibTypeCarte  = Dw_1.GetItemString   ( 1, "LIB_TYPE_CARTE" )
		dtCreele 		= Dw_1.GetItemDateTime ( 1, "CREE_LE"  )
		dtMajLe  		= Dw_1.GetItemDateTime ( 1, "MAJ_LE"   )
		sMajPar  		= Dw_1.GetItemString   ( 1, "MAJ_PAR"  )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_TYPE_CARTE (	sIdTypeCarte  	, &
										 	 	sLibTypeCarte 	, &
											 	dtCreeLe			, &
										 	 	dtMajLe 			, &
										 	 	sMajPar )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_TYPE_CARTE", "LIB_TYPE_CARTE" }

			sVal [ 1 ] = "'" + sIdTypeCarte  + "'"
			sVal [ 2 ] = "'" + sLibTypeCarte + "'"

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

		sCle [ 1 ]	= f_GetItem ( Dw_1, 1, "ID_TYPE_CARTE" )
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If


	Case	"DELE"

		sIdTypeCarte = Dw_1.GetItemString ( 1, "ID_TYPE_CARTE", DELETE!, FALSE )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_TYPE_CARTE ( sIdTypeCarte )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + sIdTypeCarte + "'"
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

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: dberror
//* Auteur			: YP
//* Date				: 04/09/97 14:45:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1
//* Evenement 		: ItemError
//* Auteur			: YP
//* Date				: 04/09/1997 14:46:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des messages d'erreur suite aux erreurs 
//*					  de saisies
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Types de Cartes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_TYPE_CARTE"
			stMessage.sVar[1] = "code du type de carte"
			stMessage.sCode	= "GENE003"

		Case "LIB_TYPE_CARTE"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$du type de carte"
			stMessage.sCode	= "GENE003"


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

type st_titre from w_8_traitement`st_titre within w_t_sp_type_carte
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_type_carte
integer y = 16
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_type_carte
integer x = 283
integer y = 16
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_type_carte
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_type_carte
boolean visible = false
integer y = 16
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_type_carte
integer x = 530
integer y = 16
end type

