HA$PBExportHeader$w_ae_sp_reedit_sinistre_wkf_2000.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre de r$$HEX2$$e900e900$$ENDHEX$$dition des travaux
forward
global type w_ae_sp_reedit_sinistre_wkf_2000 from w_accueil_edition_2000
end type
end forward

global type w_ae_sp_reedit_sinistre_wkf_2000 from w_accueil_edition_2000
end type
global w_ae_sp_reedit_sinistre_wkf_2000 w_ae_sp_reedit_sinistre_wkf_2000

type variables
Private :
	Long	ilSin
	Long	ilNumCourrier

	String	isFicEntete
end variables

forward prototypes
private function integer wf_lire_blob (long alidsin, long alidinter, string astype, ref blob abtxtblob)
private function long wf_rech_filter (string asIdSin, long alIdInter)
public function boolean wf_maj_dossier (long alsin)
end prototypes

private function integer wf_lire_blob (long alidsin, long alidinter, string astype, ref blob abtxtblob);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_Lire_Blob() ( Private )
//* Auteur			:	FS / DBI 
//* Date				:	13/01/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Lecture du blob dans W_INTER_BLOB
//*
//* Arguments		:	
//*                  adcidsin			Decimal		Identifiant du sinistre
//*                  adcidinter		Decimal		Identifiant interlocuteur
//*                  astype			String		Type de blob
//*                  asblob			Blob (*)		Retour du blob
//*
//* Retourne		:	Long
//*                  
//*-----------------------------------------------------------------

Long lRet
String 		sK_RETOUR	= "~r"
String 		sK_NEWLINE	= "~n"
String 		sText

lRet = 1

SELECTBLOB	txt_blob
		INTO	:abTxtBlob
		FROM	sysadm.w_inter_blob
	  WHERE  sysadm.w_inter_blob.id_sin         = :alIdSin
		 AND  sysadm.w_inter_blob.id_i           = :alIdInter
		 AND	sysadm.w_inter_blob.id_typ_blob    = :asType
	  USING	dw_1.iTrtrans	;	

If dw_1.iTrTrans.SQLCODE <> 0 Then
	sText = 	"~tErreur lecture " + String ( dw_1.iTrTrans.SQLCODE ) + &
				" Typ " + astype                + &
				" Sin " + String ( alIdSin   ) + &
				" Int " + String ( alIdInter ) + &
				" .... Impression stopp$$HEX1$$e900$$ENDHEX$$e." + sK_RETOUR + sK_NEWLINE		
	Mle_Msg.Uf_AjouterText ( sText )

	lRet = -1
End If

Return ( lRet )

end function

private function long wf_rech_filter (string asIdSin, long alIdInter);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_rech_filter
//* Auteur			: DBI
//* Date				: 17/07/1998 14:59:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Rech dans le buffer filter du courrier double ou joint pour un interlocuteur
//* Commentaires	: 
//*
//* Arguments		: String			asIdSin	(Val)	w_queue.id_sin
//*					  Long			alIdInter (Val) id Interlocuteur
//* Retourne		: Long			Num$$HEX1$$e900$$ENDHEX$$ro de ligne ou se trouve le courrier $$HEX2$$e0002000$$ENDHEX$$joindre
//*										0 si pas trouv$$HEX1$$e900$$ENDHEX$$
//*-----------------------------------------------------------------

Long		lNbLig			// Nombre de lignes du buffer filter
Long		lCpt				// Compteur de boucle
Long		lIdInter			// Id_i lu

String	sIdSin			// Id_Sin lu

lNbLig	=	Dw_1.FilteredCount ( )

For lCpt = 1 to lNbLig

	sIdSin	=	Dw_1.GetItemString  ( lCpt, "ID_SIN", filter!, False )
	lIdInter	=	Dw_1.GetItemNumber  ( lCpt, "ID_I",   filter!, False )

	If sIdSin = asIdSin And lIdInter = alIdInter Then Return ( lCpt )
Next

Return ( 0 )

end function

public function boolean wf_maj_dossier (long alsin);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_Maj_Dossier()
//* Auteur			:	DBI
//* Date				:	03/11/1998
//*
//* Commentaires	:	Mise $$HEX2$$e0002000$$ENDHEX$$jour de W_QUEUE suite edition
//*                                         
//*
//* Arguments		:	alsin         Long  r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistrelob
//*
//* Retourne		:	True / False si probl$$HEX1$$e800$$ENDHEX$$me de mise $$HEX2$$e0002000$$ENDHEX$$jour
//*                  
//*-----------------------------------------------------------------

String  sIdSin, sSql
String 		sK_RETOUR	= "~r"
String 		sK_NEWLINE	= "~n"
String 		sText

Boolean bOk = True

sIdSin = String( alSin )

// .... Mise $$HEX2$$e0002000$$ENDHEX$$jour de W_QUEUE

sSql	= 	"Execute sysadm.PS_U02_W_QUEUE_WKF "			+ &	
			"'"	+	sIdSin							+ "',"	+ &
			"'"	+	stGLB.sCodOper					+ "'"			

f_Execute ( sSql, Dw_1.itrTrans )
			
If Dw_1.ItrTrans.SQLCode <> 0 Then
	sText = "Erreur " + String ( dw_1.ItrTrans.SQLDBcode ) + " Maj W_QUEUE.TRV_EDITE_LE." + sK_RETOUR + sK_NEWLINE		
	Mle_Msg.Uf_AjouterText ( sText )
	bOk = False

End If

// .... Commit Final si tout Ok

f_commit ( Dw_1.ItrTrans, bOk )

Return bOk

end function

event spb_imprimerdossier;call super::spb_imprimerdossier;//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edit_Sinistre_Wkf_2000
//* Evenement 		: SPB_ImprimerDossier									(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On imprime le dossier courant
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String		sIdCourTyp		// Identifiant du courrier compos$$HEX1$$e900$$ENDHEX$$.
String		sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
String		sAltPce			// Indique s'il y a une autre piece.
String		sAltPs			// Indique s'il y a un post scriptum.
Long	      lSinSuite		// N$$HEX2$$b0002000$$ENDHEX$$sinistre courrier suivant
Long	      lSuite			// N$$HEX2$$b0002000$$ENDHEX$$ligne courrier suivant
Long	      lIdSin			// Identifiant du sinistre
Long	      lIdInter  		// Identifiant interlocuteur
Long        lLigFiltre		// Ligne pour les GetItem sur le buffer filter
String		sNom				// Nom du destinataire du courrier.
String		sTypCour			// Type du courrier $$HEX2$$e0002000$$ENDHEX$$imprimer.
String		sTxtCompo		// Premi$$HEX1$$e800$$ENDHEX$$re de la composition.
String		sAltCourGest	// Indique si un double ou courrier Joint
String		sCourTypJ		// Code du courrier Joint
String		sBac				// Bac $$HEX2$$e0002000$$ENDHEX$$partir duquel on souhaite imprimer le courrier

String 		sK_RETOUR	= "~r"
String 		sK_NEWLINE	= "~n"
String 		sText
String		sRepWinTemp, sFicSauve

Boolean		bOk = True


Blob		bTxtblob				// Blob contenant le texte des variables.

Long		lDocPrincipal		// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc principal (handle).
Long		lDocJoint			// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc ou double (handle).

Long lIdLigne

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement.            */
/*------------------------------------------------------------------*/
lIdLigne		= Message.WordParm
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepWinTemp = stGLB.sWinDir + "\TEMP\"
sRepWinTemp = stGLB.sRepTempo

/*----------------------------------------------------------------------------*/
/* DBI : le 17/07/1998                                                        */
/*                                                                            */
/* Pour chaque interlocuteur auquel on va adresser un courrier, on va dans    */
/* un premier temps g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer les donn$$HEX1$$e900$$ENDHEX$$es du courrier principal.                */
/*                                                                            */
/* Ensuite, si la zone w_inter.alt_courgest = 'D' ( double ) ou 'J' (         */
/* courrier joint )                                                           */
/* on va $$HEX1$$e900$$ENDHEX$$crire dans le .ini toutes les informations pour $$HEX1$$e900$$ENDHEX$$diter le double.   */
/* ou le courrier joint                                                       */
/* Lors du select de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro ( sur ue_fin_interro ), on filtre   */
/* pour ne pas afficher les informations sur les doubles malgr$$HEX2$$e9002000$$ENDHEX$$que l'on ait  */
/* ramener les informations utiles $$HEX2$$e0002000$$ENDHEX$$leur $$HEX1$$e900$$ENDHEX$$dition.                            */
/*                                                                            */
/* Il faut donc faire les GetItem Sur sur buffer Filtered! pour ces           */
/* compositions.                                                              */
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* Traitement du courrier principal                                           */
/*----------------------------------------------------------------------------*/

sAltPart		= dw_1.GetITemString ( lIdLigne, "ALT_PART" )
sAltPce		= dw_1.GetITemString ( lIdLigne, "ALT_PCE"  )
sAltPs		= dw_1.GetITemString ( lIdLigne, "ALT_PS"   )
sNom			= dw_1.GetItemString ( lIdLigne, "NOM"      )
lIdSin 		= Long ( dw_1.GetitemString ( lIdLigne, "ID_SIN"   ) )
lIdInter		= dw_1.GetitemNumber ( lIdLigne, "ID_I" )

sIdCourTyp 	= Dw_1.GetitemString ( lIdLigne, "ID_COUR" )

If IsNull ( sIdCourTyp ) Then
	sText = "Le courrier adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + " n'est pas renseign$$HEX1$$e900$$ENDHEX$$. Pas d'impression de ce courrier." + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_AjouterText ( sText )

//Migration PB8-WYNIWYG-03/2006 FM
//	Return
	Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

/*------------------------------------------------------------------*/
/* On ne d$$HEX1$$e900$$ENDHEX$$clenche l'impression que si le courrier est renseign$$HEX1$$e900$$ENDHEX$$.   */
/* Rappel : s'il s'agit d'un courrier particulier, on aura APART1   */
/* dans l'IdCourTyp.                                                */
/*------------------------------------------------------------------*/
If sAltPart = "O" Then
	sTypCour = "particulier"
Else
	sTypCour = sIdCourTyp
End If

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du compteur d'$$HEX1$$e900$$ENDHEX$$dition                                */
/*------------------------------------------------------------------*/
//////Wf_ActualiserEdition ( ilNumCourrier )
//////ilNumCourrier ++

sText = "Dossier : " + String( lIdSin ) + " Impression du courrier " + sTypCour + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

/*------------------------------------------------------------------*/
/* On s'occupe des valeurs particuli$$HEX1$$e800$$ENDHEX$$res du courrier. Faut-il       */
/* sauvegarder le courrier ?. Faut-il $$HEX1$$e900$$ENDHEX$$diter le courrier ?.         */
/* Faut-il positionner la mise sous pli ?.                          */
/*------------------------------------------------------------------*/
sFicSauve = sRepWinTemp + String ( lIdSin ) + "_" + String ( lIdInter )
invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "O" )

/*------------------------------------------------------------------*/
/* On ouvre le document principal. Ce document utilise l'ent$$HEX1$$ea00$$ENDHEX$$te     */
/* standard pour les DATAS.                                         */
/*------------------------------------------------------------------*/
lDocPrincipal = invEditionCourrier.uf_OuvrirDocument ( sIdCourTyp, isFicEntete )

/*------------------------------------------------------------------*/
/* On pr$$HEX1$$e900$$ENDHEX$$pare la composition du courrier principal.                 */
/*------------------------------------------------------------------*/
sTxtCompo = dw_1.GetItemString ( lIdLigne, "TXT_COMPO" )

/*------------------------------------------------------------------*/
/* On compose le courrier                                           */
/*------------------------------------------------------------------*/
invEditionCourrier.uf_InscrireComposition ( lDocPrincipal, sTxtCompo )

/*----------------------------------------------------------------------------*/
/* Gestion courrier particulier pour le courrier principal                    */
/*----------------------------------------------------------------------------*/
If sAltPart = "O" Then
	If	wf_Lire_Blob ( lIdSin, lIdInter, "CP", bTxtBlob ) < 0	Then 
		wf_SetStopTraitement ( TRUE )
	Else
		invEditionCourrier.uf_GenererBlob ( lDocPrincipal, "PART", bTxtBlob )
	End If
Else
/*------------------------------------------------------------------*/
/* Modif DBI le 25/11/1998                                          */
/* Gestion du bac pour les $$HEX1$$e900$$ENDHEX$$ditions                                 */
/*------------------------------------------------------------------*/
		Choose Case Left ( sIdCourTyp, 1 )
		Case 'Q' // Questionnaire
			sBac = "MILIEU"
		Case 'B' // Courrier Banque
			sBac = "HAUT"
		Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
			sBac = "BAS"
		End Choose	

//		invEditionCourrier.uf_InscrireBac ( lDocPrincipal, sBac, 1 )
		invEditionCourrier.uf_InscrireBac ( lDocPrincipal, sBac ) // [SUPPORT_MFP]

/*----------------------------------------------------------------------------*/
/* Gestion du paragraphe autre pi$$HEX1$$e800$$ENDHEX$$ce pour le courrier principal               */
/*----------------------------------------------------------------------------*/
	If sAltPce = "O" And Not wf_GetStopTraitement () Then
		If wf_Lire_Blob ( lIdSin, lIdInter, "PC", bTxtBlob ) < 0 Then 
			wf_SetStopTraitement ( TRUE )
		Else
			invEditionCourrier.uf_GenererBlob ( lDocPrincipal, "PIEC", bTxtBlob )
		End If
	End If

/*----------------------------------------------------------------------------*/
/* Gestion du paragraphe Post-Scriptum pour le courrier principal             */
/*----------------------------------------------------------------------------*/
	If sAltPs = "O" And Not wf_GetStopTraitement () Then
		If wf_Lire_Blob ( lIdSin, lIdInter, "PS", bTxtBlob ) < 0 Then 
			wf_SetStopTraitement ( TRUE )
		Else
			invEditionCourrier.uf_GenererBlob ( lDocPrincipal, "POST", bTxtBlob )
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* On pr$$HEX1$$e900$$ENDHEX$$pare les variables pour le courrier principal.             */
/*------------------------------------------------------------------*/
If wf_Lire_Blob ( lIdSin, lIdInter, "DT", bTxtBlob ) < 0 And Not wf_GetStopTraitement () Then 
	wf_SetStopTraitement ( TRUE )
Else
	invEditionCourrier.uf_GenererData ( lDocPrincipal, bTxtBlob )
End If

/*----------------------------------------------------------------------------*/
/* A partir de ce moment on g$$HEX1$$e800$$ENDHEX$$re les cas sp$$HEX1$$e900$$ENDHEX$$cifiques des doubles et           */
/* courriers joints                                                           */
/*----------------------------------------------------------------------------*/
sAltCourGest	=	dw_1.GetitemString ( lIdLigne, "ALT_COURGEST" )

Choose Case 	sAltCourGest	
Case 'J'		// Courrier principal + joindre autre document
	/*----------------------------------------------------------------------------*/
	/* On va ouvrir 2 Documents ( poign$$HEX1$$e900$$ENDHEX$$es ) pour que la macro va					   */
	/* regrouper ensuite.                                                         */
	/*                                                                            */
	/* Par contre, on n'a pas besoin de relire les donn$$HEX1$$e900$$ENDHEX$$es qui sont celles du     */
	/* courrier principal                                                         */
	/* pas besoin de g$$HEX1$$e900$$ENDHEX$$rer les alt_part, alt_pce et alt_ps pour le courrier $$HEX6$$e00020002000200020002000$$ENDHEX$$*/
	/* joindre.                                                                   */
	/*----------------------------------------------------------------------------*/

	/*----------------------------------------------------------------------------*/
	/* Gestion du courrier $$HEX2$$e0002000$$ENDHEX$$joindre                                              */
	/*----------------------------------------------------------------------------*/
	lLigFiltre	=	wf_Rech_Filter ( String ( lIdSin ), lIdInter )
	If ( lLigFiltre <= 0 ) Then		// erreur de recherche du courrier joint
		sText = "Le courrier adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + " n'est pas renseign$$HEX1$$e900$$ENDHEX$$. Pas d'impression de ce courrier." + sK_RETOUR + sK_NEWLINE
		Mle_Msg.Uf_AjouterText ( sText )

//Migration PB8-WYNIWYG-03/2006 FM
//		Return
		Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
	End If

	sCourTypJ		= dw_1.GetitemString ( lLigFiltre, "ID_COUR", Filter!, False )
	lDocJoint	 	= invEditionCourrier.uf_OuvrirDocument ( sCourTypJ, isFicEntete )

	/*------------------------------------------------------------------*/
	/* On pr$$HEX1$$e900$$ENDHEX$$pare la composition du courrier joint.		                 */
	/*------------------------------------------------------------------*/
	sTxtCompo 		= dw_1.GetitemString ( lLigFiltre, "TXT_COMPO", Filter!, False )
	invEditionCourrier.uf_InscrireComposition ( lDocJoint, sTxtCompo )

	/*------------------------------------------------------------------*/
	/* Modif DBI le 25/11/1998                                          */
	/* Gestion du bac pour courrier joint                               */
	/*------------------------------------------------------------------*/
	Choose Case Left ( sCourTypJ, 1 )
	Case 'Q' // Questionnaire
		sBac = "MILIEU"
	Case 'B' // Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
			sBac = "BAS"
	End Choose	
//	invEditionCourrier.uf_InscrireBac ( lDocJoint, sBac, 1 )
	invEditionCourrier.uf_InscrireBac ( lDocJoint, sBac ) // [SUPPORT_MFP]

	/*----------------------------------------------------------------------------*/
	/* La variable txt_blob contient toujours les donn$$HEX1$$e900$$ENDHEX$$es associ$$HEX1$$e900$$ENDHEX$$es au courrier.  */
	/* On n'a donc pas besoin de refaire une lecture mais uniquement d'appeler    */
	/* uf_donn$$HEX1$$e900$$ENDHEX$$e pour le courrier $$HEX2$$e0002000$$ENDHEX$$joindre                                       */
	/*----------------------------------------------------------------------------*/

	invEditionCourrier.Uf_GenererData ( lDocJoint, bTxtBlob )

Case 'D'		// Courrier Principal + double courrier autre inter

	/*----------------------------------------------------------------------------*/
	/* On va ouvrir 2 Documents ( poign$$HEX1$$e900$$ENDHEX$$es ) pour que la macro va					   */
	/* regrouper ensuite.                                                         */
	/*----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------*/
	/* De plus, il faut lire le blob de donn$$HEX1$$e900$$ENDHEX$$e li$$HEX4$$e9002000e0002000$$ENDHEX$$l'interlocuteur duquel       */
	/* provient le double et g$$HEX1$$e900$$ENDHEX$$rer alt_part, alt_pce et alt_ps de cet             */
	/* interlocuteur.                                                             */
	/*----------------------------------------------------------------------------*/

	/*----------------------------------------------------------------------------*/
	/* Gestion du double					                                             */
	/*----------------------------------------------------------------------------*/

	lLigFiltre	=	wf_Rech_Filter ( String ( lIdSin ), lIdInter )

	If ( lLigFiltre <= 0 ) Then		// erreur de recherche du courrier joint
		sText = "Le courrier adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + " n'est pas renseign$$HEX1$$e900$$ENDHEX$$. Pas d'impression de ce courrier." + sK_RETOUR + sK_NEWLINE
		Mle_Msg.Uf_AjouterText ( sText )

//Migration PB8-WYNIWYG-03/2006 FM
//		Return
		Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
	End If

	sCourTypJ		= dw_1.GetitemString ( lLigFiltre, "ID_COUR", Filter!, False )
	lDocJoint	 	= invEditionCourrier.Uf_OuvrirDocument ( sCourTypJ, isFicEntete )

	/*------------------------------------------------------------------*/
	/* On pr$$HEX1$$e900$$ENDHEX$$pare la composition du courrier joint.		                 */
	/*------------------------------------------------------------------*/
	sTxtCompo 		= dw_1.GetitemString ( lLigFiltre, "TXT_COMPO", Filter!, False )
	invEditionCourrier.Uf_InscrireComposition ( lDocJoint, sTxtCompo )

	sAltPart	= dw_1.GetITemString ( lLigFiltre, "ALT_PART", Filter!, False )
	sAltPce	= dw_1.GetITemString ( lLigFiltre, "ALT_PCE" , Filter!, False )
	sAltPs	= dw_1.GetITemString ( lLigFiltre, "ALT_PS"  , Filter!, False )
	lIdInter	= dw_1.GetitemNumber ( lLigFiltre, "ID_I_DB"	, Filter!, False )

	/*----------------------------------------------------------------------------*/
	/* Gestion courrier particulier pour le double                                */
	/*----------------------------------------------------------------------------*/
	If sAltPart = "O" Then
		If	wf_Lire_Blob ( lIdSin, lIdInter, "CP", bTxtBlob ) < 0	Then
			wf_SetStopTraitement ( TRUE )
		Else
			invEditionCourrier.uf_GenererBlob ( lDocJoint, "PART", bTxtBlob )
		End If
	Else
		/*------------------------------------------------------------------*/
		/* Modif DBI le 25/11/1998                                          */
		/* Gestion du bac pour courrier joint                               */
		/*------------------------------------------------------------------*/
		Choose Case Left ( sCourTypJ, 1 )
		Case 'Q' // Questionnaire
			sBac = "MILIEU"
		Case 'B' // Courrier Banque
			sBac = "HAUT"
		Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
			sBac = "BAS"
		End Choose	

//		invEditionCourrier.uf_InscrireBac ( lDocJoint, sBac, 1 )
		invEditionCourrier.uf_InscrireBac ( lDocJoint, sBac ) // [SUPPORT_MFP]

		/*----------------------------------------------------------------------------*/
		/* Gestion du paragraphe autre pi$$HEX1$$e800$$ENDHEX$$ce pour le double				               */
		/*----------------------------------------------------------------------------*/
		If sAltPce = "O" And Not wf_GetStopTraitement () Then
			If	wf_Lire_Blob ( lIdSin, lIdInter, "PC", bTxtBlob ) < 0	Then
				wf_SetStopTraitement ( TRUE )
			Else
				invEditionCourrier.uf_GenererBlob ( lDocJoint, "PIEC", bTxtBlob )
			End If
		End If

		/*----------------------------------------------------------------------------*/
		/* Gestion du paragraphe Post-Scriptum pour le double					            */
		/*----------------------------------------------------------------------------*/
		If sAltPs = "O" And Not wf_GetStopTraitement () Then
			If	wf_Lire_Blob ( lIdSin, lIdInter, "PS", bTxtBlob ) < 0	Then
				wf_SetStopTraitement ( TRUE )
			Else
				invEditionCourrier.uf_GenererBlob ( lDocJoint, "POST", bTxtBlob )
			End If
		End If
	End If
	/*------------------------------------------------------------------*/
	/* On pr$$HEX1$$e900$$ENDHEX$$pare les variables pour le Double                          */
	/*------------------------------------------------------------------*/
	If	Not wf_GetStopTraitement ()	Then
		If	wf_Lire_Blob ( lIdSin, lIdInter, "DT", bTxtBlob ) < 0	Then
			wf_SetStopTraitement ( TRUE )
		Else
			invEditionCourrier.uf_GenererData ( lDocJoint, bTxtBlob )
		End If
	End If
End Choose
	
/*------------------------------------------------------------------*/
/* On imprime le courrier.                                          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On utilise la macro standard (EditerCourrier).                   */
/*------------------------------------------------------------------*/
If invEditionCourrier.uf_Imprimer ( "" ) < 0	Then
/*------------------------------------------------------------------*/
/* Si l'impression se passe mal, on arr$$HEX1$$ea00$$ENDHEX$$te ; sinon on indique $$HEX6$$e00020002000200020002000$$ENDHEX$$*/
/* l'utilisateur le courrier divers imprim$$HEX1$$e900$$ENDHEX$$.                        */
/*------------------------------------------------------------------*/
	wf_SetStopTraitement ( TRUE )
Else

	// ... Mise $$HEX2$$e0002000$$ENDHEX$$jour des tables si chgt Sinistre
	// ... s'agit-il de la derni$$HEX1$$e800$$ENDHEX$$re ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e

	lSuite = dw_1.GetSelectedRow ( lIdLigne )

	If ( lSuite <> 0 ) Then 
		lSinSuite = Long ( dw_1.GetitemString ( lSuite, "ID_SIN" ) )
	Else
		lSinSuite = 0
	End If

	If ( lSinSuite <> lIdSin ) Then 

		bOk    = Wf_Maj_Dossier( lIdSin )
		If bOk = FALSE Then wf_SetStopTraitement ( TRUE )
	End If
End If


invEditionCourrier.Uf_FermerDocument ( lDocPrincipal )
If sAltCourGest = 'J' Or sAltCourGest = 'D' Then
	invEditionCourrier.Uf_FermerDocument ( lDocJoint )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event spb_terminerimpression;call super::spb_terminerimpression;//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edit_Sinistre_Wkf_2000
//* Evenement 		: SPB_TerminerImpression									(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On termine l'impression
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sK_RETOUR	= "~r"
String sK_NEWLINE	= "~n"
String sText
Long lRet

sText = "Fin de l'impression ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

/*------------------------------------------------------------------*/
/* Il n'y a pas eu d'erreur lors de la phase d'$$HEX1$$e900$$ENDHEX$$dition, on peut     */
/* envoyer le fichier de SPOOL $$HEX2$$e0002000$$ENDHEX$$l'impression.                      */
/*------------------------------------------------------------------*/
If	Wf_GetStopTraitement ()	Then Return

sText = "Envoi du fichier SPOOL ...    " + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

lRet = invEditionCourrier.uf_EnvoyerImpressionAuSpool ()
If	lRet = 1	Then
	sText = "Envoi du fichier SPOOL (OK)..." + sK_RETOUR + sK_NEWLINE
Else
	sText = "Envoi du fichier SPOOL (Probl$$HEX1$$e800$$ENDHEX$$me)..." + sK_RETOUR + sK_NEWLINE
End If

Mle_Msg.Uf_RemplacerText ( sText )
/*------------------------------------------------------------------*/
/* On supprime syst$$HEX1$$e900$$ENDHEX$$matiquement l'objet OLE et le fichier INI de    */
/* communication ainsi que le fichier SPOOL.                        */
/*------------------------------------------------------------------*/
invEditionCourrier.uf_TerminerSession ()

This.pb_Retour.SetFocus ()

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edit_Sinistre_Wkf_2000
//* Evenement 		: Open										(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil $$HEX1$$e900$$ENDHEX$$dition
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer i

//Migration PB8-WYNIWYG-03/2006 CP
//String	sTables [ 5 ]
String	sTables [  ]
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil dynamique                         */
/*------------------------------------------------------------------*/
i = 1
dw_1.istCol [ i ].sDbName			=	"sysadm.w_queue.trv_maj_le"
dw_1.istCol [ i ].sType				=	"datetime"
dw_1.istCol [ i ].sHeaderName		=	"Saisi Le"
dw_1.istCol [ i ].sFormat			=	"dd/mm/yyyy hh:mm"
dw_1.istCol [ i ].ilargeur			=	16
dw_1.istCol [ i ].sAlignement		=	"0"
dw_1.istCol [ i ].sInvisible		= 	"N"

i = 2
dw_1.istCol [ i ].sDbName			=	"sysadm.w_queue.id_sin"
dw_1.istCol [ i ].sresultSet		=	"ID_SIN"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol [ i ].sType				=	"Char(6)"
dw_1.istCol [ i ].sType				=	"Char(10)"  // [PI062]
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol [ i ].sHeaderName		=	"Sinistre"
dw_1.istCol [ i ].ilargeur			=	10  // [PI062]
dw_1.istCol [ i ].sAlignement		=	"2"
dw_1.istCol [ i ].sInvisible		= 	"N"

i = 3
Dw_1.istCol [ i ].sDbName			=	"sysadm.code_car.lib_code"
dw_1.istCol [ i ].sresultSet		=	"LIB_CODE"
Dw_1.istCol [ i ].sType				=	"char(35)"
Dw_1.istCol [ i ].sHeaderName		=	"Adress$$HEX3$$e9002000e000$$ENDHEX$$"
Dw_1.istCol [ i ].ilargeur			=	8
Dw_1.istCol [ i ].sAlignement		=	"2"
Dw_1.istCol [ i ].sInvisible		= 	"N"

i = 4
dw_1.istCol [ i ].sDbName			=	"sysadm.w_inter.nom"
dw_1.istCol [ i ].sresultSet		=	"NOM"
dw_1.istCol [ i ].sType				=	"char(71)"
dw_1.istCol [ i ].sHeaderName		=	"Nom"
dw_1.istCol [ i ].ilargeur			=	28
dw_1.istCol [ i ].sAlignement		=	"0"
dw_1.istCol [ i ].sInvisible		= 	"N"

i = 5
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.id_cour"
dw_1.istCol [ i ].sresultSet		=	"ID_COUR"
dw_1.istCol [ i ].sType				=	"char(6)"
dw_1.istCol [ i ].sHeaderName		=	"Courrier"
dw_1.istCol [ i ].ilargeur			=	6
dw_1.istCol [ i ].sAlignement		=	"2"
dw_1.istCol [ i ].sInvisible		= 	"N"

i = 6
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.txt_compo1"
dw_1.istCol [ i ].sresultSet		=	"TXT_COMPO"
dw_1.istCol [ i ].sType				=	"char(248)"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 7
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.alt_part"
dw_1.istCol [ i ].sresultSet		=	"ALT_PART"
dw_1.istCol [ i ].sType				=	"char(1)"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 8
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.alt_pce"
dw_1.istCol [ i ].sresultSet		=	"ALT_PCE"
dw_1.istCol [ i ].sType				=	"char(1)"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 9
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.alt_ps"
dw_1.istCol [ i ].sresultSet		=	"ALT_PS"
dw_1.istCol [ i ].sType				=	"char(1)"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 10
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.id_i_db"
dw_1.istCol [ i ].sresultSet		=	"ID_I_DB"
dw_1.istCol [ i ].sType				=	"NUMBER"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 11
dw_1.istCol [ i ].sDbName			=	"sysadm.w_queue.trv_maj_par"
dw_1.istCol [ i ].sresultSet		=	"TRV_MAJ_PAR"
dw_1.istCol [ i ].sType				=	"char(4)"
dw_1.istCol [ i ].sHeaderName		=	"Maj Par"
dw_1.istCol [ i ].ilargeur			=	4
dw_1.istCol [ i ].sAlignement		=	"2"
dw_1.istCol [ i ].sInvisible		= 	"N"

i = 12
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.id_i"
dw_1.istCol [ i ].sresultSet		=	"ID_I"
dw_1.istCol [ i ].sType				=	"NUMBER"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 13
dw_1.istCol [ i ].sDbName			=	"sysadm.w_courrier.id_cpt"
dw_1.istCol [ i ].sresultSet		=	"ID_CPT"
dw_1.istCol [ i ].sHeaderName		=	"Cpt"
dw_1.istCol [ i ].ilargeur			=	2
dw_1.istCol [ i ].sType				=	"NUMBER"
dw_1.istCol [ i ].sInvisible		= 	"O"

i = 14
dw_1.istCol [ i ].sDbName			=	"sysadm.w_inter.alt_courgest"
dw_1.istCol [ i ].sresultSet		=	"ALT_COURGEST"
dw_1.istCol [ i ].sHeaderName		=	"Cour. Joint"
dw_1.istCol [ i ].ilargeur			=	1
dw_1.istCol [ i ].sType				=	"char(1)"
dw_1.istCol [ i ].sInvisible		= 	"N"
dw_1.istCol [ i ].sValues 			=	"Non~tN/Document~tJ/Double~tD"


sTables [ 1 ]	= "w_queue"
sTables [ 2 ]	= "w_inter"
sTables [ 3 ]	= "w_courrier"
sTables [ 4 ]	= "code_car"
sTables [ 5 ]	= "corb_oper"

Dw_1.isTri 		= "#1 A, #2 A, #4 A"		// .... MAJ_LE / ID_SIN / NOM

// [PI062] Convert( decimal(10), sysadm.w_queue.id_sin )
Dw_1.isJointure =	" AND sysadm.w_courrier.id_sin        = Convert( decimal(10), sysadm.w_queue.id_sin )"    +&
                  " AND sysadm.w_courrier.id_sin        = sysadm.w_inter.id_sin   " +&
						" AND sysadm.w_courrier.id_i			  = sysadm.w_inter.id_i     " +&
                  " AND sysadm.code_car.id_code         = sysadm.w_inter.cod_inter" +&
						" AND sysadm.code_car.id_typ_code     = '-IN'"                    +&
                  " AND Convert ( decimal(3), sysadm.w_queue.id_corb )         = sysadm.corb_oper.id_corb" +&
                  " AND sysadm.corb_oper.id_oper        = '" + stGlb.sCodOper + "'" +&
						" AND sysadm.w_queue.cod_etat         = '5'" 							+&
						" AND sysadm.w_queue.trv_edite_le    is not null"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil.                            */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, SQLCA )

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Description  la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation.                         */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
pb_Interro.istInterro.sDataObject			= "d_int_travaux_edit"
pb_Interro.istInterro.sCodeDw					= "TRAVAUX"

pb_Interro.istInterro.sData[1].sNom			= "trv_maj_par"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_queue.trv_maj_par"
pb_Interro.istInterro.sData[1].sType		= "STRING"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[2].sNom			= "id_corb"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.w_queue.id_corb"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "id_sin"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_queue.id_sin"
pb_Interro.istInterro.sData[3].sType		= "STRING"
pb_Interro.istInterro.sData[3].sOperande	= "="

pb_Interro.istInterro.sData[4].sNom			= "nom"
pb_Interro.istInterro.sData[4].sDbName		= "sysadm.w_queue.nom"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "dte_maj"
pb_Interro.istInterro.sData[5].sDbName		= "sysadm.w_queue.trv_maj_le"
pb_Interro.istInterro.sData[5].sType		= "DATETIME" // [PI056] DATE -> DATETIME
pb_Interro.istInterro.sData[5].sOperande	= "<="

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event spb_preparerimpression;call super::spb_preparerimpression;//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edit_Sinistre_Wkf_2000
//* Evenement 		: SPB_PreparerImpression									(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$but d'impression des courriers
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long	l1erSin
String sK_RETOUR	= "~r"
String sK_NEWLINE	= "~n"
String sText, sRepCourrier, sEntete

sText = "D$$HEX1$$e900$$ENDHEX$$but d'impression ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

//isNbrCourrier = Left ( st_Nombre.Text, Pos ( st_Nombre.Text, " /" ) )
ilNumCourrier	= 1

This.wf_SetSupprimerLigne ( TRUE )
/*------------------------------------------------------------------*/
/* Chargement ilSin avec la valeur du premier sinistre $$HEX3$$e0002000e900$$ENDHEX$$diter     */
/* pour que la rupture dans UE_IMPRIMERDOSSIER soit effectu$$HEX1$$e900$$ENDHEX$$e       */
/* correctement                                                     */
/*------------------------------------------------------------------*/

l1erSin			=	Dw_1.GetSelectedRow ( 0 )

If l1erSin > 0 Then
	ilSin				= Long ( Dw_1.GetItemString ( l1erSin, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On arme une variable d'instance pour indiquer le fichier des     */
/* DATAS $$HEX2$$e0002000$$ENDHEX$$utiliser pour les impressions.                           */
/*------------------------------------------------------------------*/
	sRepCourrier	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
	sEntete			= ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )

	isFicEntete		= sRepCourrier + sEntete
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_ae_sp_reedit_sinistre_wkf_2000.create
call super::create
end on

on w_ae_sp_reedit_sinistre_wkf_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_accueil_edition_2000`cb_debug within w_ae_sp_reedit_sinistre_wkf_2000
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_ae_sp_reedit_sinistre_wkf_2000
integer width = 242
integer height = 144
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_ae_sp_reedit_sinistre_wkf_2000
integer width = 242
integer height = 144
end type

type pb_creer from w_accueil_edition_2000`pb_creer within w_ae_sp_reedit_sinistre_wkf_2000
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_ae_sp_reedit_sinistre_wkf_2000
end type

on dw_1::clicked;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition:dw_1
// Evenement 	: Clicked
//	Auteur		: DBI
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: G$$HEX1$$e800$$ENDHEX$$re la la selection Multiligne
// Commentaires: Gestion de la s$$HEX1$$e900$$ENDHEX$$lection et d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lection des lignes relatives au sinistre click$$HEX1$$e900$$ENDHEX$$
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Boolean	bSelected
String	sIdSin

Long		lRow, lNbrSelection
Long		lNbLig, lLigSin = 1

lRow 		= GetClickedRow ()
lNbLig	= This.RowCount ()

lNbrSelection = Parent.wf_GetNbrDossierSelection ()

If ( lRow > 0 ) Then 

	bSelected = IsSelected( lRow )

	sIdSin	=	This.GetitemString ( lRow, "ID_SIN" )

	lLigSin	=	This.Find ( "ID_SIN = '" + sIdSin + "'", lLigSin, lNbLig )	

	Do 

		If ( bSelected ) Then
			lNbrSelection --
		Else
			lNbrSelection ++
		End If

		SelectRow( lLigSin, Not bSelected )


//Attention le find repart
		If lLigSin + 1 <= lNbLig Then

			lLigSin	=	This.Find ( "ID_SIN = '" + sIdSin + "'", lLigSin + 1, lNbLig )	
		Else

			lLigSin	=	0
		End IF

	Loop While lLigSin > 0 

	Parent.wf_SetNbrDossierSelection ( lNbrSelection )
End If

end on

on dw_1::retrieveend;call w_accueil_edition_2000`dw_1::retrieveend;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1
//* Evenement 		: RetrieveEnd
//* Auteur			: DBI
//* Date				: 17/07/1998 14:29:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre des lignes li$$HEX1$$e900$$ENDHEX$$es aux doubles ou courriers Joints
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_1.SetFilter ( "id_cpt = 0")
Dw_1.Filter ( )

end on

type pb_tri from w_accueil_edition_2000`pb_tri within w_ae_sp_reedit_sinistre_wkf_2000
integer width = 242
integer height = 144
end type

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_ae_sp_reedit_sinistre_wkf_2000
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_ae_sp_reedit_sinistre_wkf_2000
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_ae_sp_reedit_sinistre_wkf_2000
end type

type st_1 from w_accueil_edition_2000`st_1 within w_ae_sp_reedit_sinistre_wkf_2000
end type

type st_2 from w_accueil_edition_2000`st_2 within w_ae_sp_reedit_sinistre_wkf_2000
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_ae_sp_reedit_sinistre_wkf_2000
end type

type st_edit from w_accueil_edition_2000`st_edit within w_ae_sp_reedit_sinistre_wkf_2000
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_ae_sp_reedit_sinistre_wkf_2000
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_ae_sp_reedit_sinistre_wkf_2000
integer width = 242
integer height = 144
end type

