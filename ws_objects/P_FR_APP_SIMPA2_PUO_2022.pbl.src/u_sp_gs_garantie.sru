HA$PBExportHeader$u_sp_gs_garantie.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux garanties
forward
global type u_sp_gs_garantie from u_spb_gs_anc
end type
end forward

global type u_sp_gs_garantie from u_spb_gs_anc
end type
global u_sp_gs_garantie u_sp_gs_garantie

type variables
n_cst_protocole_aig_param_gti iuoProtocoleAIG // [DCMP070914]

end variables

forward prototypes
public function boolean uf_gs_id_garantie (long alidprod, long alidrev, long alidgti)
public function boolean uf_preparermodifier (long alidprod, long alidrev, long alidgti)
public function boolean uf_preparerinserer ()
public function boolean uf_preparersupprimer ()
private function boolean uf_proteger_police ()
public function integer uf_synchro_prefixe (integer aiidpolice, integer row)
public function string uf_gs_id_prefixe ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
end prototypes

public function boolean uf_gs_id_garantie (long alidprod, long alidrev, long alidgti);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_code
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 15:01:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	garanties.
//* Commentaires	:	
//*
//* Arguments		:	Integer  aiIdProd		//Produit
//*									aiIdRev		//R$$HEX1$$e900$$ENDHEX$$vision
//*									aiIdGti		//Garantie
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
Boolean 	bRet	= True		// Variable de retour de la fonction.
Long	 	lIdGti				// Identifiant de la garantie recherch$$HEX1$$e900$$ENDHEX$$e

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un code avec l'identifiant pass$$HEX2$$e9002000$$ENDHEX$$en   */
/* parametre                                                        */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_GARANTIE ( alIdProd, alIdRev, alIdGti, lIdGti )

/*------------------------------------------------------------------*/
/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
/*------------------------------------------------------------------*/

If  ( lIdGti <> 0 ) Or Not f_Procedure ( stMessage, itrTrans, "IM_S01_GARANTIE" ) Then

	stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Garanties"
	stMessage.sVar[ 1 ]	= String ( alIdRev  )
	stMessage.sVar[ 2 ]	= String ( alIdProd )
	stMessage.sCode		= "REFU003"
	bRet						= False

	f_Message ( stMessage )

End If

Return ( bRet )
end function

public function boolean uf_preparermodifier (long alidprod, long alidrev, long alidgti);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_preparermodifier
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 10:02:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la modification d'une garantie
//* Commentaires	:	
//*
//* Arguments		:	Long						alIdProd		//Identifiant Produit
//*    					Long						alIdRev		//N$$HEX2$$b0002000$$ENDHEX$$R$$HEX1$$e900$$ENDHEX$$vision
//*						Long						alIdGti		//Identifiant Garantie
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		03/12/2002 DCMP 020393, Protection de la zone Police et Code_Radical
//*-----------------------------------------------------------------

Boolean					bRet			= True		//Valeur de retour

String					sMod							//Chaine utiliser pour r$$HEX1$$e900$$ENDHEX$$aliser un modify.
String					sCol [ 3 ]					//Champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger



DataWindowChild		dwcRevision					//DDDW des r$$HEX1$$e900$$ENDHEX$$visions
DataWindowChild		dwcGarantie					//DDDW des garanties

iDw_1.ilPremCol = 4
iDw_1.ilDernCol = 6



/*------------------------------------------------------------------*/
/* Rend prot$$HEX1$$e800$$ENDHEX$$ge en modification le Produit, la revision et la       */
/* garantie.                                                        */
/*------------------------------------------------------------------*/
sCol[ 1 ] 		= "id_prod"
sCol[ 2 ] 		= "id_rev"
sCol[ 3 ] 		= "id_gti"

iDw_1.Uf_Proteger ( sCol, "1" )

/*------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation, le produit, la r$$HEX1$$e900$$ENDHEX$$vision et la garantie $$HEX1$$e900$$ENDHEX$$tant        */
/* saisissable, on repositionne la fl$$HEX1$$e800$$ENDHEX$$che de la DDDW                */
/*------------------------------------------------------------------*/
sMod 				= "id_prod.DDDW.UseAsBorder=No "
sMod 				= sMod + 	"id_rev.DDDW.UseAsBorder=No "
sMod 				= sMod +	"id_gti.DDDW.UseAsBorder=No "

iDw_1.uf_Modify ( sMod )


/*------------------------------------------------------------------*/
/* Initialisation des DDDW pour la revision, la garantie en fonction*/
/* du code produit.                                                 */
/*------------------------------------------------------------------*/
iDw_1.GetChild ( "id_rev", dwcRevision )
iDw_1.GetChild ( "id_gti", dwcGarantie )

dwcGarantie.SetTransObject ( iTrTrans )
dwcRevision.SetTransObject ( iTrTrans )

dwcRevision.Retrieve 		( alIdProd )
dwcGarantie.Retrieve 		( alIdProd )

/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$modifier                         */
/*------------------------------------------------------------------*/
If iDw_1.Retrieve ( alIdProd, alIdRev, alIdGti ) <= 0 Then 

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* #1 : DCMP 020393                                                 */
	/*------------------------------------------------------------------*/
	This.uf_Proteger_Police ()
	
	// [DCMP070914] Chragement de la liste des pr$$HEX1$$e900$$ENDHEX$$fixes
	uf_synchro_prefixe( iDw_1.object.id_police[iDw_1.GetRow()], iDw_1.GetRow())
End If

Return ( bRet )
end function

public function boolean uf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_PreparerInserer
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 16:42:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------
String				sCol[ 3 ]						//Champs $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$proteger
String				sMod								//Modify pour la datawindow

DataWindowchild 	dwcRevision						//DDDW de la revision
DataWindowChild	dwcGarantie						//DDDW de la garantie

/*------------------------------------------------------------------*/
/* Rend accessible en saisie le produit, la revision et la garantie */
/*------------------------------------------------------------------*/
sCol[ 1 ] 		= "id_prod"
sCol[ 2 ] 		= "id_rev"
sCol[ 3 ] 		= "id_gti"

iDw_1.Uf_Proteger ( sCol, "0" )


/*------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation, le produit, la r$$HEX1$$e900$$ENDHEX$$vision et la garantie $$HEX1$$e900$$ENDHEX$$tant        */
/* saisissable, on repositionne la fl$$HEX1$$e800$$ENDHEX$$che des DDDW                  */
/*------------------------------------------------------------------*/

sMod = "id_prod.DDDW.UseAsBorder=Yes "
sMod = sMod + 	"id_rev.DDDW.UseAsBorder=Yes  "
sMod = sMod +	"id_gti.DDDW.UseAsBorder=Yes"

iDw_1.uf_Modify ( sMod )


/*----------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$initialisation des DDDW d$$HEX1$$e900$$ENDHEX$$pendant de la valeur du produit.               */
/*----------------------------------------------------------------------------*/
iDw_1.GetChild ( "ID_REV", dwcRevision )
iDw_1.GetChild ( "ID_GTI", dwcGarantie )


dwcRevision.SetTransObject ( iTrTrans )
dwcRevision.Reset ( )
dwcRevision.InsertRow ( 0 )

dwcGarantie.SetTransObject ( iTrTrans )
dwcGarantie.Reset ( ) 
dwcGarantie.InsertRow ( 0 )


iDw_1.SetItem ( 1, "ID_POLICE"  , stNul.dcm )
iDw_1.SetItem ( 1, "COD_TYP_FRA", stNul.dcm )

// [DCMP070914] Chargement de la liste des pr$$HEX1$$e900$$ENDHEX$$fixes, elle est vide en insertion
uf_synchro_prefixe( stnul.lng , iDw_1.GetRow())

iDw_1.ilPremCol = 1	
iDw_1.ilDernCol = 6	


/*------------------------------------------------------------------*/
/* Positionne le focus sur la premi$$HEX1$$e800$$ENDHEX$$re colonne de la Dw_1           */
/*------------------------------------------------------------------*/
iDw_1.SetColumn ( iDw_1.ilPremCol )


Return ( TRUE )
end function

public function boolean uf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerSupprimer
//* Auteur			: V.Capelle
//* Date				: 05/11/1997 17:05:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Demande de confirmation avant suppression d'une garantie
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*					
//*-----------------------------------------------------------------
//* #1    JFF   12/12/2006   [DCMP060824]
//*-----------------------------------------------------------------
Boolean 	bRet 			//Variable de retour de la fonction 
Integer	iRet			//Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur

// Deb #1
If uf_Proteger_Police () Then
		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'une condition de garantie"
		stMessage.sVar[ 1 ] 	= "des sinistres"  
		stMessage.sVar[ 2 ] 	= "cette r$$HEX1$$e900$$ENDHEX$$vision sur ce produit"
		stMessage.sCode		= "REFU002"

		f_Message ( stMessage )
	Return False
End IF
// Fin #1

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'une Garantie"
stMessage.sVar[ 1 ] 	= "cette  garantie"
stMessage.Bouton		= OkCancel!
stMessage.Icon			= Exclamation!
stMessage.sCode		= "CONF001"
iRet						= f_Message ( stMessage )


/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* Suppression                                                      */
	/*------------------------------------------------------------------*/
	iDw_1.DeleteRow ( 0 )
	bRet = True

End If

Return ( bRet )
end function

private function boolean uf_proteger_police ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_sp_gs_garantie::uf_Proteger_Police (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 03/12/2002 14:46:13
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Protection de la zone Police et Code Radical si
//*					  un sinistre existe pour ce produit et cette revision.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   12/12/2006    [DCMP060824]
//* #2	 PHG	 30/05/2008		[DCMP070914]
//*-----------------------------------------------------------------

String	sProt
Long 		lNb, lIdPRod, lIdRev
boolean	bExistSin
ds_existsinistre ldsES // #1 [DCMP070914]

lIdProd = iDw_1.GetItemNumber ( 1, "ID_PROD" )
lIdRev  = iDw_1.GetItemNumber ( 1, "ID_REV"  )

/*------------------------------------------------------------------*/
/* Protection contre les modifications sauvages d'assureur sans     */
/* passer par la cr$$HEX1$$e900$$ENDHEX$$ation d'une r$$HEX1$$e900$$ENDHEX$$vision                            */
/*------------------------------------------------------------------*/
ldsES = create ds_existsinistre
bExistSin = ldsES.uf_existsinistre( string(lIdProd), string(lIdRev), '-1', SQLCA)
if bExistSin Then
	sProt = "1"
Else 
	sProt = "0"
End If

// #1 [DCMP070914] Ci-dessus remplace ci-dessous
//SELECT 	Count (*)
//INTO		:lNb
//FROM		sysadm.w_sin
//WHERE 	id_prod = :lIdProd
//AND		id_rev  = :lIdrev
//USING		SQLCA ;
//
//If lNb <= 0 Then
//
//	lNb = 0
//
//	SELECT 	Count (*)
//	INTO		:lNb
//	FROM		sysadm.sinistre
//	WHERE 	id_prod = :lIdProd
//	AND		id_rev  = :lIdrev
//	USING		SQLCA ;
//
//End If
//
//
//If lNb > 0 Then
//	sProt = "1"
//Else 
//	sProt = "0"
//End If
//


iDw_1.Uf_Proteger ( { "ID_POLICE", "COD_RADICAL" }, sProt )

// #1
//Return lNb > 0 

return bExistSin

end function

public function integer uf_synchro_prefixe (integer aiidpolice, integer row);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_garantie::uf_synchro_prefixe
//* Auteur			: PHG
//* Date				: 29/05/2008 15:22:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DCMP070914]
//* Commentaires	: Assure le chargement et la synchronisation du pr$$HEX1$$e900$$ENDHEX$$fixe
//*
//* Arguments		: value integer  : aiIdPolice : N$$HEX2$$b0002000$$ENDHEX$$de police
//*					  value integer  : row : Ligne de dw concern$$HEX2$$e900e900$$ENDHEX$$
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long lRet

// Chargement de la liste des pr$$HEX1$$e900$$ENDHEX$$fixes
lRet = iuoprotocoleaig.uf_charge_prefixe(aiIdPolice)

// [DCMP070914] Protection de la liste si sinistre existant ou si pas de prefixe,
if iuoprotocoleaig.uf_existsinistre( string(iDw_1.GetItemNumber( row, "ID_PROD" )) , &
												 string(iDw_1.GetItemNumBer( row, "ID_GTI"  )) ) or lRet = 0 Then
	iDw_1.uf_proteger( {"ID_PREFIXE"}, "1")
Else
	iDw_1.uf_proteger( {"ID_PREFIXE"}, "0")
End If

return lRet
end function

public function string uf_gs_id_prefixe ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_prefixe
//* Auteur			:	PHG
//* Date				:	30/05/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	[DCMP070914] Controle le pr$$HEX1$$e900$$ENDHEX$$fixe
//* Commentaires	:	
//*
//* Arguments		:	
//* Retourne		:	le Code Msg
//*
//*-----------------------------------------------------------------
string sPos = ""
string sIdMsg

If Not iuoProtocoleAig.uf_controler_prefixe &
		( iDw_1.object.id_police[iDw_1.GetRow()], sIdMsg) Then
		stMessage.stitre 	= "Erreur Pr$$HEX1$$e900$$ENDHEX$$fixe Assureur"
		stMessage.scode 	= sIdMsg
		stMessage.icon 	= StopSign!
		stMessage.bErreurg= TRUE

		F_message(stMessage)

		sPos = "ID_PREFIXE"
End If

return sPos
end function

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_garantie::uf_initialisation (SURCHARGE)
//* Auteur			: PHG
//* Date				: 30/05/2008 16:28:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value u_transaction atrtrans	 */
/* 	ref u_datawindow adwdatawindow	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

// on surcharge afin de pouvoir initialiser l'objet de traitement du protocole AIG
super::uf_initialisation(atrTrans, adwDataWindow)

//[DCMP070914] Initialisation de l'Objet de Controle du protocole AIG
iuoProtocoleAIG = create n_cst_protocole_aig_param_gti
iuoProtocoleAIG.uf_initialiser( iDw_1, "ID_PREFIXE", "ID_POLICE", SQLCA)
//

end subroutine

on u_sp_gs_garantie.create
call super::create
end on

on u_sp_gs_garantie.destroy
call super::destroy
end on

