HA$PBExportHeader$u_spb_gs_codes_num.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux codes num$$HEX1$$e900$$ENDHEX$$riques.
forward
global type u_spb_gs_codes_num from u_spb_gs_anc
end type
end forward

global type u_spb_gs_codes_num from u_spb_gs_anc
end type
global u_spb_gs_codes_num u_spb_gs_codes_num

forward prototypes
public function string uf_gs_sup_code (string asidtypcode, long adcidcode)
end prototypes

public function string uf_gs_sup_code (string asidtypcode, long adcidcode);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_code
//* Auteur			:	YP
//* Date				:	14/08/97 15:57:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de contrainte 
//*					 	d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$en fontion du type de code, pour la 
//*					 	suppression d'un code.
//* Commentaires	:	
//*
//* Arguments		:	String		asIdTypCode	// Type de code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*						Long			adcIdCode	// Code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*														
//* Retourne		: String		"" --> la suppression est possible
//*									Type d'information en relation avec le
//*									code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*
//*-----------------------------------------------------------------

String	 sProcedure					// Nom de la procedure declenchee.
String	 sRet 			= ""		// Valeur de retour de la fonction correspondant au 
											// type d'informations en relation avec le code

Long 		lNbCode						// Nombre de code en relation.


Choose Case Upper ( asIdTypCode )

	Case "+PC" 

		/*------------------------------------------------------------------*/
		/* Recherche si ce code pi$$HEX1$$e800$$ENDHEX$$ces est li$$HEX1$$e800$$ENDHEX$$s a une garantie.             */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_PIECE ( adcIdCode, lNbCode )

		sRet			= "des pieces d'une garantie"
		sProcedure	= "IM_S02_PIECE"

	Case "+RE" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de Garanties en relation avec le code        */
		/* des natures d'exlusions.                                         */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S01_MOTIF ( adcIdCode, lNbCode )

		sRet	= "des motifs de refus d'une garantie"
		sProcedure	= "IM_S01_MOTIF"


	Case "+TR" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garanties en relation avec les codes:     */
		/* - Territorialit$$HEX50$$e9002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_CODE_CONDITION ( asIdTypCode, adcIdCode, lNbCode )		

		sRet	= "des conditions"
		sProcedure	= "IM_S02_CODE_CONDITION"

	Case "+DT" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garanties en relation avec les codes:     */
		/* - D$$HEX1$$e900$$ENDHEX$$tail sinistre                                                */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_CODE_CONDITION ( asIdTypCode, adcIdCode, lNbCode )		

		sRet	= "des conditions"
		sProcedure	= "IM_S02_CODE_CONDITION"

	Case "+EV" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garanties en relation avec les codes:     */
		/* - Ev$$HEX1$$e800$$ENDHEX$$nement                                                      */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_CODE_CONDITION ( asIdTypCode, adcIdCode, lNbCode )		

		sRet	= "des conditions"
		sProcedure	= "IM_S02_CODE_CONDITION"

	Case "+NS" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garanties en relation avec les codes:     */
		/* - Nature de Sinistre                                             */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_CODE_CONDITION ( asIdTypCode, adcIdCode, lNbCode )		

		sRet	= "des conditions"
		sProcedure	= "IM_S02_CODE_CONDITION"
	
	Case "-NO" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de r$$HEX1$$e900$$ENDHEX$$vision en relation avec les codes:      */
		/* - Niveau op$$HEX1$$e900$$ENDHEX$$rateur                                               */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S05_PRODUIT ( adcIdCode, lNbCode )

		sRet	= "des produits"
		sProcedure	= "IM_S05_PRODUIT"

	Case "-GS" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garantie en relation avec les codes:      */
		/* - Groupe statistique                                             */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S02_CODE_GARANTIE ( adcIdCode, lNbCode )

		sRet	= "des garanties"
		sProcedure	= "IM_S02_CODE_GARANTIE"

	Case "-GA" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de garantie en relation avec les codes:      */
		/* - Code Garantie                                                  */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S03_CODE_GARANTIE ( adcIdCode, lNbCode )

		sRet	= "des garanties"
		sProcedure	= "IM_S03_CODE_GARANTIE"

	Case "-CO" 

		/*------------------------------------------------------------------*/
		/* Recherche du nombre de produit en relation avec les codes:       */
		/* - Corbeille                                                      */
		/*	suivant le type de code pass$$HEX2$$e9002000$$ENDHEX$$en argument                        */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S04_PRODUIT ( adcIdCode, lNbCode )

		sRet	= "des produits"
		sProcedure	= "IM_S04_PRODUIT"

	Case "-FR" 

		/*------------------------------------------------------------------*/
		/* Recherche si le code franchise a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affect$$HEX4$$e9002000e0002000$$ENDHEX$$une garantie.     */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S01_FRANCHISE ( adcIdCode, lNbCode )

		sRet	= "des franchises d'une garantie"
		sProcedure	= "IM_S01_FRANCHISE"

	Case "-CL","-CI"

		MessageBox("ATTENTION !!" , "Les tables W_SIN, W_INTER et PERSONNE n'existe pas encore, le contr$$HEX1$$f400$$ENDHEX$$le d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX4$$e9002000e0002000$$ENDHEX$$la suppression n'est pas ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$. Suppression autoris$$HEX1$$e900$$ENDHEX$$e" )


End Choose

If ( lNbCode = 0 ) And f_Procedure ( stMessage, itrTrans, sProcedure ) Then sRet = ""

Return ( sRet )

end function

on u_spb_gs_codes_num.create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_codes_num.destroy
TriggerEvent( this, "destructor" )
end on

