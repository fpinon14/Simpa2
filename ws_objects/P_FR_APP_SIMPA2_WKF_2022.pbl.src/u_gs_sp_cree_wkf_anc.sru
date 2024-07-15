HA$PBExportHeader$u_gs_sp_cree_wkf_anc.sru
$PBExportComments$---} User Object anc$$HEX1$$ea00$$ENDHEX$$tre pour la gestion permettant d'armer iTrTrans et dw_1 en instance.
forward
global type u_gs_sp_cree_wkf_anc from nonvisualobject
end type
end forward

global type u_gs_sp_cree_wkf_anc from nonvisualobject
end type
global u_gs_sp_cree_wkf_anc u_gs_sp_cree_wkf_anc

type variables
Protected :
	u_Transaction		itrTrans
	u_DataWindow		idw_wTravail

	String			isSysadm = "sysadm."
	String			isRepWin

	u_Onglets		iUoOng
	StaticText		istPochette
	StaticText		istMessage


end variables

forward prototypes
protected subroutine uf_init_repwin ()
public subroutine uf_initialisation (ref u_datawindow adw_travail, ref u_transaction atrtrans, ref u_onglets auonglet, ref statictext astpochette, ref statictext astMessage)
end prototypes

protected subroutine uf_init_repwin ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf_Anc::Uf_Init_RepWin (PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 04/06/1998 15:16:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise le nom du r$$HEX1$$e900$$ENDHEX$$pertoire WINDOWS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String sRepWin

//u_DeclarationFuncky uoDeclarationFuncky

//uoDeclarationFuncky = Create u_DeclarationFuncky

//sRepWin = uoDeclarationFuncky.Uf_WinDir ()

//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On initialise une variable d'instance qui contient le            */
/* r$$HEX1$$e900$$ENDHEX$$pertoire de Windows. Cette variable sera utilis$$HEX1$$e900$$ENDHEX$$e pour la      */
/* gestion des fichiers de Trace.                                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//isRepWin			= sRepWin + "\TEMP\"
isRepWin			= stGLB.sRepTempo

end subroutine

public subroutine uf_initialisation (ref u_datawindow adw_travail, ref u_transaction atrtrans, ref u_onglets auonglet, ref statictext astpochette, ref statictext astMessage);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf_Anc::Uf_Initialisation (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement pour le travail
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*					  u_Onglets					auOnglet			(R$$HEX1$$e900$$ENDHEX$$f)	Onglet
//*					  StaticText				astPochette    (R$$HEX1$$e900$$ENDHEX$$f) StaticText Indiquant l'ouverture d'une pochette ou pas DCMP990451
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//*-----------------------------------------------------------------

idw_wTravail	= adw_Travail
itrTrans			= atrTrans
iuoOng			= auOnglet
istPochette		= astPochette
istMessage		= astMessage

end subroutine

on u_gs_sp_cree_wkf_anc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_cree_wkf_anc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

