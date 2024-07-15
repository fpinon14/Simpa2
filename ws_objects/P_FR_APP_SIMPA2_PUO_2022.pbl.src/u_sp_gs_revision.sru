HA$PBExportHeader$u_sp_gs_revision.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux r$$HEX1$$e900$$ENDHEX$$visions
forward
global type u_sp_gs_revision from u_spb_gs_anc
end type
end forward

global type u_sp_gs_revision from u_spb_gs_anc
end type
global u_sp_gs_revision u_sp_gs_revision

forward prototypes
public function string uf_gs_sup_revision (long adcidprod, long adcidrev)
public function boolean uf_gs_datedebut (date addteeff, u_datawindow adwlstrev, ref string ascodemess)
end prototypes

public function string uf_gs_sup_revision (long adcidprod, long adcidrev);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_revision
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 17:23:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de sinistre en relation
//*					 	avec la r$$HEX1$$e900$$ENDHEX$$vision du produit avant suppression de celle-ci.
//* Commentaires	:	
//*
//* Arguments		:	Long			adcIdProd	// Identifiant du produit concern$$HEX1$$e900$$ENDHEX$$.
//*					 	Long			adcIdRev		// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision
//*														// $$HEX2$$e0002000$$ENDHEX$$supprimer.
//* Retourne		:	String		"" --> la suppression est possible
//*										Type d'information en relation avec la
//*										r$$HEX1$$e900$$ENDHEX$$vision $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*
//*-----------------------------------------------------------------

String	 sRet 			// Valeur de retour de la fonction correspondant au 
								// type d'informations en relation avec le groupe.

String	sWSinistre
String	sSinistre

Long 		lNbWSinistre	// Nombre de sinistre dans W_Sinistre en relation avec
								// le produit.
Long 		lNbSinistre		// Nombre de sinistre dans Sinistre en relation avec
								// le produit.


sRet         = ""
sWSinistre   = ""
sSinistre    = ""
lNbWSinistre = 0
lNbSinistre  = 0

/*------------------------------------------------------------------*/
/* Recherche du nombre de sinistres en relation avec la revision    */
/*------------------------------------------------------------------*/
MessageBox('Contr$$HEX1$$f400$$ENDHEX$$le sinistres existants' , "ATTENTION : Aucun contr$$HEX1$$f400$$ENDHEX$$le n'est effectu$$HEX2$$e9002000$$ENDHEX$$sur l'existence de dossier(s) sur ce produit et cette r$$HEX1$$e900$$ENDHEX$$vision" )
//itrTrans.PS_V01_REVISION ( adcIdProd, adcIdRev, lNbWSinistre, lNbWSinistre )

//If Not f_Procedure ( ) ......

/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/
If lNbWSinistre <> 0 then

	sWSinistre = "des sinistres dans W_SINISTRE"
   
	If lNbSinistre <> 0	then

		sWSinistre = sWSinistre + " et, "		

	End If

End if

If lNbSinistre <> 0	Then	sSinistre = "des sinistres dans SINISTRE"

sRet = sWSinistre + sSinistre

Return ( sRet )
end function

public function boolean uf_gs_datedebut (date addteeff, u_datawindow adwlstrev, ref string ascodemess);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_datedebut
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 17:26:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$termine si la valeur pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e900$$ENDHEX$$tre ( une date ) est sup$$HEX1$$e900$$ENDHEX$$rieur
//*					 	$$HEX2$$e0002000$$ENDHEX$$la date de d$$HEX1$$e900$$ENDHEX$$but de la r$$HEX1$$e900$$ENDHEX$$vision N-1 pour la m$$HEX1$$ea00$$ENDHEX$$me zone d'effet.
//* Commentaires	:	Une date de d$$HEX1$$e900$$ENDHEX$$but d'une nouvelle r$$HEX1$$e900$$ENDHEX$$vision doit $$HEX1$$ea00$$ENDHEX$$tre sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date 
//*						de d$$HEX1$$e900$$ENDHEX$$but	de l'ancienne r$$HEX1$$e900$$ENDHEX$$vision plus un jour.
//*
//* Arguments		:	Date			  adDteDeb	   ( Val )	 : date de d$$HEX1$$e900$$ENDHEX$$but d'effet.
//*					 	u_datawindow  adwLstRev    ( Val )   : liste des r$$HEX1$$e900$$ENDHEX$$vision du produit.
//*
//*
//* Retourne		:	Boolean
//*
//*-----------------------------------------------------------------
//* #1	JCA	02/06/2006	Conversion datetime en date pour appel fonction RelativeDate()
//* #2	PHG	25/09/2006	[DCMP060153] Test de la fermeture de la revision pr$$HEX1$$e900$$ENDHEX$$cedente 
//*  								pour le meme effet
//*-----------------------------------------------------------------

Boolean	bRet 			// Valeur de retour de la fonction.

Long 		lNbLig		// Nbre de ligne dans la aDwLstRev.
Long		lRet			// Le N$$HEX2$$b0002000$$ENDHEX$$de ligne trouv$$HEX1$$e900$$ENDHEX$$.

String	sCodEffRev	// Zone d'effet de la r$$HEX1$$e900$$ENDHEX$$vision en cr$$HEX1$$e900$$ENDHEX$$ation ou modification.
String	sIdRev		// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision courante.

Date 		dDteEff		// Date de d$$HEX1$$e900$$ENDHEX$$but d'effet de la r$$HEX1$$e900$$ENDHEX$$vision courante.
Date		dDteFin		// Date de Fin d'effet de la r$$HEX1$$e900$$ENDHEX$$vision courante. [DCMP060153]

// #1
datetime dtDe
date dDe
// #1 FIN
// #2 [DCMP060153]
datetime dtDf
date	dDf
// #2

bret		 = True
lNbLig	 = aDwLstRev.RowCount ()

//debug
//adwLstRev.SaveAs("c:\temp\adwLstRev.xls", Excel!, TRUE)
/*------------------------------------------------------------------*/
/* Si lNbLig = 0 alors il n'y a pas de r$$HEX1$$e900$$ENDHEX$$vision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente d$$HEX1$$e900$$ENDHEX$$finie  */
/*------------------------------------------------------------------*/
If lNbLig > 0	Then

	sCodEffRev	= iDw_1.GetItemString ( 1, "COD_EFF_REV" )

	sIdRev		= String ( iDw_1.GetItemNumber ( 1, "ID_REV" ) )

 	lRet = adwLstRev.Find ( "ID_REV <> " + sIdRev + " AND COD_EFF_REV='" + sCodEffRev + "'", lNbLig, 1 )

	/*------------------------------------------------------------------*/
	/* Si lRet = 0 alors il n'y a pas de r$$HEX1$$e900$$ENDHEX$$vision pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dante d$$HEX1$$e900$$ENDHEX$$finie    */
	/*------------------------------------------------------------------*/
	If lRet <> 0	Then
		
		// #1
		dtDe = aDwLstRev.GetItemDateTime ( lRet, "DTE_EFF" )
		dDe = date(dtde)
		// #1 FIN

		// #2
		dtDf = aDwLstRev.GetItemDateTime ( lRet, "DTE_FIN" )
		dDf = date(dtdf)
		// #2 FIN
		
		//dDteEff = RelativeDate ( aDwLstRev.GetItemDate ( lRet, "DTE_EFF" ), 1 )
		dDteEff = RelativeDate ( dDe, 1 )
		dDteFin = dDf

		If	( adDteEff  < dDteEff ) Then 	// Controle de l'ant$$HEX1$$e900$$ENDHEX$$riorit$$HEX2$$e9002000$$ENDHEX$$des dates d'effets respective entre la
													// revision N et revision N-1 pour le m$$HEX1$$ea00$$ENDHEX$$me effet
			bRet = False
			asCodeMess = 'REFU008'
		End If

		// #2 [DCMP060153]
		If	bret AND ( dDteFin <> 3000-01-01 )  Then 	// Controle de "l'ouverture" de la revision N-1 pour le m$$HEX1$$ea00$$ENDHEX$$me effet
			bRet = False
			asCodeMess = 'REFU010'
		End If
		//

	End If

End If

Return ( bRet )
end function

on u_sp_gs_revision.create
call super::create
end on

on u_sp_gs_revision.destroy
call super::destroy
end on

