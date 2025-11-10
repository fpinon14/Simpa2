HA$PBExportHeader$u_cs_sp_travail.sru
$PBExportComments$Objet Consultation Travail
forward
global type u_cs_sp_travail from nonvisualobject
end type
end forward

global type u_cs_sp_travail from nonvisualobject
end type
global u_cs_sp_travail u_cs_sp_travail

type variables
Protected:
	u_Transaction	itrTrans
	s_Pass		istPass

	DataWindow	idw_tr_travail		// Dw Principale sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddProduit		// dddw des Produits sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddCorbeille		// dddw des Corbeille sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddCodEtat		// dddw des CodEtats sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddCodTypRecu 	// dddw des CodTypRecu sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddCodRecu 		// dddw des CodRecu sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
	DataWindow	idw_tr_ddCodIProv	 	// dddw des CodIProv sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail


end variables

forward prototypes
private subroutine uf_initialiser_dddw ()
public subroutine uf_init_travail (ref u_transaction atr_trans, ref datawindow adw_tr_travail, ref datawindow adw_tr_ddproduit, ref datawindow adw_tr_ddcorbeille, ref datawindow adw_tr_ddcodetat, ref datawindow adw_tr_ddcodtyprecu, ref datawindow adw_tr_ddcodrecu, ref datawindow adw_tr_ddcodiprov)
public function boolean uf_preparer_consulter (ref s_pass ast_pass)
public function string uf_titre ()
end prototypes

private subroutine uf_initialiser_dddw ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_travail
//* Fonction		:	uf_Initialiser_DdDw	(Private)
//* Auteur			:	Fabry JF
//* Date				:	16/12/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						qui appara$$HEX1$$ee00$$ENDHEX$$tront sur la Dw principale affichant le travail
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//*-----------------------------------------------------------------

DataWindowChild		dwChild


//*-----------------------------------------------------------------
//* Initialisation des DropDownDataWindow de la DW idw_Tr_Travail
//*-----------------------------------------------------------------


idw_Tr_Travail.GetChild ( "ID_PROD", dwChild )
idw_Tr_ddProduit.shareData ( dwChild )

idw_Tr_Travail.GetChild ( "ID_CORB", dwChild )
idw_Tr_ddCorbeille.shareData ( dwChild )

idw_Tr_Travail.GetChild ( "COD_ETAT", dwChild )
idw_Tr_ddCodEtat.shareData ( dwChild )

idw_Tr_Travail.GetChild ( "COD_TYP_RECU", dwChild )
idw_Tr_ddCodTypRecu.shareData ( dwChild )

idw_Tr_Travail.GetChild ( "COD_RECU", dwChild )
idw_Tr_ddCodRecu.shareData ( dwChild )

idw_Tr_Travail.GetChild ( "COD_I_PROV", dwChild )
idw_Tr_ddCodIProv.shareData ( dwChild )




end subroutine

public subroutine uf_init_travail (ref u_transaction atr_trans, ref datawindow adw_tr_travail, ref datawindow adw_tr_ddproduit, ref datawindow adw_tr_ddcorbeille, ref datawindow adw_tr_ddcodetat, ref datawindow adw_tr_ddcodtyprecu, ref datawindow adw_tr_ddcodrecu, ref datawindow adw_tr_ddcodiprov);//*-----------------------------------------------------------------
//*
//* Objet         :  u_Cs_Sp_Travail
//* Fonction		:	uf_Init_Travail  (PUBLIC)
//* Auteur			:	Fabry JF
//* Date				:	16/12/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation et instanciation des objets
//*                  de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des Travaux
//* Commentaires	:	
//*
//* Arguments		:  
//*						atr_trans						u_transaction  REF			Objet de transaction
//*						adw_Tr_Travail					DataWindow		REF			DataWindow affichant le travail, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddProduit				DataWindow		REF			DropDownDataWindow des Lib Long Produit, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddCorbeille			DataWindow		REF			DropDownDataWindow des Lib Corbeille, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddCodEtat				DataWindow		REF			DropDownDataWindow des Lib Code Etat, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddCodTypRecu			DataWindow		REF			DropDownDataWindow des Lib Code Type Recu, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddCodRecu				DataWindow		REF			DropDownDataWindow des Lib Code Recu, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*						adw_tr_ddCodIProv				DataWindow		REF			DropDownDataWindow des Lib Code inter Provenance, sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------


itrTrans					= atr_Trans							// Objet de transaction

idw_Tr_Travail			= adw_Tr_Travail					// Dw Travail sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddProduit		= adw_Tr_ddProduit				// dddw Produit sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddCorbeille	= adw_Tr_ddCorbeille				// dddw corbeille sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddCodEtat		= adw_Tr_ddCodEtat				// dddw CodEtat sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddCodTypRecu	= adw_Tr_ddCodTypRecu			// dddw CodTypRecu sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddCodRecu		= adw_Tr_ddCodRecu				// dddw CodRecu sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail
idw_Tr_ddCodIProv		= adw_Tr_ddCodIProv				// dddw CodIProv sur fen$$HEX1$$ea00$$ENDHEX$$tre Travail

//*-----------------------------------------------------------------
//* Initialisation des objets, Retrieve
//*-----------------------------------------------------------------

idw_Tr_Travail.SetTransObject ( itrTrans )

idw_Tr_ddProduit.SetTransObject ( itrTrans )
idw_Tr_ddProduit.Retrieve ( )

idw_Tr_ddCorbeille.SetTransObject ( itrTrans )
idw_Tr_ddCorbeille.Retrieve ("-CO")

idw_Tr_ddCodEtat.SetTransObject ( itrTrans )
idw_Tr_ddCodEtat.Retrieve ("-CE")

idw_Tr_ddCodTypRecu.SetTransObject ( itrTrans )
idw_Tr_ddCodTypRecu.Retrieve ("-CT")

idw_Tr_ddCodRecu.SetTransObject ( itrTrans )
idw_Tr_ddCodRecu.Retrieve ("-CR")

idw_Tr_ddCodIProv.SetTransObject ( itrTrans )
idw_Tr_ddCodIProv.Retrieve ("-IN")








end subroutine

public function boolean uf_preparer_consulter (ref s_pass ast_pass);//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_Travail
//* Fonction		:	uf_preparer_Consulter	(Public)
//* Auteur			:	Fabry JF
//* Date				:	16/12/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation du travail
//* Commentaires	:	
//*
//* Arguments		:	ast_Pass				s_Pass			REF				Structure de passage
//*                  
//*
//* Retourne		:	True / False
//*
//*-----------------------------------------------------------------

Boolean 	bRet = True


uf_Initialiser_DdDw ()				// Initialisation des DdDw pour la Dw affichant le travail


idw_Tr_Travail.Retrieve ( String ( ast_pass.ltab[ 1 ] ) )


Return bRet
end function

public function string uf_titre ();//*-----------------------------------------------------------------
//*
//* Objet			: U_Cs_Sp_Travail
//* Fonction		: Uf_Titre (PUBLIC)
//* Auteur			: JFF
//* Date				: 21/12/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne titre pour la fen$$HEX1$$ea00$$ENDHEX$$tre CONSULTATION TRAVAIL
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//*-----------------------------------------------------------------


String sRet, sNom, sLibLong,  sIdSin, sFiltre
Long   lIdProd, lRet

sNom			= idw_Tr_Travail.GetItemString ( 1, "NOM" )
sIdSin   	= idw_Tr_Travail.GetItemString ( 1, "ID_SIN" )
lIdProd		= idw_Tr_Travail.GetItemNumber ( 1, "ID_PROD" )



//*-----------------------------------------------------------------
//* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nom du produit sur idw_Tr_ddProduit $$HEX2$$e0002000$$ENDHEX$$l'aide 
//* d'un filtre
//*-----------------------------------------------------------------
sFiltre	= "ID_PROD = " + String ( lIdProd ) 
lret 		= idw_Tr_ddProduit.SetFilter ( sFiltre )
lret 		= idw_Tr_ddProduit.Filter ()

sLibLong	= idw_Tr_ddProduit.GetItemString ( 1, "LIB_LONG" )

sFiltre = ""
idw_Tr_ddProduit.SetFilter ( sFiltre )
idw_Tr_ddProduit.Filter ()




//*-----------------------------------------------------------------
//* construction du titre.
//*-----------------------------------------------------------------
sRet =	sLIbLong									+ " (" 					+ &
			String ( lIdProd )					+ ") / Sinistre N$$HEX2$$b0002000$$ENDHEX$$"	+ &
			sIdSin									+ " / "  				+ &
			sNom										+ " "						




Return ( sRet )
end function

on u_cs_sp_travail.create
TriggerEvent( this, "constructor" )
end on

on u_cs_sp_travail.destroy
TriggerEvent( this, "destructor" )
end on

