HA$PBExportHeader$w_t_cpsql.srw
forward
global type w_t_cpsql from window
end type
type st_1 from statictext within w_t_cpsql
end type
end forward

global type w_t_cpsql from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
end type
global w_t_cpsql w_t_cpsql

forward prototypes
public function integer wf_lancer ()
public function integer wf_creerficcp (string asnomficcp, string asrepsource, string asrepdest)
end prototypes

public function integer wf_lancer ();

String sNomFicSource  // fichier contenant le nom des fichier CP
String sRepDest, sRepSource
String sNomFicCp
Int iFicCP, iFicRead
sNomFicSource = "C:\CP\ListeFic.txt"
sRepSource =  "c:\CP\"
sRepDest = "c:\CP_Dest\"

st_1.Text = "Traitement en cours"

iFicCP = FileOpen ( sNomFicSource, LineMode!, Read!, LockRead!, Append! )

If iFicCP <= 0 Then 
	st_1.Text = "Erreur -1"	
	Return -1
End If 

iFicRead = 1
Do While iFicRead >= 0
	iFicRead = FileRead ( iFicCP, sNomFicCp )
	
	This.wf_CreerFicCP ( sNomFicCp, sRepSource, sRepDest )
	
Loop


FileClose ( iFicCP )

st_1.Text = "Fin"	

Return 1
end function

public function integer wf_creerficcp (string asnomficcp, string asrepsource, string asrepdest);
/*

sNomFicSource = "C:\toto.txt"
sRepSource =  "c:\mon_rep_source\"
sRepDest = "c:\mon_rep_dest\"
*/


String sNomDestOrig, sNomDest
String sPrefixe, sExt
String sLigneTrt, sNomPS 
Int iFicCP, iFicRead
Int iFicCPDest, iFicWrite
Int iPos1, iPos2, iGo
long lLigne
Boolean bIF, bCreate

sPrefixe = F_Remplace ( asNomFicCp, ".CP", "" ) + "_"
sNomDestOrig = asRepDest + sPrefixe 
sExt = ".SQL"
bIF = FALSE
bCreate = FALSE
iGo = 0
lLigne = 0

iFicCP = FileOpen ( asRepSource + asNomFicCp, LineMode!, Read!, LockRead!, Append! )

If iFicCP <= 0 Then Return -1

iFicRead = 1
Do While iFicRead >= 0
	iFicRead = FileRead ( iFicCP, sLigneTrt )
	lLigne ++
	
	sLigneTrt = Trim ( sLigneTrt )
	
	If Upper ( Left ( sLigneTrt, 2 ))  = "IF" And Not bIF Then
		bIF = True

		iPos1 = Pos ( sLigneTrt, "'", 1 ) 		
		If iPos1 <= 0 Then iPos1 = Pos ( sLigneTrt, '"', 1 ) 		

		If iPos1 <= 0 Then 
			MessageBox ( "nom PS ind$$HEX1$$e900$$ENDHEX$$tectable dans", "Fichier " + asRepSource + asNomFicCp + Char (13) + " Ligne " + String ( lLigne ) + Char (13) + " conflit : " + sLigneTrt )
			HALT
		End If
		
		iPos2 = Pos ( sLigneTrt, "'", iPos1 + 1 ) 		
		If iPos2 <= 0 Then iPos2 = Pos ( sLigneTrt, '"', iPos1 + 1 ) 		

		If iPos2 <= 0 Then 
			MessageBox ( "nom PS ind$$HEX1$$e900$$ENDHEX$$tectable dans", "Fichier " + asRepSource + asNomFicCp + Char (13) + " Ligne " + String ( lLigne ) + Char (13) + " conflit : " + sLigneTrt )
			HALT
		End If
		
		sNomPS = Trim ( Upper ( Mid ( sLigneTrt, iPos1 + 1, iPos2 - iPos1 - 1 )) )
		sNomDest = sNomDestOrig + sNomPS + sExt

		iFicCPDest = FileOpen ( sNomDest , LineMode!, Write!, LockWrite!, Replace! )	
		
	End If

	If Upper ( Left ( sLigneTrt, 6 )) = "CREATE" Then
		bCreate = True
	End If

	If Upper ( Left ( sLigneTrt, 2 ))  = "GO" &
		And Pos ( sLigneTrt, "GOTO", 1 ) <= 0 &
		Then
		iGo++
		
		If iGo = 2 And bCreate Then
			// Fin de la PS
			iFicWrite = FileWrite ( iFicCPDest, sLigneTrt )
			iGo = 0
			bIf = False
			bCreate = False
			IF iFicCPDest> 0 Then FileClose ( iFicCPDest )
		End If
		
	End If

	If bIf Then
		iFicWrite = FileWrite ( iFicCPDest, sLigneTrt )
	End If
	
Loop


FileClose ( iFicCP )

return 1

end function

on w_t_cpsql.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_t_cpsql.destroy
destroy(this.st_1)
end on

event open;
Yield ()
Wf_Lancer ()
end event

type st_1 from statictext within w_t_cpsql
integer x = 411
integer y = 356
integer width = 1870
integer height = 124
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

