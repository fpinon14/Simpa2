HA$PBExportHeader$u_sp_zn_produit.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux produits
forward
global type u_sp_zn_produit from u_spb_zn_anc
end type
end forward

global type u_sp_zn_produit from u_spb_zn_anc
end type
global u_sp_zn_produit u_sp_zn_produit

forward prototypes
public function boolean uf_zn_verifrib (string asribbanque, string asribguichet, string asribcompte, string asribcle)
public function string uf_zn_completer (string aschamp, integer ailongueur)
public subroutine uf_zn_iddept (decimal adciddept, boolean abinit)
public subroutine uf_zn_cod_adh (string ascodadh)
public function boolean uf_zn_gestion_appareil (long aiidprod)
public function boolean uf_zn_gestion_echange_flux (long aiidprod)
public function boolean uf_zn_gestion_boutique (long aiidprod)
end prototypes

public function boolean uf_zn_verifrib (string asribbanque, string asribguichet, string asribcompte, string asribcle);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_VerifRib
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:29:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Verifie le RIB si toutes les composantes du RIB ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisies.
//* Commentaires	:	Utilise la fonction F_RIB()
//*
//* Arguments		: String			asRibBanque				( Val ) Rib de la Banque
//*					  String       asRibGuichet         ( Val ) Rib du guichet
//*                 String       asRibCompte          ( Val ) Rib du compte
//*                 String       asRibCle             ( Val ) Rib de la cl$$HEX1$$e900$$ENDHEX$$
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en		TRUE = RIB correct, ou toutes les zones n'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$
//*                              saisies (dans ce cas on ne contr$$HEX1$$f400$$ENDHEX$$le pas).
//*										FALSE = RIB incorrect
//*
//*-----------------------------------------------------------------

Boolean bRet			// Valeur de retour de la fonction.

bret = True

If not IsNull ( asRibBanque  ) and asRibBanque  <> "" and &
   not IsNull ( asRibGuichet ) and asRibGuichet <> "" and &
   not IsNull ( asRibCompte  ) and asRibCompte  <> "" and &
   not IsNull ( asRibCle     ) and asRibCle     <> "" then
	
	bRet = f_rib ( asRibBanque, asRibGuichet, asRibCompte, asRibCle )

End If

Return ( bRet )
end function

public function string uf_zn_completer (string aschamp, integer ailongueur);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_completer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:24:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Compl$$HEX1$$e800$$ENDHEX$$te le champ pass$$HEX2$$e9002000$$ENDHEX$$en parametre avec n ZERO.
//* Commentaires	:	
//*
//* Arguments		:	String		asChamp		( Val ) Valeur du champ
//*                	Integer     aiLongueur	( Val ) Longueur $$HEX2$$e0002000$$ENDHEX$$compl$$HEX1$$e800$$ENDHEX$$ter
//*
//* Retourne		: String			 	Le champ compl$$HEX1$$e800$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$si asChamp <> ""
//*											"" sinon.
//*-----------------------------------------------------------------

String 	sRet 		= ""		// Valeur de retour de la fonction.
String 	sFormat 	= ""		// Format du champ $$HEX2$$e0002000$$ENDHEX$$completer.
Integer 	iLong					// Indice de boucle pour construire le format.

For iLong = 1 To (aiLongueur - Len ( asChamp ) )

	sFormat = sFormat + "0"

Next


if asChamp <> "" then


	sRet = sFormat + asChamp

End If

Return ( sRet )	
end function

public subroutine uf_zn_iddept (decimal adciddept, boolean abinit);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_IdDept
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	20/06/1997 16:29:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Filtre une DDDw en fonction du parametre.
//* Commentaires	:	
//*
//* Arguments		:	decimal		adcIdDept	( Val ) Code departement choisi.
//*						Boolean		abInit		( Val ) flag pour la r$$HEX1$$e900$$ENDHEX$$init de ID_DEPTS.
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//* #1	FPI	20/05/2009	[200905201431] Changement du filtre sur les secteurs
//*----------------------------------------------------------------


DataWindowChild	dwIdDepts	// DropDownDataWindow des codes de sous d$$HEX1$$e900$$ENDHEX$$partements.

Decimal{0}			dcBorneInf	// Borne mini dept
Decimal{0}			dcBorneSup	// Borne max dept

String				sFiltre		// Filtre $$HEX2$$e0002000$$ENDHEX$$positionner sur la DDDw des sous d$$HEX1$$e900$$ENDHEX$$partements.

sFiltre = ""

idw_1.GetChild ( "ID_DEPTS" , dwIdDepts )

dcBorneInf = Truncate ( adcIdDept / 10, 0 ) * 10
dcBorneSup = dcBorneInf + 9

//sFiltre = "ID_DEPT >= " + String ( dcBorneInf ) + "AND ID_DEPT <= " + String ( dcBorneSup )
sFiltre = "ID_DEPT > " + String ( dcBorneInf ) + "AND ID_DEPT <= " + String ( dcBorneSup )	// #1

dwIdDepts.SetFilter ( sFiltre )
dwIdDepts.Filter    ( )

If abInit Then	idw_1.SetItem ( 1, "ID_DEPTS", stNul.dcm )
end subroutine

public subroutine uf_zn_cod_adh (string ascodadh);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_Cod_Adh ( public )
//* Auteur			:	DBI
//* Date				:	13/07/1998	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Mise $$HEX2$$e0002000$$ENDHEX$$jour des colonnes li$$HEX1$$e900$$ENDHEX$$es au cod_adh en fonction de la valeur de ce dernier
//* Commentaires	:	
//*
//* Arguments		:	String		asCodAdh		( val ) code_adh saisi
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

String		sAccesZone[]

/*----------------------------------------------------------------------------*/
/* Je ne g$$HEX1$$e800$$ENDHEX$$re pas la protection des zones  "COD_BASE_DMS", "COD_PROD_DMS",    */
/* "COD_ADR_DMS",   "ALT_CREBQ_DMS"  car elles sont cach$$HEX1$$e900$$ENDHEX$$es si cod_adh <> 1   */
/*----------------------------------------------------------------------------*/

Choose Case asCodAdh

	Case '1','2','5'			// Gestion adh$$HEX1$$e900$$ENDHEX$$sion DMS, Gestion Adh$$HEX1$$e900$$ENDHEX$$sion SPB sans liaison DMS
									// ou Garantie 24

		sAccesZone[1] = "NB_ADHERENT"
		sAccesZone[2] = "DUR_PERRNV_ADH"
		sAccesZone[3] = "UNT_PERRNV_ADH"

		// On donne acc$$HEX1$$e800$$ENDHEX$$s aux zones li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la gestion des adh$$HEX1$$e900$$ENDHEX$$sions
		// et on les initialise	toute	

		iDw_1.uf_Proteger ( sAccesZone, '0' )
		
		iDw_1.SetItem ( 1, "NB_ADHERENT", 		stNul.dcm  )
		iDw_1.SetItem ( 1, "DUR_PERRNV_ADH",  	stNul.dcm  )
		iDw_1.SetItem ( 1, "UNT_PERRNV_ADH",   stNul.str  )
		iDw_1.SetItem ( 1, "COD_BASE_DMS", 		stNul.dcm  )
		// [DCMP080496] PHG le 16/08/2008 : Cod prod Dms est tjr actif et non remis a null
		//iDw_1.SetItem ( 1, "COD_PROD_DMS", 		stNul.dcm  )
		//
		iDw_1.SetItem ( 1, "COD_ADR_DMS",  		stNul.dcm  )
		iDw_1.SetItem ( 1, "ALT_CREBQ_DMS", 	'N' )

		iDw_1.SetColumn ( "NB_ADHERENT" )

	Case '3','4'	// Adh$$HEX1$$e900$$ENDHEX$$sions par carte

		sAccesZone[1] = "NB_ADHERENT"
		sAccesZone[2] = "DUR_PERRNV_ADH"
		sAccesZone[3] = "UNT_PERRNV_ADH"

		// On donne acc$$HEX1$$e800$$ENDHEX$$s aux zones li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la gestion des adh$$HEX1$$e900$$ENDHEX$$sions
		// et on les initialise	toute	

		iDw_1.uf_Proteger ( sAccesZone, '1' )
		
		iDw_1.SetItem ( 1, "NB_ADHERENT", 		1  )
		iDw_1.SetItem ( 1, "DUR_PERRNV_ADH",  	0  )
		iDw_1.SetItem ( 1, "UNT_PERRNV_ADH",   'J'  )
		iDw_1.SetItem ( 1, "COD_BASE_DMS", 		stNul.dcm  )
		iDw_1.SetItem ( 1, "COD_PROD_DMS", 		stNul.dcm  )
		iDw_1.SetItem ( 1, "COD_ADR_DMS",  		stNul.dcm  )
		iDw_1.SetItem ( 1, "ALT_CREBQ_DMS", 	'N' )

End Choose
end subroutine

public function boolean uf_zn_gestion_appareil (long aiidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_gestion_appareil
//* Auteur			:	JCA
//* Date				:	06/02/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle l'existence des options det_pro 25 et 28
//*
//* Arguments		:	long		aiIdProd	
//*
//* Retourne		:	boolean
//*
//*-----------------------------------------------------------------

Integer iRetGa
Boolean bRet

bRet = true

iRetGa = SQLCA.PS_S01_GESTION_APPAREIL_V00 ( aiIdProd )
if iRetGa < 2 then bRet = false

return bRet
end function

public function boolean uf_zn_gestion_echange_flux (long aiidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_gestion_echange_flux
//* Auteur			:	JCA
//* Date				:	06/02/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle l'existence de commande
//*
//* Arguments		:	long		aiIdProd	
//*
//* Retourne		:	boolean
//*
//*-----------------------------------------------------------------

Integer iRetGef
Boolean bRet

bRet = true

iRetGef = SQLCA.PS_S01_GESTION_ECHANGE_FLUX_V00 ( aiIdProd )
if iRetGef <= 0 then	bRet = false

return bRet
	

end function

public function boolean uf_zn_gestion_boutique (long aiidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_gestion_boutique
//* Auteur			:	JCA
//* Date				:	06/02/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle l'existence de boutique
//*
//* Arguments		:	long		aiIdProd	
//*
//* Retourne		:	boolean
//*
//*-----------------------------------------------------------------

Integer iRetGef
Boolean bRet

bRet = true

iRetGef = SQLCA.PS_S01_GESTION_BOUTIQUE_V00 ( aiIdProd  )
if iRetGef <= 0 then	bRet = false

return bRet
	

end function

on u_sp_zn_produit.create
call super::create
end on

on u_sp_zn_produit.destroy
call super::destroy
end on

