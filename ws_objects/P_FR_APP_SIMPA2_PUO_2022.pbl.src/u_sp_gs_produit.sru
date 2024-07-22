HA$PBExportHeader$u_sp_gs_produit.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux produits
forward
global type u_sp_gs_produit from u_spb_gs_anc
end type
end forward

global type u_sp_gs_produit from u_spb_gs_anc
end type
global u_sp_gs_produit u_sp_gs_produit

forward prototypes
public subroutine uf_gs_courriernonaffectes (datawindow adwcible)
public function boolean uf_preparervalider (boolean abinsert)
public function string uf_gs_id_produit (long adcidprod)
public function boolean uf_gs_courriertypeexiste (datawindow adwsource, string asidcour)
public function string uf_gs_sup_produit (long adcidprod)
public function boolean uf_gs_longueur (string asidprod)
public function string uf_gestiontelephonie ()
public function boolean uf_gs_verif_compte ()
end prototypes

public subroutine uf_gs_courriernonaffectes (datawindow adwcible);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_CourrierNonAffectes
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 17:03:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il reste des courriers non affect$$HEX1$$e900$$ENDHEX$$s au produit et en 
//*                	avertit l'utilisateur, ce message est non bloquant, la validation peut
//*                	continuer.
//* Commentaires	: 
//*
//* Arguments		:	Datawindow	adwCible		( Val )	DataWindow cible des
//* 																   courriers non affect$$HEX1$$e900$$ENDHEX$$s.
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long		lNbrLig

lNbrLig = adwCible.RowCount ()

If lNbrLig > 0 then

	stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Produits"
	stMessage.sCode	= "GENE008"

	f_Message ( stMessage )

End If
end subroutine

public function boolean uf_preparervalider (boolean abinsert);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_PreparerValider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:36:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise les infos de mise $$HEX2$$e0002000$$ENDHEX$$jour d'un PRODUIT
//* Commentaires	:	
//*
//* Arguments		:	Bool$$HEX1$$e900$$ENDHEX$$en 	abInsert		-->   Vrai s'il on est en cr$$HEX1$$e900$$ENDHEX$$ation
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 					-->	Vrai : La validation peut 
//*														  	continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 		= True	//Valeur de retour de la fonction

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'un nouveau produit.                                */
/*------------------------------------------------------------------*/
If ( abInsert ) Then

		f_Creele ( iDw_1, 1 )		
	
End If

f_MajPar ( iDw_1, 1 )

Return ( bRet )
end function

public function string uf_gs_id_produit (long adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	UF_GS_ID_PRODUIT
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:37:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	produits.
//* Commentaires	:	
//*
//* Arguments		:	Long		adcIdProd		//Identifiant du produit
//*
//* Retourne		:	String    "" s'il n'existe pas de produit avec cet Identifiant
//*									sLibProduit si un produit existe
//*
//*-----------------------------------------------------------------

String  sLibCourt		// Libell$$HEX2$$e9002000$$ENDHEX$$du produit correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant 
							// pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre


sLibCourt	= space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un produit avec l'identifiant         */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre                                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S03_PRODUIT ( adcIdProd, slibCourt )

Return ( Trim ( sLibCourt ) )
end function

public function boolean uf_gs_courriertypeexiste (datawindow adwsource, string asidcour);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_courriertypeexiste
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:55:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste si l'Id Cour pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre existe dans la table COUR_TYPE
//* Commentaires	: 
//*
//* Arguments		: String			asIdCour			( Val )	Valeur de ID_COUR
//*
//* Retourne		: Boolean		True  = L'IdCour existe
//*										False = L'IdCour n'existe pas
//*
//*-----------------------------------------------------------------

DataWindowChild	dwcCour		// DropDownDataWindow des courriers types.
Boolean 				bRet			// Valeur de retour de la fonction.
Long					lNumLig		// Num$$HEX1$$e900$$ENDHEX$$ro de la ligne dans dwcCour.

bRet = False

/*------------------------------------------------------------------*/
/* Si on trouve le courrier type dans la DDDW, on renvoit TRUE.     */
/*------------------------------------------------------------------*/
adwSource.GetChild ( "ID_COUR" , dwcCour )

lNumLig = 	dwcCour.Find &
				( "ID_COUR = '"+ asIdCour + "'" , 1 , dwcCour.RowCount ( ) )

If lNumLig > 0 Then bRet = True

Return ( bRet )
end function

public function string uf_gs_sup_produit (long adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_produit
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:54:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de sinistre en relation
//*					 	avec le produit avant suppression de celui-ci.
//* Commentaires	:	
//*
//* Arguments		:	Long			adcIdProd	//Identifiant du produit
//*
//* Retourne		:	String		"" --> la suppression est possible
//*										Type d'information en relation avec le
//*										produit $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*								
//*-----------------------------------------------------------------
//* #1 JFF  12/12/2006   Ajout des delete manquant [DCMP060824]
//*-----------------------------------------------------------------

String	 sRet 			// Valeur de retour de la fonction correspondant au 
								// type d'informations en relation avec le groupe

String	sWSinistre		// Message pour table W_SINISTRE.
String	sSinistre		// Message pour table SINISTRE.

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
/* Recherche du nombre de sinistre en relation avec le produit      */
/*------------------------------------------------------------------*/
// D$$HEX1$$e900$$ENDHEX$$but #1
SELECT 	Count ( id_sin )
  INTO	:lNbSinistre
  FROM	sysadm.sinistre
 WHERE 	sysadm.sinistre.id_prod	= :adcIdProd
 USING		itrTrans;

SELECT 	Count ( id_sin )
  INTO	:lNbWSinistre
  FROM	sysadm.w_sin
 WHERE 	sysadm.w_sin.id_prod	= :adcIdProd
 USING		itrTrans;
// Fin #1

/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/
If lNbSinistre + lNbWSinistre > 0 Then sRet = "Sinistres pr$$HEX1$$e900$$ENDHEX$$sents"

Return ( sRet )

end function

public function boolean uf_gs_longueur (string asidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Gs_Longueur
//* Auteur			:	YP
//* Date				:	08/09/1997 16:45:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rifie que l'id du produit est bien sur 5 caract$$HEX1$$e800$$ENDHEX$$res.
//* Commentaires	:	
//*
//* Arguments		:	String		asIdProd		//Identifiant du produit
//*
//* Retourne		:	Boolean TRUE = Longueur OK ; FALSE Sinon
//*
//*-----------------------------------------------------------------
//*      JFF   12/05/2020 [PI085]
//*-----------------------------------------------------------------

// [PI085]

If F_CLE_A_TRUE ( "PI085" ) Then
	Return ( Len ( asIdProd ) = 7 )	
End If

Return ( Len ( asIdProd ) = 5 )
end function

public function string uf_gestiontelephonie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_GestionTelephonie (PUBLIC)
//* Auteur			:	FABRY JF
//* Date				:	18/05/2001 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	: 
//*
//* Arguments		:	
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------

String sRet, sCodAdh, sCodTel
sRet = ""

sCodAdh = iDw_1.GetItemString ( 1, "COD_ADH" )
sCodTel = String ( iDw_1.GetItemNumber ( 1, "COD_TEL" ) )

/*----------------------------------------------------------------------------*/
/* On ne peut choisir la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie avec ADH DMS que si le produit a ses      */
/* adh$$HEX1$$e900$$ENDHEX$$sions sur les bases DMS.                                               */
/*----------------------------------------------------------------------------*/
CHOOSE CASE sCodTel

	// T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie avec Adh DMS
	CASE "1"
		
		// Le produit doit donc $$HEX1$$ea00$$ENDHEX$$tre avec Adh$$HEX1$$e900$$ENDHEX$$sion DMS
		CHOOSE CASE sCodAdh

			CASE "1", "6"
				sRet = ""

			CASE ELSE
				sRet = "- Le type de gestion de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie mobile n'est pas en coh$$HEX1$$e900$$ENDHEX$$rence avec le type d'adh$$HEX1$$e900$$ENDHEX$$sion."

		END CHOOSE


END CHOOSE

Return sRet
end function

public function boolean uf_gs_verif_compte ();
 //*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_produit::uf_gs_verif_compte
//* Auteur			: F. Pinon
//* Date				: 07/12/2010 10:44:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [20101207.FPI]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bRet
String sValRib[]

sValRib[1] = idw_1.getItemString(1,"RIB_BQ")
sValRib[2] = idw_1.getItemString(1,"RIB_GUI")
sValRib[3] = idw_1.getItemString(1,"RIB_CPT")
sValRib[4] = idw_1.getItemString(1,"RIB_CLE")

bRet=(itrtrans.PS_S01_VERIF_COMPTE(stGlb.scodappli ,sValRib[1] ,sValRib[2] ,sValRib[3] ,sValRib[4] ) > 0)

Return bRet


end function

on u_sp_gs_produit.create
call super::create
end on

on u_sp_gs_produit.destroy
call super::destroy
end on

