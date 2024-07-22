HA$PBExportHeader$w_a_sp_relances_2000.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre des Relances/Soldage.
forward
global type w_a_sp_relances_2000 from w_a_sp_rel_sold_2000
end type
end forward

global type w_a_sp_relances_2000 from w_a_sp_rel_sold_2000
end type
global w_a_sp_relances_2000 w_a_sp_relances_2000

event ue_item7;call super::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Relances (OVERRIDE)
//* Evenement 		: ue_Item7
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:15:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du Traitement
//* Commentaires	: A ce Moment Dw_1 est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$Charg$$HEX1$$e900$$ENDHEX$$e
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk     = True
Boolean	bTrace  = False
Boolean	bSaisie = True       // A false en retour, indique qu'une saisie contr$$HEX1$$f400$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$e par l'objet
										// est invalide.
String 	sMes						// Message d'erreur
String	sCodeMes 				// Code du message $$HEX2$$e0002000$$ENDHEX$$afficher
Icon		icIcon   				// Icon



/*------------------------------------------------------------------*/
/* Lancement du traitement (une partie sur l'objet, l'autre sur la  */
/* la fen$$HEX1$$ea00$$ENDHEX$$tre).                                                 	  */
/*------------------------------------------------------------------*/
If bOk then
	bOk = iuo_Rel.uf_LancerTrt ( bSaisie )

	If Not bOk Then
		TriggerEvent ("ue_enablefenetre")

		// Ce n'est pas le traitement qui s'est plant$$HEX1$$e900$$ENDHEX$$
		// Mais la saisie qui n'est pas valide.
		If not bSaisie Then
			pb_Creer.enabled  = False
			pb_Lancer.enabled = True
		End IF 

	End If


End If


If bSaisie Then

 CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R1P", "R2"

		If bOk Then

			This.wf_Editer_Relance ()

			If wf_GetStopTraitement () Then
				sMes 				   = "Probl$$HEX1$$e800$$ENDHEX$$me lors de l'$$HEX1$$e900$$ENDHEX$$dition. Le traitement se termine anormalement : pr$$HEX1$$e900$$ENDHEX$$venir le service informatique."
				sCodeMes				= "GENE012"
				icIcon				= Exclamation!
				bTrace				= True
			Else
				sMes 			      = "Fin des $$HEX1$$e900$$ENDHEX$$ditions. Le traitement s'est termin$$HEX2$$e9002000$$ENDHEX$$normalement."
				sCodeMes				= "RELA140"
				icIcon				= Information!
				bTrace				= False
			End If

			iuo_Rel.uf_EcrireTrace ( 3, "", 0, "" )
			iuo_Rel.uf_EcrireTrace ( 3, "", 0, sMes )

			stMessage.sCode    = sCodeMes
			stMessage.Icon	    = icIcon
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.sVar[1]  = sMes
			stMessage.bTrace	 = bTrace
			F_Message ( stMessage )

		End If


	CASE "R1T"

			If Not bOk Then
				sMes 				   = "Probl$$HEX1$$e800$$ENDHEX$$me lors l'$$HEX1$$e900$$ENDHEX$$dition de la liste."
				sCodeMes				= "GENE012"
				icIcon				= Exclamation!
				bTrace				= True
			Else
				sMes 			      = "Fin de l'$$HEX1$$e900$$ENDHEX$$dition de la liste."
				sCodeMes				= "RELA140"
				icIcon				= Information!
				bTrace				= False
			End If

			iuo_Rel.uf_EcrireTrace ( 3, "", 0, "" )
			iuo_Rel.uf_EcrireTrace ( 3, "", 0, sMes )

			stMessage.sCode    = sCodeMes
			stMessage.Icon	    = icIcon
			stMessage.sTitre   = "SIMPA2 - Relances"			
			stMessage.sVar[1]  = sMes
			stMessage.bTrace	 = bTrace
			F_Message ( stMessage )



	CASE "DR1"

			If Not bOk Then
				sMes 				   = "Probl$$HEX1$$e800$$ENDHEX$$me lors de l'annulation de la relance. Le traitement se termine anormalement : pr$$HEX1$$e900$$ENDHEX$$venir le service informatique."
				sCodeMes				= "GENE012"
				icIcon				= Exclamation!
				bTrace				= True
			Else
				sMes 			      = "Premi$$HEX1$$e800$$ENDHEX$$re relance annul$$HEX1$$e900$$ENDHEX$$e. Le traitement s'est termin$$HEX2$$e9002000$$ENDHEX$$normalement."
				sCodeMes				= "RELA140"
				icIcon				= Information!
				bTrace				= False
			End If

			iuo_Rel.uf_EcrireTrace ( 3, "", 0, "" )
			iuo_Rel.uf_EcrireTrace ( 3, "", 0, sMes )

			stMessage.sCode    = sCodeMes
			stMessage.Icon	    = icIcon
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.sVar[1]  = sMes
			stMessage.bTrace	 = bTrace
			F_Message ( stMessage )



	CASE "SOL"

			If Not bOk Then
				sMes 				   = "Probl$$HEX1$$e800$$ENDHEX$$me lors du lors du soldage des dossiers. Le traitement se termine anormalement : pr$$HEX1$$e900$$ENDHEX$$venir le service informatique."
				sCodeMes				= "GENE012"
				icIcon				= Exclamation!
				bTrace				= True
			Else
				sMes 			      = "Dossiers sold$$HEX1$$e900$$ENDHEX$$s. Le traitement s'est termin$$HEX2$$e9002000$$ENDHEX$$normalement."
				sCodeMes				= "RELA140"
				icIcon				= Information!
				bTrace				= False
			End If

			iuo_Rel.uf_EcrireTrace ( 3, "", 0, "" )
			iuo_Rel.uf_EcrireTrace ( 3, "", 0, sMes )

			stMessage.sCode    = sCodeMes
			stMessage.Icon	    = icIcon
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.sVar[1]  = sMes
			stMessage.bTrace	 = bTrace
			F_Message ( stMessage )


 END CHOOSE

DataWindowChild dwChild
dw_Produit.GetChild ( "ID_PROD", dwChild )
dw_Produit.SetItem ( 1, "ID_PROD", stNul.lng )
dwChild.Reset()
dwChild.SetTransObject ( SQLCA )
		
// [OPTIM_MENU_EDT][RS-331]
dwChild.Retrieve( isTypTrt )	


 stMessage.bTrace	 = False
 TriggerEvent ("ue_enablefenetre")

End If

end event

on w_a_sp_relances_2000.create
int iCurrent
call super::create
end on

on w_a_sp_relances_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on ue_creer;call w_a_sp_rel_sold_2000::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Relances
//* Evenement 		: ue_Creer
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 16:10:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement des Donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk = True

/*------------------------------------------------------------------*/
/* On prepare le lancement du traitement.                           */
/*------------------------------------------------------------------*/
bOk = iuo_Rel.uf_PreparerLancer ( ) 

If Not bOk Then
	TriggerEvent ("ue_EnableFenetre")
End If


If bOk Then

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R2"
			This.Dw_TailleLot.Show ()

			This.pb_Retour.Enabled	= True
			This.pb_Creer.enabled	= False
			This.pb_Lancer.Enabled	= True


		CASE "R1P", "DR1", "R1T", "SOL"

			This.pb_Retour.Enabled	= True
			This.pb_Creer.Enabled	= False
			This.pb_Lancer.Enabled	= True



	END CHOOSE

End If


end on

type cb_debug from w_a_sp_rel_sold_2000`cb_debug within w_a_sp_relances_2000
end type

type pb_retour from w_a_sp_rel_sold_2000`pb_retour within w_a_sp_relances_2000
end type

type pb_interro from w_a_sp_rel_sold_2000`pb_interro within w_a_sp_relances_2000
end type

type pb_creer from w_a_sp_rel_sold_2000`pb_creer within w_a_sp_relances_2000
end type

event pb_creer::clicked;call super::clicked;

dw_saisiesin.AcceptText()
end event

type dw_1 from w_a_sp_rel_sold_2000`dw_1 within w_a_sp_relances_2000
end type

type pb_tri from w_a_sp_rel_sold_2000`pb_tri within w_a_sp_relances_2000
end type

type pb_imprimer from w_a_sp_rel_sold_2000`pb_imprimer within w_a_sp_relances_2000
end type

type cb_tout from w_a_sp_rel_sold_2000`cb_tout within w_a_sp_relances_2000
boolean visible = false
boolean enabled = false
end type

type cb_aucun from w_a_sp_rel_sold_2000`cb_aucun within w_a_sp_relances_2000
boolean visible = false
boolean enabled = false
end type

type st_1 from w_a_sp_rel_sold_2000`st_1 within w_a_sp_relances_2000
end type

type st_2 from w_a_sp_rel_sold_2000`st_2 within w_a_sp_relances_2000
end type

type st_nombre from w_a_sp_rel_sold_2000`st_nombre within w_a_sp_relances_2000
end type

type st_edit from w_a_sp_rel_sold_2000`st_edit within w_a_sp_relances_2000
end type

type mle_msg from w_a_sp_rel_sold_2000`mle_msg within w_a_sp_relances_2000
end type

type pb_editer from w_a_sp_rel_sold_2000`pb_editer within w_a_sp_relances_2000
end type

type uo_defil from w_a_sp_rel_sold_2000`uo_defil within w_a_sp_relances_2000
end type

type dw_taillelot from w_a_sp_rel_sold_2000`dw_taillelot within w_a_sp_relances_2000
end type

type dw_saisiesin from w_a_sp_rel_sold_2000`dw_saisiesin within w_a_sp_relances_2000
end type

event dw_saisiesin::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de produit.
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//*-----------------------------------------------------------------


// [PM407-1]
If SQLCA.PS_S_PM407_NOUVEAU_SYSTEME ( "SINISTRE", 0, Long ( this.GetText () ) )> 0 Then
	Return 1
End If

end event

event dw_saisiesin::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de produit.
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//*-----------------------------------------------------------------


stMessage.sTitre		= "Relances automatis$$HEX1$$e900$$ENDHEX$$es"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.bErreurG	= False
stMessage.sCode		= "GENE179"
f_Message ( stMessage )	

Return 1

end event

type dw_produit from w_a_sp_rel_sold_2000`dw_produit within w_a_sp_relances_2000
end type

event dw_produit::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de produit.
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//       JFF   08/04/2019 [PM407-1][20190408]
//*-----------------------------------------------------------------


// [PM407-1]
// [PM407-1][20190408]
// Demande de Magali : on lance encore pour 1 mois apr$$HEX1$$e800$$ENDHEX$$s la MEP du 03/04/19, 
// Les relances sur l'ancien syst$$HEX1$$e800$$ENDHEX$$me pour sortir les relances 2 de l'ancien syst$$HEX1$$e800$$ENDHEX$$me.
If Not ( isTypTrt = "R2" And Today () < 2019-05-03 ) Then
	If SQLCA.PS_S_PM407_NOUVEAU_SYSTEME ( "PRODUIT", Long ( this.GetText () ), 0  )> 0 Then
		Return 1
	End IF
End If 

end event

event dw_produit::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de produit.
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//*-----------------------------------------------------------------


stMessage.sTitre		= "Relances automatis$$HEX1$$e900$$ENDHEX$$es"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.bErreurG	= False
stMessage.sCode		= "GENE179"
f_Message ( stMessage )	

Return 1
end event

type dw_para_prod from w_a_sp_rel_sold_2000`dw_para_prod within w_a_sp_relances_2000
end type

type dw_police from w_a_sp_rel_sold_2000`dw_police within w_a_sp_relances_2000
end type

type uo_libelle from w_a_sp_rel_sold_2000`uo_libelle within w_a_sp_relances_2000
end type

type dw_civilite from w_a_sp_rel_sold_2000`dw_civilite within w_a_sp_relances_2000
end type

type pb_lancer from w_a_sp_rel_sold_2000`pb_lancer within w_a_sp_relances_2000
end type

type dw_boitearchive from w_a_sp_rel_sold_2000`dw_boitearchive within w_a_sp_relances_2000
end type

type dw_detpro from w_a_sp_rel_sold_2000`dw_detpro within w_a_sp_relances_2000
end type

type dw_page_blanche from w_a_sp_rel_sold_2000`dw_page_blanche within w_a_sp_relances_2000
end type

type pb_pageblanche from w_a_sp_rel_sold_2000`pb_pageblanche within w_a_sp_relances_2000
end type

type dw_gencourrier from w_a_sp_rel_sold_2000`dw_gencourrier within w_a_sp_relances_2000
end type

type dw_autorisation from w_a_sp_rel_sold_2000`dw_autorisation within w_a_sp_relances_2000
end type

