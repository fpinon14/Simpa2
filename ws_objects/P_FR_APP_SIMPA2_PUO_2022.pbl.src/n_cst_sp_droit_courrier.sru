HA$PBExportHeader$n_cst_sp_droit_courrier.sru
$PBExportComments$nvuo pour la gestion dses droits de courrier
forward
global type n_cst_sp_droit_courrier from nonvisualobject
end type
end forward

global type n_cst_sp_droit_courrier from nonvisualobject
end type
global n_cst_sp_droit_courrier n_cst_sp_droit_courrier

type variables
Private :

Datawindow	idwDroitExistant
Datawindow	idwParamDroit
Datawindow	idwProduit

u_datawindow 	idw1

StaticText	stTemSav
end variables

forward prototypes
public function integer uf_preparer ()
public subroutine uf_filtre_dwproduit (string asidoper, string asnom)
public subroutine uf_afficher_droit (string asidoper, long alidprod)
private function integer uf_zn_autoriser (string asdata, long alrow)
public function integer uf_controlerzone (string asnomcol, string asdata, long alrow)
private function integer uf_zn_refuser (string asdata, long alrow)
public function integer uf_valider ()
public subroutine uf_initialiser (ref u_datawindow adw1, ref s_pass astpass, ref statictext asttemsav)
end prototypes

public function integer uf_preparer ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_droit_courrier::uf_Preparer (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 16:59:52
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

U_Transaction	trSesame
String 			sErrConnect, sFicIniAppli, sIdOper, sNom
Long	lRow

sIdOper = ""

/*------------------------------------------------------------------*/
/* On va se connecter $$HEX2$$e0002000$$ENDHEX$$la base qui g$$HEX1$$e900$$ENDHEX$$re la gestion des acc$$HEX1$$e900$$ENDHEX$$s.      */
/*------------------------------------------------------------------*/
trSesame = CREATE U_Transaction

sFicIniAppli 		= stGLB.sFichierIni
sErrConnect			= ""

If F_ConnectSqlServer ( sFicIniAppli, "SESAME BASE", trSesame, sErrConnect, "SESAME", stGlb.sCodOper ) Then
/*------------------------------------------------------------------*/
/* On va populiser une DataWindow pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la liste des       */
/* op$$HEX1$$e900$$ENDHEX$$rateurs qui peuvent se connecter $$HEX2$$e0002000$$ENDHEX$$l'application.             */
/*------------------------------------------------------------------*/
	idw1.SetTransObject ( trSesame )
	If idw1.Retrieve ( stGlb.sCodAppli ) < 0 Then
		DISCONNECT USING trSesame ;
		stMessage.sTitre		= "Droits courriers"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "DRCO001"
		f_Message ( stMessage )
		Return -1
	End If
	DISCONNECT USING trSesame ;	

Else
	stMessage.sTitre		= "Droits courriers"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "DRCO001"
	f_Message ( stMessage )
	Return -1
End If

idwProduit.Retrieve ( )
idwDroitExistant.Retrieve ()
idwParamDroit.Retrieve ()

lRow = idwProduit.InsertRow (0)
idwProduit.SetItem ( lRow, "ID_PROD", -1 )
idwProduit.SetItem ( lRow, "LIB_PROD", "Par d$$HEX1$$e900$$ENDHEX$$faut, pour tout produit affect$$HEX4$$e9002000e0002000$$ENDHEX$$ce gestionnaire" )

lRow = idwParamDroit.InsertRow (0)
idwParamDroit.SetItem ( lRow, "ID_CODE", 0 )
idwParamDroit.SetItem ( lRow, "LIBELLE", "Contr$$HEX1$$f400$$ENDHEX$$le Total" )
idwParamDroit.SetItem ( lRow, "AUTORISER", "N" )
idwParamDroit.SetItem ( lRow, "REFUSER", "N" )

iDw1.SetSort ( "NOM A" )
iDw1.Sort ()
iDwProduit.Sort ()
idwDroitExistant.Sort ()
idwParamDroit.Sort ()

If iDw1.RowCount () > 0 Then
	iDw1.SelectRow ( 1,True )
	iDw1.SetRow ( 1 )
	sIdOper = iDw1.GetItemString ( 1, "ID_OPER" ) 
	sNom    = iDw1.GetItemString ( 1, "PRENOM" ) + " " + iDw1.GetItemString ( 1, "NOM" ) + " (" + sIdOper + ")"
End If

This.uf_Filtre_DwProduit ( sIdOper, sNom )

Return 1
end function

public subroutine uf_filtre_dwproduit (string asidoper, string asnom);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_droit_courrier::uf_Filtre_DwProduit (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 09:17:00
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : String		asIdOper		Val,
//*					  String		asNom			Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    11/12/2018  On pr$$HEX1$$e900$$ENDHEX$$sente la ligne de d$$HEX1$$e900$$ENDHEX$$faut m$$HEX1$$ea00$$ENDHEX$$me si aucune corbeille pr$$HEX1$$e900$$ENDHEX$$sente.
//*
//*-----------------------------------------------------------------

Long	lIdProd, lTotProd, lCptProd

asIdOper  = Upper ( asIdOper )
lIdProd  = 0

idwProduit.SetRedraw ( False )

// On pr$$HEX1$$e900$$ENDHEX$$sente la ligne de d$$HEX1$$e900$$ENDHEX$$faut m$$HEX1$$ea00$$ENDHEX$$me si aucune corbeille pr$$HEX1$$e900$$ENDHEX$$sente.
idwProduit.SetFilter ( "ID_OPER = '" + asIdOper  + "' OR ID_PROD = -1" )
idwProduit.Filter ()

idwProduit.modify ( "oper_t.text = 'Produit(s) affect$$HEX1$$e900$$ENDHEX$$(s) $$HEX2$$e0002000$$ENDHEX$$" + asNom + "'" )

lTotProd = idwProduit.RowCount ()
If lTotProd > 0 Then
	idwProduit.SelectRow ( 0, False )
	idwProduit.SelectRow ( 1, True )
	idwProduit.SetRow ( 1 )
	lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" )
End If

/*------------------------------------------------------------------*/
/* Affichage en rouge s'il existe un droit particulier sur ce       */
/* produit.                                                         */
/*------------------------------------------------------------------*/
idwDroitExistant.SetFilter ( "ID_OPER = '" + asIdOper  + "'" )
idwDroitExistant.Filter ( )

For lCptProd = 1 To lTotProd 
	If idwDroitExistant.Find ( "ID_PROD = " + String ( idwProduit.GetItemNumber ( lCptProd, "ID_PROD" ) ), 1, lTotProd ) > 0 Then
		idwProduit.SetItem ( lCptProd, "ALT_DROIT", "O" )
	Else
		idwProduit.SetItem ( lCptProd, "ALT_DROIT", "N" )
	End If
Next

idwDroitExistant.SetFilter ( "" )
idwDroitExistant.Filter ( )

This.uf_Afficher_Droit ( asIdOper, lIdProd )

idwProduit.Sort ()
idwProduit.SetRedraw ( True )

end subroutine

public subroutine uf_afficher_droit (string asidoper, long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_droit_courrier::uf_Afficher_Droit (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 10:00:35
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Affichage des droits actuel
//* Commentaires  : 
//*
//* Arguments     : String		asIdOper			Val
//*					  Long		alIdProd			Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Int	iCptParam, iTotParam, iCptDrAct, iTotDrAct, iIdNat, iRow
Boolean	bAutorisation   // Sinon Refus
iTotParam = idwParamDroit.RowCount ()

idwParamDroit.SetRedraw ( False )

For iCptParam = 1 To iTotParam
	idwParamDroit.SetItem ( iCptParam, "AUTORISER", "N" )
	idwParamDroit.SetItem ( iCptParam, "REFUSER", "N" )
Next

//Migration PB8-WYNIWYG-03/2006 FM
//lorsque alIdProd = null, il faut passer ici et pas essayer de constituer le filtre
//If Trim ( asIdOper ) = "" Or alIdProd = 0 Then
If Trim ( asIdOper ) = "" Or alIdProd = 0 Or IsNull(alIdProd) Or IsNull(asIdOper) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	idwParamDroit.Sort ()
	idwParamDroit.SetRedraw ( True )
	Return
End If

idwDroitExistant.SetFilter ( "ID_OPER = '" + asIdOper + "' AND ID_PROD = " + String ( alIdProd ) )
idwDroitExistant.Filter ()
idwDroitExistant.Sort ()

iTotDrAct = idwDroitExistant.RowCount ()
For iCptDrAct = 1 To iTotDrAct

	iIdNat = idwDroitExistant.GetItemNumber ( iCptDrAct, "ID_NAT_OPER" )
	bAutorisation = iIdNat <= 100

	If iIdNat > 100 Then iIdNat -= 100
	iRow  = idwParamDroit.Find ( "ID_CODE = " + String ( iIdNat ), 1, iTotParam  )

	If iRow <= 0 Then Continue

	If bAutorisation Then
		idwParamDroit.SetItem ( iRow, "AUTORISER", "O" )
	Else
		idwParamDroit.SetItem ( iRow, "REFUSER", "O" )
	End If
Next

idwParamDroit.Sort ()
idwParamDroit.SetRedraw ( True )
end subroutine

private function integer uf_zn_autoriser (string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_droit_courrier::Uf_Zn_Autoriser (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 20/02/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Autoriser
//* Commentaires	: On trouve plusieurs fois dans la fonction "idwDroitExistant.RowCount ()".
//*					  Il faut absolument le laisser et ne pas le stocker en variable. 
//*					  Cela est du $$HEX2$$e0002000$$ENDHEX$$la fonction r$$HEX1$$e900$$ENDHEX$$cursive incluse ci-dessous, le compteur peut donc 
//*					  varier et doit $$HEX1$$ea00$$ENDHEX$$tre recalcul$$HEX4$$e9002000e0002000$$ENDHEX$$chaque fois.
//*
//* Arguments		: asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   MADM   27/07/2006   Projet DNTMAIL1/2 Mails sortant en remplacement des courriers
//* #2   JCA	07/03/2007		DCMP 070161 - Ajout d'un droit sur la validation avec r$$HEX1$$e900$$ENDHEX$$glement
//* #3   FPI	28/10/2008		Correction cases $$HEX2$$e0002000$$ENDHEX$$cocher Autoriser/Refuser tout
//*      JFF   13/09/2012     [DROIT223_19]
//*      JFF   04/02/2014     [DROITS_SANDRINE]
//		FPI	03/07/2014		   [VDOC14806]
//*	   JFF   29/10/2018     [CONS_REST_CARDIF]
//*---------------------------------------------------------------

Int iRet, iRet2
Long	lRowIns, lRowProd, lRowOper, lRowRech, lIdProd, lIdNatOper
Long	lCptParam, lTotParam, lDebParam, lFinParam, lCtpProd, lTotProd
String sIdOper, sRech
String sValActuelleAuto

iRet = 0

/*------------------------------------------------------------------*/
/* S'il n'y a pas au une ligne dans produit, on ne peut pas         */
/* toucher la dw des droits.                                        */
/*------------------------------------------------------------------*/
If IdwProduit.RowCount () <= 0 Then	Return 2

stTemSav.Text = "*"

asData = Upper ( asData )
lRowProd = idwProduit.GetSelectedRow ( 0 )
lRowOper = idw1.GetSelectedRow ( 0 )

lIdProd		= idwProduit.GetItemNumber ( lRowProd, "ID_PROD" )
lIdNatOper  = idwParamDroit.GetItemNumber ( alRow, "ID_CODE" )
sIdOper		= idw1.GetItemString ( lRowOper, "ID_OPER" )
lTotParam	= idwParamDroit.RowCount ()

lDebParam   = alRow
lFinParam   = alRow

/*------------------------------------------------------------------*/
/* Gestion du contr$$HEX1$$f400$$ENDHEX$$le total.                                       */
/*------------------------------------------------------------------*/
If lIdNatOper = 0 Then
	lDebParam  = 1
	lFinParam  = lTotParam
End If

For lCptParam = lDebParam To lFinParam

	lIdNatOper  = idwParamDroit.GetItemNumber ( lCptParam, "ID_CODE" )
	sValActuelleAuto = idwParamDroit.GetItemString ( lCptParam, "AUTORISER" )


	/*------------------------------------------------------------------*/
	/* Si l'on est en Trt Controle total, alors on ne coche pas         */
	/* l'option 9, qui est : Gestionnaire DSC.                          */
	/*------------------------------------------------------------------*/
	If lIdNatOper = 9 And lDebParam <> lFinParam Then Continue

	/*------------------------------------------------------------------*/
	/* Si l'on est en Trt Controle total, alors on ne coche pas         */
	/* l'option 11, qui est : Aucune signature.                         */
	/*------------------------------------------------------------------*/
	If lIdNatOper = 11 And lDebParam <> lFinParam Then Continue

	/*------------------------------------------------------------------*/
	/* Si l'on est en Trt Controle total, alors on ne coche pas         */
	/* l'option 19, qui est : Saisie base manuelle.                     */
	/*------------------------------------------------------------------*/
	// [DROIT223_19]
	If lIdNatOper = 19 And lDebParam <> lFinParam Then Continue
  
   // [DROITS_SANDRINE]
	If lDebParam <> lFinParam And lIdNatOper >= 20 Then
/*
		Choose Case lIdNatOper 
			Case 20 TO 26
*/				
				Continue
/*
		End Choose 
*/		
	End If
  
  	// [VDOC14806]
	If asData="O" and lIdNatOper=9 Then
		stMessage.sTitre		= "Droit Membre du DR"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE172"
		stMessage.bouton		= YesNo!
					
		iRet2=F_Message ( stMessage )
		
		if iRet2=2 Then 
			iRet=2
			Continue
		End if
	End if
	// :[VDOC14806]
		 
	idwParamDroit.SetItem ( lCptParam, "AUTORISER", asData )

	// #3
	//If lCptParam = 1 Then Continue
	If lCptParam = 1 Then 
		if asData="O" Then 	idwParamDroit.SetItem ( lCptParam, "REFUSER", "N" )
		Continue
	end if
	// Fin #3

	Choose Case asData

		/*------------------------------------------------------------------*/
		/* on Affecte le droit "Autoriser"                                  */
		/*------------------------------------------------------------------*/
		Case "O"
			
			// [CONS_REST_CARDIF]
			If lIdNatOper = 31 Then
				Choose Case stGlb.sCodOper
					Case "JFF", "FS", "YNA", "RGI", "JBV", "NRI", "RVR", "RPB"
						// Ok pour modifier
					Case Else 
						idwParamDroit.SetItem ( lCptParam, "AUTORISER", sValActuelleAuto )
						stMessage.sTitre		= "!! Droit -NA/31 => 2110 !!"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "GENE181"
						stMessage.bouton		= Ok!
						
						F_Message ( stMessage )							
						Return 2
				End Choose 
			End If
			
			sRech    = "ID_NAT_OPER = " + String ( lIdNatOper ) + " AND " + &
						  "ID_OPER     = '" + sIdOper + "' AND " + &
						  "ID_PROD     = " + String ( lIdProd ) 
			lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
			If lRowRech <= 0 Then
				lRowIns= idwDroitExistant.InsertRow ( 0 )
				idwDroitExistant.SetItem ( lRowIns, "ID_NAT_OPER", lIdNatOper )
				idwDroitExistant.SetItem ( lRowIns, "ID_PROD", lIdProd )
				idwDroitExistant.SetItem ( lRowIns, "ID_OPER", sIdOper )
				idwDroitExistant.SetItem ( lRowIns, "CREE_LE", DateTime ( Today (), Now () ) )
				idwDroitExistant.SetItem ( lRowIns, "MAJ_LE", DateTime ( Today (), Now () ) )
				idwDroitExistant.SetItem ( lRowIns, "MAJ_PAR", stGlb.sCodOper )
			End If

			// Si l'on autorise ce droit pour ce produit, 
			// on ne peut donc pas le refuser pour ce m$$HEX1$$ea00$$ENDHEX$$me produit
			This.uf_Zn_Refuser ( "N", lCptParam )

			/*------------------------------------------------------------------*/
			/* Si l'on coche 'Validation Autonome', alors il faut cocher        */
			/* 'Phase de Validation'                                            */
			/*------------------------------------------------------------------*/
			If lIdNatOper = 6 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 7", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "O", lRowRech )
				End If
			End If

			/*------------------------------------------------------------------*/
			/* Si l'on coche 'Sig Pers', alors il faut ne faut pas cocher       */
			/* 'Aucune signature'                                               */
			/*------------------------------------------------------------------*/
			If lIdNatOper = 8 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 11", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "N", lRowRech )
				End If
			End If

			/*--------------------------------------------------------------------*/
			/* Si l'on coche 'Aucune signature', alors il faut ne faut pas cocher */
			/* 'Sig Pers'                                                         */
			/*--------------------------------------------------------------------*/
			If lIdNatOper = 11 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 8", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "N", lRowRech )
				End If
			End If
						 
			
			/*------------------------------------------------------------------*/
			/* #1 MADM 27/07/2006  Projet DNTMAIL1/2                            */
			/*------------------------------------------------------------------*/
			
			/*------------------------------------------------------------------*/
			/* Si l'on coche 'Envoi courrier particulier par mail' droit 16     */ 
			/* alors il faut cocher 'Envoi courrier par mail' droit 12          */
	      /*------------------------------------------------------------------*/
			If lIdNatOper = 16 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 12", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "O", lRowRech )
				End If
			End If

			If lIdNatOper = 13 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 16", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "O", lRowRech )
				End If
				lRowRech = idwParamDroit.Find ( "ID_CODE = 12", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "O", lRowRech )
				End If
			End If

			/*-------------------------------------------------------------------*/
			/* # 2																					*/
			/* Si l'on coche 'Validation avec r$$HEX1$$e900$$ENDHEX$$glement', alors il faut cocher  	*/
			/* 'Phase de Validation'                                            	*/
			/*-------------------------------------------------------------------*/
			If lIdNatOper = 17 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 7", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "O", lRowRech )
				End If
			End If

			//	[DROIT223_19]
			If lIdNatOper = 19 Then
				stMessage.sTitre		= "!! Droit -NA/223 Reprise base Manuelle !!"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "GENE168 "
				stMessage.bouton		= Ok!
				
				F_Message ( stMessage )
				
			End If
			
			// [DROITS_SANDRINE]
			Choose Case lIdNatOper 
				Case 20 TO 26
					stMessage.sTitre		= "!! Droit r$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$aux RE!!"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "GENE171 "
					stMessage.bouton		= Ok!
					
					F_Message ( stMessage )

			End Choose 

		/*------------------------------------------------------------------*/
		/* on retire le droit "Autoriser"                                   */
		/*------------------------------------------------------------------*/
		Case "N"

			// [CONS_REST_CARDIF]
			If lIdNatOper = 31 Then
				Choose Case stGlb.sCodOper
					Case "JFF", "FS", "YNA", "RGI", "JBV", "NRI", "RVR", "RPB"
						// Ok pour modifier
					Case Else 
						idwParamDroit.SetItem ( lCptParam, "AUTORISER", sValActuelleAuto )
						stMessage.sTitre		= "!! Droit -NA/31 => 2110 !!"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "GENE181"
						stMessage.bouton		= Ok!
						
						F_Message ( stMessage )							
						Return 2
				End Choose 
			End If
			
			sRech    = "ID_NAT_OPER = " + String ( lIdNatOper ) + " AND " + &
						  "ID_OPER     = '" + sIdOper + "' AND " + &
						  "ID_PROD     = " + String ( lIdProd ) 
			lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
			If lRowRech > 0 Then
				idwDroitExistant.DeleteRow ( lRowRech )
			End If

			/*----------------------------------------------------------------------*/
			/* Si l'on d$$HEX1$$e900$$ENDHEX$$coche 'Phase de Validation alors', alors il faut d$$HEX1$$e900$$ENDHEX$$dcocher */
			/* 'Validation Autonome'                                                */
			/* #2 et 'Validation avec r$$HEX1$$e900$$ENDHEX$$glement'                                    */
			/*----------------------------------------------------------------------*/
			If lIdNatOper = 7 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 6", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "N", lRowRech )
				End If
				
				// #2
				lRowRech = idwParamDroit.Find ( "ID_CODE = 17", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "N", lRowRech )
				End If
				// FIN - #2
			End If
						
			/*------------------------------------------------------------------*/
			/* #1 MADM 27/07/2006  Projet DNTMAIL1/2                            */
			/*------------------------------------------------------------------*/
			/*----------------------------------------------------------------------*/
			/* Si l'on d$$HEX1$$e900$$ENDHEX$$coche 'Envoi courrier par mail' droit 12, alors            */
			/* il faut d$$HEX1$$e900$$ENDHEX$$cocher 'Envoi courrier particulier par mail' droit 16      */
			/*----------------------------------------------------------------------*/
			If lIdNatOper = 12 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 16", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Autoriser ( "N", lRowRech )
				End If
			End If



	End Choose
Next

/*------------------------------------------------------------------*/
/* Affichage en rouge s'il existe un droit particulier sur ce       */
/* produit.                                                         */
/*------------------------------------------------------------------*/
sRech = "ID_OPER = '" + sIdOper  + "' AND ID_PROD = " + String ( lIdProd )
lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
If lRowRech > 0 Then
	idwProduit.SetItem ( lRowProd, "ALT_DROIT", "O" )
Else
	idwProduit.SetItem ( lRowProd, "ALT_DROIT", "N" )
End If

Return iRet


end function

public function integer uf_controlerzone (string asnomcol, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_droit_courrier::Uf_ControlerZone (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 20/02/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de zones
//* Commentaires	: 
//*
//* Arguments		: asNomcol		String		Val
//*					  asData			String		Val
//*					  alRow			Long			Val
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*----------------------------------------------------------------

Int	iRet

iRet = 0

CHOOSE CASE Upper ( asNomCol )

	CASE "AUTORISER"
		iRet = This.uf_Zn_Autoriser ( asData, alRow )

	CASE "REFUSER"
		
		iRet = This.uf_Zn_Refuser ( asData, alRow )

END CHOOSE
//Migration PB8-WYNIWYG-03/2006 FM
//idwParamDroit.SetActionCode ( iRet )
//Fin Migration PB8-WYNIWYG-03/2006 FM
Return iRet
end function

private function integer uf_zn_refuser (string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_droit_courrier::Uf_Zn_Refuser (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 20/02/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Refuser
//* Commentaires	: On trouve plusieurs fois dans la fonction "idwDroitExistant.RowCount ()".
//*					  Il faut absolument le laisser et ne pas le stocker en variable. 
//*					  Cela est du $$HEX2$$e0002000$$ENDHEX$$la fonction r$$HEX1$$e900$$ENDHEX$$cursive incluse ci-dessous, le compteur peut donc 
//*					  varier et doit $$HEX1$$ea00$$ENDHEX$$tre recalcul$$HEX4$$e9002000e0002000$$ENDHEX$$chaque fois.
//*
//* Arguments		: asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   MADM   27/07/2006   Projet DNTMAIL1/2 Mails sortant en remplacement des courriers   
//* #2   JCA	07/03/2007		DCMP 070161 - Ajout d'un droit sur la validation avec r$$HEX1$$e900$$ENDHEX$$glement
//* #3   FPI	28/10/2008		Correction cases $$HEX2$$e0002000$$ENDHEX$$cocher Autoriser/Refuser tout
//*      JFF   13/09/2012     [DROIT223_19]
//*      JFF   04/02/2014     [DROITS_SANDRINE]
//*	   JFF   29/10/2018     [CONS_REST_CARDIF]
//*---------------------------------------------------------------

Int iRet
Long	lRowIns, lRowProd, lRowOper, lRowRech, lIdProd, lIdNatOper
Long	lCptParam, lTotParam, lDebParam, lFinParam
String sIdOper, sRech
String sValActuelleRefu

/*------------------------------------------------------------------*/
/* S'il n'y a pas au une ligne dans produit, on ne peut pas         */
/* toucher la dw des droits.                                        */
/*------------------------------------------------------------------*/
If IdwProduit.RowCount () <= 0 Then	Return 2

stTemSav.Text = "*"

asData = Upper ( asData )
lRowProd = idwProduit.GetSelectedRow ( 0 )
lRowOper = idw1.GetSelectedRow ( 0 )

lIdProd		= idwProduit.GetItemNumber ( lRowProd, "ID_PROD" )
lIdNatOper  = idwParamDroit.GetItemNumber ( alRow, "ID_CODE" )
sIdOper		= idw1.GetItemString ( lRowOper, "ID_OPER" )
lTotParam	= idwParamDroit.RowCount ()

lDebParam   = alRow
lFinParam   = alRow

/*------------------------------------------------------------------*/
/* Gestion du contr$$HEX1$$f400$$ENDHEX$$le total.                                       */
/*------------------------------------------------------------------*/
If lIdNatOper = 0 Then
	lDebParam  = 1
	lFinParam  = lTotParam
End If

For lCptParam = lDebParam To lFinParam

	lIdNatOper  = idwParamDroit.GetItemNumber ( lCptParam, "ID_CODE" ) + 100
	sValActuelleRefu = idwParamDroit.GetItemString ( lCptParam, "REFUSER" )

	/*------------------------------------------------------------------*/
	/* Si l'on ai en Trt Controle total, alors on ne coche pas          */
	/* l'option 9, qui est : Gestionnaire DSC.                          */
	/*------------------------------------------------------------------*/
	If lIdNatOper = 109 And lDebParam <> lFinParam Then Continue

	/*------------------------------------------------------------------*/
	/* Si l'on ai en Trt Controle total, alors on ne coche pas          */
	/* l'option 11, qui est : Aucune Signature								  */
	/*------------------------------------------------------------------*/
	If lIdNatOper = 111 And lDebParam <> lFinParam Then Continue

	// [DROIT223_19]
	/*------------------------------------------------------------------*/
	/* Si l'on ai en Trt Controle total, alors on ne coche pas          */
	/* l'option 19, qui est : Saisie Base manuelle                      */
	/*------------------------------------------------------------------*/
	If lIdNatOper = 119 And lDebParam <> lFinParam Then Continue

   // [DROITS_SANDRINE]
	If lDebParam <> lFinParam Then
		Choose Case lIdNatOper 
			Case 120 TO 126
				Continue
		End Choose 
	End If

	idwParamDroit.SetItem ( lCptParam, "REFUSER", asData )

	// #3
	//If lCptParam = 1 Then Continue
	If lCptParam = 1 Then 
		if asData="O" Then 	idwParamDroit.SetItem ( lCptParam, "AUTORISER", "N" )
		Continue
	end if
	// Fin #3

	Choose Case asData

		/*------------------------------------------------------------------*/
		/* On Affecte le droit "Autoriser"                                  */
		/*------------------------------------------------------------------*/
		Case "O"
			
			// [CONS_REST_CARDIF]
			If lIdNatOper = 131 Then
				Choose Case stGlb.sCodOper
					Case "JFF", "FS", "YNA", "RGI", "JBV", "NRI", "RVR", "RPB"
						// Ok pour modifier
					Case Else 
						idwParamDroit.SetItem ( lCptParam, "REFUSER", sValActuelleRefu )
						stMessage.sTitre		= "!! Droit -NA/31 => 2110 !!"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "GENE181"
						stMessage.bouton		= Ok!
						
						F_Message ( stMessage )							
						Return 2
				End Choose 
			End If
			
			sRech    = "ID_NAT_OPER = " + String ( lIdNatOper ) + " AND " + &
						  "ID_OPER     = '" + sIdOper + "' AND " + &
						  "ID_PROD     = " + String ( lIdProd ) 
			lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
			If lRowRech <= 0 Then
				lRowIns= idwDroitExistant.InsertRow ( 0 )
				idwDroitExistant.SetItem ( lRowIns, "ID_NAT_OPER", lIdNatOper )
				idwDroitExistant.SetItem ( lRowIns, "ID_PROD", lIdProd )
				idwDroitExistant.SetItem ( lRowIns, "ID_OPER", sIdOper )
				idwDroitExistant.SetItem ( lRowIns, "CREE_LE", DateTime ( Today (), Now () ) )
				idwDroitExistant.SetItem ( lRowIns, "MAJ_LE", DateTime ( Today (), Now () ) )
				idwDroitExistant.SetItem ( lRowIns, "MAJ_PAR", stGlb.sCodOper )
			End If

			// Si l'on autorise ce droit pour ce produit, 
			// on ne peut donc pas le refuser pour ce m$$HEX1$$ea00$$ENDHEX$$me produit
			This.uf_Zn_Autoriser ( "N", lCptParam )

			/*----------------------------------------------------------------------*/
			/* Si l'on refuse 'Phase de Validation', alors il faut refuser				*/
			/* 'Validation Autonome'                                                */
			/* #2 et 'Validation avec r$$HEX1$$e900$$ENDHEX$$glement'                                    */
			/*----------------------------------------------------------------------*/
			If lIdNatOper = 107 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 6", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Refuser ( "O", lRowRech )
				End If
				
				// #2
				lRowRech = idwParamDroit.Find ( "ID_CODE = 17", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Refuser ( "O", lRowRech )
				End If
				// FIN - #2

			End If
			
			/*------------------------------------------------------------------*/
			/* #1 MADM 27/07/2006  Projet DNTMAIL1/2                            */
			/*------------------------------------------------------------------*/
			/*----------------------------------------------------------------------*/
			/* Si l'on coche 'Refuser Envoi mail' Refus droit 112, alors            */
			/* il faut d$$HEX1$$e900$$ENDHEX$$cocher 'Envoi Courrier particulier par mail'  droit 16     */
			/*----------------------------------------------------------------------*/
			If lIdNatOper = 112 Then
				lRowRech = idwParamDroit.Find ( "ID_CODE = 16", 1, idwParamDroit.RowCount () )
				If lRowRech > 0 Then
					Uf_Zn_Refuser ( "O", lRowRech )
				End If
			End If

		/*------------------------------------------------------------------*/
		/* on retire le droit "Autoriser"                                   */
		/*------------------------------------------------------------------*/
		Case "N"

			// [CONS_REST_CARDIF]
			If lIdNatOper = 131 Then
				Choose Case stGlb.sCodOper
					Case "JFF", "FS", "YNA", "RGI", "JBV", "NRI", "RVR", "RPB"
						// Ok pour modifier
					Case Else 
						idwParamDroit.SetItem ( lCptParam, "REFUSER", sValActuelleRefu )
						stMessage.sTitre		= "!! Droit -NA/31 => 2110 !!"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "GENE181"
						stMessage.bouton		= Ok!
						
						F_Message ( stMessage )							
						Return 2
				End Choose 
			End If
						
			
			sRech    = "ID_NAT_OPER = " + String ( lIdNatOper ) + " AND " + &
						  "ID_OPER     = '" + sIdOper + "' AND " + &
						  "ID_PROD     = " + String ( lIdProd ) 
			lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
			If lRowRech > 0 Then
				idwDroitExistant.DeleteRow ( lRowRech )
			End If


	End Choose
Next

/*------------------------------------------------------------------*/
/* Affichage en rouge s'il existe un droit particulier sur ce       */
/* produit.                                                         */
/*------------------------------------------------------------------*/
sRech = "ID_OPER = '" + sIdOper  + "' AND ID_PROD = " + String ( lIdProd )
lRowRech = idwDroitExistant.Find ( sRech, 1, idwDroitExistant.RowCount ()	)
If lRowRech > 0 Then
	idwProduit.SetItem ( lRowProd, "ALT_DROIT", "O" )
Else
	idwProduit.SetItem ( lRowProd, "ALT_DROIT", "N" )
End If


Return iRet
end function

public function integer uf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_droit_courrier::uf_Valider (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 16:17:04
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Int iRet

iRet = idwDroitExistant.UpDate ()

If iRet < 0 Or SQLCA.SqlCode <> 0 Or SQLCA.SqlDbCode <> 0 Then
	iRet = -1
	F_Commit ( SQLCA, False )
Else
	iRet = 1
	F_Commit ( SQLCA, True )
	stTemSav.Text = ""
End If

Return iRet
end function

public subroutine uf_initialiser (ref u_datawindow adw1, ref s_pass astpass, ref statictext asttemsav);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_droit_courrier::uf_initialiser (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 16:59:52
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : u_DataWindow		aDw1			R$$HEX1$$e900$$ENDHEX$$f
//*					  s_Pass				asPass		R$$HEX1$$e900$$ENDHEX$$f
//*					  StaticText		astTemSav	R$$HEX1$$e900$$ENDHEX$$f
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Boolean bFin 

idw1 = adw1
idwDroitExistant = astPass.dwNorm [1]
idwParamDroit	  = astPass.dwNorm [2]
idwProduit		  = astPass.dwNorm [3]

stTemSav			  = astTemSav

// idw1 est initialiser sur uf_preparer.
idwDroitExistant.SetTransObject ( SQLCA )
idwParamDroit.SetTransObject ( SQLCA )
idwProduit.SetTransObject ( SQLCA )

Do While Not bFin
	stMessage.sTitre		= "INFORMATION IMPORTANTE"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "DRCO002"
	If F_Message ( stMessage ) = 1 Then bFin = TRUE
Loop

end subroutine

on n_cst_sp_droit_courrier.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_droit_courrier.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

