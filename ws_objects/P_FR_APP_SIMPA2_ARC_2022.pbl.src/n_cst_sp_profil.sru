HA$PBExportHeader$n_cst_sp_profil.sru
forward
global type n_cst_sp_profil from nonvisualobject
end type
end forward

global type n_cst_sp_profil from nonvisualobject
end type
global n_cst_sp_profil n_cst_sp_profil

type variables
Private:
u_DataWindow		idwTrtProfil
u_Datawindow		idwStkProfil

String			isTypeTrt		// M ou C

PictureButton		iPbSupprimer

statictext			istMessage


end variables

forward prototypes
public subroutine uf_gerermessage (string asobjet, string asnomcol, string astaberr[])
public function boolean uf_preparer (string astype, ref s_pass astpass)
public function string uf_controlersaisie ()
public function string uf_controlergestion ()
public function boolean uf_preparersupprimer ()
public function boolean uf_preparervalider ()
public function integer uf_controlerzone (string ascol, string asval)
public subroutine uf_initialiser (ref u_datawindow adwtrtprofil, ref u_datawindow adwstkprofil, ref picturebutton apbsupprimer, ref statictext astmessage)
end prototypes

public subroutine uf_gerermessage (string asobjet, string asnomcol, string astaberr[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_profil::Uf_GereMessage
//* Auteur			:	PLJ
//* Date				: 	18/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages
//* Commentaires	:	
//*
//* Arguments		:	String	asObjet
//*						String	asNomCol
//*						String	asTabErr[]
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------


Choose Case Upper ( asObjet )

	Case	'N_CST_SP_PROFIL'

			Choose Case Upper ( asNomCol )

				Case 'ID_PROFIL'
					stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un profil"
					stMessage.Icon			= StopSign!
					stMessage.bErreurG	= False
					stMessage.sCode		= "PROF001"
				   stMessage.bTrace  	= False
					stMessage.sVar[1]    = "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration Id_Profil"
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
					stMessage.sVar[1] 	= asTabErr [1]
					stMessage.sVar[2] 	= asTabErr [2]
					stMessage.sCode		= "PROF002"

					f_Message ( stMessage )

				Case 'TERMINER_VALIDER'
					stMessage.sTitre		= "Maj d'un profil"
					stMessage.Icon			= StopSign!
					stMessage.bErreurG	= False
					stMessage.sCode		= "PROF001"
				   stMessage.bTrace  	= False
					stMessage.sVar[1]    = "Uf_TerminerValider"
					stMessage.sVar[2] 	= asTabErr [1]			// SqlCa.SqlCode
					stMessage.sVar[3] 	= asTabErr [2]			// SqlCa.SqlDBCode
					stMessage.sVar[4] 	= asTabErr [3]			// SqlCa.SqlErrText

					f_Message ( stMessage )


			End Choose


End Choose
end subroutine

public function boolean uf_preparer (string astype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Preparer (Public)
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Chargement 
//*
//* Arguments		: 
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------

Long 		lCptVal, lNbLigne, lIdProfil, lIdCie, lIdTypArch
Boolean  bOk = True

isTypeTrt = asType

If isTypeTrt = 'M' Then

	/*----------------------------------------------*/
   /* Chargement du Profil                         */
	/*----------------------------------------------*/
	lIdProfil = Integer   ( astPass.sTab [ 1 ] )
	idwTrtProfil.Retrieve ( lIdProfil  )

	lIdCie 		= idwTrtProfil.GetItemNumber ( 1, "ID_CIE" )
	lIdTypArch  = idwTrtProfil.GetItemNumber ( 1, "ID_TYP_ARCH" )

	idwStkProfil.Retrieve ( lIdCie, lIdTypArch )
	

	/*------------------------------------------------------------------*/
	/* Si le profil est utilis$$HEX1$$e900$$ENDHEX$$, on autorise uniquement la modification */
   /* du libell$$HEX1$$e900$$ENDHEX$$, et on emp$$HEX1$$ea00$$ENDHEX$$che la suppression                         */
	/*------------------------------------------------------------------*/
	SELECT count(*) INTO :lNbLigne
     FROM sysadm.wkfs_regroup
    WHERE id_profil = :lIdProfil 
    USING SQLCA;

	If SqlCa.SqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then
		uf_GererMessage ( "n_cst_sp_profil", "ID_PROFIL", { String(SqlCa.SqlCode), String(SqlCa.SqlDbCode), SqlCa.SqlErrText} )
		bOk = False
	End IF

	If bOk = True And lNbLigne > 0 Then
		idwTrtProfil.uf_proteger ( {"ID_CIE","ID_TYP_ARCH"}, '1' )
		istMessage.Visible   = True		
		ipbSupprimer.Enabled = False
	Else
		idwTrtProfil.uf_proteger ( {"ID_CIE","ID_TYP_ARCH"}, '0' )
		istMessage.Visible   = False
		ipbSupprimer.Enabled = True
	End If


Else

	/*------------------------------------------------------------------*/
	/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration provisoire d'un nouveau num$$HEX1$$e900$$ENDHEX$$ro de profil            */
   /* La proc$$HEX1$$e900$$ENDHEX$$dure PS_X_INCREMENTER.                                   */
	/*------------------------------------------------------------------*/                                   	
	SELECT cpt_val INTO :lCptvAL
     FROM sysadm.parametre
    WHERE ref_cpt = 'ID_PROFIL'
    USING SqlCa;
   
	If SqlCa.sqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then
		uf_GererMessage ( "n_cst_sp_profil", "ID_PROFIL", { String(SqlCa.SqlCode), String(SqlCa.SqlDbCode), SqlCa.SqlErrText} )
		bOk = False
	End If

	If bOk Then
		idwTrtProfil.SetItem ( 1, "ID_PROFIL", lCptVal + 1 )	
	End If

	idwTrtProfil.uf_proteger ( {"ID_CIE","ID_TYP_ARCH"}, '0' )
	istMessage.Visible   = False
//	ipbSupprimer.Enabled = True

End If


Return bOk



end function

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



/*------------------------------------------------------*/
/* Controle que la cie et le type aient $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisis      */
/*------------------------------------------------------*/

sVal = String (idwTrtProfil.GetItemNumber ( 1, "ID_CIE"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"	Then
	sPos  = "ID_CIE"
	Stext = " - La Compagnie" + sCrLf
End If


sVal = String (idwTrtProfil.GetItemNumber ( 1, "ID_TYP_ARCH"))

If IsNull ( sVal ) Or  sVal = "" Or sVal = "0"	Then
	If sPos = "" Then sPos = "ID_TYP_ARCH"
	Stext += " - La M$$HEX1$$e900$$ENDHEX$$thode" + sCrLf
End If


sVal = idwTrtProfil.GetItemString ( 1, "LIB_PROFIL")

If IsNull ( sVal ) Or  sVal = "" Then
	If sPos = "" Then sPos = "LIB_PROFIL"
	Stext += " - Le libell$$HEX1$$e900$$ENDHEX$$" + sCrLf
End If


/*------------------------------------------------------*/
/* Affichage du message d'erreur                        */
/*------------------------------------------------------*/

If	( sPos <> "" ) Then

	uf_GererMessage ( "n_cst_sp_profil", "CONTROLER_SAISIE", { sText } )

End If


Return sPos
end function

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_profil::uf_ControlerGestion
//* Auteur			:	PLJ
//* Date				:	19/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Colonne en erreur
//*
//*-----------------------------------------------------------------

String 	sCol = ""

Long 		lIdCie, lIdTypArch, lIdProfil, lIdProfilExist
String	sLibCie, sLibMethode, sLibProfil, sLibProfilS


/*------------------------------------------------------------------------------*/
/*   .                                                                          */
/*  / \   Suite R$$HEX1$$e900$$ENDHEX$$union du 11/09/2003 avec Corrine Verrier, Luc R$$HEX1$$e900$$ENDHEX$$aux, DGA, PLJ */
/* / ! \  Il ne doit plus y avoir d'unicit$$HEX2$$e9002000$$ENDHEX$$sur (ID_CIE, METHODE).              */           
/* $$HEX7$$af00af00af00af00af0020002000$$ENDHEX$$Car on ne plus regrouper les bo$$HEX1$$ee00$$ENDHEX$$tes uniquement par compagnie, mais    */
/*        aussi par produit.                                                    */
/*        Le contr$$HEX1$$f400$$ENDHEX$$le d'unicit$$HEX2$$e9002000$$ENDHEX$$se fait maintenant sur le libell$$HEX2$$e9002000$$ENDHEX$$( rappel le   */
/*        libell$$HEX2$$e9002000$$ENDHEX$$est uniquement l$$HEX4$$e0002000e0002000$$ENDHEX$$titre d'information )                     */
/*                                                                              */
/*------------------------------------------------------------------------------*/


	//	/*----------------------------------------------------------------------*/
	//	/* On ne doit pas trouver de profil avec la m$$HEX1$$ea00$$ENDHEX$$me cie et la m$$HEX1$$ea00$$ENDHEX$$me m$$HEX1$$e900$$ENDHEX$$thode */
	//	/* Cas d'une cr$$HEX1$$e900$$ENDHEX$$ation Aucune autre ligne ne doit exister                */
	//	/* Cas de la modification Aucune autre ligne avec un id_profil different*/
	//	/* ne doit exister                                                      */
	//	/*----------------------------------------------------------------------*/
	//	LIdProfil	= idwTrtProfil.GetItemNumber ( 1, "ID_PROFIL"   )
	//	lIdCie 		= idwTrtProfil.GetItemNumber ( 1, "ID_CIE" 		)
	//	lIdTypArch	= idwTrtProfil.GetItemNumber ( 1, "ID_TYP_ARCH" )
	//
	//
	//	If isTypeTrt = 'C' Then
	//
	//		SELECT id_profil INTO :lIdProfilExist
	//		  FROM sysadm.wkfs_profil
	//		 WHERE id_cie      = :lIdCie			AND
	//				 id_typ_arch = :lIdTypArch
	//		 USING SqlCa;
	//
	//	Else
	//	
	//		SELECT id_profil INTO :lIdProfilExist
	//		  FROM sysadm.wkfs_profil
	//		 WHERE id_cie      = :lIdCie			AND
	//				 id_typ_arch = :lIdTypArch		AND
	//				 id_profil  <> :lIdProfil
	//		 USING SqlCa;
	//
	//	End If


	//	If lIdProfilExist <> 0 Then
	//
	//		sLIbCie 		= idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_CIE      )', 1 ) " )
	//		sLIbMethode = idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_TYP_ARCH )', 1 ) " )
	//
	//		uf_GererMessage ( "n_cst_sp_profil", "CONTROLER_GESTION", { sLibCie, Upper(sLibMethode), String(lIdProfilExist) } )
	//		sCol = "ID_CIE"
	//
	//	End IF


LIdProfil	= idwTrtProfil.GetItemNumber ( 1, "ID_PROFIL"   )
lIdCie 		= idwTrtProfil.GetItemNumber ( 1, "ID_CIE" 		)
lIdTypArch	= idwTrtProfil.GetItemNumber ( 1, "ID_TYP_ARCH" )
sLibProfilS	= idwTrtProfil.GetItemString ( 1, "LIB_PROFIL"  )


If isTypeTrt = 'C' Then
	
	SELECT lib_profil INTO :sLibProfil
	  FROM sysadm.wkfs_profil
	 WHERE id_cie      = :lIdCie			AND
			 id_typ_arch = :lIdTypArch
		 USING SqlCa;
	
Else
	
		SELECT lib_profil INTO :sLibProfil
		  FROM sysadm.wkfs_profil
		 WHERE id_cie      = :lIdCie			AND
				 id_typ_arch = :lIdTypArch		AND
				 id_profil  <> :lIdProfil
		 USING SqlCa;
	
End If


If Upper ( TRIM (sLibProfil) ) = Upper ( TRIM (sLibProfilS) ) Then

	sLIbCie 		= idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_CIE      )', 1 ) " )
	sLIbMethode = idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_TYP_ARCH )', 1 ) " )
	uf_GererMessage ( "n_cst_sp_profil", "CONTROLER_GESTION", { sLibCie, Upper(sLibMethode) } )
	sCol = "LIB_PROFIL"

End If 


Return sCol


end function

public function boolean uf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	n_cst_sp_profil::uf_PrepareSupprimer
//* Auteur			:	PLJ
//* Date				:	19/08/2003
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
stMessage.sTitre 		= "Suppression d'un Profil"
stMessage.sVar[ 1 ] 	= "ce profil"
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

	If idwTrtProfil.DeleteRow ( 0 ) < 0	Then
		bRet = False
	End If

End If



Return bRet


end function

public function boolean uf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_profil::Uf_PreparerValider (PUBLIC)
//* Auteur			: PLJ
//* Date				: 19/08/2003
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

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du num$$HEX1$$e900$$ENDHEX$$ro de profil avant cr$$HEX1$$e900$$ENDHEX$$ation                  */
/*------------------------------------------------------------------*/
If isTypeTrt = 'C' Then
	SqlCa.PS_X_INCREMENTER ( "ID_PROFIL", lIdProfil )
	
	// [ITSM178659]
	F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 
	
	idwTrtProfil.SetItem ( 1, "ID_PROFIL", lIdProfil )
	f_Creele ( idwTrtProfil, 1 )	
End If

f_MajPar (idwTrtProfil, 1 )


Return bRet
end function

public function integer uf_controlerzone (string ascol, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_Profil::Uf_ControlerZone (Public)
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

Integer				iActionCode
Long					lLigne, lTot, lIdCie, lIdTypArch
DatawindowChild	dwChild

String				sLibCie, sLibMethode


iActionCode = 0




Choose Case asCol 

	Case "ID_CIE"

		idwStkProfil.Reset()			
		/*----------------------------------------------------------------*/
		/* La compagnie doit se trouver dans la dddw                      */
		/*----------------------------------------------------------------*/
		If Not isNumber ( asVal ) Then 
			iActionCode = 2
			Return iActionCode
		End If


		idwTrtProfil.GetChild ( "ID_CIE", dwChild )
		
		lTot   = dwChild.RowCount ()
		lLigne = dwChild.Find ( "ID_CIE = " + asVal , 1, lTot )

		If lLigne < 1 Then
			iActionCode = 2
		End If	

		
		lIdTypArch = idwTrtProfil.GetItemNumber ( 1, "ID_TYP_ARCH" )
		If Not isNull ( lIdTypArch ) Then
			/*-------------------------------------------------------------*/
			/* Chargement de tous les profils identiques                   */ 
			/*-------------------------------------------------------------*/
			idwStkProfil.Retrieve ( Long  (asVal), lIdTypArch )

			/*-------------------------------------------------------------*/
			/* Constitution automatique du d$$HEX1$$e900$$ENDHEX$$but de libell$$HEX17$$e9002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/			
			/*-------------------------------------------------------------*/
			sLIbCie 		= dwChild.GetItemString ( lLigne, "LIB_CIE" )
			sLIbMethode = idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_TYP_ARCH )', 1 ) " )
			idwTrtProfil.SetItem ( 1, "LIB_PROFIL", sLibCie + ' ' + sLibMethode )		

		End If 


	Case "ID_TYP_ARCH"	

		idwStkProfil.Reset()

		/*----------------------------------------------------------------*/
		/* La m$$HEX1$$e900$$ENDHEX$$thode doit se trouver dans la dddw                        */
		/*----------------------------------------------------------------*/
		If Not isNumber ( asVal ) Then 
			iActionCode = 2
			Return iActionCode
		End If


		idwTrtProfil.GetChild ( "ID_TYP_ARCH", dwChild )
		
		lTot   = dwChild.RowCount ()
		lLigne = dwChild.Find ( "ID_CODE = " + asVal , 1, lTot )

		If lLigne < 1 Then
			iActionCode = 2
		End If	

		lIdCie = idwTrtProfil.GetItemNumber ( 1, "ID_CIE" )
		If Not isNull ( lIdCie ) Then
			/*-------------------------------------------------------------*/
			/* Chargement de tous les profils identiques                   */ 
			/*-------------------------------------------------------------*/
			idwStkProfil.Retrieve ( lIdCie, Long (asVal) )

			/*-------------------------------------------------------------*/
			/* Constitution automatique du d$$HEX1$$e900$$ENDHEX$$but de libell$$HEX17$$e9002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/			
			/*-------------------------------------------------------------*/
			sLIbCie 		= idwTrtProfil.Describe ( "Evaluate ( 'LookUpDisplay ( ID_CIE      )', 1 ) " )
			sLIbMethode = dwChild.GetItemString ( lLigne, "LIB_CODE" )
			idwTrtProfil.SetItem ( 1, "LIB_PROFIL", sLibCie + ' ' + sLibMethode )

		End If 
	


End Choose

Return iActionCode

end function

public subroutine uf_initialiser (ref u_datawindow adwtrtprofil, ref u_datawindow adwstkprofil, ref picturebutton apbsupprimer, ref statictext astmessage);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser (Public)
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adwtrtprofil	(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du profil
//*					  pictureButton			apbSupprimer	(R$$HEX1$$e900$$ENDHEX$$f)
//*					  staticText				astMessage		(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DatawindowChild	dwChild, dwChild2
String 				sCol[1]

/*------------------------------------------------------------------*/
/* Affectation des objets                                           */
/*------------------------------------------------------------------*/
idwTrtProfil	= adwtrtprofil
idwStkProfil	= adwStkProfil
ipbSupprimer	= apbSupprimer
istMessage		= astMessage

idwTrtProfil.setTransObject ( SqlCa )
idwStkProfil.setTransObject ( SqlCa )

	
long lRet
/*------------------------------------------------------------------*/
/* Initialisation des DropdownDatawindows                           */
/*------------------------------------------------------------------*/
idwTrtProfil.GetChild  ( "ID_CIE", dwChild  )
dwChild.SetTransObject ( SqlCa              )
dwChild.Retrieve       ()

idwTrtProfil.GetChild  ( "ID_TYP_ARCH", dwChild  )
idwStkProfil.GetChild  ( "ID_TYP_ARCH", dwChild2 )
dwChild.SetTransObject ( SqlCa                   )
dwChild.Retrieve       ( '-MC'                   )

dwChild2.SetTransObject ( SqlCa                   )
dwChild2.Retrieve       ( '-MC'                   )


/*-------------------------------------------------------------------*/
/* Initialisation des colonnes qui peuvent $$HEX1$$ea00$$ENDHEX$$tre prot$$HEX1$$e900$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$s             */
/*-------------------------------------------------------------------*/
idwTrtProfil.Uf_InitialiserCouleur ( {"ID_CIE","ID_TYP_ARCH"} )






end subroutine

on n_cst_sp_profil.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_profil.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

