HA$PBExportHeader$w_t_sp_aide_tarif.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage d' aide tarif
forward
global type w_t_sp_aide_tarif from w_8_traitement
end type
end forward

global type w_t_sp_aide_tarif from w_8_traitement
integer x = 690
integer y = 572
integer height = 792
string title = "Gestion Aide Tarif"
event ue_droitecriture pbm_custom39
end type
global w_t_sp_aide_tarif w_t_sp_aide_tarif

type variables
u_sp_gs_aide_tarif		iuoGsAide_tarif
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
public function boolean wf_preparermodifier ()
public function string wf_controlersaisie ()
public function boolean wf_preparerinserer ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_aide_tarif
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

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerSupprimer
//* Auteur			: PLJ
//* Date				: 12/03/1998 15:03:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Demande de confirmation avant suppression
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			//Variable de retour de la fonction 
Integer	iRet			//Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/

stMessage.sTitre 		= "Suppression d'un code tarif"
stMessage.sVar[ 1 ] 	= "ce tarif"
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
   
   bRet = True
	
   /*----------------------------*/
	/* Suppression                */
	/*----------------------------*/
   
	Dw_1.DeleteRow ( 0 )
	

End If

Return ( bRet )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerModifier
//* Auteur			: PLJ
//* Date				: 12/03/1998 15:35:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


If Dw_1.Retrieve ( Dec ( istPass.sTab[1] ) ) <= 0 Then Return ( False )

Return ( TRUE )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie (PUBLIC)
//* Auteur			: PLJ
//* Date				: 13/03/1998 09:45:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la saisie 
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------


s_Pass	stPass_Dga

iuoGsAide_Tarif.Uf_controlersaisie ( stPass_Dga )

Return ( stPass_Dga.sTab [ 1 ] ) 



end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_aide_tarif	
//* Auteur        : Fabry JF
//* Date          : 17/09/2003 10:53:55
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

Return True
end function

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_aide_tarif
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	PLJ
//* Date				:	11/03/1998 11:20:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 				sTab				// Code tabulation.
String				sMajLe			// Variable tampon pour MAJ_lE.
String				sIdCode			// Variable tampon pour ID_CODE.

String   			sLibGti    		// Libell$$HEX2$$e9002000$$ENDHEX$$de la garantie.
Long	   			dcIdGti      	// Id de la Garantie.
Long              lNumLigneGti	// No de ligne dans la DDDW garantie.
DataWindowChild 	dwGti				// DDDW de la Garantie.

sTab		= "~t"
sIdCode	= String ( dw_1.GetItemNumber   ( 1, "ID_CODE" ) )
sMajLe	= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

/*------------------------------------------------------------------*/
/* Recherche du libell$$HEX2$$e9002000$$ENDHEX$$de la garantie                              */
/*------------------------------------------------------------------*/

Dw_1.GetChild ( "id_gti", dwGti )

dcIdGti			= dw_1.GetItemNumber ( 1, "ID_GTI" )

lNumLigneGti   = dwGti.Find ( "ID_CODE=" + String ( dcIdGti ) , 1, dwGti.RowCount() )

If lNumLigneGti > 0 then
	sLibGti        = dwGti.GetItemString ( lNumLigneGti, "LIB_CODE")
else
	sLibGti			= "Introuvable"
End If


/*------------------------------------------------------------------*/
/* Initialisation de la chaine d'import                             */
/*------------------------------------------------------------------*/

isMajAccueil 	=	sIdCode										 + sTab	+ &
                  sLibGti                              + sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_CODE" ) + sTab	+ &
						sMajLe								 		 + sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )


end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_sp_aide_tarif
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	PLJ
//* Date				:	11/03/98 10:45:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	tarifs.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DatawindowChild	DwcGti

/*------------------------------------------------------------------*/
/* Initialisation des User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion           */
/*------------------------------------------------------------------*/
iuoGsAide_tarif = Create u_sp_gs_aide_tarif
iuoGsAide_tarif.uf_initialisation ( itrTrans, Dw_1 )

/*------------------------------------------------------------------*/
/* Initialisation de la transaction de DW_1                         */
/*------------------------------------------------------------------*/

Dw_1.Uf_SetTransObject ( itrTrans )


Dw_1.GetChild ( "ID_GTI", DwcGti )
istpass.dwnorm[1].sharedata(DwcGti)


/*------------------------------------------------------------------*/
/* Passage de la reference de la datawindow dw_1 au User Object de  */
/* contr$$HEX1$$f400$$ENDHEX$$le de gestion                                              */
/*------------------------------------------------------------------*/

iuoGsAide_tarif.Uf_Initialisation(itrTrans,dw_1)



end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_aide_tarif
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 11/03/1998 11:15:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects de contr$$HEX1$$f400$$ENDHEX$$le de gestion              */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsAide_tarif
If IsValid(iuoGsAide_tarif) Then Destroy iuoGsAide_tarif
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_sp_aide_tarif.create
call super::create
end on

on w_t_sp_aide_tarif.destroy
call super::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_t_sp_aide_tarif
integer x = 18
integer y = 216
integer width = 2414
string dataobject = "d_sp_aide_tarif"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1
//* Evenement 		: SQLPREVIEW
//* Auteur			: PLJ
//* Date				: 04/09/1997 15:35:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification du SqlPreview de la datawindow Dw_1
//*					  dans le cas de l'insertion ou de la suppression  
//*					  d'un code tarif
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			// SqlPreview de la datawindow Dw_1
String		sDebSqlPreview 	// Debut du SqlPreview

Long			dcIdCode				// Identifiant du code aide tarif.
Long			dcIdGti				// code de la garantie.
String		sLibCode				// Libell$$HEX2$$e9002000$$ENDHEX$$de la carte.
Real        dcMtPrej          // montant depr$$HEX1$$e900$$ENDHEX$$judice.
String 		sMajPar				// Auteur de la mise $$HEX2$$e0002000$$ENDHEX$$jour.
DateTime		dtCreeLe				// Date de cr$$HEX1$$e900$$ENDHEX$$ation.
DateTime		dtMajLe				// Date de MAJ.

String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "AIDE_TARIF"

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

		dcIdCode       = 1
		dcIdGti			= Dw_1.GetItemNumber   ( 1, "ID_GTI"        )
		sLibCode  		= Dw_1.GetItemString   ( 1, "LIB_CODE"      )
		dcMtPrej			= Dw_1.GetItemNumber   ( 1, "MT_PREJ"       )
		dtCreele 		= Dw_1.GetItemDateTime ( 1, "CREE_LE"       )
		dtMajLe  		= Dw_1.GetItemDateTime ( 1, "MAJ_LE"        )
		sMajPar  		= Dw_1.GetItemString   ( 1, "MAJ_PAR"       )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_AIDE_TARIF ( 	dcIdCode  		, &
												dcIdGti			, &
												sLibCode     	, &
										 	 	dcMtPrej 		, &
												dtCreeLe			, &
										 	 	dtMajLe 			, &
												sMajPar 					)

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

		Else

 			This.SetItem ( 1, "ID_CODE", dcIdCode )
//
//			sCol = { "ID_CARTE", "ID_TYPE_CARTE", "ID_GRP", "LIB_CARTE", "VAL_RG_MINI", &
//						"VAL_RG_MAX" }
//
//			For lCpt = 1 To UpperBound ( sCol )
//		
//				sVal [ lCpt ] = f_GetItem ( Dw_1, 1, sCol [ lCpt ] )
//
//			Next
//
//			sCle [ 1 ]	= sVal [ 1 ]
//
//			sType = 'I'
//
//			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//
//				This.SetActionCode ( 1 )
//
//			Else
//
//				This.SetActionCode ( 2 )
//
//			End If
			
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM

		End If


//	Case	"UPDA" 
//
//		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )
//
//		sCle [ 1 ]	= "'" + String ( GetItemNumber ( 1, "ID_CARTE" ) ) + "'"
//
//		sType = 'U'
//
//		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//
//			This.SetActionCode ( 1 )
//
//		End If

	Case	"DELE"

		dcIdCode = Dw_1.GetItemNumber ( 1, "ID_CODE", DELETE!, FALSE )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_AIDE_TARIF ( dcIdCode )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

		Else

//			sCle [ 1 ] = "'" + String ( dcIdCarte ) + "'"
//			sType = 'D'
//
//			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//
//				This.SetActionCode ( 1 )
//
//			Else
//
//				This.SetActionCode ( 2 )
//
//			End If

//Migration PB8-WYNIWYG-03/2006 FM
//		   This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM

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
//* Auteur			: PLJ
//* Date				: 12/03/1998 17:25:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des messages d'erreur suite aux erreurs 
//*					  de saisies
//* Commentaires	: L'Erreur de type GENE003 est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par les r$$HEX1$$e800$$ENDHEX$$gles de validation.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des tarifs"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_CODE"
			stMessage.sVar[1] = "code tarif"
			stMessage.sCode	= "GENE003"

		Case "LIB_CODE"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$tarif"
			stMessage.sCode	= "GENE003"

		Case "ID_GTI"
			stMessage.sVar[1] = "Garantie invalide"
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

type st_titre from w_8_traitement`st_titre within w_t_sp_aide_tarif
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_aide_tarif
integer y = 24
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_aide_tarif
integer x = 283
integer y = 24
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_aide_tarif
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_aide_tarif
boolean visible = false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_aide_tarif
integer x = 530
integer y = 24
end type

