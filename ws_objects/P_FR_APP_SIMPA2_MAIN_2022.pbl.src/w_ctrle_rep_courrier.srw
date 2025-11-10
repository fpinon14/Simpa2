$PBExportHeader$w_ctrle_rep_courrier.srw
forward
global type w_ctrle_rep_courrier from window
end type
type jauge_ctrle_courrier from hprogressbar within w_ctrle_rep_courrier
end type
type st_pctage from statictext within w_ctrle_rep_courrier
end type
type st_pause_ctrle_courrier from statictext within w_ctrle_rep_courrier
end type
end forward

global type w_ctrle_rep_courrier from window
integer width = 3058
integer height = 1232
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
event ue_ctrle_rep_courrier ( )
jauge_ctrle_courrier jauge_ctrle_courrier
st_pctage st_pctage
st_pause_ctrle_courrier st_pause_ctrle_courrier
end type
global w_ctrle_rep_courrier w_ctrle_rep_courrier

type variables

s_Pass istPassData1
end variables

forward prototypes
public subroutine uf_controle_rep_courrier ()
end prototypes

event ue_ctrle_rep_courrier();//*-----------------------------------------------------------------
//*
//* Objet 			: w_ctrle_rep_courrier
//* Evenement 		: ue_Ctrle_Rep_Courrier
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------
This.uf_controle_rep_courrier ()

this.postEvent ( "close" ) 
end event

public subroutine uf_controle_rep_courrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_controle_rep_courrier	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 26/12/2002
//* Libellé			: 
//* Commentaires	: Vérif du répertoire courrier
//*
//* Arguments		: 
//*
//* Retourne		: 
//* 					  
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

DataStore dsFicPara
String sRepSourceSav, sRepDestProduction, sNomFicSourceSav, sNomFicDestProduction, sFrequenceMin, sRepFicTrace
String sObjet, sMailBodyOrig, sSaut, sSql, sRacineUNCDest
Long lCpt, lTot, lRet, lCountRedresse
U_DeclarationWindows32	invWin
Boolean bAMUERR 

This.Width = 2535
This.Height= 735
This.X = istPassData1.lTab[3] + (istPassData1.lTab[1] - This.Width) / 2
This.Y = istPassData1.lTab[4] + (istPassData1.lTab[2]  - This.Height) / 2

st_pause_ctrle_courrier.X			=  0
st_pause_ctrle_courrier.Y			=  00
st_pause_ctrle_courrier.Height	=  700	
st_pause_ctrle_courrier.Width		= 2500	
st_pause_ctrle_courrier.text = " ~n~rVeuillez patienter pendant l'initialisation des courriers... ~n~r~n~r" + "Ne fermez pas votre session, n’éteignez pas votre ordinateur, laissez le traitement se terminer, merci.~n~r"
st_pause_ctrle_courrier.Show ()
st_pause_ctrle_courrier.BringToTop	= TRUE

Jauge_Ctrle_courrier.Y			=  500
Jauge_Ctrle_courrier.Height	=  100
Jauge_Ctrle_courrier.Width		= 2200
Jauge_Ctrle_courrier.X			=  ( st_pause_ctrle_courrier.Width - Jauge_Ctrle_courrier.Width ) / 2
Jauge_Ctrle_courrier.MinPosition = 0
Jauge_Ctrle_courrier.Position = 0
Jauge_Ctrle_courrier.SetStep = 1
Jauge_Ctrle_courrier.Hide ()

st_pctage.Text		= "0%"
st_pctage.Y			=  Jauge_Ctrle_courrier.Y + 5
st_pctage.Height	=  Jauge_Ctrle_courrier.Height - 10
st_pctage.Width	= 210
st_pctage.X			= Jauge_Ctrle_courrier.X + Jauge_Ctrle_courrier.Width / 2 - st_pctage.Width / 2 
st_pctage.textcolor = RGB(0, 0, 0)
st_pctage.Hide ()

Yield ()


sRepSourceSav = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_REP_SOURCE_SAV","")
sRepDestProduction = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_REP_DEST_PROD","")

sFrequenceMin = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_FREQUENCE_EN_MINUTE","5")
sRacineUNCDest = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_RACINE_UNC","")
sRacineUNCDest = sRacineUNCDest + Right ( sRepDestProduction, len ( sRepDestProduction ) - 3 ) 

/*
lRet = SQLCA.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01 ( "CTRLE_REP_COURRIER", Long ( sFrequenceMin ), sRacineUNCDest )
F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0)

If lRet <= 0 Then Return
*/

This.Enabled = False

bAMUERR = FALSE
lCountRedresse = 0
// sSaut = char (10 ) + char (10 )
sSaut = char (13 )
sRepFicTrace = ProfileString(stglb.sfichierini,"TRACE","REP_TRACE_RPC","")

invWin = Create U_DeclarationWindows32

dsFicPara = Create DataStore
dsFicPara.dataobject="d_stk_nom_fic_para"
dsFicPara.setTransobject( SQLCA)
dsFicPara.Retrieve (sRacineUNCDest)

lTot = dsFicPara.RowCount ()
Jauge_Ctrle_courrier.MaxPosition = lTot

Jauge_Ctrle_courrier.SHow ()
Jauge_Ctrle_courrier.BringToTop = TRUE
st_pctage.Show ()
st_pctage.BringToTop = TRUE
Yield()
	
For lCpt = 1 To lTot

	If lCpt >= lTot / 2 Then st_pctage.textcolor = RGB(255, 255, 255)

	Jauge_Ctrle_courrier.Position = lCpt
	st_pctage.Text = String ( Round ( (lCpt / lTot) * 100, 0 ) ) + "%"
	Yield()
	
	sNomFicDestProduction = sRepDestProduction + dsFicPara.GetItemString ( lCpt, "NOM_FIC" ) 	

	If FileExists ( sNomFicDestProduction ) Then Continue
	
	lCountRedresse ++
	
	sNomFicSourceSav = sRepSourceSav + dsFicPara.GetItemString ( lCpt, "NOM_FIC" ) 

	lRet = Filecopy ( sNomFicSourceSav, sNomFicDestProduction, False) // Recopie sans écrasement (False)
	invWin.uf_SetFileAttributes(sNomFicDestProduction, 33) // Lecture Seule (1) + Archive (32 ou 20x)
	
 	dsFicPara.SetItem ( lCpt, "ERR_COUR", "Fichier absent en production, redressé, résulat recopie : " + String ( lRet) )
	
	bAMUERR = TRUE
	
Next 

If bAMUERR Then
	sRepFicTrace += "TRACE_ERR_REP_COURRIER_" + String ( Today(), "yyyymmdd" ) + String ( Time (Today()), "hhmmss" ) + ".XLS"
	dsFicPara.SaveAs ( sRepFicTrace, EXCEL8!, TRUE)  // [MIG_PB2022]

	sObjet = "Redressement répertoire courrier"
	
	
	sMailBodyOrig  = "RepSourceSav : " + sRepSourceSav + sSaut 
	sMailBodyOrig += "RepDestProduction : " + sRepDestProduction + sSaut 
	sMailBodyOrig += "Nbre de paragraphes redressés : " + String ( lCountRedresse ) + sSaut 
	sMailBodyOrig += "Fichier Trace Détail : " + sRepFicTrace + sSaut 
	sMailBodyOrig += "Base : " + SQLCA.DataBase + sSaut 
	sMailBodyOrig += "Trigramme : " + stGlb.sCodOper + sSaut 
	sMailBodyOrig += "Date : " + String ( Today (), "dd/mm/yyyy" ) + " " + String ( Time ( Today()), "hh:mm:ss" ) + sSaut 
	
	sSql = "Exec sysadm.PS_S01_MAIL '" + "jff@spb.fr" + "', "  +&
			  "'" + sMailBodyOrig + "'"		 + ", " + &
			  "'" + sObjet + "'"		 + ", " + &
			  "'REP COURRIER'"		    + ", " + &
			  "''"			 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"
	
	F_execute ( sSql, SQLCA )
	F_Commit ( SQLCA, true )	
End If 

Destroy dsFicPara
Destroy invWin

Return


end subroutine

on w_ctrle_rep_courrier.create
this.jauge_ctrle_courrier=create jauge_ctrle_courrier
this.st_pctage=create st_pctage
this.st_pause_ctrle_courrier=create st_pause_ctrle_courrier
this.Control[]={this.jauge_ctrle_courrier,&
this.st_pctage,&
this.st_pause_ctrle_courrier}
end on

on w_ctrle_rep_courrier.destroy
destroy(this.jauge_ctrle_courrier)
destroy(this.st_pctage)
destroy(this.st_pause_ctrle_courrier)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ctrle_rep_courrier
//* Evenement 		: Open
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

istPassData1 = Message.PowerObjectParm





end event

event show;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ctrle_rep_courrier
//* Evenement 		: Show
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


PostEvent ( "ue_Ctrle_Rep_Courrier" ) 

end event

event close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ctrle_rep_courrier
//* Evenement 		: Close
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


CloseWithReturn ( This, istPassData1 )

end event

type jauge_ctrle_courrier from hprogressbar within w_ctrle_rep_courrier
boolean visible = false
integer x = 210
integer y = 484
integer width = 622
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

type st_pctage from statictext within w_ctrle_rep_courrier
boolean visible = false
integer x = 667
integer y = 208
integer width = 571
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 553648127
string text = "none"
alignment alignment = center!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pause_ctrle_courrier from statictext within w_ctrle_rep_courrier
boolean visible = false
integer x = 251
integer y = 160
integer width = 338
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

