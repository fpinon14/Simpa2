Attribute VB_Name = "Fonctions_SPB"
Option Explicit

Private Declare Function GetTempPath Lib "kernel32" _
        Alias "GetTempPathA" (ByVal nBufferLength As Long, _
        ByVal lpBuffer As String) As Long

Private Declare Function GetTempFileName Lib "kernel32" _
        Alias "GetTempFileNameA" (ByVal lpszPath As String, _
        ByVal lpPrefixString As String, ByVal wUnique As Long, _
        ByVal lpTempFileName As String) As Long

Private Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" ( _
                ByVal lpFileName As String) As Long

Private Declare Function SetFileAttributes Lib "kernel32" Alias "SetFileAttributesA" ( _
                ByVal lpFileName As String, _
                ByVal dwFileAttributes As Long) As Long

Private Const FILE_ATTRIBUTE_TEMPORARY As Long = 256

'===============================================================================================================
'
'   Fonction:
'       CreateTempFile : créer un nouveau fichier temporaire et retourne son nom
'
'
'   Hisorique :
'       AJOUT LBP le 11/05/2010 pour patch UNC
'
'   Param :
'       (I) sPrefix  -> Préfixe de 3 lettres utilisé pour le nom du fichier temp
'
'   Retour :
'       String  -> Nom du fichier temporaire nouvellement créé
'
'===============================================================================================================
Public Function CreateTempFile(sPrefix As String) As String

    Dim sTmpPath    As String * 512
    Dim sTmpName    As String * 576
    Dim nRet        As Long

    Dim attr        As Long
    
    ' Par défaut pas de fichier créé
    CreateTempFile = ""
    
    ' Récupère le nom du répertoire temporaire de l'utilisateur
    nRet = GetTempPath(512, sTmpPath)
    
    If (nRet > 0 And nRet < 512) Then
         ' Demande un nom de fichier temporaire
        nRet = GetTempFileName(sTmpPath, sPrefix, 0, sTmpName)
        
        If nRet <> 0 Then
            ' Formate le nom du fichier récupéré (retire les caract Null de fin)
            CreateTempFile = Left$(sTmpName, InStr(sTmpName, vbNullChar) - 1)
            
            ' Dans le cas ou l'attribut FILE_ATTRIBUTE_TEMPORARY n'est pas actif on le force
            attr = GetFileAttributes(CreateTempFile)
            If Not (attr And FILE_ATTRIBUTE_TEMPORARY) = FILE_ATTRIBUTE_TEMPORARY Then
                 SetFileAttributes CreateTempFile, (attr Or FILE_ATTRIBUTE_TEMPORARY)
            End If
        End If
    End If
   
End Function

'===============================================================================================================
'
'   Fonction:
'       bCopyFichierVersFichierTemp : Copie un fichier donné vers un fichier
'                                     temporaire dont le nom est retourné
'
'
'   Hisorique :
'       AJOUT LBP le 11/05/2010 pour patch UNC
'
'   Param :
'       (I) szOriginalFilePath  -> Nom du fichier à copier ( peut être au format UNC)
'       (I) szFileTempPrefix    -> Préfixe de 3 lettres du fichier temp créé
'       (O) szTemporayLocalFile -> Nom du fichier temporaire nouvellement créé
'
'   Retour :
'       boolean   -> Dit si la recopie s'est bien déroulée
'
'===============================================================================================================
Public Function bCopyFichierVersFichierTemp(szOriginalFilePath As String, szFileTempPrefix As String, _
                                            ByRef szTemporayLocalFile As String) As Boolean
    ' Activation trappage d'erreur
    On Error GoTo COPY_ERR
    
    ' Init du nom de fichier temp à vide
    szTemporayLocalFile = ""
    
    ' S'assure de l'existence du fichier source
    If Dir(szOriginalFilePath) = "" Then
        bCopyFichierVersFichierTemp = False
        Exit Function
    End If
    
    ' Demande un nom de fichier temporaire
    szTemporayLocalFile = CreateTempFile(szFileTempPrefix)
    
    ' Vérifie que l'on a bien obtenu le nom du fichier temp
    If szTemporayLocalFile = "" Then GoTo COPY_ERR
    
    ' Copie le fichier SRC dans le fichier temp
    FileCopy szOriginalFilePath, szTemporayLocalFile
    
    ' Dévalidation du gestionnaire d'erreur (par sécu)
    On Error GoTo 0
    
    ' Fin de recopie OK
    bCopyFichierVersFichierTemp = True
    Exit Function
    
COPY_ERR:
    ' Dévalidation du gestionnaire d'erreur
    On Error GoTo 0
    
    ' Supprime le fichier temp si celui-ci existe
    If szTemporayLocalFile <> "" Then
        If Dir(szTemporayLocalFile) <> "" Then
            Kill (szTemporayLocalFile)
        End If
    End If
    
    ' Ne retourne pas de nom de fichier temp
    szTemporayLocalFile = ""
    bCopyFichierVersFichierTemp = False
    Exit Function
    
End Function

'===============================================================================================================
'
'   Fonction:
'       bCopyTemporaireFichierEntete : Copie un fichier d'entete vers le rep tempo de l'utilisateur
'
'
'
'   Hisorique :
'       AJOUT LBP le 11/05/2010 pour patch UNC
'
'   Param :
'       (I) sFicCourrierIni       -> Nom du fichier INI contenant le modèle a copier
'       (I) sSuffixe              -> Suffixe du document concerné
'       (O) sNomFichierTemporaire -> Nom du fichier temporaire nouvellement créé
'
'   Retour :
'       boolean   -> Dit si la recopie s'est bien déroulée
'
'===============================================================================================================


Function bCopyTemporaireFichierEntete(sFicCourrierIni As String, sSuffixe As String, ByRef sNomFichierTemporaire As String) As Boolean
    Dim sNomDoc As String, sEntete As String
    Dim sTemporaryFile As String, sNomCourtFichier As String
    Dim bRet As Boolean
    
    ' Copie en local du fichier modèle vers un fichier temporaire pour import
    sNomDoc = "DOCUMENT" + sSuffixe
    sNomDoc = System.PrivateProfileString(sFicCourrierIni, "COURRIER", sNomDoc)
    sEntete = System.PrivateProfileString(sFicCourrierIni, sNomDoc, "ENTETE")
    
    bRet = bCopyFichierVersFichierTemp(sEntete, "ENT", sTemporaryFile)
    If Not bRet Then GoTo GestionErreur
    
    ' Vérifie existence du fichier d'entete & en profite pour stocker le nom du fichier sans chemin
    sNomCourtFichier = Dir(sTemporaryFile)
    If sNomCourtFichier = "" Then GoTo GestionErreur
    
    ' Retourne le nom du fichier
    sNomFichierTemporaire = sTemporaryFile
    
    bCopyTemporaireFichierEntete = True
    Exit Function
GestionErreur:
    sNomFichierTemporaire = ""
    bCopyTemporaireFichierEntete = False
    
End Function

'===============================================================================================================
'
'   Fonction:
'       SupprTousFichiersEnteteTemporaire : Supprime tous les fichiers temporaires passés en paramètre
'
'
'
'   Hisorique :
'       AJOUT LBP le 11/05/2010 pour patch UNC
'
'   Param :
'       (I) tsTabFichierTemporaire  -> Nom des fichiers temporaire à supprimer
'       (I) iNbrDoc                 -> Nombre de fichier à supprimer
'
'   Retour :
'       boolean   -> Dit si la recopie s'est bien déroulée
'
'===============================================================================================================
Function SupprTousFichiersEnteteTemporaire(ByRef tsTabFichierTemporaire() As String, iNbrDoc As Integer) As Boolean
    Dim i As Integer
    Dim sNomCourtFichier As String
    Dim sTemporaryFile As String
    
    ' En cas d'erreur on ignore, dans pire des cas un fichier temp resterait...
    On Error Resume Next
    
    For i = 1 To iNbrDoc
        sTemporaryFile = tsTabFichierTemporaire(i)
        
        ' Si la création du fichier Temp a été faite on le supprime
        If sTemporaryFile <> "" Then
        
            ' Teste existance du fichier et stocke le nom court
            sNomCourtFichier = Dir(sTemporaryFile)
            
            ' Supprime le fichier si celui-ci existe
            If sNomCourtFichier <> "" Then
            
                ' Teste l'ouverture du fichier Entete et le ferme le cas échéant
                If bIsDocumentExisting(sNomCourtFichier) Then _
                      Documents(sNomCourtFichier).Close SaveChanges:=wdDoNotSaveChanges
            
                ' supprime le fichier
                Kill (sTemporaryFile)
            End If
        End If
    Next
    
    ' RAZ du gestionnaire d'erreur
    On Error GoTo 0
    
End Function


'===============================================================================================================
'
'   Fonction:
'       bIsDocumentExisting : Vérifie l'existence d'un doc donné dans
'       la collection des documents ouverts dans Word
'
'   Hisorique :
'       AJOUT LBP le 11/05/2010 pour patch UNC
'
'   Param :
'       (I) szDocName -> Nom du document dont on veut vérifier l'existence
'   Retour :
'       boolean   -> Dit si le doc spécifié existe ou non
'
'===============================================================================================================
Public Function bIsDocumentExisting(szDocName As String)
    Dim i As Integer
    ' Parcours la collection de doc à la recherche du document spécifié
    For i = 1 To Documents.Count
        If Documents(i).Name = szDocName Then
            ' Le doc existe retourn vrai
            bIsDocumentExisting = True
            Exit Function
        End If
    Next i
    ' Le doc n'existe pas retourne false
    bIsDocumentExisting = False

End Function


'===============================================================================================================
' LBP : PATCH UNC - Modification de la déclaration de la fonction, ajout du paramètre " sEntete As String "
'                   Passage du nom du fichier d'entête en paramètre (on n'utilise plus le nom du fichier du .INI
'                   qui est au format UNC mais la copie locale dont le nom est passé en paramètre

'Public Function uf_CommencerFusion(asSuffixe, asFicCourrierIni, asRepGenDoc, aDocPrincipal)
'===============================================================================================================
Public Function uf_CommencerFusionNew(asSuffixe, asFicCourrierIni, asRepGenDoc, aDocPrincipal, sEntete As String)

Dim sNomDoc, sDonnee, sGestionPart, sFicSauve, sFusion As String
Dim docEntete As Document
Dim bRet As Boolean
Dim sTemporaryShortFileName As String
'Dim sEntete As String

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On arme le nom du document que l'on va fusionner.
sNomDoc = "DOCUMENT" + asSuffixe
sNomDoc = System.PrivateProfileString(asFicCourrierIni, "COURRIER", sNomDoc)

' On arme le nom du fichier qui contient les DATAS pour la fusion
sDonnee = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "DONNEE")

' On arme le nom du fichier d'entête
'sEntete = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "ENTETE")

' On arme une valeur pour expliquer s'il s'agit d'une gestion particuliere de courrier
sGestionPart = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "GESTION_PART")

' On arme le nom du fichier qu'il faudra utiliser pour la sauvegarde
sFicSauve = asRepGenDoc + asSuffixe
' S'il n'existe aucun champ dans le document la fusion va échouer.
sFusion = "O"
If aDocPrincipal.Fields.Count = 0 Then
    sFusion = "N"
    aDocPrincipal.SaveAs FileName:=sFicSauve, FileFormat:=wdFormatDocument
End If

If sGestionPart = "" Then sGestionPart = "N"

If sGestionPart = "N" And sFusion = "O" Then

' On ouvre le fichier d'entête
    Set docEntete = Documents.Open(sEntete, Visible:=False)
    docEntete.ActiveWindow.Activate
    With docEntete.ActiveWindow
' On se positionne à la fin du document.
        .Selection.EndKey Unit:=wdStory
' On insére un retour chariot.
        .Selection.TypeParagraph
' On insére le fichier de DATA à la suite.
        .Selection.InsertFile FileName:=sDonnee, Range:="", ConfirmConversions:=False, Link:=False, Attachment:=False
' On se positionne à la fin du document.
        .Selection.EndKey Unit:=wdStory
' On supprime le dernier retour chariot.
        .Selection.TypeBackspace
    End With
    
' On va réaliser la fusion
  'MsgBox "Avant MailMerge"
  
  aDocPrincipal.ActiveWindow.Activate

  With aDocPrincipal.MailMerge
        .MainDocumentType = wdFormLetters
        .OpenDataSource Name:=sEntete
        .Destination = wdSendToNewDocument
        .SuppressBlankLines = False
        .Execute
  End With
    

    '===================================================================================
        
    ' La fusion WORD 2000 ne fonctionne pas comme la fusion WORD 95.
    ' La fusion d'un seul enregistrement se termine toujours avec un saut de section.
    ' Il faut donc supprimer ce saut de section + le dernier retour chariot.
'[ITSM54562] lignes décommentées
    Selection.EndKey Unit:=wdStory
    Selection.TypeBackspace
    Selection.Delete Unit:=wdCharacter, Count:=1

    ' On sauvegarde le document de fusion.
    ActiveDocument.SaveAs FileName:=sFicSauve, FileFormat:=wdFormatDocument
    
' JFF DCMP04020 le 27/04/04 // Ajout de le bloc ElseIf
ElseIf sGestionPart = "O" Then
    ' On insére un Retour Chariot à vide pour permettre la fermeture du document dans la fonction principale
    ' En effet, s'il n'existe aucune modification dans le document ou que tous les documents soient fermés,
    ' l'appel de Documents.Close va échouer.
    ' Attention: Ce RC ne sera jamais sauvegardeé
    aDocPrincipal.ActiveWindow.Selection.TypeParagraph
End If

uf_CommencerFusionNew = 1
Exit Function

GestionErreur:

uf_CommencerFusionNew = -1

End Function



Sub appendFile(ByVal fileFrom As String, ByVal fileTo As String)
    Dim v() As Byte
    Dim fin As Integer
    Dim fout As Integer
    
    fin = FreeFile
    Open fileFrom For Binary As fin
    ReDim v(LOF(fin))
    Get fin, , v
    
    Close fin
    
    fout = FreeFile
    Open fileTo For Binary As fout
    Seek fout, LOF(fout)
    
    Put fout, , v
    
    Close fout
End Sub


Public Function uf_Imprimer(asFicSpool, asFicCourrierIni, aDocPrincipal)

Dim iAjout, iNbPage, iTotPage As Integer
Dim sFichierExport As String

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On vérifie si le fichier de SPOOL existe. S'il existe, on va ajouter le document en cours d'impression au
' fichier d'impression.
iAjout = 0
If Dir(asFicSpool) <> "" Then iAjout = 1

If iAjout = 1 Then
  sFichierExport = CreateTempFile("SPO")
Else
  sFichierExport = asFicSpool
End If

' On calcule le nombre de pages du document en cours.
aDocPrincipal.Repaginate
' On récupére le nombre de pages du document.
iNbPage = aDocPrincipal.ActiveWindow.Selection.Information(wdNumberOfPagesInDocument)
' On récupére le nombre de pages positionné dans le fichier INI.
iTotPage = Val(System.PrivateProfileString(asFicCourrierIni, "PAGE", "CUMUL"))
iTotPage = iTotPage + iNbPage
' On positionne le nouveau nombre de pages.
System.PrivateProfileString(asFicCourrierIni, "PAGE", "CUMUL") = RTrim(Str(iTotPage))
' On lance l'édition.
aDocPrincipal.PrintOut Background:=False, Append:=False, OutputFileName:=sFichierExport, _
    PrintToFile:=True, Collate:=True, Copies:=1, Range:=wdPrintAllDocument, Item:=wdPrintDocumentContent, _
    PageType:=wdPrintAllPages


' Concatène le fichier temp au fichier de sppol
If iAjout = 1 Then
  appendFile sFichierExport, asFicSpool
  
  ' Supprime le fichier temp
  Kill sFichierExport
End If



uf_Imprimer = 1
GoTo fin

GestionErreur:
uf_Imprimer = -1

fin:

End Function



Public Function uf_GenererComposition(asSuffixe, asFicCourrierIni, asRepCourrier, aDocPrincipal)

Dim sNomDoc, sCompo1, sCompo2, sGestionPart, sPara As String
Dim iTot, iCpt As Integer
Dim docParagraphe As Document

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

sNomDoc = "DOCUMENT" + asSuffixe

sNomDoc = System.PrivateProfileString(asFicCourrierIni, "COURRIER", sNomDoc)
sCompo1 = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "COMPOSITION")
sCompo2 = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "COMPOSITION2")
sGestionPart = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "GESTION_PART")

sCompo1 = sCompo1 + sCompo2
If sGestionPart = "" Then sGestionPart = "N"

If sGestionPart = "N" Then
    iTot = Len(sCompo1)
    
    For iCpt = 1 To iTot Step 8
        sPara = Mid(sCompo1, iCpt, 8)
        
        Select Case Left(sPara, 4)
        Case "PIEC"
            sPara = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "AUTRE PIECE")
                   
        Case "POST"
            sPara = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "POST SCRIPTUM")
        
        Case "PART"
            sPara = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "PARTICULIER")
                    
        Case Else
            sPara = asRepCourrier + sPara

        End Select
        
        '<VBA_INSPECTOR>
        '   <CHANGE>
        '       <MESSAGE>Potentially contains changed items in the object model</MESSAGE>
        '       <ITEM>[wrd]Documents.Open</ITEM>
        '       <URL>http://go.microsoft.com/?linkid=9718420 </URL>
        '   </CHANGE>
        '</VBA_INSPECTOR>
        Set docParagraphe = Documents.Open(sPara, Visible:=False)
        docParagraphe.Activate

        ActiveDocument.Content.Select
        Selection.Range.Copy
        ActiveDocument.Close SaveChanges:=wdDoNotSaveChanges
' On se positionne à la fin du document.
        aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
        
        Select Case Left(Mid(sCompo1, iCpt, 8), 4)
            Case "Z014", "Z017", "Z040", "Z041", "Z042", "Z043"
              aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
              aDocPrincipal.ActiveWindow.Selection.InsertBreak Type:=wdSectionBreakNextPage
        End Select

        aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
        aDocPrincipal.ActiveWindow.Selection.Range.Paste
        
    Next
End If

uf_GenererComposition = 1
GoTo fin

GestionErreur:
uf_GenererComposition = -1

fin:

End Function

Public Function uf_CommencerFusion(asSuffixe, asFicCourrierIni, asRepGenDoc, aDocPrincipal)

Dim sNomDoc, sDonnee, sEntete, sGestionPart, sFicSauve, sFusion As String
Dim docEntete As Document

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On arme le nom du document que l'on va fusionner.
sNomDoc = "DOCUMENT" + asSuffixe
sNomDoc = System.PrivateProfileString(asFicCourrierIni, "COURRIER", sNomDoc)

' On arme le nom du fichier qui contient les DATAS pour la fusion
sDonnee = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "DONNEE")

' On arme le nom du fichier d'entête
sEntete = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "ENTETE")

' On arme une valeur pour expliquer s'il s'agit d'une gestion particuliere de courrier
sGestionPart = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "GESTION_PART")

' On arme le nom du fichier qu'il faudra utiliser pour la sauvegarde
sFicSauve = asRepGenDoc + asSuffixe
' S'il n'existe aucun champ dans le document la fusion va échouer.
sFusion = "O"
If aDocPrincipal.Fields.Count = 0 Then
    sFusion = "N"
    aDocPrincipal.SaveAs FileName:=sFicSauve, FileFormat:=wdFormatDocument
End If

If sGestionPart = "" Then sGestionPart = "N"

If sGestionPart = "N" And sFusion = "O" Then
' On ouvre le fichier d'entête
    '<VBA_INSPECTOR>
    '   <CHANGE>
    '       <MESSAGE>Potentially contains changed items in the object model</MESSAGE>
    '       <ITEM>[wrd]Documents.Open</ITEM>
    '       <URL>http://go.microsoft.com/?linkid=9718420 </URL>
    '   </CHANGE>
    '</VBA_INSPECTOR>
    Set docEntete = Documents.Open(sEntete, Visible:=False)
    docEntete.ActiveWindow.Activate
    With docEntete.ActiveWindow
' On se positionne à la fin du document.
        .Selection.EndKey Unit:=wdStory
' On insére un retour chariot.
        .Selection.TypeParagraph
' On insére le fichier de DATA à la suite.
        .Selection.InsertFile FileName:=sDonnee, Range:="", ConfirmConversions:=False, Link:=False, Attachment:=False
' On se positionne à la fin du document.
        .Selection.EndKey Unit:=wdStory
' On supprime le dernier retour chariot.
        .Selection.TypeBackspace
    End With
' On va réaliser la fusion
    aDocPrincipal.ActiveWindow.Activate
    With aDocPrincipal.MailMerge
            .MainDocumentType = wdFormLetters
            .OpenDataSource Name:=sEntete
            .Destination = wdSendToNewDocument
            .SuppressBlankLines = False
            .Execute
    End With
' La fusion WORD 2000 ne fonctionne pas comme la fusion WORD 95.
' La fusion d'un seul enregistrement se termine toujours avec un saut de section.
' Il faut donc supprimer ce saut de section + le dernier retour chariot.
'[ITSM54562] lignes décommentées
    Selection.EndKey Unit:=wdStory
    Selection.TypeBackspace
    Selection.Delete Unit:=wdCharacter, Count:=1

' On sauvegarde le document de fusion.
    '<VBA_INSPECTOR>
    '   <DEPRECATION>
    '       <MESSAGE>Potentially contains removed items the object model</MESSAGE>
    '       <ITEM>[wrd]Document.SaveAs</ITEM>
    '       <URL>http://go.microsoft.com/?linkid=9718414 /URL>
    '   </DEPRECATION>
    '</VBA_INSPECTOR>
    #If VBA7 Then
        ActiveDocument.SaveAs2 FileName:=sFicSauve, FileFormat:=wdFormatDocument
    #Else
        ActiveDocument.SaveAs FileName:=sFicSauve, FileFormat:=wdFormatDocument
    #End If
    
' JFF DCMP04020 le 27/04/04 // Ajout de le bloc ElseIf
ElseIf sGestionPart = "O" Then
' On insére un Retour Chariot à vide pour permettre la fermeture du document dans la fonction principale
' En effet, s'il n'existe aucune modification dans le document ou que tous les documents soient fermés,
' l'appel de Documents.Close va échouer.
' Attention: Ce RC ne sera jamais sauvegardeé
    aDocPrincipal.ActiveWindow.Selection.TypeParagraph
End If

uf_CommencerFusion = 1
GoTo fin

GestionErreur:
uf_CommencerFusion = -1

fin:

End Function
Public Function uf_Regroupement(asSuffixe, asFicCourrierIni, asRepGenDoc, aiSection, aDocPrincipal)

Dim sNomDoc, sGestionPart, sDteEditDoc As String
Dim iBac, iTotColonne, iEgal, i As Integer
Dim docRegroupement As Document
Dim objColumns As TextColumns
Dim lLarg(10), lEspace(10) As Single
Dim iSectionCount As Integer '[SUPPORT_MFP].SIMPA2
Dim iSectionCurrentIndex As Integer '[SUPPORT_MFP].SIMPA2

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On arme le nom du document que l'on va construire
sNomDoc = "DOCUMENT" + asSuffixe
sNomDoc = System.PrivateProfileString(asFicCourrierIni, "COURRIER", sNomDoc)

' On récupére le N° du BAC pour l'impression.
iBac = Val(System.PrivateProfileString(asFicCourrierIni, sNomDoc, "BAC"))

' On récupére la date d'édition précise du document dans le cas d'une relance.
sDteEditDoc = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "DTE_EDIT_DOCUMENT")

' On arme une valeur pour expliquer s'il s'agit d'une gestion particuliere de courrier
sGestionPart = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "GESTION_PART")

If sGestionPart = "" Then sGestionPart = "N"

If sGestionPart = "N" Then
    sNomDoc = asRepGenDoc + asSuffixe
Else
    sNomDoc = System.PrivateProfileString(asFicCourrierIni, sNomDoc, "COMPOSITION")
End If

' On insére le document dans le courrier principal.
'<VBA_INSPECTOR>
'   <CHANGE>
'       <MESSAGE>Potentially contains changed items in the object model</MESSAGE>
'       <ITEM>[wrd]Documents.Open</ITEM>
'       <URL>http://go.microsoft.com/?linkid=9718420 </URL>
'   </CHANGE>
'</VBA_INSPECTOR>
Set docRegroupement = Documents.Open(sNomDoc, Visible:=False)
docRegroupement.ActiveWindow.Activate
' On remplace la date d'édition du document éventuellement.
If sDteEditDoc <> "" Then uf_ModifierDteEdition (sDteEditDoc)

ActiveDocument.Content.Select
Selection.Range.Copy
ActiveDocument.Close SaveChanges:=wdDoNotSaveChanges

' On se positionne à la fin du document.
aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory

'[SUPPORT_MFP].SIMPA2 Avant de coller le document lu dans le doc pricncipal
'on mémorise la section courante
iSectionCurrentIndex = aDocPrincipal.ActiveWindow.Selection.Sections.Last.Index

'Insertion du Document lu dans le Document principal
aDocPrincipal.ActiveWindow.Selection.Range.Paste
'[ITSM54562] Suppression du retour chariot présent initialement à l'ouverture du document vierge
' On se positionne à la fin du document.
aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
' On supprime le dernier retour chariot.
aDocPrincipal.ActiveWindow.Selection.TypeBackspace

' On ne positionne la valeur des bacs que si iBac est positif. (iBac=0 -> Bac par défaut)
' Il est préférable de garder la mise en page du document.
If iBac > 0 Then
' La mise en page de Word2000 fonctionne de manière différente de Word95.
' Elle repositionne automatiquement les colonnes si elles existent dans le document.
    Set objColumns = aDocPrincipal.ActiveWindow.Selection.PageSetup.TextColumns
    iTotColonne = objColumns.Count
    iEgal = objColumns.EvenlySpaced

    If iTotColonne > 1 Then
        For i = 1 To iTotColonne
            lLarg(i) = objColumns(i).Width
        Next
    
        For i = 1 To iTotColonne - 1
            lEspace(i) = objColumns(i).SpaceAfter
        Next
    End If

' On positionne la mise en page.
    With aDocPrincipal.ActiveWindow.Selection.PageSetup
        .LineNumbering.Active = False
'        .FirstPageTray = iBac '[SUPPORT_MFP].SIMPA2 Fait dans la boucle ci-dessous
'        .OtherPagesTray = iBac '[SUPPORT_MFP].SIMPA2 Fait dans la boucle ci-dessous
        .SectionStart = wdSectionNewPage
        .TextColumns.EvenlySpaced = iEgal
    End With
 
    '[SUPPORT_MFP].SIMPA2 Support des Bac de la hp m5035 MFP,
    'avec une gestion d'exception pour le bac à enveloppe et le papier A3
    '<VBA_INSPECTOR>
    '   <DEPRECATION>
    '       <MESSAGE>Potentially contains removed items the object model</MESSAGE>
    '       <ITEM>[mso]AnswerWizardFiles.Count</ITEM>
    '       <URL>http://go.microsoft.com/?linkid=171733 /URL>
    '   </DEPRECATION>
    '</VBA_INSPECTOR>
    iSectionCount = aDocPrincipal.Sections.Count
    For i = iSectionCurrentIndex To iSectionCount
        With aDocPrincipal.Sections(i).PageSetup
            If .PaperSize <> wdPaperB5 And .PaperSize <> wdPaperA3 Then
                    .FirstPageTray = iBac
                    .OtherPagesTray = iBac
            End If
        End With
    Next

    If iTotColonne > 1 Then
        For i = 1 To iTotColonne
            With aDocPrincipal.ActiveWindow.Selection.PageSetup
                .TextColumns(i).Width = lLarg(i)
            End With
        Next
        
        For i = 1 To iTotColonne - 1
            With aDocPrincipal.ActiveWindow.Selection.PageSetup
                .TextColumns(i).SpaceAfter = lEspace(i)
            End With
        Next
    End If
End If

aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
If aiSection = 1 Then aDocPrincipal.ActiveWindow.Selection.InsertBreak Type:=wdSectionBreakNextPage

uf_Regroupement = 1
GoTo fin

GestionErreur:
uf_Regroupement = -1

fin:

End Function

Public Function uf_CourrierSauve(asFicSauve, asTypeSauve, asFicCourrierIni, aDocPrincipal)

Dim iTot, iCpt, iFormat As Integer
Dim sDteEdit As String

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' La variable sTypeSauve contient une ou plusieurs valeurs correspondant au(x) type(s) de sauvegarde(s).
iTot = Len(asTypeSauve)

' On modifie la date d'édition du courrier si besoin.
' Cas d'un duplicata ou d'une consultation.
' La clé DTE_EDIT_COURRIER sera armée dans le fichier INI.

sDteEdit = System.PrivateProfileString(asFicCourrierIni, "COURRIER", "DTE_EDIT_COURRIER")
If sDteEdit <> "" Then uf_ModifierDteEdition (sDteEdit)

For iCpt = 1 To iTot Step 1
    iFormat = Val(Mid(asTypeSauve, iCpt, 1))
    aDocPrincipal.SaveAs FileName:=asFicSauve, FileFormat:=iFormat
Next

uf_CourrierSauve = 1
GoTo fin

GestionErreur:
uf_CourrierSauve = -1

fin:

End Function

'Public Function uf_Imprimer(asFicSpool, asFicCourrierIni, aDocPrincipal)
'
'Dim iAjout, iNbPage, iTotPage As Integer
'
'' On active un gestionnaire d'erreur.
'On Error GoTo GestionErreur
'
'' On vérifie si le fichier de SPOOL existe. S'il existe, on va ajouter le document en cours d'impression au
'' fichier d'impression.
'iAjout = 0
'If Dir(asFicSpool) <> "" Then iAjout = 1
'
'' On calcule le nombre de pages du document en cours.
'aDocPrincipal.Repaginate
'' On récupére le nombre de pages du document.
'iNbPage = aDocPrincipal.ActiveWindow.Selection.Information(wdNumberOfPagesInDocument)
'' On récupére le nombre de pages positionné dans le fichier INI.
'iTotPage = Val(System.PrivateProfileString(asFicCourrierIni, "PAGE", "CUMUL"))
'iTotPage = iTotPage + iNbPage
'' On positionne le nouveau nombre de pages.
'System.PrivateProfileString(asFicCourrierIni, "PAGE", "CUMUL") = RTrim(Str(iTotPage))
'' On lance l'édition.
'aDocPrincipal.PrintOut Background:=False, Append:=iAjout, OutputFileName:=asFicSpool, _
'    PrintToFile:=True, Collate:=True, Copies:=1, Range:=wdPrintAllDocument, Item:=wdPrintDocumentContent, _
'    PageType:=wdPrintAllPages
'
'uf_Imprimer = 1
'GoTo fin
'
'GestionErreur:
'uf_Imprimer = -1
'
'fin:
'
'End Function
Public Function uf_ModifierDteEdition(asDteEdit)

Dim sSelect As String

' On se positionne au début du document.
Selection.HomeKey Unit:=wdStory

Selection.GoTo What:=wdGoToField, Name:="Date"
Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
sSelect = Selection.Text

While Len(sSelect) > 3
    Selection.TypeText Text:=asDteEdit
    
    Selection.GoTo What:=wdGoToField, Name:="Date"
    Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
    sSelect = Selection.Text
Wend

End Function

Public Function uf_MiseSousPli(aDocPrincipal)

Dim s11_10_09(8), sChaine(8) As String
Dim sTiret, sBlanc, s13, s12, s08_07_06, s05, s04, s03_02_01 As String

Dim iTotPage, iPage, iTableau As Integer

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' Les marques de mises sous pli sont représentées par 13 Marques
' On s'occupe de définir les constantes
' Une marque de mise sous pli correspond à trois 'traits' ou trois espaces insécables (CHR$(160))
sTiret = "___"
sBlanc = Chr(160) + Chr(160) + Chr(160)

' Position 13 et Position 12
s13 = sBlanc
s12 = ""

' Position 09,10 et 11
s11_10_09(1) = sBlanc + sBlanc + sBlanc
s11_10_09(2) = sBlanc + sBlanc + sTiret
s11_10_09(3) = sBlanc + sTiret + sBlanc
s11_10_09(4) = sBlanc + sTiret + sTiret
s11_10_09(5) = sTiret + sBlanc + sBlanc
s11_10_09(6) = sTiret + sBlanc + sTiret
s11_10_09(7) = sTiret + sTiret + sBlanc
s11_10_09(8) = sTiret + sTiret + sTiret

' Position 08,07 et 06
s08_07_06 = sBlanc + sBlanc + sBlanc

' Position 05
s05 = ""

' Position 04
s04 = ""

' Position 03,02 et 01
s03_02_01 = sBlanc + sBlanc + sTiret

' On se positionne en haut du document
aDocPrincipal.ActiveWindow.Activate
aDocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdStory
' On va se positionner en Affichage Page
aDocPrincipal.ActiveWindow.View.Type = wdNormalView
aDocPrincipal.ActiveWindow.View.Type = wdPrintView

' On va calculer le nombre de pages du document
aDocPrincipal.Repaginate
iTotPage = aDocPrincipal.ActiveWindow.Selection.Information(wdNumberOfPagesInDocument)

' Si le nombre de pages est compris entre 1 et 6, on va effectuer la mse sous pli.
' Dans le cas contraire, plus de 6 pages, il n'y aura pas de marques.
If iTotPage < 7 Then
' On va traiter les pages une à une. Chacune des pages doit posséder ses propres codes.
    For iPage = 1 To iTotPage
' On traite la dernière page, la position 12 change de valeur.
        If iPage = iTotPage Then
            s12 = sTiret
        Else
            s12 = sBlanc
        End If
' On traite la première page, les positiones 04 et 05 dépendent de cette valeur.
        If iPage = 1 Then
            s05 = sTiret
            s04 = sBlanc
        Else
            s05 = sBlanc
            s04 = sTiret
        End If
' On va construire la chaine pour la page en cours.
        sChaine(iPage) = s13 + s12 + s11_10_09(iPage) + s08_07_06 + s05 + s04 + s03_02_01
' On se positionne sur la page - que l'on est en train de traiter - du document.
        aDocPrincipal.ActiveWindow.Selection.GoTo What:=wdGoToPage, Count:=iPage
' On vérifie s'il existe un tableau pour la sélection en cours.
        If aDocPrincipal.ActiveWindow.Selection.Information(wdFrameIsSelected) Then
            aDocPrincipal.ActiveWindow.View.SplitSpecial = wdPaneCurrentPageHeader
            aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
        End If
        aDocPrincipal.ActiveWindow.Selection.TypeText Text:=sChaine(iPage)
        aDocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdLine, Extend:=wdExtend
        
        With aDocPrincipal.ActiveWindow.Selection.Font
            .Name = "Courier"
            .Size = 10
            .Bold = False
            .Italic = False
            .Underline = False
            .StrikeThrough = False
            .Superscript = False
            .Subscript = False
            .Shadow = False
            .Hidden = False
            .Outline = False
        End With
        
        aDocPrincipal.ActiveWindow.Selection.CreateTextbox
        With aDocPrincipal.ActiveWindow.Selection
        .ShapeRange.Fill.Visible = msoTrue
        .ShapeRange.Fill.Solid
        .ShapeRange.Fill.ForeColor.RGB = RGB(255, 255, 255)
        .ShapeRange.Fill.Transparency = 0#
        .ShapeRange.Line.Weight = 0.75
        .ShapeRange.Line.DashStyle = msoLineSolid
        .ShapeRange.Line.Style = msoLineSingle
        .ShapeRange.Line.Transparency = 0#
        .ShapeRange.Line.Visible = msoFalse
        .ShapeRange.LockAspectRatio = msoFalse
        .ShapeRange.Height = 174.6
        .ShapeRange.Width = 19.55
        .ShapeRange.TextFrame.MarginLeft = 0#
        .ShapeRange.TextFrame.MarginRight = 0#
        .ShapeRange.TextFrame.MarginTop = 0#
        .ShapeRange.TextFrame.MarginBottom = 0#
        .ShapeRange.RelativeHorizontalPosition = wdRelativeHorizontalPositionPage
        .ShapeRange.RelativeVerticalPosition = wdRelativeVerticalPositionPage
        .ShapeRange.Left = CentimetersToPoints(0.45)
        .ShapeRange.Top = CentimetersToPoints(10)
        .ShapeRange.LockAnchor = False
        .ShapeRange.WrapFormat.AllowOverlap = True
        .ShapeRange.WrapFormat.Side = wdWrapBoth
        .ShapeRange.WrapFormat.DistanceTop = CentimetersToPoints(0)
        .ShapeRange.WrapFormat.DistanceBottom = CentimetersToPoints(0)
        .ShapeRange.WrapFormat.DistanceLeft = CentimetersToPoints(0)
        .ShapeRange.WrapFormat.DistanceRight = CentimetersToPoints(0)
        .ShapeRange.WrapFormat.Type = wdWrapSquare
        End With
 
        With aDocPrincipal.ActiveWindow.Selection.ParagraphFormat
            .LeftIndent = CentimetersToPoints(0)
            .RightIndent = CentimetersToPoints(0)
            .SpaceBefore = 0
            .SpaceBeforeAuto = False
            .SpaceAfter = 0
            .SpaceAfterAuto = False
            .LineSpacingRule = wdLineSpaceExactly
            .LineSpacing = 12
            .Alignment = wdAlignParagraphLeft
            .WidowControl = True
            .KeepWithNext = False
            .KeepTogether = False
            .PageBreakBefore = True
            .NoLineNumber = False
            .Hyphenation = True
            .FirstLineIndent = CentimetersToPoints(0)
            .OutlineLevel = wdOutlineLevelBodyText
            .CharacterUnitLeftIndent = 0
            .CharacterUnitRightIndent = 0
            .CharacterUnitFirstLineIndent = 0
            .LineUnitBefore = 0
            .LineUnitAfter = 0
            '[GOODWARE2006] PHG 09/08/2006 correction passage Office 2000 => 2003
            .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
            .Borders(wdBorderRight).LineStyle = wdLineStyleNone
            .Borders(wdBorderTop).LineStyle = wdLineStyleNone
            .Borders(wdBorderBottom).LineStyle = wdLineStyleNone
            With .Shading '[GOODWARE2006] PHG 03/10/2006 correction couleur de fond non réinitialisée
                .Texture = wdTextureNone
                .ForegroundPatternColor = wdColorBlack
                .BackgroundPatternColor = wdColorWhite
            End With
        End With
    Next
End If

uf_MiseSousPli = 1
GoTo fin

GestionErreur:
uf_MiseSousPli = -1

fin:
   
End Function
Public Function uf_MiseSousPliNouvelleMethode(aDocPrincipal, asFicCourrierIni)

Dim sChaine3Of9, sChaineEnClair As String
Dim sMspChrono, sMspCompteur As String
Dim iTotPage, iPage, iMspCompteur As Integer

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On se positionne en haut du document
aDocPrincipal.ActiveWindow.Activate
aDocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdStory
' On va se positionner en Affichage Page
aDocPrincipal.ActiveWindow.View.Type = wdNormalView
aDocPrincipal.ActiveWindow.View.Type = wdPrintView

' On arme les deux valeurs nécessaires à la mise sous pli. N° Chrono et Valeur du compteur de page.
sMspChrono = System.PrivateProfileString(asFicCourrierIni, "COURRIER", "MSP_CHRONO")
sMspCompteur = System.PrivateProfileString(asFicCourrierIni, "COURRIER", "MSP_COMPTEUR")

' On va calculer le nombre de pages du document
aDocPrincipal.Repaginate
iTotPage = aDocPrincipal.ActiveWindow.Selection.Information(wdNumberOfPagesInDocument)

' On positionne le nouveau nombre de pages dans le fichier INI.
System.PrivateProfileString(asFicCourrierIni, "PAGE", "NbPageMiseSousPli") = RTrim(Str(iTotPage))
' On va traiter les pages une à une. Chacune des pages doit posséder ses propres codes.
For iPage = 1 To iTotPage
' On va construire la chaine pour la page en cours.
    sChaine3Of9 = "*" + sMspChrono + sMspCompteur + "*"
    sChaineEnClair = Format(sMspChrono, "@@@ @ @@@@@@@") + " " + sMspCompteur

' On arme le compteur de page pour la page suivante
    iMspCompteur = Val(sMspCompteur)
    iMspCompteur = iMspCompteur + 1
    If iMspCompteur > 9 Then iMspCompteur = 0
    
    sMspCompteur = RTrim(LTrim(Str(iMspCompteur)))
' On se positionne sur la page - que l'on est en train de traiter - du document.
    aDocPrincipal.ActiveWindow.Selection.GoTo What:=wdGoToPage, Count:=iPage
' On vérifie s'il existe un tableau pour la sélection en cours.
    If aDocPrincipal.ActiveWindow.Selection.Information(wdFrameIsSelected) Then
        aDocPrincipal.ActiveWindow.View.SplitSpecial = wdPaneCurrentPageHeader
        aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
    End If
    
'
'   Positionnement du code à Barre
'
    aDocPrincipal.ActiveWindow.Selection.TypeText Text:=sChaine3Of9
    aDocPrincipal.ActiveWindow.Selection.HomeKey Unit:=wdLine, Extend:=wdExtend
        
    With aDocPrincipal.ActiveWindow.Selection.Font
        .Name = "Helvetica"
        .Size = 10
        .Bold = False
        .Italic = False
        .Underline = False
        .StrikeThrough = False
        .Superscript = False
        .Subscript = False
        .Shadow = False
        .Hidden = False
        .Outline = False
    End With
        
    aDocPrincipal.ActiveWindow.Selection.CreateTextbox
    With aDocPrincipal.ActiveWindow.Selection
        .ShapeRange.Fill.Visible = msoFalse
        .ShapeRange.Fill.Transparency = 0#

        .ShapeRange.Line.Weight = 0.75
        .ShapeRange.Line.DashStyle = msoLineSolid
        .ShapeRange.Line.Style = msoLineSingle
        .ShapeRange.Line.Transparency = 0#
        .ShapeRange.Line.Visible = msoFalse

        .ShapeRange.LockAspectRatio = msoFalse
        .ShapeRange.Height = 198.45
        .ShapeRange.Width = 19.85

        .ShapeRange.TextFrame.MarginLeft = 0#
        .ShapeRange.TextFrame.MarginRight = 0#
        .ShapeRange.TextFrame.MarginTop = 0#
        .ShapeRange.TextFrame.MarginBottom = 0#

        .ShapeRange.RelativeHorizontalPosition = wdRelativeHorizontalPositionPage
        .ShapeRange.RelativeVerticalPosition = wdRelativeVerticalPositionPage
        .ShapeRange.Left = CentimetersToPoints(0.46)
        .ShapeRange.Top = CentimetersToPoints(19#)
        .ShapeRange.LockAnchor = True

        .ShapeRange.WrapFormat.AllowOverlap = False
        .ShapeRange.WrapFormat.Side = wdWrapBoth
        .ShapeRange.WrapFormat.DistanceTop = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceBottom = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceLeft = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceRight = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.Type = 3

        .Orientation = wdTextOrientationUpward
        '[GOODWARE2003] PHG 04/08/2006 Correction Effet de bord W2000->w2003
        With .ParagraphFormat
            .LeftIndent = CentimetersToPoints(0)
            .RightIndent = CentimetersToPoints(0)
            '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
            '.SpaceBefore = 0
            .SpaceBefore = 6
            .SpaceBeforeAuto = False
            '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
            '.SpaceAfter = 0
            .SpaceAfter = 6
            .SpaceAfterAuto = False
'            .Alignment = wdAlignParagraphLeft
            .WidowControl = True
            .KeepWithNext = False
            .KeepTogether = False
            .PageBreakBefore = True
            .NoLineNumber = False
            .Hyphenation = True
            .FirstLineIndent = CentimetersToPoints(0)
            .OutlineLevel = wdOutlineLevelBodyText
            .CharacterUnitLeftIndent = 0
            .CharacterUnitRightIndent = 0
            .CharacterUnitFirstLineIndent = 0
            .LineUnitBefore = 0
            .LineUnitAfter = 0
            .Alignment = wdAlignParagraphCenter
            .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
            .Borders(wdBorderRight).LineStyle = wdLineStyleNone
            .Borders(wdBorderTop).LineStyle = wdLineStyleNone
            .Borders(wdBorderBottom).LineStyle = wdLineStyleNone
            With .Shading '[GOODWARE2006] PHG 03/10/2006 correction couleur de fond non réinitialisée
                .Texture = wdTextureNone
                .ForegroundPatternColor = wdColorBlack
                .BackgroundPatternColor = wdColorWhite
            End With

        End With
        .Font.Bold = False
        .Font.Name = "3 of 9 Barcode"
        .Font.Size = 18
    End With
        
    ActiveDocument.ActiveWindow.Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=0
    ActiveDocument.ActiveWindow.Selection.Font.Name = "Helvetica"
    
'
'   Positionnement du code en clair sur le haut de page
'
    ActiveDocument.ActiveWindow.Selection.EndKey Unit:=wdStory
    ActiveDocument.ActiveWindow.Selection.GoTo What:=wdGoToPage, Count:=iPage

    ActiveDocument.ActiveWindow.Selection.TypeText Text:=sChaineEnClair
    ActiveDocument.ActiveWindow.Selection.HomeKey Unit:=wdLine, Extend:=wdExtend
    
    With ActiveDocument.ActiveWindow.Selection.Font
        .Name = "Helvetica"
        'DGA on positionne la taille à 10 car si courrier 2 pages avec 1 page vide
        '       lors de l'impression 1 page avec 2 code à barre (car reste 8points en bas de 1er page)
        .Size = 10
        .Bold = False
        .Italic = False
        .Underline = False
        .StrikeThrough = False
        .Superscript = False
        .Subscript = False
        .Shadow = False
        .Hidden = False
        .Outline = False
    End With
    
    ActiveDocument.ActiveWindow.Selection.CreateTextbox
    With ActiveDocument.ActiveWindow.Selection
        .ShapeRange.Fill.Visible = msoFalse
        .ShapeRange.Fill.Transparency = 0#

        .ShapeRange.Line.Weight = 0.75
        .ShapeRange.Line.DashStyle = msoLineSolid
        .ShapeRange.Line.Style = msoLineSingle
        .ShapeRange.Line.Transparency = 0#
        .ShapeRange.Line.Visible = msoFalse

        .ShapeRange.LockAspectRatio = msoFalse
        .ShapeRange.Height = 18.45
        .ShapeRange.Width = 92.15

        .ShapeRange.TextFrame.MarginLeft = 0#
        .ShapeRange.TextFrame.MarginRight = 0#
        .ShapeRange.TextFrame.MarginTop = 0#
        .ShapeRange.TextFrame.MarginBottom = 0#

        .ShapeRange.RelativeHorizontalPosition = wdRelativeHorizontalPositionPage
        .ShapeRange.RelativeVerticalPosition = wdRelativeVerticalPositionPage
        '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
        '.ShapeRange.Left = CentimetersToPoints(0.2)
        .ShapeRange.Left = CentimetersToPoints(0.4)
        '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
        '.ShapeRange.Top = CentimetersToPoints(0.2)
        .ShapeRange.Top = CentimetersToPoints(0.4)
        .ShapeRange.LockAnchor = True

        .ShapeRange.WrapFormat.AllowOverlap = False
        .ShapeRange.WrapFormat.Side = wdWrapBoth
        .ShapeRange.WrapFormat.DistanceTop = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceBottom = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceLeft = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.DistanceRight = CentimetersToPoints(0.1)
        .ShapeRange.WrapFormat.Type = 3
        '[GOODWARE2003] PHG 04/08/2006 Correction Effet de bord W2000->w2003
        With .ParagraphFormat
            .LeftIndent = CentimetersToPoints(0)
            .RightIndent = CentimetersToPoints(0)
            '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
            '.SpaceBefore = 0
            .SpaceBefore = 6
            .SpaceBeforeAuto = False
            '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
            '.SpaceAfter = 0
            .SpaceAfter = 6
            .SpaceAfterAuto = False
'            .Alignment = wdAlignParagraphLeft
            .WidowControl = True
            .KeepWithNext = False
            .KeepTogether = False
            .PageBreakBefore = True
            .NoLineNumber = False
            .Hyphenation = True
            .FirstLineIndent = CentimetersToPoints(0)
            .OutlineLevel = wdOutlineLevelBodyText
            .CharacterUnitLeftIndent = 0
            .CharacterUnitRightIndent = 0
            .CharacterUnitFirstLineIndent = 0
            .LineUnitBefore = 0
            .LineUnitAfter = 0
            .Alignment = wdAlignParagraphCenter
            .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
            .Borders(wdBorderRight).LineStyle = wdLineStyleNone
            .Borders(wdBorderTop).LineStyle = wdLineStyleNone
            .Borders(wdBorderBottom).LineStyle = wdLineStyleNone
            With .Shading '[GOODWARE2006] PHG 03/10/2006 correction couleur de fond non réinitialisée
                .Texture = wdTextureNone
                .ForegroundPatternColor = wdColorBlack
                .BackgroundPatternColor = wdColorWhite
            End With
        End With
        .Font.Bold = False
        .Font.Name = "Courier New"
        .Font.Size = 8
    End With
    
    ActiveDocument.ActiveWindow.Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=0
    ActiveDocument.ActiveWindow.Selection.Font.Name = "Helvetica"
    
    If iPage = 1 Then
        ActiveDocument.ActiveWindow.Selection.EndKey Unit:=wdStory
        ActiveDocument.ActiveWindow.Selection.GoTo What:=wdGoToPage, Count:=iPage

        ActiveDocument.ActiveWindow.Selection.TypeText Text:=sChaineEnClair
        ActiveDocument.ActiveWindow.Selection.HomeKey Unit:=wdLine, Extend:=wdExtend
        
        With ActiveDocument.ActiveWindow.Selection.Font
            .Name = "Helvetica"
            .Size = 10
            .Bold = False
            .Italic = False
            .Underline = False
            .StrikeThrough = False
            .Superscript = False
            .Subscript = False
            .Shadow = False
            .Hidden = False
            .Outline = False
        End With
        
        ActiveDocument.ActiveWindow.Selection.CreateTextbox
        With ActiveDocument.ActiveWindow.Selection
            .ShapeRange.Fill.Visible = msoFalse
            .ShapeRange.Fill.Transparency = 0#
    
            .ShapeRange.Line.Weight = 0.75
            .ShapeRange.Line.DashStyle = msoLineSolid
            .ShapeRange.Line.Style = msoLineSingle
            .ShapeRange.Line.Transparency = 0#
            .ShapeRange.Line.Visible = msoFalse
    
            .ShapeRange.LockAspectRatio = msoFalse
            .ShapeRange.Height = 18.45
            .ShapeRange.Width = 92.15
    
            .ShapeRange.TextFrame.MarginLeft = 0#
            .ShapeRange.TextFrame.MarginRight = 0#
            .ShapeRange.TextFrame.MarginTop = 0#
            .ShapeRange.TextFrame.MarginBottom = 0#
    
            .ShapeRange.RelativeHorizontalPosition = wdRelativeHorizontalPositionPage
            .ShapeRange.RelativeVerticalPosition = wdRelativeVerticalPositionPage
            .ShapeRange.Left = CentimetersToPoints(16)
            .ShapeRange.Top = CentimetersToPoints(4)
            .ShapeRange.LockAnchor = True
    
            .ShapeRange.WrapFormat.AllowOverlap = False
            .ShapeRange.WrapFormat.Side = wdWrapBoth
            .ShapeRange.WrapFormat.DistanceTop = CentimetersToPoints(0.1)
            .ShapeRange.WrapFormat.DistanceBottom = CentimetersToPoints(0.1)
            .ShapeRange.WrapFormat.DistanceLeft = CentimetersToPoints(0.1)
            .ShapeRange.WrapFormat.DistanceRight = CentimetersToPoints(0.1)
            .ShapeRange.WrapFormat.Type = 3
            '[GOODWARE2003] PHG 04/08/2006 Correction Effet de bord W2000->w2003
            With .ParagraphFormat
                .LeftIndent = CentimetersToPoints(0)
                .RightIndent = CentimetersToPoints(0)
                '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
                '.SpaceBefore = 0
                .SpaceBefore = 6
                .SpaceBeforeAuto = False
                '[GOODWARE2003.1] Correction de l'amputation du code en clair et  du code barre
                '.SpaceAfter = 0
                .SpaceAfter = 6
                .SpaceAfterAuto = False
'               .Alignment = wdAlignParagraphLeft
                .WidowControl = True
                .KeepWithNext = False
                .KeepTogether = False
                .PageBreakBefore = True
                .NoLineNumber = False
                .Hyphenation = True
                .FirstLineIndent = CentimetersToPoints(0)
                .OutlineLevel = wdOutlineLevelBodyText
                .CharacterUnitLeftIndent = 0
                .CharacterUnitRightIndent = 0
                .CharacterUnitFirstLineIndent = 0
                .LineUnitBefore = 0
                .LineUnitAfter = 0
                .Alignment = wdAlignParagraphCenter
                .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
                .Borders(wdBorderRight).LineStyle = wdLineStyleNone
                .Borders(wdBorderTop).LineStyle = wdLineStyleNone
                .Borders(wdBorderBottom).LineStyle = wdLineStyleNone
                With .Shading '[GOODWARE2006] PHG 03/10/2006 correction couleur de fond non réinitialisée
                    .Texture = wdTextureNone
                    .ForegroundPatternColor = wdColorBlack
                    .BackgroundPatternColor = wdColorWhite
                End With
            End With
            .Font.Bold = False
            .Font.Name = "Courier New"
            .Font.Size = 8
        End With
        
        ActiveDocument.ActiveWindow.Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=0
        ActiveDocument.ActiveWindow.Selection.Font.Name = "Helvetica"
    End If
Next


uf_MiseSousPliNouvelleMethode = 1
GoTo fin

GestionErreur:
uf_MiseSousPliNouvelleMethode = -1

fin:

End Function
