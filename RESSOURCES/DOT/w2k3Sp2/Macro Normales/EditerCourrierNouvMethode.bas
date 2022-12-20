"Option Explicit
Public Sub Main()

' Variables portant sur Fichier COURRIER.INI.
Dim sFicCourrierIni, sNomFic, sFicSauve, sTypeSauve, sMiseSousPli, sEdition, sFicSpool As String
Dim DocPrincipal As Document

' Variables portant sur Fichier de paramêtres de l'application.
Dim sFicIniApp As String
Dim sDteEdit As String

' Variables de traitement.
Dim iRet, iTotWin, iCpt As Integer
Dim sErreur As String

' On va iconiser WORD et on empêche le rafraichissement de l'écran.
Application.ScreenUpdating = False
If Application.WindowState <> wdWindowStateMinimize Then Application.WindowState = wdWindowStateMinimize

' On active un gestionnaire d'erreur
On Error GoTo GestionErreur

' On récupére le fichier de configuration de l'application (Ex: K:\PEGASE\P_PEGA.INI).
' On est obligé d'utliser une équivalence WordBasic, en effet les fonctions VISUAL BASIC ne permettent.
' pas de récupérer le répertoire ou se trouve le fichier WIN.INI.
sFicIniApp = WordBasic.[GetProfileString$]("IMPRESSION", "APPLICATION_INI")

' De la même manière, on récupére le nom du fichier qui contient les informations du courrier à éditer.
' (Ex: C:\SPB\PEGA_E.INI)
sFicCourrierIni = WordBasic.[GetProfileString$]("IMPRESSION", "COURRIER_INI")

' On ouvre le document.
sNomFic = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "NOMFICH")

' JFF DCMP04020 le 27/04/04
' On récupére la date d'édition du courrier. Cette information provient de la table ARCHIVE.
sDteEdit = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "DTE_EDIT_DOCUMENT")

iTotWin = Application.Windows.Count
If iTotWin > 0 Then
    For iCpt = 1 To iTotWin
        If Application.Windows.Item(iCpt).WindowState <> wdWindowStateMinimize Then Application.Windows.Item(iCpt).WindowState = wdWindowStateMinimize
    Next
End If

Set DocPrincipal = Documents.Open(sNomFic, Visible:=False)
DocPrincipal.Activate

' On met à jour les champs de façon à afficher la date du jour.
ActiveDocument.Content.Select
ActiveDocument.Fields.Update
DocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdStory

' Doit-on sauvegarder le courrier ?
' Pour le moment le courrier ne contient pas de marques de mise sous pli.

sFicSauve = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "FIC_SAUVE")
If RTrim(sFicSauve) <> "" Then
    sTypeSauve = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "TYPE_SAUVE")
' On génére la sauvegarde du courrier
    iRet = uf_CourrierSauve(sFicSauve, sTypeSauve, sFicCourrierIni, DocPrincipal)
    If iRet < 1 Then
        sErreur = "Erreur dans la sauvegarde du courrier"
        GoTo GestionErreur
    End If
End If

' JFF DCMP04020 le 27/04/04
' On remplace la date d'édition du document éventuellement.
If sDteEdit <> "" Then uf_ModifierDteEdition (sDteEdit)

' On positionne la mise sous pli si nécessaire.
sMiseSousPli = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "MISE SOUS PLI")

'If sMiseSousPli = "" Then sMiseSousPli = "O" '[SUPPORT_MFP].SIMPA2
If sMiseSousPli = "" Then sMiseSousPli = "NouvelleMethode" 'On active la nvlle methode si pas de methode spécifiée

If sMiseSousPli = "NouvelleMethode" Then
' On génére la mise sous pli.
    iRet = uf_MiseSousPliNouvelleMethode(DocPrincipal, sFicCourrierIni)
 
    If iRet < 1 Then
       sErreur = "Erreur dans la mise sous pli"
       GoTo GestionErreur
    End If
End If

'If sMiseSousPli = "O" Then '[SUPPORT_MFP].SIMPA2 DEsactivation Mise sous pli ancienne méthode.
'' On génére la mise sous pli.
'    iRet = uf_MiseSousPli(DocPrincipal)
'    If iRet < 1 Then
'       sErreur = "Erreur dans la mise sous pli"
'       GoTo GestionErreur
'    End If
'End If

' Faut-il éditer le fichier ?
sEdition = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "EDITION")

If sEdition <> "N" Then
    sFicSpool = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "SPOOL")
    
    Application.ScreenUpdating = True
    iRet = uf_Imprimer(sFicSpool, sFicCourrierIni, DocPrincipal)
    If iRet < 1 Then
        sErreur = "Erreur dans l'édition"
        GoTo GestionErreur
    End If
End If

' On positionne certains flags pour dire que tout est OK.
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "STATUS") = "OK"
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "ERREUR_WORD") = ""

' On ferme tous les documents actuellement ouverts sans poser de questions.
Documents.Close SaveChanges:=wdDoNotSaveChanges

If Application.WindowState <> wdWindowStateMinimize Then Application.WindowState = wdWindowStateMinimize

' On quitte pour éviter le gestionnaire d'erreur.
Exit Sub

' Il vient de se produire une erreur.
GestionErreur:

' On positionne certains flags pour dire qu'il y a une erreur.
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "STATUS") = "PAS OK"
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "ERREUR_WORD") = sErreur

' On ferme tous les documents actuellement ouverts sans poser de questions.
Documents.Close SaveChanges:=wdDoNotSaveChanges

End Sub
