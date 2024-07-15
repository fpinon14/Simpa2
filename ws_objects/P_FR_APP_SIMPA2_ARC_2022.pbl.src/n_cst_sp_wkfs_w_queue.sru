HA$PBExportHeader$n_cst_sp_wkfs_w_queue.sru
forward
global type n_cst_sp_wkfs_w_queue from nonvisualobject
end type
end forward

global type n_cst_sp_wkfs_w_queue from nonvisualobject
end type
global n_cst_sp_wkfs_w_queue n_cst_sp_wkfs_w_queue

type variables
Public:
String		isIdOper
Private:

u_datawindow	idwStkSinistre
u_datawindow	idwTrtBoiteArchive

char		icOrigineTrt
end variables

forward prototypes
public subroutine uf_initialiser (ref u_datawindow adwstksinistre, ref u_datawindow adwtrtboitearchive)
public function boolean uf_preparer (s_pass astpass)
public function boolean uf_valider ()
end prototypes

public subroutine uf_initialiser (ref u_datawindow adwstksinistre, ref u_datawindow adwtrtboitearchive);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_Sp_Wkfs_w_queue::Uf_Initialiser (Public)
//* Auteur			: PLJ
//* Date				: 08/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adwStkSinistre			(R$$HEX1$$e900$$ENDHEX$$f)	
//*					  U_DataWindow				adwTrtBoiteArchive	(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Affectation des objets                                           */
/*------------------------------------------------------------------*/
idwStkSinistre			= adwStkSinistre
idwTrtBoiteArchive	= adwTrtBoiteArchive

idwStkSinistre.SetTransObject     ( SqlCa )
idwTrtBoiteArchive.SetTransObject ( SqlCa )



end subroutine

public function boolean uf_preparer (s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_Sp_Wkfs_w_queue::Uf_Preparer (Public)
//* Auteur			: PLJ
//* Date				: 08/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*                 et r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du num$$HEX1$$e900$$ENDHEX$$ro de bo$$HEX1$$ee00$$ENDHEX$$te en cours
//*
//* Arguments		: s_Pass	astPass
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

Boolean	bOk = True
Long		lLigne, lIdSin, lIdEts, lIdProd
Long  	lIdCie, lIdProfil, lIdTypArch
String 	sBoiteCourante

/*------------------------------------------------------------------*/
/* lTab[1] = ID_SIN                                                 */
/* lTab[2] = ID_PROD                                                */
/* lTab[3] = ID_ETS                                                 */
/* lTab[4] = ID_CIE                                                 */
/* sTab[1] = COD_OPER  (centralisateur #xxx)                        */
/*------------------------------------------------------------------*/
lIdSin   	= astPass.lTab[1]
lIdProd  	= astPass.lTab[2]
lIdEts   	= astPass.lTab[3]
lIdCie   	= astPass.lTab[4]
isIdOper 	= astPass.sTab[1]
icOrigineTrt= astPass.sTab[2]

/*------------------------------------------------------------------*/
/* Chargement des informations relatives au sinistre                */
/*------------------------------------------------------------------*/
lLigne = idwStkSinistre.Retrieve ( lIdSin )

If lLigne <> 1 Then
//	uf_GererMessage ( )
	bOk = False
End If

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination du nu$$HEX1$$e900$$ENDHEX$$mro de bo$$HEX1$$ee00$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$Archive.                      */
/* On ne doit pas v$$HEX1$$e900$$ENDHEX$$rifier que le produit poss$$HEX1$$e800$$ENDHEX$$de un code 4 dans    */
/* Det_Pro.                                                         */
/* En effet s'il est arriv$$HEX2$$e9002000$$ENDHEX$$dans wkfs_w_queue c'est qu'au moment    */
/* de la validation le produit poss$$HEX1$$e900$$ENDHEX$$dait un code 4. Il faut donc    */
/* le traiter m$$HEX1$$ea00$$ENDHEX$$me si entre temps la gestion $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$cider de ne plus   */
/* avoir de gestion automatique pour ce produit.                    */
/*------------------------------------------------------------------*/
If bOk Then

	
	idwTrtBoiteArchive.Reset ()
	idwTrtBoiteArchive.Visible	= FALSE
	idwTrtBoiteArchive.Enabled	= FALSE

	idwTrtBoiteArchive.Retrieve ( lIdProd, lIdEts, lidCie, isIdOper )

	/*------------------------------------------------------------------*/
	/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des donn$$HEX1$$e900$$ENDHEX$$es impossible.                             */
	/*------------------------------------------------------------------*/
	If	idwTrtBoiteArchive.RowCount () <> 1	Then 
		bOk = FALSE
		stMessage.sCode		= "BARC005"
	Else
		lIdCie 			= idwTrtBoiteArchive.GetItemNumber ( 1, "ID_CIE"            )
		lIdProfil		= idwTrtBoiteArchive.GetItemNumber ( 1, "ID_PROFIL"         )
		lIdTypArch		= idwTrtBoiteArchive.GetItemNumber ( 1, "ID_TYP_ARCH"       )
		sBoiteCourante	= idwTrtBoiteArchive.GetItemString ( 1, "ID_BOITE_COURANTE" )

		idwTrtBoiteArchive.Visible	= TRUE

	End If

	/*------------------------------------------------------------------*/
	/* Impossible de d$$HEX1$$e900$$ENDHEX$$terminer la compagnie d'assurance.               */
	/*------------------------------------------------------------------*/
	If	bOk And lIdCie = -1	Then
		bOk = FALSE
		stMessage.sCode		= "BARC010"
	End If

	/*------------------------------------------------------------------*/
	/* Le profil n'existe pas pour ce produit/compagnie.                */
	/*------------------------------------------------------------------*/
	If	bOk And lIdProfil = -1	Then
		bOk = FALSE
		stMessage.sCode		= "BARC015"
	End If

	/*------------------------------------------------------------------*/
	/* Si la m$$HEX1$$e900$$ENDHEX$$thode $$HEX2$$e0002000$$ENDHEX$$changer depuis la derni$$HEX1$$e800$$ENDHEX$$re modification avertir  */
   /*------------------------------------------------------------------*/
	IF bOk And ( lIdTypArch = 1 And icOrigineTrt = 'C' ) Then
		bOk = False
		stMessage.sCode		= "BARC030"
		stMessage.sVar[1]    = "Priv$$HEX1$$e900$$ENDHEX$$e"
	End If

	IF bOk And ( lIdTypArch = 2 And icOrigineTrt = 'P' ) Then
		bOk = False
		stMessage.sCode		= "BARC030"
		stMessage.sVar[1]    = "Centrale"
	End If

	/*------------------------------------------------------------------*/
	/* Il existe plusieurs boites ouvertes en m$$HEX1$$ea00$$ENDHEX$$me temps pour un        */
	/* gestionnaire donn$$HEX2$$e9002000$$ENDHEX$$dans le cas d'une m$$HEX1$$e900$$ENDHEX$$thode CENTRALISEE.        */
	/*------------------------------------------------------------------*/
	If bOk And lIdTypArch = 2 And sBoiteCourante = "ERREUR 01"	Then
		bOk = FALSE
		stMessage.sCode		= "BARC020"
	End If

	/*------------------------------------------------------------------*/
	/* On arme le N$$HEX2$$b0002000$$ENDHEX$$de boite sur la DW. Ce N$$HEX2$$b0002000$$ENDHEX$$de boite peut-$$HEX1$$ea00$$ENDHEX$$tre NULL. */
	/* (1$$HEX1$$e900$$ENDHEX$$re boite ouverte par le gestionnaire)                         */
	/*------------------------------------------------------------------*/
	If bOk Then
		idwTrtBoiteArchive.SetItem ( 1, "NO_BOITE", sBoiteCourante )
	End If

End If


If	Not bOk	Then F_Message ( stMessage )
		
Return bOk

end function

public function boolean uf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_Sp_Wkfs_w_queue::Uf_Preparer (Public)
//* Auteur			: PLJ
//* Date				: 11/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*                 et r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du num$$HEX1$$e900$$ENDHEX$$ro de bo$$HEX1$$ee00$$ENDHEX$$te en cours
//*
//* Arguments		: s_Pass	astPass
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

Boolean 	bOk
Long		lIdSin
String	sSql, sNoBoite


lIdSin   = idwStkSinistre.GetItemNumber     ( 1, "ID_SIN"   )
sNoBoite = idwTrtBoiteArchive.GetItemString ( 1, "NO_BOITE" )

If isNull ( sNoboite ) Or sNoBoite = '' Then
	stMessage.sCode		= "BARC035"
	f_Message ( stMessage )
	Return False
End If


sSQL = "EXECUTE sysadm.PS_VAL_ARCH_CENTRAL " + String ( lIdSin ) + ", " + sNoBoite + ", " + stglb.sCodOper
	
bOk = F_execute ( sSql, SqlCa )

If SqlCa.SqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then bOk = False


/*------------------------------------------------------------------*/
/* On stocke les informations du SQLCA avant de faire le RollBack   */
/*------------------------------------------------------------------*/
If bOk = False Then
	stMessage.sTitre		= "Archivage Centralis$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sCode		= "PROF001"
   stMessage.bTrace  	= False
	stMessage.sVar[1]    = "Validation Archivage centralis$$HEX1$$e900$$ENDHEX$$"
	stMessage.sVar[2] 	= String (SqlCa.SqlCode  )
	stMessage.sVar[3] 	= String (SqlCa.SqlDBCode)
	stMessage.sVar[4] 	= SqlCa.SqlErrText
End If



F_Commit ( SqlCa, bOk )


If bOk = False Then 	F_Message ( stMessage )


Return bok
end function

on n_cst_sp_wkfs_w_queue.create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_wkfs_w_queue.destroy
TriggerEvent( this, "destructor" )
end on

