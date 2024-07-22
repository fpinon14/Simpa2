HA$PBExportHeader$u_sp_gs_code_condition.sru
$PBExportComments$-} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux codes condition.
forward
global type u_sp_gs_code_condition from u_spb_gs_anc
end type
end forward

global type u_sp_gs_code_condition from u_spb_gs_anc
end type
global u_sp_gs_code_condition u_sp_gs_code_condition

forward prototypes
public function string uf_presencecodecondition ()
end prototypes

public function string uf_presencecodecondition ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_PresenceCodeCondition
//* Auteur			:	YP
//* Date				:	10/11/1997 09:48:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins une nature de sinistre, une territorialit$$HEX1$$e900$$ENDHEX$$,
//*						un d$$HEX1$$e900$$ENDHEX$$tail de sinistre pour le produit. Test non bloquant.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String sMessage : Le message $$HEX1$$e900$$ENDHEX$$ventuel constitu$$HEX1$$e900$$ENDHEX$$.
//*
//*-----------------------------------------------------------------
String		sMessage		// Message d'erreur en cas d'absence d'un code condition.


iDw_1.SetFilter	( ""	)
iDw_1.Filter		(		)


/*------------------------------------------------------------------*/
/* Y a t-il une nature de sinistre pour le produit ?                */
/*------------------------------------------------------------------*/
If ( iDw_1.Find ( "ID_TYP_CODE = '+NS' AND ID_GTI=-1", 1, iDw_1.RowCount() ) = 0 ) Then


		sMessage = "- Il n'y a aucune nature de sinistre.~r~n"

End If

/*------------------------------------------------------------------*/
/* Y a t-il une territorialit$$HEX2$$e9002000$$ENDHEX$$pour le produit ?                    */
/*------------------------------------------------------------------*/
If ( iDw_1.Find ( "ID_TYP_CODE = '+TR' AND ID_GTI=-1", 1, iDw_1.RowCount() ) = 0 ) Then

	sMessage = sMessage + "- Il n'y a aucune territorialit$$HEX1$$e900$$ENDHEX$$.~r~n"

End If

/*------------------------------------------------------------------*/
/* Y a t-il un d$$HEX1$$e900$$ENDHEX$$tail de sinistre pour le produit?                  */
/*------------------------------------------------------------------*/
If ( iDw_1.Find ( "ID_TYP_CODE = '+DT' AND ID_GTI=-1", 1, iDw_1.RowCount() ) = 0 ) Then

	sMessage = sMessage + "- Il n'y a aucun d$$HEX1$$e900$$ENDHEX$$tail de sinistre.~r~n"

End If


Return ( sMessage )


end function

on u_sp_gs_code_condition.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_code_condition.destroy
TriggerEvent( this, "destructor" )
end on

