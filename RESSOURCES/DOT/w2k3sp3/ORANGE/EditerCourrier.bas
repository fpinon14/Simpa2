Option Explicit
Public Sub Main()

' Variables portant sur Fichier COURRIER.INI.
Dim sFicCourrierIni, sRepGenDoc, sCleEdition, sFicSauve, sTypeSauve, sMiseSousPli, sEdition, sFicSpool As String
Dim iNbrDoc As Integer
Dim DocPrincipal As Document

' Variables portant sur Fichier de paramêtres de l'application.
Dim sFicIniApp, sRepCourrier, sModele As String

' Variables de traitement.
Dim sSuffixe, sErreur As String
Dim iCpt, iRet, iSection, iTotWin As Integer

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

' On récupére le nombre de documents qui composent le courrier.
iNbrDoc = Val(System.PrivateProfileString(sFicCourrierIni, "COURRIER", "NBR_DOC"))

' On récupére le répertoire ou l'on stocke les documents avant le regroupement final.
' (Ex:C:\WIN\TEMP)
sRepGenDoc = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "WINTEMP")

' On récupére la cle qui permet de déterminer les valeurs à utiliser
' En SIMPA2, il existe [EDITION] et [EDITION_SIMPA1]
sCleEdition = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "CLE_EDITION")
If sCleEdition = "" Then sCleEdition = "EDITION"

' On récupére le répertoire ou se trouve les paragraphes à insérer.
sRepCourrier = System.PrivateProfileString(sFicIniApp, sCleEdition, "REP_COURRIER")

'-- Ancien code annulé par JFF le 16/01/2004, où le modèle était lu en dur dans le fichier INI de l appli --
' On récupére le nom du modèle à utiliser
' sModele = sRepCourrier + System.PrivateProfileString(sFicIniApp, sCleEdition, "MODELE")
'-- Nouveau code par JFF le 16/01/2004, où le modèle est passé par n_cst_edition_courrier --
' On récupére le nombre de documents qui composent le courrier.
sModele = sRepCourrier + System.PrivateProfileString(sFicCourrierIni, "COURRIER", "MODELE")


' On ferme toutes les fenêtres/documents ouverts.
If Documents.Count > 1 Then
    Documents.Close SaveChanges:=wdDoNotSaveChanges
End If

iTotWin = Application.Windows.Count
If iTotWin > 0 Then
    For iCpt = 1 To iTotWin
        If Application.Windows.Item(iCpt).WindowState <> wdWindowStateMinimize Then Application.Windows.Item(iCpt).WindowState = wdWindowStateMinimize
    Next
End If

For iCpt = 1 To iNbrDoc
' On ouvre un nouveau document basé sur le modéle désiré.
    Set DocPrincipal = Documents.Add(Template:=sModele, Visible:=False)

    sSuffixe = "_" + LTrim(Str(iCpt))
' On va composer le document.
    iRet = uf_GenererComposition(sSuffixe, sFicCourrierIni, sRepCourrier, DocPrincipal)
    If iRet < 1 Then
        sErreur = "Erreur dans la composition " + sSuffixe
        GoTo GestionErreur
    End If

' On va ensuite le fusionner et le sauvegarder dans lr répertoire prévu à cet effet..
    iRet = uf_CommencerFusion(sSuffixe, sFicCourrierIni, sRepGenDoc, DocPrincipal)
    If iRet < 1 Then
        sErreur = "Erreur dans la fusion " + sSuffixe
        GoTo GestionErreur
    End If

' On ferme tous les documents actuellement ouverts sans poser de questions.
    If Documents.Count > 1 Then
        Documents.Close SaveChanges:=wdDoNotSaveChanges
    End If
Next

' On va regrouper tous les documents en un seul courrier.
' On va positionner les sauts de section et les bacs pour l'impression.

' On ouvre un nouveau document basé sur le modéle désiré.
Set DocPrincipal = Documents.Add(Template:=sModele, Visible:=False)
     
For iCpt = 1 To iNbrDoc
    sSuffixe = "_" + LTrim(Str(iCpt))
' Par défaut, on insére un saut de section.
' Sauf s'il s'agit du dernier document du courrier
    iSection = 1
    If iCpt = iNbrDoc Then iSection = 0
    
    iRet = uf_Regroupement(sSuffixe, sFicCourrierIni, sRepGenDoc, iSection, DocPrincipal)
    If iRet < 1 Then
        sErreur = "Erreur dans le regroupement " + sSuffixe
        GoTo GestionErreur
    End If
Next

' On met à jour les champs de façon à afficher la date du jour.
DocPrincipal.Content.Select
DocPrincipal.Fields.Update
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

' On positionne la mise sous pli si nécessaire.
sMiseSousPli = System.PrivateProfileString(sFicCourrierIni, "COURRIER", "MISE SOUS PLI")

If sMiseSousPli = "" Then sMiseSousPli = "O"

If sMiseSousPli = "O" Then
' On génére la mise sous pli.
    iRet = uf_MiseSousPli(DocPrincipal)
    If iRet < 1 Then
       sErreur = "Erreur dans la mise sous pli"
       GoTo GestionErreur
    End If
End If

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
If Documents.Count > 1 Then
    Documents.Close SaveChanges:=wdDoNotSaveChanges
End If

If Application.WindowState <> wdWindowStateMinimize Then Application.WindowState = wdWindowStateMinimize

' On quitte pour éviter le gestionnaire d'erreur.
Exit Sub

' Il vient de se produire une erreur.
GestionErreur:

' On positionne certains flags pour dire qu'il y a une erreur.
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "STATUS") = "PAS OK"
System.PrivateProfileString(sFicCourrierIni, "IMPRESSION", "ERREUR_WORD") = sErreur

' On ferme tous les documents actuellement ouverts sans poser de questions.
If Documents.Count > 1 Then
    Documents.Close SaveChanges:=wdDoNotSaveChanges
End If

End Sub
