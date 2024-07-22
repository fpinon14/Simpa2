HA$PBExportHeader$w_sp_trt_stat3.srw
$PBExportComments$Extraction pour le contr$$HEX1$$f400$$ENDHEX$$le des Devis DCMP020281
forward
global type w_sp_trt_stat3 from w_8_accueil
end type
type dw_charger from datawindow within w_sp_trt_stat3
end type
type cb_charger from commandbutton within w_sp_trt_stat3
end type
type cb_annuler from commandbutton within w_sp_trt_stat3
end type
type cb_lancer from commandbutton within w_sp_trt_stat3
end type
type st_charger from statictext within w_sp_trt_stat3
end type
type st_extraire from statictext within w_sp_trt_stat3
end type
type cb_controler from commandbutton within w_sp_trt_stat3
end type
type dw_extraire from datawindow within w_sp_trt_stat3
end type
type uo_defil from u_barredefil within w_sp_trt_stat3
end type
type dw_stocker from datawindow within w_sp_trt_stat3
end type
type dw_fourn from datawindow within w_sp_trt_stat3
end type
type cb_maj from commandbutton within w_sp_trt_stat3
end type
end forward

global type w_sp_trt_stat3 from w_8_accueil
integer width = 3538
integer height = 1952
dw_charger dw_charger
cb_charger cb_charger
cb_annuler cb_annuler
cb_lancer cb_lancer
st_charger st_charger
st_extraire st_extraire
cb_controler cb_controler
dw_extraire dw_extraire
uo_defil uo_defil
dw_stocker dw_stocker
dw_fourn dw_fourn
cb_maj cb_maj
end type
global w_sp_trt_stat3 w_sp_trt_stat3

type variables
Private :

String	isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = "DEVIS.XLS"
String	K_FICCHARG = "DEVIS.TXT"
end variables

forward prototypes
private function boolean wf_chargerdonnees ()
private function boolean wf_controler ()
private function boolean wf_lancer ()
public subroutine wf_choixfourn (string asidfourn)
private function boolean wf_maj ()
end prototypes

private function boolean wf_chargerdonnees ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_stat3::wf_ChargerDonnees (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/09/2002 17:01:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

Boolean bOk
Long	lTotRow

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

bOk = True

/*------------------------------------------------------------------*/
/* Chemin ou Fichier Excel introuvable.                             */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If Not FileExists ( isRepWin + K_TEMP + K_FICCHARG ) Then
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
If Not f_FileExists ( stGlb.sRepTempo + K_FICCHARG ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	stMessage.sCode = "COMD036"
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	stMessage.sVar [1] = stGlb.sRepTempo + K_FICCHARG
	bOk = False
End If

/*------------------------------------------------------------------*/
/* Suppression du fichier destination existant.                     */
/*------------------------------------------------------------------*/
If bOk then

//Migration PB8-WYNIWYG-03/2006 CP	
//	If FileExists ( isRepWin + K_TEMP + K_FICSTAT ) Then
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	If f_FileExists ( stGlb.sRepTempo + K_FICSTAT ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		If Not FileDelete ( stGlb.sRepTempo + K_FICSTAT ) Then
			stMessage.sCode		= "COMD027"
			//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
			stMessage.sVar[1]		= Upper ( stGlb.sRepTempo + K_FICSTAT )
			bOk = False
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* Chargement des donn$$HEX1$$e900$$ENDHEX$$es.                                          */
/*------------------------------------------------------------------*/
If bOk Then
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	lTotRow = dw_Charger.ImportFile ( stGlb.sRepTempo + K_FICCHARG )

	If lTotRow < 0 Then
		stMessage.sCode = "COMD036"	
		stMessage.sVar [1] = String ( lTotRow )
		bOk = False
	End If
	
End If

/*------------------------------------------------------------------*/
/* MAJ du static text                                               */
/*------------------------------------------------------------------*/
If bOk Then
	st_Charger.Text = String ( lTotRow ) + " r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes charg$$HEX1$$e900$$ENDHEX$$es"
End If


If Not bOk Then F_Message ( stMessage )

Return bOk


end function

private function boolean wf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_stat3::wf_Controler (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 23/09/2002 17:01:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des donn$$HEX1$$e900$$ENDHEX$$es
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
//* #1	 CAG	 04/11/02 	  Modification SFR # Ajout du ctrl facturation CEGETEL
//* #2	 CAG	 04/11/02 	  Modification SFR # La zone ID_CMDE de dw_Charger
//*															est maintenant de 20 car. d'o$$HEX1$$f900$$ENDHEX$$
//*															ctrl suppl$$HEX1$$e900$$ENDHEX$$mentaire de la longueur
//*															pour CETELEC
//* #3	 CAG	 18/08/03	  Modification n$$HEX2$$b0002000$$ENDHEX$$de commandes CEGETEL : pour Must les n$$HEX1$$b000$$ENDHEX$$
//*										de commandes peuvent maintenant $$HEX1$$ea00$$ENDHEX$$tre au format Mobile Protect
//*-----------------------------------------------------------------

Long		lTotRow, lCpt, lPos
Boolean	bOk
String	sIdCmde, sIdFourn

bOk = True

lTotRow = dw_Charger.RowCount ()

sIdFourn = dw_Fourn.GetItemString ( 1, "ID_FOURN" )

Choose Case sIdFourn

	/*------------------------------------------------------------------*/
	/* Fournisseur : CEGETEL                                            */
	/*------------------------------------------------------------------*/
	Case "CEG"
		For lCpt = 1 To lTotRow
			sIdCmde = Upper ( Trim ( dw_Charger.GetItemString ( lCpt, "ID_CMDE" ) ) )

			If IsNull ( sIdCmde ) Then Continue

			// si le n$$HEX2$$b0002000$$ENDHEX$$de commande ne commence pas par 920, il doit commencer par 2 chiffres
			If Left ( sIdCmde, 3 ) <> "920" Then
				// s'il commence par 2 chiffres, on doit avoir une s$$HEX1$$e900$$ENDHEX$$quence alphanum de 6
				If Not Match ( Mid ( sIdCmde, 1, 8 ), "^[0-9a-zA-Z]+$" ) Then
					bOk = False
					st_Extraire.Text  = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sIdCmde + " : '" + Mid ( sIdCmde, 1, 8 ) + "' n'est pas un alphanum$$HEX1$$e900$$ENDHEX$$rique de 8 caract$$HEX1$$e800$$ENDHEX$$res"
				End If
				If bOk Then
					/*------------------------------------------------------------------*/
					/* #3 : CAG 18/08/03, 2 chiffres + 8 alphanum + "PR00/" ou "FR00/"  */
					/*------------------------------------------------------------------*/
					If Mid ( sIdCmde, 9, 5 ) <> "PR00/" And Mid ( sIdCmde, 9, 5 ) <> "FR00/" Then
						bOk = False
						st_Extraire.Text  = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sIdCmde + " : '" + Mid ( sIdCmde, 9, 5 ) + "' doit $$HEX1$$ea00$$ENDHEX$$tre PR00/ ou FR00/"
					End If
				End If
				If bOk Then
					If Not IsNumber ( Right ( sIdCmde, Len ( sIdCmde ) - 13 ) ) Or Len ( sIdCmde ) <> 20 Then
						bOk = False
						st_Extraire.Text  = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sIdCmde + " : '" + Right ( sIdCmde, Len ( sIdCmde ) - 13 ) + "' n'est pas un num$$HEX1$$e900$$ENDHEX$$rique de 7 chiffres"
					End If
				End If
			Else
				// le n$$HEX2$$b0002000$$ENDHEX$$de commande commence par 920
				If bOk Then
					If Not IsNumber ( Right ( sIdCmde, Len ( sIdCmde ) - 3 ) ) Or Len ( sIdCmde ) <> 10 Then
						bOk = False
						st_Extraire.Text  = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sIdCmde + " : '" + Right ( sIdCmde, Len ( sIdCmde ) - 3 ) + "' n'est pas un num$$HEX1$$e900$$ENDHEX$$rique de 7 chiffres"
					End If
				End If
			End If

			If Not bOk Then
				dw_Charger.ScrollToRow ( lCpt )
				dw_Charger.SelectRow ( lCpt, True )
				Exit
			End If
		Next

End Choose

If bOk Then
	st_Extraire.Text  = "Contr$$HEX1$$f400$$ENDHEX$$le Ok !"
End If

Return bOk
end function

private function boolean wf_lancer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_stat3::wf_Lancer (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 23/09/2002 17:01:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement du traitement.
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
//* #1	 CAG	 05/11/2002	  Modification SFR # : Ajout d'un param$$HEX1$$e800$$ENDHEX$$tre
//*								  pour le retrieve + id_sin et id_seq $$HEX2$$e0002000$$ENDHEX$$0 
//*								  pour CEGETEL
//*-----------------------------------------------------------------

Boolean	bOk
Long		lTotRow, lCpt, lIdSin, lIdSeq, lPos, lRow
String	sIdCmde, sIdCmdFrn, sIdFourn

bOk = True

Dw_Stocker.Reset ()
lTotRow = dw_Charger.RowCount ()
uo_Defil.uf_Init ( lTotRow )

For lCpt = 1 To lTotRow
	
	sIdCmde = Upper ( Trim ( dw_Charger.GetItemString ( lCpt, "ID_CMDE" ) ) )
	st_Extraire.Text  = sIdCmde + " en cours de traitement..."

	sIdFourn = dw_Fourn.GetItemString ( 1, "ID_FOURN" )

	Choose Case sIdFourn

		/*------------------------------------------------------------------*/
		/* Fournisseur : CEGETEL                                            */
		/*------------------------------------------------------------------*/
		Case "CEG"
			If IsNull ( sIdCmde ) Then
				lRow = Dw_Stocker.InsertRow (0)
				Dw_Stocker.SetItem ( lRow, "NUM_COMMANDE_SPB", "Aucune r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence charg$$HEX1$$e900$$ENDHEX$$e !" )
				// CAG 17/03/03 : si la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence n'est pas trouv$$HEX1$$e900$$ENDHEX$$e, la jauge ne va pas $$HEX2$$e0002000$$ENDHEX$$100%
				uo_Defil.uf_Progression ( lCpt )
				Continue
			End If

			lIdSin = 0
			lIdSeq = 0
			sIdCmdFrn = sIdCmde
	End Choose

	If IsNull ( sIdCmde ) Then
		lRow = Dw_Stocker.InsertRow (0)
		Dw_Stocker.SetItem ( lRow, "NUM_COMMANDE_SPB", "Aucune r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence charg$$HEX1$$e900$$ENDHEX$$e !" )
		// CAG 17/03/03 : si la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence n'est pas trouv$$HEX1$$e900$$ENDHEX$$e, la jauge ne va pas $$HEX2$$e0002000$$ENDHEX$$100%
		uo_Defil.uf_Progression ( lCpt )
		Continue
	End If

	Dw_Extraire.Retrieve ( lIdSin, lIdSeq, sIdCmdFrn )
	If Dw_Extraire.RowCount () <= 0 Then
		lRow = Dw_Stocker.InsertRow (0)
		Dw_Stocker.SetItem ( lRow, "NUM_COMMANDE_SPB", sIdCmde + " : R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence non trouv$$HEX1$$e900$$ENDHEX$$e !" )
	Else
		Dw_Extraire.RowsCopy ( 1, Dw_Extraire.RowCount (), Primary!, Dw_Stocker, Dw_Stocker.RowCount () + 1, Primary! )
	End If

	uo_Defil.uf_Progression ( lCpt )


Next
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//If Dw_Stocker.SaveAs ( isRepWin + K_TEMP + K_FICSTAT, Excel!, True ) > 0 Then
//	st_Extraire.Text  = "Extraction sauvegard$$HEX1$$e900$$ENDHEX$$e sur " + isRepWin + K_TEMP + K_FICSTAT
//	RUN ( isRepExcel + " " + isRepWin + K_TEMP + K_FICSTAT )
//Else
//	st_Extraire.Text  = "Impossible d'$$HEX1$$e900$$ENDHEX$$crire le fichier" + isRepWin + K_TEMP + K_FICSTAT
//End If
If Dw_Stocker.SaveAs ( stGlb.sRepTempo + K_FICSTAT, Excel!, True ) > 0 Then
	st_Extraire.Text  = "Extraction sauvegard$$HEX1$$e900$$ENDHEX$$e sur " + stGlb.sRepTempo + K_FICSTAT
	RUN ( isRepExcel + " " + stGlb.sRepTempo + K_FICSTAT )
Else
	st_Extraire.Text  = "Impossible d'$$HEX1$$e900$$ENDHEX$$crire le fichier" + stGlb.sRepTempo + K_FICSTAT
End If

Return bOk

end function

public subroutine wf_choixfourn (string asidfourn);//*-----------------------------------------------------------------
//*
//* Fonction      : W_Sp_Trt_Stat3::wf_ChoixFourn
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 04/11/2002 14:07:59
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Modification SFR #
//* Commentaires  : Modification de l'affichage sur choix du fournisseur
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

Choose Case asIdFourn

	/*------------------------------------------------------------------*/
	/* Fournisseur : CEGETEL                                            */
	/*------------------------------------------------------------------*/
	Case "CEG"
		cb_Charger.Text = "Charger les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences des commandes SFR"
End Choose

cb_Charger.Enabled = True
end subroutine

private function boolean wf_maj ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_stat3::wf_Maj (PRIVATE)
//* Auteur        : Catherine Abdmeziem
//* Date          : 30/01/2003
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Maj du code $$HEX1$$e900$$ENDHEX$$tat des commandes $$HEX2$$e0002000$$ENDHEX$$RPC
//* Commentaires  : Annexe 22
//*					  
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 02/06/2003   Correction de la maj de la table w_commande
//*									(condition se faisait sur id_cmd_frn qui est vide dans la table)
//*-----------------------------------------------------------------

Long		lCpt, lTot
String	sIdCmde, sSql, sSqlOrig, sSqlOrigW
Boolean	bRet

bRet = False
lTot = dw_Charger.RowCount()

stMessage.sTitre		= "Attention aux commandes !!"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YesNo!
stMessage.sCode		= "SFRP090"
stMessage.sVar[1]		= String ( lTot )

If F_Message ( stMessage ) = 1 Then

	bRet = True

	/*------------------------------------------------------------------*/
	/* #1 : CAG 02/06/2003                                              */
	/*------------------------------------------------------------------*/
	sSqlOrigW = "UPDATE wc " + &
			 		"SET    wc.cod_etat = 'RPC' " + &
					"FROM	  sysadm.commande c, sysadm.w_commande wc "+ &
					"WHERE  c.id_sin = wc.id_sin " + &
					"  AND  c.id_seq = wc.id_seq " + &
					"  AND  c.id_cmd_frn = '"

	sSqlOrig = "UPDATE sysadm.commande " + &
				  "SET    sysadm.commande.cod_etat = 'RPC' " + &
			 	  "WHERE  sysadm.commande.id_cmd_frn = '"

	For lCpt = 1 To lTot
		sIdCmde = Upper ( Trim ( dw_Charger.GetItemString ( lCpt, "ID_CMDE" ) ) )
		If Not ( IsNull ( sIdCmde ) ) And Trim ( sIdCmde ) <> "" Then
			sSql = sSqlOrig + sIdCmde + "'"
			F_Execute ( sSql, SQLCA )
			If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 Then
				bRet = False
				Exit
			End If
			sSql = sSqlOrigw + sIdCmde + "'"
			F_Execute ( sSql, SQLCA )
			If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 Then
				bRet = False
				Exit
			End If
		End If
	Next

	/*------------------------------------------------------------------*/
	/* #1 : CAG 02/06/2003                                              */
	/*------------------------------------------------------------------*/
	If Not bRet Then
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "SFRP100"
		stMessage.sVar[1] 	= String ( SQLCA.SqlDbCode )
		stMessage.sVar[2] 	= SQLCA.SqlErrText
		F_Commit ( SQLCA, False )
	Else
		stMessage.Icon		= Information!
		stMessage.sCode	= "SFRP095"
		stMessage.sVar[1]	= String ( lTot )
		F_Commit ( SQLCA, True )
	End If

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour du code $$HEX1$$e900$$ENDHEX$$tat en RPC"
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )

End If

Return bRet
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Extr1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 03/09/2002 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	CAG	04/11/02 Modification SFR # Ajout du ctrl facturation CEGETEL
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

This.Title = "Extraction pour le contr$$HEX1$$f400$$ENDHEX$$le des devis ou factures de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie"

//wf_PositionnerObjets ()


dw_Extraire.SetTransObject ( SQLCA )

/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//isRepWin	= uoDeclarationFuncky.Uf_WinDir () 
//Destroy uoDeclarationFuncky

/*----------------------------------------------------------------------------*/
/* Armement du nom du Rep Excel en local.													*/
/*----------------------------------------------------------------------------*/
//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel=F_GetExcelPath() //[PI037]

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
dw_Fourn.Reset ()
dw_Fourn.InsertRow ( 0 )

dw_Fourn.GetChild ( "ID_FOURN", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-FR" )

end event

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3
//* Evenement     : Show
//* Auteur        : Fabry JF
//* Date          : 20/09/2002 17:10:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 04/11/2002	  Modification SFR # Ajout du ctrl facturation CEGETEL
//* #2	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//*-----------------------------------------------------------------

String	sIdFourn, sModif

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
sModif = "ID_FOURN.protect = 0 ID_FOURN.background.color = 16777215 ID_FOURN.border = 5"
dw_Fourn.Modify ( sModif )

sIdFourn = dw_Fourn.GetItemString ( 1, "ID_FOURN" )
If IsNull ( sIdFourn ) Then sIdFourn = ""

cb_Charger.Enabled = sIdFourn <> ""


cb_Annuler.Enabled = False
cb_Controler.Enabled = False
cb_Lancer.Enabled = False
/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
cb_Maj.Enabled = False
uo_Defil.uf_Init ( 0 )

st_charger.Text = ""
st_Extraire.Text = ""

Dw_Charger.Reset ()
Dw_Extraire.Reset ()
Dw_Stocker.Reset ()

end on

on w_sp_trt_stat3.create
int iCurrent
call super::create
this.dw_charger=create dw_charger
this.cb_charger=create cb_charger
this.cb_annuler=create cb_annuler
this.cb_lancer=create cb_lancer
this.st_charger=create st_charger
this.st_extraire=create st_extraire
this.cb_controler=create cb_controler
this.dw_extraire=create dw_extraire
this.uo_defil=create uo_defil
this.dw_stocker=create dw_stocker
this.dw_fourn=create dw_fourn
this.cb_maj=create cb_maj
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_charger
this.Control[iCurrent+2]=this.cb_charger
this.Control[iCurrent+3]=this.cb_annuler
this.Control[iCurrent+4]=this.cb_lancer
this.Control[iCurrent+5]=this.st_charger
this.Control[iCurrent+6]=this.st_extraire
this.Control[iCurrent+7]=this.cb_controler
this.Control[iCurrent+8]=this.dw_extraire
this.Control[iCurrent+9]=this.uo_defil
this.Control[iCurrent+10]=this.dw_stocker
this.Control[iCurrent+11]=this.dw_fourn
this.Control[iCurrent+12]=this.cb_maj
end on

on w_sp_trt_stat3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_charger)
destroy(this.cb_charger)
destroy(this.cb_annuler)
destroy(this.cb_lancer)
destroy(this.st_charger)
destroy(this.st_extraire)
destroy(this.cb_controler)
destroy(this.dw_extraire)
destroy(this.uo_defil)
destroy(this.dw_stocker)
destroy(this.dw_fourn)
destroy(this.cb_maj)
end on

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_stat3
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_stat3
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_stat3
boolean visible = false
integer taborder = 150
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_stat3
boolean visible = false
integer taborder = 140
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_stat3
integer x = 1243
integer y = 20
integer width = 302
integer height = 244
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_stat3
boolean visible = false
integer taborder = 160
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_stat3
integer taborder = 20
end type

type dw_charger from datawindow within w_sp_trt_stat3
integer x = 2048
integer y = 424
integer width = 928
integer height = 784
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_trt_stat31"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_charger from commandbutton within w_sp_trt_stat3
integer x = 512
integer y = 424
integer width = 1513
integer height = 172
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Charger les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3::cb_Charger
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/09/2002 17:10:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 06/11/2002	  Modification SFR # Ajout du ctrl facturation CEGETEL
//* #2	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//*-----------------------------------------------------------------

String	sModif

If Parent.wf_ChargerDonnees () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = True
	cb_Lancer.Enabled = False

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	cb_Maj.Enabled = False

	uo_Defil.uf_Init ( 0 )
	
	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	sModif = "ID_FOURN.protect = 1 ID_FOURN.background.color = 12632256 ID_FOURN.border = 6"
	dw_Fourn.Modify ( sModif )

End If

end on

type cb_annuler from commandbutton within w_sp_trt_stat3
integer x = 512
integer y = 596
integer width = 1513
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler le chargement"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_extr1::cb_Annuler
//* Evenement     : cb_Annuler
//* Auteur        : Fabry JF
//* Date          : 03/09/2002 16:05:18
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

Parent.TriggerEvent ("show")

end on

type cb_lancer from commandbutton within w_sp_trt_stat3
integer x = 512
integer y = 1036
integer width = 1513
integer height = 172
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Extraire sous Excel les donn$$HEX1$$e900$$ENDHEX$$es li$$HEX1$$e900$$ENDHEX$$es aux commandes"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3::cb_Lancer
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 23/09/2002 17:10:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement du traitement
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

cb_Lancer.Enabled = False

If Parent.wf_Lancer () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = False

End If

end on

type st_charger from statictext within w_sp_trt_stat3
integer x = 521
integer y = 1376
integer width = 2464
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_extraire from statictext within w_sp_trt_stat3
integer x = 521
integer y = 1472
integer width = 2464
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_controler from commandbutton within w_sp_trt_stat3
integer x = 512
integer y = 692
integer width = 1513
integer height = 172
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contr$$HEX1$$f400$$ENDHEX$$ler les donn$$HEX1$$e900$$ENDHEX$$es charg$$HEX1$$e900$$ENDHEX$$es"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3::cb_Controler
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/09/2002 17:10:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Controle des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//*-----------------------------------------------------------------

If Parent.wf_Controler () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = False
	cb_Lancer.Enabled = True

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	If dw_Fourn.GetItemString ( 1, "ID_FOURN" ) = "CEG" Then
		cb_Maj.Enabled = True
	End If

	uo_Defil.uf_Init ( 0 )

End If

end on

type dw_extraire from datawindow within w_sp_trt_stat3
boolean visible = false
integer x = 1568
integer y = 20
integer width = 302
integer height = 244
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_stat3"
end type

type uo_defil from u_barredefil within w_sp_trt_stat3
integer x = 928
integer y = 1260
integer height = 76
integer taborder = 10
boolean livescroll = false
end type

type dw_stocker from datawindow within w_sp_trt_stat3
boolean visible = false
integer x = 1893
integer y = 20
integer width = 302
integer height = 244
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_stat3"
end type

type dw_fourn from datawindow within w_sp_trt_stat3
integer x = 695
integer y = 220
integer width = 2281
integer height = 104
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_choix_fournisseur_ctrl"
boolean border = false
boolean livescroll = true
end type

on itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3::dw_Fourn
//* Evenement     : ItemChanged
//* Auteur        : Abdmeziem Catherine
//* Date          : 04/11/2002
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Choix du fournisseur
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Parent.wf_ChoixFourn ( GetText () )

cb_Charger.Enabled = True

end on

type cb_maj from commandbutton within w_sp_trt_stat3
integer x = 512
integer y = 864
integer width = 1513
integer height = 172
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour du code $$HEX1$$e900$$ENDHEX$$tat en ~"RECU PAR CLIENT~""
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_stat3::cb_Maj
//* Evenement     : Clicked
//* Auteur        : Catherine Abdmeziem
//* Date          : 30/01/2003
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement de la mise $$HEX2$$e0002000$$ENDHEX$$jour du code $$HEX1$$e900$$ENDHEX$$tat des cmdes
//* Commentaires  : $$HEX2$$e0002000$$ENDHEX$$RPC
//*
//* Arguments     : 
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//*-----------------------------------------------------------------

cb_Maj.Enabled = False

If Parent.wf_Maj () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = False

Else

	cb_Lancer.Enabled = False

End If

end on

