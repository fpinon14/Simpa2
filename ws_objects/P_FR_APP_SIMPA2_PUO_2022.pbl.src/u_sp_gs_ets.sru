HA$PBExportHeader$u_sp_gs_ets.sru
forward
global type u_sp_gs_ets from nonvisualobject
end type
end forward

global type u_sp_gs_ets from nonvisualobject
end type
global u_sp_gs_ets u_sp_gs_ets

type variables
Private :

	DataWindow	idwEtsRev      // Liste des ets param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
	DataWindow	idwEtsDispo    // Liste des ets dispos non encore param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s
	DataWindow	idwLstGrp       // Liste des groupes non pr$$HEX1$$e900$$ENDHEX$$sents dans Ets
	u_transaction	itrTrans          // Objet de transaction

end variables

forward prototypes
public subroutine uf_afficherets (decimal adcidrev)
public subroutine uf_initialisation (ref datawindow adwetsrev, ref datawindow adwetsdispo, ref datawindow adwLstGrp, ref u_transaction atrtrans)
public subroutine uf_majrev (ref decimal adcidrev)
public function integer uf_zn_ets (string astexte, decimal adcidprod, long allignecourante)
public function long uf_supets (decimal adcidprod, decimal adcidets)
public function long uf_razets (string astexte)
public function long uf_terminervalider (decimal adcidprod, boolean abinsert, datetime adtmajle, ref u_spb_gs_trace auogstrace)
end prototypes

public subroutine uf_afficherets (decimal adcidrev);//*-----------------------------------------------------------------
//*
//* Fonction		: ( Public ) uf_AfficherEts
//* Auteur			: DBI
//* Date				: 20/01/1998 15:25:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Affiche dans le U_ajout les etablissements param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$s pour une r$$HEX1$$e900$$ENDHEX$$vision
//* Commentaires	: 
//*
//* Arguments		: adcIdRev Decimal - Num"ro de r$$HEX1$$e900$$ENDHEX$$vision $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

Long		lCpt				// Compteur de boucle
Long		lNbEtsDispo		// Nombre de ligne de la dw Ets Dispo
Long		lNbEtsRev		// Nombre de ligne de la dw Ets Rev
Long		lLig				// Tampon pour r$$HEX1$$e900$$ENDHEX$$cup n$$HEX2$$b0002000$$ENDHEX$$ligne

/*----------------------------------------------------------------------------*/
/* On g$$HEX1$$e800$$ENDHEX$$re 2 cas :                                                            */
/*                                                                            */
/* adcIdRev =  -1                                                             */
/* 	                                                                        */
/* 	On affiche dans la datawindow Cible la liste des groupes associ$$HEX1$$e900$$ENDHEX$$s au    */
/*    contractant                                                             */
/* 	et qui ne font pas partie des etablissements du produit                 */
/*                                                                            */
/* 	On affiche dans la datawindow Source la liste des $$HEX1$$e900$$ENDHEX$$tablissements avec   */
/*    id_rev = -1                                                             */
/*                                                                            */
/* adcIdRev <> -1                                                             */
/*                                                                            */
/* 	On affiche dans la datawindow Cible la liste des $$HEX1$$e900$$ENDHEX$$tablissements avec    */
/*    id_rev = -1                                                             */
/* 	et qui ne font pas partie des etablissements de la r$$HEX1$$e900$$ENDHEX$$vision             */
/*                                                                            */
/* 	On affiche dans la datawindow Source la liste des $$HEX1$$e900$$ENDHEX$$tablissements de la  */
/*    r$$HEX1$$e900$$ENDHEX$$vision                                                                */
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* On charge la Dw Cible avec tous les $$HEX1$$e900$$ENDHEX$$tablissements avec id_rev = -1.       */
/* On supprime ensuite ceux qui sont d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$affect$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$vision              */
/*----------------------------------------------------------------------------*/


If adcIdRev <> -1 Then
	iDwEtsDispo.ShareDataOff  ( )
	iDwEtsDispo.Reset    ( )

	iDwEtsRev.SetFilter  ( "ID_REV = -1" )
	iDwEtsRev.Filter     ( )	

	lNbEtsDispo	=	iDwEtsRev.RowCount ( )
	iDwEtsRev.RowsCopy ( 1, lNbEtsDispo, Primary!, iDwEtsDispo, 1, Primary! )

	iDwEtsRev.SetFilter  ( "ID_REV = " + String ( adcIdRev ) )
	iDwEtsRev.Filter     ( )	
	lNbEtsRev	=	iDwEtsRev.RowCount ( )

	
	For lCpt = lNbEtsDispo To 1 Step -1

		lLig = idwEtsRev.Find ( "ID_ETS = " + &
										String ( idwEtsDispo.GetItemNumber ( lCpt, "ID_ETS" ) ), &
										1, lNbEtsRev )

		If lLig > 0 Then

			idwEtsDispo.DeleteRow ( lCpt )
		End If
	Next	
	
	
End If
end subroutine

public subroutine uf_initialisation (ref datawindow adwetsrev, ref datawindow adwetsdispo, ref datawindow adwLstGrp, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: ( Public ) uf_Initialisation
//* Auteur			: DBI
//* Date				: 20/01/1998 15:02:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement des datawindows du u_ajout en instance
//* Commentaires	: 
//*
//* Arguments		: adwEtsRev   - Datawindow 
//*					  adwEtsDispo - Datawindow 
//*					  adwRecherche- Datawindow 
//*					  atrTrans    - Transaction
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

idwEtsRev   	= adwEtsRev   	
idwEtsDispo 	= adwEtsDispo 	
idwLstGrp  	   = adwLstGrp	
itrTrans    	= atrTrans    	




end subroutine

public subroutine uf_majrev (ref decimal adcidrev);//*-----------------------------------------------------------------
//*
//* Fonction		: ( Public ) uf_MajRev
//* Auteur			: DBI
//* Date				: 21/01/1998 09:50:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Armement de l'id_rev
//* Commentaires	: 
//*
//* Arguments		: Decimal	adcIdRev // Revision $$HEX2$$e0002000$$ENDHEX$$positionner
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

Long		lLig			// Compteur de boucle
Long		lNbLig		// Nombre de lignes de la datawindow

/*----------------------------------------------------------------------------*/
/* On repositionne dans idwEtsRev l'id_rev des lignes affich$$HEX1$$e900$$ENDHEX$$es dans la       */
/* liste des ets                                                              */
/*----------------------------------------------------------------------------*/
lNbLig	=	idwEtsRev.RowCount ( )

For lLig = 1 To lNbLig

	idwEtsRev.SetItem ( lLig, "ID_REV", adcIdRev )	
Next

end subroutine

public function integer uf_zn_ets (string astexte, decimal adcidprod, long allignecourante);//*-----------------------------------------------------------------
//*
//* Fonction		: ( public ) uf_zn_ets
//* Auteur			: DBI
//* Date				: 21/01/1998 10:31:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de saisie du ID_ETS
//* Commentaires	: 
//*
//* Arguments		: String			asTexte				(Val)	Valeur de la zone
//* 					  Decimal		adcIdProd			(Val)	Produit en cours
//* 					  Long			alLigneCourante	(Val)	Ligne click$$HEX1$$e900$$ENDHEX$$e sur Dw_Source
//*
//* Retourne		: Integer 	Indicant l'erreur rencontr$$HEX1$$e900$$ENDHEX$$e
//*								0 = pas d'erreur
//*								1 = l'ets existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$sur un autre groupe
//*								2 = Impossible de rechercher Les sinistres ( erreur SQL )
//*								3 = Pr$$HEX1$$e900$$ENDHEX$$sence de l'Ets dans La table permanente des sinistres
//*								4 = Pr$$HEX1$$e900$$ENDHEX$$sence de l'Ets dans La table de travail des sinistres
//*					( 3 et 4 sont issues de la proc Stock$$HEX1$$e900$$ENDHEX$$e )					
//*
//*-----------------------------------------------------------------

Decimal {0}		dcIdEts			// Valeur de l'ets saisi
Decimal {0}		dcIdEtsOld		// Valeur de l'ets avant la saisie
Decimal {0}		dcIdGrp			// Valeur du groupe sur lequel on travail

Long				lLig				// Variable de travail
Long				lNbLig			// Nombre de lignes de la Dw

Integer			iRet	= 0 		// Valeur de retour de la fonction
Integer			iSinistre		// Retour Proc Stock$$HEX1$$e900$$ENDHEX$$e pour savoir si sinistre en cours

dcIdEts	=	Dec ( asTexte )

/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'ID_ETS sur le produit                       */
/*----------------------------------------------------------------------------*/

lLig = idwEtsRev.Find ( "ID_ETS = " + String ( dcIdEts ), 1, iDwEtsRev.RowCount () )

If lLig > 0 Then

	iRet	=	1
Else

/*----------------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que l'ets n'est pas utilis$$HEX2$$e9002000$$ENDHEX$$sur un sinistre du produit          */
/*----------------------------------------------------------------------------*/

	dcIdGrp		=	idwEtsRev.GetItemNumber ( alLigneCourante, "ID_GRP" )
	dcIdEtsOld	=	idwEtsRev.GetItemNumber ( alLigneCourante, "ID_ETS" )


	itrTrans.IM_S01_ETABLISSEMENT ( adcIdProd, dcIdEtsOld, iSinistre )

	If itrTrans.SQLCode <> 0 Then

		iRet = 2
	Else

		If iSinistre <> 0 Then

			iRet 	=	iSinistre
		End If
	End If
End If

If iRet = 0 Then

/*----------------------------------------------------------------------------*/
/* On positionne le nouvel Ets Saisi sur toutes les r$$HEX1$$e900$$ENDHEX$$visions pour            */
/* lesquelles il est couvert                                                  */
/*----------------------------------------------------------------------------*/

	If Not ( isNull ( dcIdEts ) ) Then

		idwEtsRev.SetRedraw ( False )
		idwEtsRev.SetFilter ( "" )
		idwEtsRev.Filter ( )
		lNbLig	=	idwEtsRev.RowCount ( )


		lLig	=	1
		lLig	=	idwEtsRev.Find ( 	"ID_GRP = " + String ( dcIdGrp ) + " AND ID_ETS = " + String ( dcIdEtsOld ), &
											lLig, lNbLig )

		Do While lLig > 0 

			iDwEtsRev.SetItem ( lLig, "ID_ETS", dcIdEts )
			lLig  ++
			If lLig <= lNbLig Then

				lLig	=	idwEtsRev.Find ( 	"ID_GRP = " + String ( dcIdGrp ) + " AND ID_ETS = " + String ( dcIdEtsOld ), &
													 lLig, lNbLig )
			Else

				lLig	= -1
			End If
		Loop

		idwEtsRev.SetFilter ( "ID_REV = -1" )
		idwEtsRev.Filter ( )
		idwEtsRev.SetRedraw ( True )
	End If

End If

Return ( iRet )

end function

public function long uf_supets (decimal adcidprod, decimal adcidets);//*-----------------------------------------------------------------
//*
//* Fonction		: ( Public ) uf_SupEts
//* Auteur			: DBI
//* Date				: 21/01/1998 11:51:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rification lors de la suppression d'un ets 
//* Commentaires	: 
//*
//* Arguments		: Decimal  adcIdProd	// Produit auquel appartient l'Ets
//*					  Decimal  adcIdEts	// Ets que l'on veut supprimer
//* Retourne		: Long	0 = Ok pour Suppression
//*								1 = L'ets est couvert par au moins une r$$HEX1$$e900$$ENDHEX$$vision
//*								2 = Probl$$HEX1$$e800$$ENDHEX$$me SQL pour la recherche des sinistes
//*								3 = L'Ets est utilis$$HEX2$$e9002000$$ENDHEX$$sur au moins 1 sinistre valid$$HEX3$$e90009000900$$ENDHEX$$
//*								4 = L'Ets est utilis$$HEX2$$e9002000$$ENDHEX$$sur au moins 1 sinistre en saisie		
//*
//*-----------------------------------------------------------------

Long		lRet			= 0		// Retour de la fonction
Long		lLig						// Test de Ets / r$$HEX1$$e900$$ENDHEX$$vision 
Integer	iSinistre				// Test des sinistres sur Ets


idwEtsRev.SetRedraw ( False )
idwEtsRev.SetFilter ( "" )
idwEtsRev.Filter ( )

lLig	=	idwEtsRev.Find ( "ID_REV <> -1 AND ID_ETS = " + String ( adcIdEts ), 1, idwEtsRev.RowCount ( ) )
If lLig > 0 Then

	lRet = 1
Else

/*----------------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que l'ets n'est pas utilis$$HEX2$$e9002000$$ENDHEX$$sur un sinistre du produit          */
/*----------------------------------------------------------------------------*/

	itrTrans.IM_S01_ETABLISSEMENT ( adcIdProd, adcIdEts, iSinistre )

	If itrTrans.SQLCode <> 0 Then

		lRet = 2
	Else

		If iSinistre <> 0 Then

			lRet 	=	iSinistre * -1
		End If
	End If

End If

idwEtsRev.SetFilter ( "ID_REV = -1" )
idwEtsRev.Filter ( )
idwEtsRev.SetRedraw ( True )

Return ( lRet )
end function

public function long uf_razets (string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: ( Public ) uf_RazEts
//* Auteur			: DBI
//* Date				: 21/01/1998 16:46:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Personnalisation des Groupes d'un contractant apr$$HEX1$$e800$$ENDHEX$$s modif
//* Commentaires	: V$$HEX1$$e900$$ENDHEX$$rifie si d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$des sinistres saisis
//*
//* Arguments		: String			asTexte				(Val)	Nouveau contractant
//*
//* Retourne		: Long			 1 = L'adh$$HEX1$$e900$$ENDHEX$$sion existe
//*										-1 = L'adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas
//*
//*-----------------------------------------------------------------
Decimal {0}		dcIdGrp			// Groupe

dcIdGrp	=	Dec ( asTexte )

idwEtsRev.Reset ( )
idwLstGrp.Retrieve ( dcIdGrp )

Return ( 0 )

end function

public function long uf_terminervalider (decimal adcidprod, boolean abinsert, datetime adtmajle, ref u_spb_gs_trace auogstrace);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_TerminerValider
//* Auteur			: DBI
//* Date				: 22/01/1998 09:51:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Insertion des $$HEX1$$e900$$ENDHEX$$tablissements 
//* Commentaires	: 
//*
//* Arguments		: adcIdProd Decimal ( Produit en cours )
//*					  abInsert  Boolean ( Indique si on est cr$$HEX1$$e900$$ENDHEX$$ation de produit )
//*					  adtMajLe  Datetime( Indique si on est cr$$HEX1$$e900$$ENDHEX$$ation de produit )
//*					  auoGsTrace u_spb_gs_trace(  )
//* Retourne		: Long		1 si Ok
//*									-1 si erreur delete
//*									-2 si Erreur Insertion
//*									-3 si erreur Trace
//*
//*-----------------------------------------------------------------

String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 3 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String		sCol [ 7 ]			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal [ 7 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sMajPar				// Auteur de la mise $$HEX2$$e0002000$$ENDHEX$$jour.

Long			dcIdGrp				// Identifiant du contractant.
Long			dcIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision de cet $$HEX1$$e900$$ENDHEX$$tablissement.
Long			dcIdEts				// Identifiant de l'$$HEX1$$e900$$ENDHEX$$tablissement.
Long			lLig					// N$$HEX2$$b0002000$$ENDHEX$$de la ligne $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e800$$ENDHEX$$rer ou supprimer.
Long			lNbLig				// Nombre de lignes de la datawindow
Long			lRet = 1				// Retour de la fonction


/*----------------------------------------------------------------------------*/
/* Delete uniquement si on n'est pas en insertion                             */
/*----------------------------------------------------------------------------*/

If Not ( abInsert )	Then

	F_Execute ( "Exec sysadm.IM_D02_ETABLISSEMENT " + String ( adcIdProd ), itrTrans) 

	If Not F_Procedure ( stMessage, itrTrans, "IM_D02_ETABLISSEMENT" ) Then
		
		lRet	=	-1
	Else

		sVal [ 1 ] = "'" + String ( adcIdProd     ) + "'"

		sCle [ 1 ]	= sVal [ 1 ]

		sTable			= "ETABLISSEMENT"
		sCol 				= { "ID_PROD" }
		sType 			= 'D'

		If Not ( auoGsTrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			lRet	=	-3
		End If


	End If
End If

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable			= "ETABLISSEMENT"
sCol 				= { "ID_PROD" , "ID_GRP" , "ID_REV" , "ID_ETS" }
sType 			= 'I'

sMajPar	   	= stGLB.sCodOper
idwEtsRev.SetFilter ( "" )
idwEtsRev.Filter    ( )

lNbLig			= idwEtsRev.RowCount ( )

For lLig = 1 To lNbLig

	dcIdGrp			= idwEtsRev.GetItemNumber ( lLig, "ID_GRP" )
	dcIdRev			= idwEtsRev.GetItemNumber ( lLig, "ID_REV" )
	dcIdEts			= idwEtsRev.GetItemNumber ( lLig, "ID_ETS" )


	/*------------------------------------------------------------------*/
	/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
	/*------------------------------------------------------------------*/
	F_Execute ( "Exec sysadm.DW_I01_ETABLISSEMENT " + String ( adcIdProd ) + ", " + String ( dcIdGrp )+ ", " + String ( dcIdRev ) + ", " + String ( dcIdEts ) + ", '" + String ( adtMajLe, "dd/mm/aaaa hh:mm:ss" ) + "', '" + String ( adtMajLe, "dd/mm/aaaa hh:mm:ss" ) + "', '" + sMajPar + "'" , itrTrans) 

	If Not F_Procedure ( stMessage, itrTrans, "DW_I01_ETABLISSEMENT" )	Then

		lRet	=	-2

	Else

		sVal [ 1 ] = "'" + String ( adcIdProd     ) + "'"
		sVal [ 2 ] = "'" + String ( dcIdGrp       ) + "'"
		sVal [ 3 ] = "'" + String ( dcIdRev       ) + "'"
		sVal [ 4 ] = "'" + String ( dcIdets       ) + "'"

		sCle [ 1 ]	= sVal [ 1 ]
		sCle [ 2 ]	= sVal [ 2 ]
		sCle [ 3 ]	= sVal [ 3 ]

		If Not ( auoGsTrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			lRet	=	-3
		End If

	End If

Next

Return ( lRet )
end function

on u_sp_gs_ets.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_ets.destroy
TriggerEvent( this, "destructor" )
end on

