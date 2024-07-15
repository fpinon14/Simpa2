HA$PBExportHeader$w_a_sp_cas_id_adh_carte.srw
forward
global type w_a_sp_cas_id_adh_carte from w_a_spb_workflow
end type
end forward

global type w_a_sp_cas_id_adh_carte from w_a_spb_workflow
string title = "Accueil - Gestion des cas particuliers SIMPA 2"
event ue_majworkflow pbm_custom02
end type
global w_a_sp_cas_id_adh_carte w_a_sp_cas_id_adh_carte

event ue_majworkflow;//*-----------------------------------------------------------------
//*
//* Fonction		: W_A_Sp_Cas_Id_Adh::Ue_MajWorkFlow ( EXTEND )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 16:01:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion de ALT_OCCUPE 
//*
//*-----------------------------------------------------------------

String sIdSin, sIdCorb, sSql
String  sTrvMajParNouveau
String sCodOper
String sMaintenant

DateTime dtMaintenant

If	dw_1.ilLigneClick > 0 Then
/*------------------------------------------------------------------*/
/* Puisque la ligne est bonne, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$de sinistre et le  */
/* N$$HEX2$$b0002000$$ENDHEX$$de corbeille                                                  */
/* Ces valeurs doivent $$HEX1$$ea00$$ENDHEX$$tre uniques dans la table W_QUEUE           */
/*------------------------------------------------------------------*/

	sIdSin 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )
	sIdCorb	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" )

	dtMaintenant	= DateTime ( Today(), Now() )

	sMaintenant 	= "'" + String ( dtMaintenant, "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
	sIdSin			= "'" + sIdSin + "'"
	sIdCorb			= "'" + sIdCorb + "'"
	sSql 				= "EXECUTE sysadm.IM_U04_W_QUEUE_CAS1 "
	sCodOper 		= "'" + stGLB.sCodOper + "'"

	sSql = 	sSql 												+ &
				sMaintenant								+ "," + &
				sCodOper									+ "," + &
				sIdSin									+ "," + &
				sIdCorb

	If 		Not F_Execute ( sSql , itrTrans ) Then
/*------------------------------------------------------------------*/
/* Il y a une erreur de MAJ. Normalement, ce cas ne doit pas        */
/* arriver sauf erreur particuli$$HEX1$$e800$$ENDHEX$$re (R$$HEX1$$e900$$ENDHEX$$seau, Cable, Serveur)        */
/*------------------------------------------------------------------*/
				stMessage.bErreurG	= True
				stMessage.sVar[1]		= "de mise $$HEX2$$e0002000$$ENDHEX$$jour sur W_QUEUE"
				stMessage.sVar[2]		= itrTrans.SqlErrText
				stMessage.sTitre		= "- WorkFlow - "
				stMessage.Icon			= Exclamation!
				stMessage.sCode 		= "ANCE043"

/*------------------------------------------------------------------*/
/* Il faut faire le ROOLBACK apr$$HEX1$$e900$$ENDHEX$$s. Sinon la zone SqlErrText est    */
/* remise $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro                                                    */
/*------------------------------------------------------------------*/
//				ROLLBACK USING	itrTrans	;
				F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

				f_Message ( stMessage )
				Return 
		
	ElseIf	itrTrans.SqlnRows = 0 Then

/*------------------------------------------------------------------*/
/* On ne trouve aucune ligne $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour. Deux cas sont         */
/* possibles.                                                       */
/* 1 - Le travail vient d'$$HEX1$$ea00$$ENDHEX$$tre pris pas quelqu'un en saisie donc    */
/* ALT_OCCUPE = OUI                                                 */
/* 2 - Le travail n'existe plus. Cas tr$$HEX1$$e900$$ENDHEX$$s improbable                */
/*------------------------------------------------------------------*/
//			ROLLBACK USING	itrTrans	;
			F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			SELECT	sysadm.w_queue.trv_maj_par
			INTO		:sTrvMajParNouveau
			FROM		sysadm.w_queue
			WHERE		id_sin	= :sIdSin
			AND		id_corb	= :sIdCorb
			USING		itrTrans		;

			If	itrTrans.SqlnRows = 1 Then

				stMessage.bErreurG	= True
				stMessage.sVar[1]		= sTrvMajParNouveau
				stMessage.sTitre		= "- WorkFlow - "
				stMessage.Icon			= Exclamation!
				stMessage.sCode 		= "ANCE044"

				f_Message ( stMessage )
				Return 

			Else

				stMessage.bErreurG	= True
				stMessage.sVar[1]		= "Ce dossier"
				stMessage.sTitre		= "- WorkFlow - "
				stMessage.Icon			= Exclamation!
				stMessage.sCode 		= "ANCE040"

				f_Message ( stMessage )
				Return 

			End If

	Else

/*------------------------------------------------------------------*/
/* Sinon tout se passe bien, on valide la transaction et on met     */
/* les informations $$HEX2$$e0002000$$ENDHEX$$jour de mani$$HEX1$$e800$$ENDHEX$$re visuelle.                     */
/* ALT_OCCUPE	= OUI                                                */
/* TRV_MAJ_LE	= Maintenant                                         */
/* TRV_MAJ_PAR	= stGLB.ScodOper                                     */
/*------------------------------------------------------------------*/

//			COMMIT	USING itrTrans		;
			F_Commit ( itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]


			dw_1.SetItem ( dw_1.ilLigneClick, "ALT_OCCUPE", "N" )

			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_LE", dtMaintenant )
			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_PAR", stGLB.sCodOper )

//			dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_LE", dtMaintenant )
//			dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_PAR", stGLB.sCodOper )

	End If
End If




end event

on open;call w_a_spb_workflow::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cas_Id_Adh_Carte::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 26/01/1999 14:37:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le traitement des cas particuliers
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sJointure, sRet, sRech
Long lPos, lLng

/*------------------------------------------------------------------*/
/* La fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re une jointure pour les corbeilles dont  */
/* dipose le gestionnaire. Il suffit simplement de rajouter dans    */
/* la chaine de jointure de fait de ne pouvoir acc$$HEX1$$e900$$ENDHEX$$der qu'aux       */
/* produits avec un COD_ADH $$HEX2$$e0002000$$ENDHEX$$3 ou 4. (Produits avec adh$$HEX1$$e900$$ENDHEX$$sion par   */
/* carte).                                                          */
/*------------------------------------------------------------------*/
sJointure	= dw_1.isJointure
sRech			= " order "

lPos = Pos ( sJointure, sRech, 1 )
lLng = Len ( sJointure )

sRet = Left ( sJointure, lPos )																										+ &
		 " AND sysadm.w_queue.id_prod in ( select id_prod from sysadm.produit where cod_adh = '3' ) "			+ &
		 Mid ( sJointure, lPos + 1, lLng )

dw_1.isJointure = sRet

end on

on ue_modifier;call w_a_spb_workflow::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cas_Id_Adh_Carte::Ue_Modifier
//* Evenement 		: Ue_Modifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:03:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion pour les cas particuliers
//*					  Modification de la zone ID_ADH correspondant $$HEX2$$e0002000$$ENDHEX$$un N$$HEX2$$b0002000$$ENDHEX$$de carte
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

If ibContinuerModifier Then

	istPass.bSupprime = False
	istPass.bControl  = True
	istPass.bInsert   = False

	istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )

	istPass.sTab[2] 	= "S"				// Nous sommes en saisie

	F_OuvreTraitement ( W_Tm_Sp_Cas_Id_Adh, istpass )

End If
end on

on ue_workflow;call w_a_spb_workflow::ue_workflow;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cas_Id_Adh_Carte::Ue_WorkFlow
//* Evenement 		: Ue_WorkFlow
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:04:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion d'une fen$$HEX1$$ea00$$ENDHEX$$tre de workflow
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On part du principe que l'on est en saisie. On arme donc la      */
/* zone COD_ETAT $$HEX2$$e0002000$$ENDHEX$$1.                                               */
/*------------------------------------------------------------------*/
isCodEtat = '1'

end on

on ue_fermer_interro;call w_a_spb_workflow::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cas_Id_Adh_Carte::Ue_Fermer_Interro
//* Evenement 		: Ue_Fermer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild

W_Interro.dw_1.GetChild ( "ID_CORB", dwChild )
dwChild.ShareDataOff ()

end on

on ue_preparer_interro;call w_a_spb_workflow::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cas_Id_Adh_Carte::Ue_Preparer_Interro
//* Evenement 		: Ue_Preparer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Populise la liste des corbeilles dans la dw d'interro
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

W_Interro.dw_1.GetChild ( "ID_CORB", dwChild )
dw_Corbeille.GetChild ( "ID_CORB", dwChild1 )
dwChild1.ShareData ( dwChild )

end on

on w_a_sp_cas_id_adh_carte.create
call super::create
end on

on w_a_sp_cas_id_adh_carte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_a_spb_workflow`cb_debug within w_a_sp_cas_id_adh_carte
end type

type pb_retour from w_a_spb_workflow`pb_retour within w_a_sp_cas_id_adh_carte
end type

type pb_interro from w_a_spb_workflow`pb_interro within w_a_sp_cas_id_adh_carte
integer taborder = 60
end type

type pb_creer from w_a_spb_workflow`pb_creer within w_a_sp_cas_id_adh_carte
end type

type dw_1 from w_a_spb_workflow`dw_1 within w_a_sp_cas_id_adh_carte
end type

type pb_tri from w_a_spb_workflow`pb_tri within w_a_sp_cas_id_adh_carte
end type

type pb_imprimer from w_a_spb_workflow`pb_imprimer within w_a_sp_cas_id_adh_carte
end type

type dw_libre from w_a_spb_workflow`dw_libre within w_a_sp_cas_id_adh_carte
integer x = 50
integer y = 212
end type

type mle_msg1 from w_a_spb_workflow`mle_msg1 within w_a_sp_cas_id_adh_carte
end type

type pb_debloc from w_a_spb_workflow`pb_debloc within w_a_sp_cas_id_adh_carte
end type

type dw_corbeille from w_a_spb_workflow`dw_corbeille within w_a_sp_cas_id_adh_carte
integer x = 247
integer y = 212
integer taborder = 50
boolean livescroll = false
end type

type dw_workflow from w_a_spb_workflow`dw_workflow within w_a_sp_cas_id_adh_carte
integer x = 443
integer y = 212
boolean livescroll = false
end type

