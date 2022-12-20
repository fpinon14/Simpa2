Attribute VB_Name = "Duplicata"
Option Explicit
Public Sub Main()

' Variables de traitement.
Dim sDuplicata, sDteEdit, sErreur, sSelect As String
Dim iTotWin, iCpt As Integer
Dim DocPrincipal As Document

' On va iconiser WORD et on empêche le rafraichissement de l'écran.
Application.ScreenUpdating = False
If Application.WindowState <> wdWindowStateMinimize Then Application.WindowState = wdWindowStateMinimize

' On récupére le nom du fichier WORD. (Ex C:\FN\20010130\5061921.DOC)
' On est obligé d'utliser une équivalence WordBasic, en effet les fonctions VISUAL BASIC ne permettent.
' pas de récupérer le répertoire ou se trouve le fichier WIN.INI.
sDuplicata = WordBasic.[GetProfileString$]("SIMPA2", "Nouveau Courrier")

' On récupére la date d'édition du courrier. Cette information provient de la table ARCHIVE.
sDteEdit = WordBasic.[GetProfileString$]("SIMPA2", "Dte Edition Nouveau Courrier")

' On ferme toutes les fenêtres/documents ouverts.
Documents.Close SaveChanges:=wdDoNotSaveChanges

iTotWin = Application.Windows.Count
If iTotWin > 0 Then
    For iCpt = 1 To iTotWin
        If Application.Windows.Item(iCpt).WindowState <> wdWindowStateMinimize Then Application.Windows.Item(iCpt).WindowState = wdWindowStateMinimize
    Next
End If

' On ouvre le document spécifié.
'<VBA_INSPECTOR>
'   <CHANGE>
'       <MESSAGE>Potentially contains changed items in the object model</MESSAGE>
'       <ITEM>[wrd]Documents.Open</ITEM>
'       <URL>http://go.microsoft.com/?linkid=9718420 </URL>
'   </CHANGE>
'</VBA_INSPECTOR>
Set DocPrincipal = Documents.Open(sDuplicata, Visible:=False)
DocPrincipal.Activate

' On se positionne au début du document.
DocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdStory

DocPrincipal.ActiveWindow.Selection.GoTo What:=wdGoToField, Name:="Date"
DocPrincipal.ActiveWindow.Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
sSelect = DocPrincipal.ActiveWindow.Selection.Text

While Len(sSelect) > 3
    DocPrincipal.ActiveWindow.Selection.TypeText Text:=sDteEdit
    
    DocPrincipal.ActiveWindow.Selection.GoTo What:=wdGoToField, Name:="Date"
    DocPrincipal.ActiveWindow.Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
    sSelect = DocPrincipal.ActiveWindow.Selection.Text
Wend

DocPrincipal.ActiveWindow.View.Type = wdPrintView
DocPrincipal.Save
Documents.Close SaveChanges:=wdDoNotSaveChanges
'<VBA_INSPECTOR>
'   <CHANGE>
'       <MESSAGE>Potentially contains changed items in the object model</MESSAGE>
'       <ITEM>[wrd]Documents.Open</ITEM>
'       <URL>http://go.microsoft.com/?linkid=9718420 </URL>
'   </CHANGE>
'</VBA_INSPECTOR>
Documents.Open (sDuplicata)

' On ferme tous les documents actuellement ouverts sans poser de questions.

If Application.WindowState <> wdWindowStateMaximize Then Application.WindowState = wdWindowStateMaximize

End Sub
