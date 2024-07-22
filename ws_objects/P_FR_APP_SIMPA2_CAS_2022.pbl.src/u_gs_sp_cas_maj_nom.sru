HA$PBExportHeader$u_gs_sp_cas_maj_nom.sru
forward
global type u_gs_sp_cas_maj_nom from nonvisualobject
end type
end forward

global type u_gs_sp_cas_maj_nom from nonvisualobject
end type
global u_gs_sp_cas_maj_nom u_gs_sp_cas_maj_nom

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow		idw_wSin

	String			isTypeTrt = ""
	String			isFicTrace = ""

	DataWindow		idw_Rech





end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_valider (ref s_pass astpass)
private subroutine uf_ecriretrace ()
public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans)
private subroutine uf_controlersaisie (ref s_pass astpass)
public subroutine uf_initialiser_dw (ref datawindow adw_norm)
private function long uf_verifier_homonymes ()
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_Adh::Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fen$$HEX1$$ea00$$ENDHEX$$tre)
	Uf_InitialiserFenetre ()

Case 2					// MODIFICATION		(Wf_PreparerModifier)
	Uf_PreparerModifier ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )

Case 5					// Recherche homonymes ( Wf_ControlerGestion )
	Uf_Verifier_Homonymes 	( )

Case 7					// VALIDER	(Wf_Valider) ( La fonction anc$$HEX1$$ea00$$ENDHEX$$tre est totalement r$$HEX2$$e900e900$$ENDHEX$$crite. )
	Uf_Valider ( astPass )

End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_MAJ_NOM::Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

String sRep

/*------------------------------------------------------------------*/
/* On initialise l'objet de transaction de dw_wSIn.                 */
/*------------------------------------------------------------------*/
idw_wSin.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes COD_CIV, COD_CIV_NOUVEAU                                 */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "COD_CIV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CI", "-CL" )

idw_wSin.GetChild ( "COD_CIV_NOUVEAU", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_ADR", "" )
isFicTrace = sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )




end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Maj_Nom::Uf_PreparerModifier (PRIVATE)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String		sCiv, sNom, sPrenom
Boolean bRet

bRet = True

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'enregistrement.                                    */
/*------------------------------------------------------------------*/
If	idw_wSin.Retrieve ( Dec ( astPass.sTab [ 1 ] ), astPass.sTab [ 2 ] ) <= 0 Then 

	bRet = False
Else


	idw_wSin.ilPremCol	= 21
	idw_wSin.ilDernCol	= 23

//*-----------------------------------------------------------------
//* Recopie des valeurs actuelles civilit$$HEX1$$e900$$ENDHEX$$, Nom, pr$$HEX1$$e900$$ENDHEX$$nom 
//* dans les nouvelles zones
//*-----------------------------------------------------------------

	sCiv		=	idw_wSin.GetItemString ( 1, "COD_CIV" )
	sNom		=	idw_wSin.GetItemString ( 1, "NOM" )
	sPrenom	=	idw_wSin.GetItemString ( 1, "PRENOM" )

	idw_wSin.SetItem ( 1, "COD_CIV_NOUVEAU"	, sCiv    )
	idw_wSin.SetItem ( 1, "NOM_NOUVEAU" 		, sNom    )
	idw_wSin.SetItem ( 1, "PRENOM_NOUVEAU" 	, sPrenom )

End If
astPass.bRetour	= bRet


end subroutine

private subroutine uf_valider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Maj_Nom::Uf_Valider (PRIVATE)
//* Auteur			: DBI
//* Date				: 24/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Mise $$HEX2$$e0002000$$ENDHEX$$jour nom
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------
Boolean			bRet = True
String			sIdSin, sNom, sPrenom, sCodCiv, sSql, sAltOccupe

sIdSin		=	String ( idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
sCodCiv		=	idw_wSin.GetItemString ( 1, "COD_CIV_NOUVEAU" )
sNom			=	idw_wSin.GetItemString ( 1, "NOM_NOUVEAU"     )
sPrenom		=	idw_wSin.GetItemString ( 1, "PRENOM_NOUVEAU"  )


SELECT 	alt_occupe
INTO		:sAltOccupe
FROM     sysadm.w_queue
WHERE    id_sin = :sIdSin
USING		itrTrans;

If ( itrTrans.SqlCode = 0 ) And ( sAltOccupe = 'O' ) Then		// existe un travail en cours occup$$HEX1$$e900$$ENDHEX$$

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la mise $$HEX2$$e0002000$$ENDHEX$$jour de nom"
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "CASP520"
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )
	astPass.bRetour = False
	Return
End If

// [DECIMAL_PAPILLON]
sSql	= "EXECUTE sysadm.PS_U01_PERSONNE_CAS2 " + sIdSin + ".,'" + sCodCiv + "', '" + sNom + "', '" + sPrenom + "'"

// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
//EXECUTE IMMEDIATE :sSql USING	itrTrans	;
f_execute( sSql, itrTrans )
// [MIGPB11] [EMD] : Fin Migration

/*------------------------------------------------------------------*/
/* Si SqlDbCode ou SqlCode sont arm$$HEX1$$e900$$ENDHEX$$s, on part du principe qu'il y  */
/* a eu une erreur.                                                 */
/*------------------------------------------------------------------*/
If itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0 Then	bRet = False

/*------------------------------------------------------------------*/
/* On s'occupe maintenant du COMMIT, ou du ROLLBACK.                */
/*------------------------------------------------------------------*/
If	bRet	Then
	F_Commit ( itrTrans, True )
	uf_EcrireTrace ()

Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/

	stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sVar[1] 	= "PS_U01_PERSONNE_CAS2"
	stMessage.sVar[2] 	= String ( itrTrans.SqlDbCode )
	stMessage.sVar[3] 	= itrTrans.SqlErrText
	stMessage.sCode		= "WORK220"
   stMessage.bTrace  	= True

/*------------------------------------------------------------------*/
/* On peut envoyer le ROLLBACK.                                     */
/*------------------------------------------------------------------*/
	F_Commit ( itrTrans, False )
/*------------------------------------------------------------------*/
/* On peut afficher le message sans risques.                        */
/*------------------------------------------------------------------*/
	F_Message ( stMessage )
End If

astPass.bRetour = bRet

end subroutine

private subroutine uf_ecriretrace ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Maj_Nom::Uf_EcrireTrace ( Private )
//* Auteur			: DBI
//* Date				: 29/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


Long lTot, lCpt

String sTrace[13]
String sLigne, sTab, sAltAdr

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* ID_SIN							01                                    */
/* ID_PROD 							02                                    */
/* ID_ETS							03                                    */
/* ID_ADH	 						04                                    */
/* ID_SDOS							05                                    */
/* ADR_1		 						06                                    */
/* ADR_2								07                                    */
/* ADR_CP							08                                    */
/* ADR_VILLE						09                                    */
/* NOM								10                                    */
/* PRENOM							11                                    */
/* DOS_MAJ_LE (Fin)				12                                    */
/* DOS_MAJ_PAR (Fin)				13                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

sTrace[  1 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_SIN" 		) )
sTrace[  2 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" 	) )
sTrace[  3 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_ETS" 		) )
sTrace[  4 ]  = idw_wSin.GetItemString 			( 1, "ID_ADH" 		)
sTrace[  5 ]  = String ( idw_wSin.GetItemNumber ( 1, "ID_SDOS" 	) )
sTrace[  6 ]  = Trim ( idw_wSin.GetItemString 	( 1, "ADR_1" 		) )
sTrace[  7 ]  = Trim ( idw_wSin.GetItemString 	( 1, "ADR_2" 		) )
sTrace[  8 ]  = idw_wSin.GetItemString 			( 1, "ADR_CP" 		)
sTrace[  9 ]  = Trim ( idw_wSin.GetItemString 	( 1, "ADR_VILLE" 	) )
sTrace[ 10 ]  = Trim ( idw_wSin.GetItemString 	( 1, "NOM_NOUVEAU") )
sTrace[ 11 ]  = Trim ( idw_wSin.GetItemString 	( 1, "PRENOM_NOUVEAU" ) )
sTrace[ 12 ]  = String ( DateTime ( Today(), Now () ), "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 13 ]  = stGLB.sCodOper

sLigne	= ""
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( isFicTrace, sLigne )

end subroutine

public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Id_ADh::Uf_Initialisation (Public)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du sinistre
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_wSin		= adw_Sin
itrTrans		= atrTrans

uf_InitialiserFenetre ( )

end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Maj_Nom::Uf_ControlerSaisie (PRIVATE)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie du cas particulier
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String  sPos, sCivNouveau,sNomNouveau,sPrenomNouveau

Integer iRet

sPos	= ""

sCivNouveau		= idw_wSin.GetItemString ( 1, "COD_CIV_NOUVEAU" )
sNomNouveau		= idw_wSin.GetItemString ( 1, "NOM_NOUVEAU" )
sPrenomNouveau	= idw_wSin.GetItemString ( 1, "PRENOM_NOUVEAU" )

If	Trim ( sCivNouveau ) 	= ""	Then sCivNouveau		= stNul.str 
If	Trim ( sNomNouveau ) 	= ""	Then sNomNouveau		= stNul.str 
If	Trim ( sPrenomNouveau ) = ""	Then sPrenomNouveau	= stNul.str 

/*------------------------------------------------------------------*/
/* Si la zone ID_ADH est NULL, on demande confirmation $$HEX2$$e0002000$$ENDHEX$$la         */
/* personne.                                                        */
/*------------------------------------------------------------------*/

If	IsNull ( sCivNouveau ) Or IsNull ( sNomNouveau ) Or IsNull ( sPrenomNouveau )  Then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la mise $$HEX2$$e0002000$$ENDHEX$$jour de nom"
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "CASP500"
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )
	sPos = "COD_CIV_NOUVEAU"
End If

astPass.sTab [ 1 ] 	= sPos

end subroutine

public subroutine uf_initialiser_dw (ref datawindow adw_norm);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: DataWindow				adw_Norm[1]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
DataWindowChild		dwChild

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow de recherche des homonymes                            */
/*------------------------------------------------------------------*/
idw_Rech	= adw_Norm
idw_Rech.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* Chargement Dw Cod_Civ pour fen$$HEX1$$ea00$$ENDHEX$$tre de recherche homonymes        */
/*------------------------------------------------------------------*/
idw_Rech.GetChild ( "COD_CIV", dwChild )

dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve ( '-CI', '-CL' )

end subroutine

private function long uf_verifier_homonymes ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cas_Maj_Nom::Uf_Verifier_Homonymes (PRIVATE)
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche des homonymes avant modification
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String		sNom, sPrenom
Decimal {7} dcIdSin
Long			lNbLig

sNom		=	idw_wSin.GetItemString ( 1, "NOM_NOUVEAU" 		)
sPrenom	=	idw_wSin.GetItemString ( 1, "PRENOM_NOUVEAU" 	)
dcIdSin	=	idw_wSin.GetItemNumber ( 1, "ID_SIN" 				)

lNbLig = idw_Rech.Retrieve ( dcIdSin, sNom, sPrenom )

Return lNbLig
end function

on u_gs_sp_cas_maj_nom.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_cas_maj_nom.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

