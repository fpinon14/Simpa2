HA$PBExportHeader$u_sp_gs_type_carte.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux types de cartes
forward
global type u_sp_gs_type_carte from u_spb_gs_anc
end type
end forward

global type u_sp_gs_type_carte from u_spb_gs_anc
end type
global u_sp_gs_type_carte u_sp_gs_type_carte

forward prototypes
public function boolean uf_gs_sup_typecarte (string asidtypecarte)
public function boolean uf_gs_id_type_carte (string asidtypecarte)
end prototypes

public function boolean uf_gs_sup_typecarte (string asidtypecarte);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gs_Sup_Type_Carte
//* Auteur			: YP
//* Date				: 04/09/1997 14:20:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rification de l'absence de carte en relation
//*					  avec le type de carte avant suppression de 
//*					  celui-ci.
//* Commentaires	: 
//*
//* Arguments		: String		asIdTypeCarte	//Identifiant du Type 
//*														//de Carte $$HEX2$$e0002000$$ENDHEX$$supprimer
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Boolean 	bRet 		= True			//Valeur de retour de la fonction
Long 		lNbCarte	= 0				//Nombre de carte en relation avec
											//le type de cartes

/*------------------------------------------------------------------*/
/* Recherche du nombre de cartes en relation avec le type de carte. */
/*------------------------------------------------------------------*/

lNbCarte = itrTrans.IM_S04_CARTE ( asIdTypeCarte )

If ( lNbCarte > 0 ) Or Not f_procedure ( stMessage , itrTrans , "IM_S04_CARTE" ) Then bRet = False

Return ( bRet )

end function

public function boolean uf_gs_id_type_carte (string asidtypecarte);//*-----------------------------------------------------------------
//*
//* Fonction		: UF_GS_ID_TYPE_CARTE
//* Auteur			: YP
//* Date				: 04/09/1997 12:24:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					  Types de Cartes
//* Commentaires	: 
//*
//* Arguments		: String		asIdTypeCarte		//Identifiant du type de carte.
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*									
//*
//*-----------------------------------------------------------------

Boolean	bRet				= True		//Variable de retour de la fonction
String	sLibTypeCarte	= ""			//Libell$$HEX2$$e9002000$$ENDHEX$$du type de carte correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant 
												//pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre


/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un type de carte avec l'identifiant   */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre                                               */
/*------------------------------------------------------------------*/

itrTrans.IM_S01_TYPE_CARTE ( asIdTypeCarte , sLibTypeCarte )
 
If Not f_procedure ( stMessage, itrTrans , "IM_S01_TYPE_CARTE" ) Then

	Return ( false )

End If

/*------------------------------------------------------------------*/
/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
/*------------------------------------------------------------------*/
If sLibTypeCarte <> "" Then


	stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Types de Cartes"
	stMessage.sVar[1] = asIdTypeCarte
	stMessage.sVar[2] = "au type de carte"
	stMessage.sVar[3] = sLibTypeCarte
	stMessage.sCode	= "REFU001"

	bRet					= False

	f_Message ( stMessage )


End If

Return ( bRet )
end function

on u_sp_gs_type_carte.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_type_carte.destroy
TriggerEvent( this, "destructor" )
end on

