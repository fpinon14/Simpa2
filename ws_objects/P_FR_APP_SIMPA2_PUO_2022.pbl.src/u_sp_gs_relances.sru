HA$PBExportHeader$u_sp_gs_relances.sru
$PBExportComments$---} Objet concernant les relances dans le param$$HEX1$$e800$$ENDHEX$$trages.
forward
global type u_sp_gs_relances from nonvisualobject
end type
end forward

global type u_sp_gs_relances from nonvisualobject
end type
global u_sp_gs_relances u_sp_gs_relances

type variables
Private :

u_DataWindow	iDwRelances, iDw1

// Valeur par d$$HEX1$$e900$$ENDHEX$$faut, fixer par Denis, pour les d$$HEX1$$e900$$ENDHEX$$lais
// de relances lors de la cr$$HEX1$$e900$$ENDHEX$$ation d'un produit.
Int		iiDefDurRl1Min, iiDefDurRl1Max, iiDefDurRl2, iiDefDurSoldRl, iiDefDurSoldPc
String		isDefAltRl1, isDefAltRl2, isDefAltsold, isDefUntRl1
end variables

forward prototypes
public subroutine uf_initialiser (ref u_datawindow adwrelances, ref u_datawindow adw1)
public subroutine uf_preparerinserer ()
public subroutine uf_preparermodifier ()
private function integer uf_zn_dur_rl1_min ()
private function integer uf_zn_dur_rl1_max ()
private function integer uf_zn_dur_rl2 ()
private function integer uf_zn_dur_sold_rl ()
private function integer uf_zn_dur_sold_pc ()
private function integer uf_zn_alt_rl1 ()
private function integer uf_zn_alt_rl2 ()
private function integer uf_zn_alt_sold ()
private subroutine uf_zn_znerreur ()
public function boolean uf_controlersaisie ()
public function long uf_zn_trt (integer acas)
end prototypes

public subroutine uf_initialiser (ref u_datawindow adwrelances, ref u_datawindow adw1);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialiser
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 12:20:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de l'objet des relances
//* Commentaires	: 
//*
//* Arguments		: u_DataWindow			aDwRelances
//*					  u_DataWindow			aDw1
//*
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iDwRelances = aDwRelances
iDw1			= aDw1

/*------------------------------------------------------------------*/
/* Aucun Retrieve n'est fait sur Dw_Relances. La donn$$HEX1$$e900$$ENDHEX$$e est   		  */
/* partag$$HEX1$$e900$$ENDHEX$$e avec Dw_1.													        */
/*------------------------------------------------------------------*/
iDw1.ShareData ( iDwRelances )

/*------------------------------------------------------------------*/
/* Initialisation des valeurs de d$$HEX1$$e900$$ENDHEX$$lais par d$$HEX1$$e900$$ENDHEX$$faut. (valeur fix$$HEX1$$e900$$ENDHEX$$es  */
/* par Denis)                                                       */
/*------------------------------------------------------------------*/
isDefAltRl1			= "O"
isDefAltRl2			= "O"
isDefAltSold		= "O"
isDefUntRl1			= "M"
iiDefDurRl1Min		= 2
iiDefDurRl1Max		= 5
iiDefDurRl2			= 2
iiDefDurSoldRl		= 1
iiDefDurSoldPc		= 5
end subroutine

public subroutine uf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_PreparerInserer (Public)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:23:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Preparation avant Insertion
//* Commentaires	: Dw_Relances est en ShareData avec Dw_1
//*
//* Arguments		: Rien
//*
//* Retourne		: Aucun
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Int 		iRet


iDwRelances.ilPremCol = 35	
iDwRelances.ilPremCol = 46

/*------------------------------------------------------------------*/
/* On est en Insertion, on initialise donc les valeurs par d$$HEX1$$e900$$ENDHEX$$faut.  */
/* (Les unit$$HEX1$$e900$$ENDHEX$$s de temps sont toutes $$HEX1$$e900$$ENDHEX$$gales entre elles, soit $$HEX1$$e900$$ENDHEX$$gales */
/* $$HEX2$$e0002000$$ENDHEX$$UNT_RL1																		  */		
/*------------------------------------------------------------------*/
iDwRelances.SetItem ( 1, "ALT_RL1", isDefAltRl1			 )
iDwRelances.SetItem ( 1, "ALT_RL2", isDefAltRl2			 )
iDwRelances.SetItem ( 1, "ALT_SOLD", isDefAltSold	 	 )

iDwRelances.SetItem ( 1, "UNT_RL1", isDefUntRl1			 )
iDwRelances.SetItem ( 1, "UNT_RL2", isDefUntRl1 	 	 )
iDwRelances.SetItem ( 1, "UNT_SOLD_RL", isDefUntRl1	 )
iDwRelances.SetItem ( 1, "UNT_SOLD_PC", isDefUntRl1 	 )

iDwRelances.SetItem ( 1, "DUR_RL1_MIN", iiDefDurRl1Min )
iDwRelances.SetItem ( 1, "DUR_RL1_MAX", iiDefDurRl1Max )
iDwRelances.SetItem ( 1, "DUR_RL2", iiDefDurRl2 )
iDwRelances.SetItem ( 1, "DUR_SOLD_RL", iiDefDurSoldRl )
iDwRelances.SetItem ( 1, "DUR_SOLD_PC", iiDefDurSoldPc )


end subroutine

public subroutine uf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_PreparerModifier (Public)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:27:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Preparation Avant Modification
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



iDwRelances.ilPremCol = 35	
iDwRelances.ilPremCol = 46

end subroutine

private function integer uf_zn_dur_rl1_min ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Dur_Rl1_Min (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la DUR_RL1_MIN
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet, iRet1        // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


iRet  = Integer ( sVal )
iRet1 = iDwRelances.GetItemNumber ( 1, "DUR_RL1_MAX" )

/*------------------------------------------------------------------*/
/* Le nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0                                          */
/*------------------------------------------------------------------*/
If iRet < 1 Then 

	iDwRelances.iiErreur = 0
	iActionCode   			= 1
	bSuite					= False

End If			
	
/*------------------------------------------------------------------*/
/* La contrainte DUR_RL1_MIN <= DUR_RL1_MAX est-elle respect$$HEX1$$e900$$ENDHEX$$e ?    */
/*------------------------------------------------------------------*/
If bSuite And ( Not IsNull ( iRet1 ) ) and ( iRet > iRet1 ) Then

	iDwRelances.iiErreur = 10
	iActionCode   			= 1
	bSuite					= False

End If


Return iActionCode
end function

private function integer uf_zn_dur_rl1_max ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Dur_Rl1_Max (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la DUR_RL1_MAX
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet, iRet1        // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


iRet  = Integer ( sVal )
iRet1 = iDwRelances.GetItemNumber ( 1, "DUR_RL1_MIN" )

/*------------------------------------------------------------------*/
/* Le nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0                                          */
/*------------------------------------------------------------------*/
If iRet < 1 Then

	iDwRelances.iiErreur = 0
	iActionCode   			= 1
	bSuite					= False

End If			


/*------------------------------------------------------------------*/
/* La contrainte DUR_RL1_MIN <= DUR_RL1_MAX est-elle respect$$HEX1$$e900$$ENDHEX$$e ?    */
/*------------------------------------------------------------------*/
If bSuite and ( Not IsNull ( iRet1 ) ) and ( iRet < iRet1 ) Then

	iDwRelances.iiErreur = 10
	iActionCode   			= 1
	bSuite					= False

End If			


Return iActionCode

end function

private function integer uf_zn_dur_rl2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Dur_Rl2 (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la DUR_RL2
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet, iRet1        // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True

iRet  = Integer ( sVal )


/*------------------------------------------------------------------*/
/* Le nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0                                          */
/*------------------------------------------------------------------*/
If iRet < 1 Then 

	iDwRelances.iiErreur = 0
	iActionCode   			= 1
	bSuite					= False

End If			


Return iActionCode
end function

private function integer uf_zn_dur_sold_rl ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Dur_Sold_Rl (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la DUR_SOLD_RL
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet, iRet1        // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


iRet  = Integer ( sVal )
iRet1 = iDwRelances.GetItemNumber ( 1, "DUR_SOLD_PC" )

/*------------------------------------------------------------------*/
/* Le nombre doit $$HEX1$$ea00$$ENDHEX$$tre >= 0                                         */
/*------------------------------------------------------------------*/
If iRet < 0 Then 

	iDwRelances.iiErreur = 0
	iActionCode   			= 1
	bSuite					= False

End If			


/*------------------------------------------------------------------*/
/* La contrainte DUR_SOLD_RL <= DUR_SOLD_PC est-elle respect$$HEX1$$e900$$ENDHEX$$e ?.   */
/*------------------------------------------------------------------*/
If bSuite and ( Not IsNull ( iRet1 ) ) and ( iRet > iRet1 ) Then

	iDwRelances.iiErreur = 10
	iActionCode   			= 1
	bSuite					= False

End If			


Return iActionCode

end function

private function integer uf_zn_dur_sold_pc ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Dur_Sold_Pc (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la DUR_SOLD_PC
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet, iRet1, iRet2 // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


iRet  = Integer ( sVal )
iRet1 = iDwRelances.GetItemNumber ( 1, "DUR_RL1_MIN" )
iRet2 = iDwRelances.GetItemNumber ( 1, "DUR_SOLD_RL" )
	

/*------------------------------------------------------------------*/
/* Le nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0                                          */
/*------------------------------------------------------------------*/
If iRet < 1 Then 

	iDwRelances.iiErreur = 0
	iActionCode  			= 1
	bSuite					= False

End If			

/*------------------------------------------------------------------*/
/* La contrainte DUR_SOLD_PC >= DUR_SOLD_RL est-elle respect$$HEX1$$e900$$ENDHEX$$e ?.   */
/*------------------------------------------------------------------*/
If bSuite and ( Not IsNull ( iRet2 ) ) and ( iRet < iRet2 ) Then

	iDwRelances.iiErreur = 10
	iActionCode   			= 1
 	bSuite				   = False

End If

Return iActionCode
end function

private function integer uf_zn_alt_rl1 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Alt_Rl1 (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la ALT_RL1
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet		          // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


/*------------------------------------------------------------------*/
/* Si Les premi$$HEX1$$e800$$ENDHEX$$res relances sont d$$HEX1$$e900$$ENDHEX$$coch$$HEX1$$e900$$ENDHEX$$es, on d$$HEX1$$e900$$ENDHEX$$coche les 2$$HEX1$$e800$$ENDHEX$$mes   */
/* relances                                                         */
/*------------------------------------------------------------------*/
If sVal = "N" Then
	iDwRelances.SetItem ( 1, "ALT_RL2", "N" )
End If 


/*------------------------------------------------------------------*/
/* Si DUR_RL1_MIN est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$0, c'est qu'il n'y avait pas de        */
/* premi$$HEX1$$e800$$ENDHEX$$re relance lors du dernier Retrieve, donc si l'on coche    */
/* les 1$$HEX1$$e800$$ENDHEX$$re Rel. on r$$HEX1$$e900$$ENDHEX$$initialise tous les champs concern$$HEX1$$e900$$ENDHEX$$s avec     */
/* les valeurs par d$$HEX1$$e900$$ENDHEX$$faut.                                          */
/*------------------------------------------------------------------*/
If (sVal = "O") And ( iDwRelances.GetItemNumber ( 1, "DUR_RL1_MIN" ) = 0 ) Then
	iDwRelances.SetItem ( 1 , "DUR_RL1_MIN", iiDefDurRl1Min )
	iDwRelances.SetItem ( 1 , "DUR_RL1_MAX", iiDefDurRl1Max )
				
End If


Return iActionCode
end function

private function integer uf_zn_alt_rl2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Alt_Rl2 (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la ALT_RL2
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet		          // valeur de retour de fonction.
Int		iActioncode 

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True


/*------------------------------------------------------------------*/
/* Si DUR_RL2 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$0, c'est qu'il n'y avait pas de deuxi$$HEX1$$e800$$ENDHEX$$me   */
/* relance lors du dernier Retrieve, donc si l'on coche les 2$$HEX1$$e800$$ENDHEX$$me    */
/* Rel. on r$$HEX1$$e900$$ENDHEX$$initialise tous les champs concern$$HEX1$$e900$$ENDHEX$$s avec les valeurs  */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/
If (sVal = "O") And ( iDwRelances.GetItemNumber ( 1, "DUR_RL2" ) = 0 ) Then

	iDwRelances.SetItem ( 1 , "DUR_RL2", iiDefDurRl2 )
	
End If


Return iActionCode
end function

private function integer uf_zn_alt_sold ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Alt_Sold (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:30:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de Zone
//* Commentaires	: Controle de la ALT_SOLD
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Integer ActionCode
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	10/07/2013	[PC509-2]			  
//*-----------------------------------------------------------------

Boolean	bSuite				 // On passe au controle Suivant
String	sVal  				 // Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.
Int		iRet		          // valeur de retour de fonction.
Int		iActioncode 
Decimal dcIdProd

iActionCode = 0
sVal 			= iDwRelances.GetText ( )
bSuite 		= True

dcIdProd=idw1.getItemDecimal(1,"ID_PROD")
iRet=SQLCA.PS_S01_DET_PRO(dcIdProd, 244)

If iRet > 0 Then
	// Soldage auto sur prescription
	iDwRelances.iiErreur = 0
	iActionCode   			= 1
	Return iActionCode
End if

/*------------------------------------------------------------------*/
/* Si DUR_SOLD_PC est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$0, c'est qu'il n'y avait pas de        */
/* soldage lors du dernier Retrieve, donc si l'on coche le          */
/* soldage. on r$$HEX1$$e900$$ENDHEX$$initialise tous les champs concern$$HEX1$$e900$$ENDHEX$$s avec les      */
/* valeurs par d$$HEX1$$e900$$ENDHEX$$faut.                                              */
/* ATTENTTION : Ce test test doit imp$$HEX1$$e900$$ENDHEX$$rativement se faire sur 		  */
/* cette zone, DUR_SOLD_RL peut $$HEX1$$ea00$$ENDHEX$$tre saisie $$HEX2$$e0002000$$ENDHEX$$0 par l'utilisteur	  */
/*------------------------------------------------------------------*/
If (sVal = "O") And ( iDwRelances.GetItemNumber ( 1, "DUR_SOLD_PC" ) = 0 ) Then

	iDwRelances.SetItem ( 1 , "DUR_SOLD_RL", iiDefDurSoldRl )
	iDwRelances.SetItem ( 1 , "DUR_SOLD_PC", iiDefDurSoldPc )
				
End If

Return iActionCode


end function

private subroutine uf_zn_znerreur ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_znErreur (Private)
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 13:34:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des erreurs de saisies
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	10/07/2013	[PC509-2]		
//*-----------------------------------------------------------------


If	iDwRelances.ibErreur Then

	stMessage.sTitre	= "SIMPA2 - Relances/Soldages"
	stMessage.Icon		= Information!
	stMessage.bErreurG= False
	stMessage.sCode	= ""
	
	Choose Case iDwRelances.isErrCol


		Case "DUR_RL1_MIN"

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA010"
				Case 10
					stMessage.sCode	= "RELA020"
					
			End Choose			



		Case "DUR_RL1_MAX"

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA010"
				Case 10
					stMessage.sCode	= "RELA030"
					
			End Choose			



		Case "DUR_RL2"

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA010"
				
			End Choose			



		Case  "DUR_SOLD_RL"

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA015"
				Case 10
					stMessage.sCode	= "RELA050"
				
			End Choose			



		Case "DUR_SOLD_PC"

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA010"
				Case 10
					stMessage.sCode	= "RELA060"
				Case 20
					stMessage.sCode	= "RELA040"


			End Choose			

		Case "ALT_SOLD" // [PC509-2]

			Choose Case iDwRelances.iiErreur
				Case 0
					stMessage.sCode	= "RELA070"
			End Choose			
				
	End Choose

	f_Message ( stMessage )
	
	iDwRelances.iiReset = 2
	iDwRelances.uf_Reinitialiser ()

End If
end subroutine

public function boolean uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ControlerSaisie ( Public )
//* Auteur			: Fabry JF
//* Date				: 10/06/1999 16:09:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle la saisie de Dw_Relances.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean	False si Erreur
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean		bOk = True

Int	  iVal, iVal1
String  sVal, sVal1

iVal 	= iDwRelances.GetItemNumber ( 1, "DUR_RL1_MAX" )
iVal1 = iDwRelances.GetItemNumber ( 1, "DUR_SOLD_PC" )
sVal  = iDwRelances.GetItemString ( 1, "ALT_RL1" )
sVal1 = iDwRelances.GetItemString ( 1, "ALT_SOLD" )

If ( sVal = "O" ) and ( sVal1 = "O" ) and Not IsNull ( iVal ) and Not IsNull ( iVal1 ) Then

	bOk = Not ( iVal > iVal1 )

End If

Return bOk 


end function

public function long uf_zn_trt (integer acas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Trt (Public)
//* Auteur			: Fabry JF
//* Date				: 07/06/1999 10:39:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: "Dispatcheur" de contr$$HEX1$$f400$$ENDHEX$$le de zone
//*
//* Arguments		: Integer		aCas			// Cas : 1 --> Controle des zones imm$$HEX1$$e900$$ENDHEX$$diatement apr$$HEX1$$e800$$ENDHEX$$s
//*														// Cas : 2 --> Gestion des Erreurs de zones
//*													
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI		10/07/2013	[PC509-2] Correction pour $$HEX1$$e900$$ENDHEX$$viter 2 msg d'erreurs			  
//*-----------------------------------------------------------------

Int		iActioncode 

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

ll_Ret=1 //	[PC509-2]

/*------------------------------------------------------------------*/
/* Cas 1 : Controle des zones                                       */
/*------------------------------------------------------------------*/
If aCas = 1 Then

	Choose Case iDwRelances.isNomCol


		Case "DUR_RL1_MIN"

			iActionCode = This.uf_Zn_Dur_Rl1_Min ()


		Case "DUR_RL1_MAX"

			iActionCode = This.uf_Zn_Dur_Rl1_Max ()
			

		Case "DUR_RL2"

			iActionCode = This.uf_Zn_Dur_Rl2 ()


		Case "DUR_SOLD_RL"

			iActionCode = This.uf_Zn_Dur_Sold_Rl ()
	

		Case "DUR_SOLD_PC"

			iActionCode = This.uf_Zn_Dur_Sold_Pc ()	


		Case "ALT_RL1"

			iActionCode = This.uf_Zn_Alt_Rl1 ()		


		Case "ALT_RL2"

			iActionCode = This.uf_Zn_Alt_Rl2 ()		


		Case "ALT_SOLD"

			iActionCode = This.uf_Zn_Alt_Sold ()		
		

	End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//	iDwRelances.SetActionCode ( iActionCode )
	ll_ret = iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM
End IF


/*------------------------------------------------------------------*/
/* Cas 2 : Gestion des erreurs.                                     */
/*------------------------------------------------------------------*/
If aCas = 2 Then

	This.uf_zn_znErreur ()	
	
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

on u_sp_gs_relances.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_relances.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

