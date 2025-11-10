HA$PBExportHeader$w_ae_sp_interro.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre ancetre revue pour SIMPA2
forward
global type w_ae_sp_interro from w_interro
end type
end forward

global type w_ae_sp_interro from w_interro
end type
global w_ae_sp_interro w_ae_sp_interro

forward prototypes
private subroutine wf_posfenetre ()
end prototypes

private subroutine wf_posfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_PosFenetre (Protected)
//* Auteur			: Fabry JF
//* Date				: 09/04/2004 15:41:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Dimension de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long ldw_H, lX, lY

String sdw_H, sSection

sdw_H = dw_1.Describe ( "DataWindow.Detail.Height" )

ldw_H = Long ( sdw_H )

/*------------------------------------------------------------------*/
/* On retaille la Data Window, on positionne le bandeau et on       */
/* termine par le retaillage de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro.               */
/*------------------------------------------------------------------*/

dw_1.Resize ( 2500, 300 )

This.X = 1600
This.Y = 1000
This.Width = 2500
This.Height = 700

uo_1.Move ( (This.Width - uo_1.Width)/2, ldw_H + 50 )
end subroutine

on ue_envoi;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Interro::Ue_Envoi   ! OVERRIDE !
//* Evenement 		: Ue_Envoi
//* Auteur			: Erick John Stark
//* Date				: 20/02/1996 16:05:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sFicTrace, sRep, sMaintenant, sNomMachine, sLigne
String sTab
s_Pass stPass

U_DeclarationWindows	nvWin

sTab = "~t"

Choose Case uo_1.ilBouton
Case 1		
/*------------------------------------------------------------------*/
/* On vient d'appuyer sur le bouton Valider, on va construire la    */
/* cha$$HEX1$$ee00$$ENDHEX$$ne correspondant aux valeurs renseign$$HEX1$$e900$$ENDHEX$$es.                    */
/*------------------------------------------------------------------*/

	If	dw_1.AcceptText () > 0 Then

		If IsNull ( dw_1.GetItemNumber ( 1, "ID_DEPT" ) ) And &
			IsNull ( dw_1.GetItemString ( 1, "MAJ_PAR" ) ) And &
			IsNull ( dw_1.GetItemNumber ( 1, "ID_SIN" ) ) Then
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "EDIT055"

			F_Message ( stMessage )
			Return
		End If

		Wf_ConstruireChaine ()

/*------------------------------------------------------------------*/
/* On assigne les valeurs de la clause $$HEX2$$e0002000$$ENDHEX$$la structure               */
/*------------------------------------------------------------------*/

		iwParent.TriggerEvent ( "UE_FERMER_INTERRO" )

		stPass.sTab[1] = isClause
		stPass.sTab[2] = isClauseFrancais

		sRep			= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_I", "" )

/*------------------------------------------------------------------*/
/* Si la section n'existe pas, on n'$$HEX1$$e900$$ENDHEX$$crit rien dans la trace.       */
/*------------------------------------------------------------------*/

		If	sRep <> "" Then

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/

			sFicTrace	= sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
			nvWin				= stGLB.uoWin
			sNomMachine 	= nvWin.uf_GetEnvironment ( "SQL" )

			sMaintenant = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )

			sLigne = sMaintenant 			+ sTab + &
						stGLB.sCodAppli		+ sTab + &
						sNomMachine 			+ sTab + &
						stGLB.sCodOper			+ sTab + &
						istInterro.sCodeDw	+ sTab + &
						isClause

			f_EcrireFichierText ( sFicTrace, sLigne )
		End If

/*------------------------------------------------------------------*/
/* Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre et envoi de la cha$$HEX1$$ee00$$ENDHEX$$ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e            */
/*------------------------------------------------------------------*/
		CloseWithReturn ( This, stPass )

	End If

Case 2		

/*------------------------------------------------------------------*/
/* On assigne les valeurs de la clause $$HEX2$$e0002000$$ENDHEX$$la structure               */
/*------------------------------------------------------------------*/

	stPass.sTab[1] = ""
	stPass.sTab[2] = ""

	CloseWithReturn ( This, stPass )


Case 3
/*------------------------------------------------------------------*/
/* On vient d'appuyer sur le bouton Effacer.                        */
/*------------------------------------------------------------------*/

	dw_1.Reset ()
	dw_1.InsertRow ( 0 )
	dw_1.SetFocus ()

End Choose

end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet         : w_ae_sp_interro
//* Evenement     : Open
//* Auteur        : Fabry JF
//* Date          : 08/04/2004 17:45:53
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
//*       JFF   28/04/2021   [OPTIM_MENU_EDT]
//*-----------------------------------------------------------------

DataWindowChild  dwChild

This.Title = "Recherche des courriers $$HEX3$$e0002000e900$$ENDHEX$$diter"

dw_1.GetChild ( "ID_DEPT", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ()

// [OPTIM_MENU_EDT]
dwChild.InsertRow ( 1 )
dwChild.SetItem ( 1, "ID_DEPT", -1 )
dwChild.SetItem ( 1, "LIB_DEPT", "CHARGER TOUS LES DEPARTEMENTS !" )
dwChild.SetFilter ( "ID_DEPT NOT IN ( 280, 260, 9999)" ) 

dwChild.Filter ()

dw_1.GetChild ( "ID_PROD", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ()

dwChild.SetFilter ( "ID_DEPTS = -1" ) 
dwChild.Filter ()





end event

on w_ae_sp_interro.create
int iCurrent
call super::create
end on

on w_ae_sp_interro.destroy
call super::destroy
end on

type cb_debug from w_interro`cb_debug within w_ae_sp_interro
end type

type uo_1 from w_interro`uo_1 within w_ae_sp_interro
end type

type dw_1 from w_interro`dw_1 within w_ae_sp_interro
end type

on dw_1::itemchanged;call w_interro`dw_1::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_1
//* Evenement     : ItemChanged
//* Auteur        : Fabry JF
//* Date          : 19/05/2004 11:01:30
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

DataWindowChild dwChild
Int iNull

SetNull ( iNull )

Choose Case Upper ( This.GetcolumnName () )

	Case "ID_DEPT"
	
		dw_1.GetChild ( "ID_PROD", dwChild )

		dwChild.SetFilter ( "ID_DEPTS = " + This.GetText () ) 
		dwChild.Filter ()

		dw_1.SetItem ( 1, "ID_PROD", iNull )

End Choose

end on

