HA$PBExportHeader$w_t_sp_sinistres_lies.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement SIMPLE pour la recherche des sinistres li$$HEX1$$e900$$ENDHEX$$s.
forward
global type w_t_sp_sinistres_lies from w_ancetre
end type
type pb_valider from u_8_pbvalider within w_t_sp_sinistres_lies
end type
type pb_retour from u_8_pbretour within w_t_sp_sinistres_lies
end type
type dw_1 from datawindow within w_t_sp_sinistres_lies
end type
type dw_wtravail from u_datawindow within w_t_sp_sinistres_lies
end type
type cb_prendre2 from commandbutton within w_t_sp_sinistres_lies
end type
type cb_prendre1 from commandbutton within w_t_sp_sinistres_lies
end type
type cb_retour from commandbutton within w_t_sp_sinistres_lies
end type
end forward

global type w_t_sp_sinistres_lies from w_ancetre
boolean visible = true
integer x = 0
integer y = 0
integer width = 3570
integer height = 1744
boolean titlebar = true
string title = "Recherche des sinistres li$$HEX1$$e900$$ENDHEX$$s"
pb_valider pb_valider
pb_retour pb_retour
dw_1 dw_1
dw_wtravail dw_wtravail
cb_prendre2 cb_prendre2
cb_prendre1 cb_prendre1
cb_retour cb_retour
end type
global w_t_sp_sinistres_lies w_t_sp_sinistres_lies

type variables
Private :
	w_Ancetre_Traitement	iwParentDet

	Long			ilRetour
end variables

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_Lies::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:55:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lTotSinistre, lIdOrdre, lCpt, lLig, lAdrDms

DataWindowChild dwChild, dwChild1

String sAltQueue, sTitre, sCodAdh, sVar, sNouvelleLigne
String sCodCivAdh, sNomAdh, sPrenomAdh, sAdr1Adh, sAdr2Adh, sAdrCpAdh, sAdrVilleAdh
String sCodCivSin, sNomSin, sPrenomSin, sAdr1Sin, sAdr2Sin, sAdrCpSin, sAdrVilleSin

Boolean bErreur

DateTime dDteAdh, dDteAdhAdh, dDteAdhSin // [PI056] date -> datetime

bErreur 				= False
sNouvelleLigne		= "~r~n"

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
iwParentDet = istPass.wParent

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT non saisissable.                       */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = False

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les lignes correspondant aux sinistres li$$HEX1$$e900$$ENDHEX$$s.         */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Il faut partager les donn$$HEX1$$e900$$ENDHEX$$es des childs avant de partager les donn$$HEX1$$e900$$ENDHEX$$es de la dw principale
//sinon la fenetre des retrieve arg s'affiche!!
long	ll_res
ll_res = istPass.dwNorm[1].GetChild("cod_civ", dwchild)
ll_res = dw_1.GetChild("cod_civ", dwchild1)
ll_res = dwchild1.SetTransObject(istPass.trtrans)
ll_res = dwchild.ShareData(dwchild1)
ll_res = istPass.dwNorm[1].ShareData ( dw_1 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la DW de saisie de la fen$$HEX1$$ea00$$ENDHEX$$tre parente.               */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
ll_res = iwParentDet.dw_1.GetChild("cod_civ", dwchild)
ll_res = dw_wTravail.GetChild ( "COD_CIV", dwChild1 )
ll_res = dwchild1.SetTransObject(istPass.trtrans)
ll_res = dwChild.ShareData ( dwChild1 )

ll_res = iwParentDet.dw_1.GetChild("cod_i_prov", dwchild)
ll_res = dw_wTravail.GetChild ( "cod_i_prov", dwChild1 )
ll_res = dwchild1.SetTransObject(istPass.trtrans)
ll_res = dwChild.ShareData ( dwChild1 )

ll_res = iwParentDet.dw_1.GetChild("id_prod", dwchild)
ll_res = dw_wTravail.GetChild ( "id_prod", dwChild1 )
ll_res = dwchild1.SetTransObject(istPass.trtrans)
ll_res = dwChild.ShareData ( dwChild1 )

ll_res = iwParentDet.dw_1.ShareData ( dw_wTravail )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On s'occupe de faire apparaitre la civilit$$HEX2$$e9002000$$ENDHEX$$correctement.        */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//le partage de donn$$HEX1$$e900$$ENDHEX$$es des child est d$$HEX1$$e900$$ENDHEX$$plac$$HEX2$$e9002000$$ENDHEX$$avant le partage de donn$$HEX1$$e900$$ENDHEX$$e des dw m$$HEX1$$e800$$ENDHEX$$res
//ll_res = istPass.dwNorm[1].GetChild ( "COD_CIV", dwChild )
//ll_res = dw_1.GetChild ( "COD_CIV", dwChild1 )
//ll_res = dwChild.ShareData ( dwChild1 )
//
//ll_res = dw_wTravail.GetChild ( "COD_CIV", dwChild1 )
//ll_res = dwChild.ShareData ( dwChild1 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On arme le titre de la DW. Ce titre est g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$dans la fonction  */
/* Uf_Recuperer_Sinistres_Lies ().                                  */
/*------------------------------------------------------------------*/
sTitre = "st_Titre.Text = '" + istPass.sTab[1] + "'"
dw_1.Modify ( sTitre )

lTotSinistre = dw_1.RowCount ()
/*------------------------------------------------------------------*/
/* On traite maintenant les diff$$HEX1$$e900$$ENDHEX$$rents probl$$HEX1$$e800$$ENDHEX$$mes.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* S'il existe des num$$HEX1$$e900$$ENDHEX$$ros d'ordre diff$$HEX1$$e900$$ENDHEX$$rents, il y a un probl$$HEX1$$e800$$ENDHEX$$me   */
/* d'attribution de N$$HEX2$$b0002000$$ENDHEX$$d'ordre $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$gler par le service              */
/* informatique. Il faut interdire la validation.                   */
/*------------------------------------------------------------------*/
lIdOrdre = dw_1.GetItemNumber ( 1, "ID_ORDRE" )
For	lCpt = 2 To lTotSinistre
		If	dw_1.GetItemNumber ( lCpt, "ID_ORDRE" ) <> lIdOrdre	Then

			cb_Prendre1.Enabled = False
			cb_Prendre1.Visible = False

			cb_Prendre2.Enabled = False
			cb_Prendre2.Visible = False
			
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WORK180"
			stMessage.bTrace		= TRUE

			F_Message ( stMessage )
			bErreur = True
			Exit
		End If
Next

/*------------------------------------------------------------------*/
/* S'il existe un sinistre en cours de traitement, il faut d'abord  */
/* le valider avant d'en saisir un nouveau.                         */
/*------------------------------------------------------------------*/
If	Not bErreur Then
	For lCpt = 1 To lTotSinistre
			sAltQueue = dw_1.GetItemString ( lCpt, "ALT_QUEUE" )
			If	sAltQueue = "O" Then

				cb_Prendre1.Enabled = False
				cb_Prendre1.Visible = False

				cb_Prendre2.Enabled = False
				cb_Prendre2.Visible = False

			
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
				stMessage.Icon			= StopSign!
				stMessage.bErreurG	= False
				stMessage.sVar[1]		= String ( dw_1.GetItemNumber ( lCpt, "ID_SIN" ) )
				stMessage.sCode		= "WORK190"

				F_Message ( stMessage )
				bErreur = True
				Exit
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* S'il existe diff$$HEX1$$e900$$ENDHEX$$rentes dates d'adh$$HEX1$$e900$$ENDHEX$$sion pour les sinistres, il  */
/* faut pr$$HEX1$$e900$$ENDHEX$$venir le service informatique et interdire la            */
/* validation. Ce test est r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$sur les dates que l'on poss$$HEX1$$e900$$ENDHEX$$de   */
/* d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$. On ne v$$HEX1$$e900$$ENDHEX$$rifie pas cette date unique avec la date que l'on  */
/* vient de saisir (COD_ADH = 2,3,4,5), ou que l'on vient de        */
/* calculer (COD_ADH = 1).                                          */
/*------------------------------------------------------------------*/
If	Not bErreur Then
	dDteAdh = dw_1.GetItemDateTime ( 1, "DTE_ADH" ) // [PI056] date -> datetime

	For	lCpt = 2 To lTotSinistre
			If	dw_1.GetItemDateTime ( lCpt, "DTE_ADH" ) <> dDteAdh	Then

				cb_Prendre1.Enabled = False
				cb_Prendre1.Visible = False

				cb_Prendre2.Enabled = False
				cb_Prendre2.Visible = False
			
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
				stMessage.Icon			= StopSign!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WORK250"
				stMessage.bTrace		= TRUE

				F_Message ( stMessage )
				bErreur = True
				Exit
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* On compare les informations r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es lors de la recherche      */
/* adh$$HEX1$$e900$$ENDHEX$$sion $$HEX2$$e0002000$$ENDHEX$$celle que l'on vient de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer. On affiche les     */
/* diff$$HEX1$$e900$$ENDHEX$$rences pour pr$$HEX1$$e900$$ENDHEX$$venir l'utilisateur. Ce test ne doit $$HEX1$$ea00$$ENDHEX$$tre    */
/* r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$que pour les produits avec COD_ADH = 1 et 6.             */
/*------------------------------------------------------------------*/
If	Not bErreur Then
	iwParentDet.dw_1.GetChild ( "ID_PROD", dwChild )

	lLig				= dwChild.GetRow ()
	sCodAdh			= dwChild.GetItemString ( lLig, "COD_ADH" )
	lAdrDms			= dwChild.GetItemNumber ( lLig, "COD_ADR_DMS" )

	If	sCodAdh = "1" Or sCodAdh = "6" Then

		sCodCivAdh		= dw_wTravail.GetItemString ( 1, "COD_CIV" )
		sNomAdh			= dw_wTravail.GetItemString ( 1, "NOM" )
		sPrenomAdh		= dw_wTravail.GetItemString ( 1, "PRENOM" )
		If IsNull ( sPrenomAdh ) Then sPrenomAdh = ""

		sAdr1Adh			= dw_wTravail.GetItemString ( 1, "ADR_1" )
		If IsNull ( sAdr1Adh ) Then sAdr2Sin = ""

		sAdr2Adh			= dw_wTravail.GetItemString ( 1, "ADR_2" )
		If IsNull ( sAdr2Adh ) Then sAdr2Sin = ""

		sAdrCpAdh		= dw_wTravail.GetItemString ( 1, "ADR_CP" )
		sAdrVilleAdh	= dw_wTravail.GetItemString ( 1, "ADR_VILLE" )
		If IsNull ( sAdrVilleAdh ) Then sAdr2Sin = ""

		dDteAdhAdh		= dw_wTravail.GetItemDateTime ( 1, "DTE_ADH" ) // [PI056] date -> datetime

		sCodCivSin		= dw_1.GetItemString ( 1, "COD_CIV" )
		sNomSin			= dw_1.GetItemString ( 1, "NOM" )
		sPrenomSin		= dw_1.GetItemString ( 1, "PRENOM" )

		sAdr1Sin			= dw_1.GetItemString ( 1, "ADR_1" )
		sAdr2Sin			= dw_1.GetItemString ( 1, "ADR_2" )
		If IsNull ( sAdr2Sin ) Then sAdr2Sin = ""

		sAdrCpSin		= dw_1.GetItemString ( 1, "ADR_CP" )
		sAdrVilleSin	= dw_1.GetItemString ( 1, "ADR_VILLE" )

		dDteAdhSin		= dw_1.GetItemDateTime ( 1, "DTE_ADH" ) // [PI056] date -> datetime

		If	sCodCivAdh <> sCodCivSin Then

			sCodCivAdh = dw_wTravail.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )
			sCodCivSin = dw_1.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )
			
			sVar = sVar + "Civilit$$HEX2$$e9002000$$ENDHEX$$(Adh)	" + sCodCivAdh + sNouvelleLigne + &
							  "Civilit$$HEX2$$e9002000$$ENDHEX$$(Sin)	" + sCodCivSin + sNouvelleLigne + sNouvelleLigne
		End If

		If	sNomAdh <> sNomSin Then
			sVar = sVar + "Nom (Adh)	" + sNomAdh + sNouvelleLigne + &
							  "Nom (Sin)		" + sNomSin + sNouvelleLigne + sNouvelleLigne
		End If

		If	sPrenomAdh <> sPrenomSin Then
			sVar = sVar + "Pr$$HEX1$$e900$$ENDHEX$$nom (Adh)	" + sPrenomAdh + sNouvelleLigne + &
							  "Pr$$HEX1$$e900$$ENDHEX$$nom (Sin)	" + sPrenomSin + sNouvelleLigne + sNouvelleLigne
		End If

		If	sAdr1Adh <> sAdr1Sin And lAdrDms = 1 Then
			sVar = sVar + "Adresse1 (Adh)	" + sAdr1Adh + sNouvelleLigne + &
							  "Adresse1 (Sin)	" + sAdr1Sin + sNouvelleLigne + sNouvelleLigne
		End If

		If	sAdr2Adh <> sAdr2Sin And lAdrDms = 1 Then
			sVar = sVar + "Adresse2 (Adh)	" + sAdr2Adh + sNouvelleLigne + &
							  "Adresse2 (Sin)	" + sAdr2Sin + sNouvelleLigne + sNouvelleLigne
		End If

		If	sAdrCpAdh <> sAdrCpSin And lAdrDms = 1 Then
			sVar = sVar + "Code Postal (Adh)	" + sAdrCpAdh + sNouvelleLigne + &
							  "Code Postal (Sin)	" + sAdrCpSin + sNouvelleLigne + sNouvelleLigne	
		End If

		If	sAdrVilleAdh <> sAdrVilleSin And lAdrDms = 1 Then
			sVar = sVar + "Ville (Adh)		" + sAdrVilleAdh + sNouvelleLigne + &
							  "Ville (Sin)		" + sAdrVilleSin + sNouvelleLigne + sNouvelleLigne	
		End If

		If	dDteAdhAdh <> dDteAdhSin Then
			sVar = sVar + "Date Adh.(Adh)		" + String ( dDteAdhAdh ) + sNouvelleLigne + &
							  "Date Adh.(Sin)		" + String ( dDteAdhSin ) + sNouvelleLigne + sNouvelleLigne	
		End If

		If	sVar <> "" Then 

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur les sinistres li$$HEX1$$e900$$ENDHEX$$s"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sVar[1]		= sVar
			stMessage.sCode		= "WORK260"
			stMessage.bTrace		= FALSE

			F_Message ( stMessage )

			cb_Prendre2.Enabled = True
			cb_Prendre2.Visible = True
		End If
	End If
End If






end event

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_Lies::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT saisissable.                           */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = True

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche le script de la fen$$HEX1$$ea00$$ENDHEX$$tre parent. On lui passe en     */
/* param$$HEX1$$e800$$ENDHEX$$tre la valeur ilRetour. Cela $$HEX1$$e900$$ENDHEX$$vite d'avoir deux            */
/* $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nements $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$crire.                                            */
/*------------------------------------------------------------------*/
iwParentDet.TriggerEvent ( "Ue_Sinistres_Lies", 0, ilRetour )

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
Close ( This )
end on

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_Lies::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1769
This.Width		= 3598
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_Lies::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:49:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* La variable ilRetour sert $$HEX2$$e0002000$$ENDHEX$$savoir si on appuie sur le bouton    */
/* PRENDRE ou le bouton RETOUR. Par d$$HEX1$$e900$$ENDHEX$$faut on arme la valeur $$HEX2$$e0002000$$ENDHEX$$0,   */
/* ce qui correspond au bouton RETOUR.                              */
/*------------------------------------------------------------------*/
ilRetour = 0

This.PostEvent ( "Ue_Initialiser" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_sp_sinistres_lies.create
int iCurrent
call super::create
this.pb_valider=create pb_valider
this.pb_retour=create pb_retour
this.dw_1=create dw_1
this.dw_wtravail=create dw_wtravail
this.cb_prendre2=create cb_prendre2
this.cb_prendre1=create cb_prendre1
this.cb_retour=create cb_retour
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_valider
this.Control[iCurrent+2]=this.pb_retour
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_wtravail
this.Control[iCurrent+5]=this.cb_prendre2
this.Control[iCurrent+6]=this.cb_prendre1
this.Control[iCurrent+7]=this.cb_retour
end on

on w_t_sp_sinistres_lies.destroy
call super::destroy
destroy(this.pb_valider)
destroy(this.pb_retour)
destroy(this.dw_1)
destroy(this.dw_wtravail)
destroy(this.cb_prendre2)
destroy(this.cb_prendre1)
destroy(this.cb_retour)
end on

type cb_debug from w_ancetre`cb_debug within w_t_sp_sinistres_lies
end type

type pb_valider from u_8_pbvalider within w_t_sp_sinistres_lies
boolean visible = false
integer x = 3287
integer y = 212
integer width = 233
integer height = 136
integer taborder = 0
integer textsize = -7
string facename = "Arial"
boolean enabled = false
string text = "&Prendre"
boolean originalsize = false
end type

type pb_retour from u_8_pbretour within w_t_sp_sinistres_lies
boolean visible = false
integer x = 3287
integer y = 40
integer width = 233
integer height = 136
integer taborder = 0
boolean enabled = false
boolean originalsize = false
end type

type dw_1 from datawindow within w_t_sp_sinistres_lies
integer x = 37
integer y = 148
integer width = 2976
integer height = 1472
integer taborder = 10
string dataobject = "d_sp_wkf_sinistres_lies"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

type dw_wtravail from u_datawindow within w_t_sp_sinistres_lies
boolean visible = false
integer x = 3209
integer y = 396
integer width = 315
integer height = 220
integer taborder = 0
boolean enabled = false
string dataobject = "d_sp_w_queue"
boolean livescroll = false
end type

type cb_prendre2 from commandbutton within w_t_sp_sinistres_lies
boolean visible = false
integer x = 1737
integer y = 16
integer width = 1271
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Prendre avec les coordonn$$HEX1$$e900$$ENDHEX$$es des adh$$HEX1$$e900$$ENDHEX$$sions"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_lies::Cb_Prendre2::Clicked!
//* Evenement 		: Clicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La variable ilRetour sert $$HEX2$$e0002000$$ENDHEX$$savoir si on appuie sur le bouton    */
/* PRENDRE ou le bouton RETOUR. On vient d'appuyer sur le bouton    */
/* PRENDRE, on arme donc la valeur $$HEX2$$e0002000$$ENDHEX$$2.                             */
/*------------------------------------------------------------------*/
ilRetour = 2

Parent.TriggerEvent ( "Ue_Retour" )

end on

type cb_prendre1 from commandbutton within w_t_sp_sinistres_lies
integer x = 448
integer y = 16
integer width = 1271
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Prendre les coordon$$HEX1$$e900$$ENDHEX$$es du sinistre pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_lies::Cb_Prendre1::Clicked!
//* Evenement 		: Clicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La variable ilRetour sert $$HEX2$$e0002000$$ENDHEX$$savoir si on appuie sur le bouton    */
/* PRENDRE ou le bouton RETOUR. On vient d'appuyer sur le bouton    */
/* PRENDRE, on arme donc la valeur $$HEX2$$e0002000$$ENDHEX$$1.                             */
/*------------------------------------------------------------------*/
ilRetour = 1

Parent.TriggerEvent ( "Ue_Retour" )

end on

type cb_retour from commandbutton within w_t_sp_sinistres_lies
integer x = 37
integer y = 16
integer width = 398
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ne rien faire"
boolean cancel = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Sinistres_lies::Cb_Retour::Clicked!
//* Evenement 		: Clicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Retour" )

end on

