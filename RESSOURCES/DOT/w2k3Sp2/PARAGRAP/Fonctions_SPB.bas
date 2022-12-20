"Option Explicit

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
        
        Set docParagraphe = Documents.Open(sPara, Visible:=False)
        docParagraphe.Activate

        ActiveDocument.Content.Select
        Selection.Range.Copy
        ActiveDocument.Close SaveChanges:=wdDoNotSaveChanges
' On se positionne à la fin du document.
        aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
        aDocPrincipal.ActiveWindow.Selection.Range.Paste
    Next
End If

uf_GenererComposition = 1
GoTo Fin

GestionErreur:
uf_GenererComposition = -1

Fin:

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
'    Selection.EndKey Unit:=wdStory
'    Selection.TypeBackspace
'    Selection.Delete Unit:=wdCharacter, Count:=1

' On sauvegarde le document de fusion.
    ActiveDocument.SaveAs FileName:=sFicSauve, FileFormat:=wdFormatDocument
End If

uf_CommencerFusion = 1
GoTo Fin

GestionErreur:
uf_CommencerFusion = -1

Fin:

End Function
Public Function uf_Regroupement(asSuffixe, asFicCourrierIni, asRepGenDoc, aiSection, aDocPrincipal)

Dim sNomDoc, sGestionPart, sDteEditDoc As String
Dim iBac, iTotColonne, iEgal, i As Integer
Dim docRegroupement As Document
Dim objColumns As TextColumns
Dim lLarg(10), lEspace(10) As Single

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
Set docRegroupement = Documents.Open(sNomDoc, Visible:=False)
docRegroupement.ActiveWindow.Activate
' On remplace la date d'édition du document éventuellement.
If sDteEditDoc <> "" Then uf_ModifierDteEdition (sDteEditDoc)

ActiveDocument.Content.Select
Selection.Range.Copy
ActiveDocument.Close SaveChanges:=wdDoNotSaveChanges

' On se positionne à la fin du document.
aDocPrincipal.ActiveWindow.Selection.EndKey Unit:=wdStory
aDocPrincipal.ActiveWindow.Selection.Range.Paste
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
        .FirstPageTray = iBac
        .OtherPagesTray = iBac
        .SectionStart = wdSectionNewPage
        .TextColumns.EvenlySpaced = iEgal
    End With
    
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
GoTo Fin

GestionErreur:
uf_Regroupement = -1

Fin:

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
GoTo Fin

GestionErreur:
uf_CourrierSauve = -1

Fin:

End Function

Public Function uf_Imprimer(asFicSpool, asFicCourrierIni, aDocPrincipal)

Dim iAjout, iNbPage, iTotPage As Integer

' On active un gestionnaire d'erreur.
On Error GoTo GestionErreur

' On vérifie si le fichier de SPOOL existe. S'il existe, on va ajouter le document en cours d'impression au
' fichier d'impression.
iAjout = 0
If Dir(asFicSpool) <> "" Then iAjout = 1

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
aDocPrincipal.PrintOut Background:=False, Append:=iAjout, OutputFileName:=asFicSpool, _
    PrintToFile:=True, Collate:=True, Copies:=1, Range:=wdPrintAllDocument, Item:=wdPrintDocumentContent, _
    PageType:=wdPrintAllPages
    
uf_Imprimer = 1
GoTo Fin

GestionErreur:
uf_Imprimer = -1

Fin:
    
End Function
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
GoTo Fin

GestionErreur:
uf_MiseSousPli = -1

Fin:
   
End Function"
