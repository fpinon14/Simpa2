HA$PBExportHeader$u_sp_zn_confirmation.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux confirmation des courriers d'un produit.
forward
global type u_sp_zn_confirmation from u_spb_zn_anc
end type
end forward

global type u_sp_zn_confirmation from u_spb_zn_anc
end type
global u_sp_zn_confirmation u_sp_zn_confirmation

forward prototypes
public function boolean uf_zn_initconfirmation (string astext)
end prototypes

public function boolean uf_zn_initconfirmation (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_InitConfirmation
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	08/07/1997 10:10:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise certains champs en fonction d'une demande de confirmation. 
//* Commentaires	:	
//*
//* Arguments		:	String		asText			( Val ) Valeur de ALT_CONF.
//*
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

If asText = 'N'	Then


	iDw_1.SetItem ( 1, "ID_CONF_DEB", stNul.str  )
	iDw_1.SetItem ( 1, "ID_CONF_N", stNul.str  )
	iDw_1.SetItem ( 1, "ID_CONF_FIN", stNul.str  )

End If

Return ( True )
end function

on u_sp_zn_confirmation.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_confirmation.destroy
TriggerEvent( this, "destructor" )
end on

