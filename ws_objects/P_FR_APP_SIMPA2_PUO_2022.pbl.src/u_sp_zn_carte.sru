HA$PBExportHeader$u_sp_zn_carte.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux cartes
forward
global type u_sp_zn_carte from u_spb_zn_anc
end type
end forward

global type u_sp_zn_carte from u_spb_zn_anc
end type
global u_sp_zn_carte u_sp_zn_carte

forward prototypes
public function boolean uf_zn_longueurrang (string asrang)
public function boolean uf_zn_rangcarte (string asrangmini, string asrangmaxi)
end prototypes

public function boolean uf_zn_longueurrang (string asrang);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_LongueurRang
//* Auteur			: YP
//* Date				: 04/09/97 14:333:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le que le Rang de carte est bien compos$$HEX2$$e9002000$$ENDHEX$$de
//*                 16 chiffres.
//* Commentaires	: Aucun
//*
//* Arguments		: String			asRang				( Val )	Rang de la Carte
//*
//* Retourne		: Boolean			TRUE  = tout est OK
//*										   FALSE = le rang n'est pas compos$$HEX2$$e9002000$$ENDHEX$$de 16 chiffres.
//*-----------------------------------------------------------------

Return ( Len ( asRang ) = 16 )
end function

public function boolean uf_zn_rangcarte (string asrangmini, string asrangmaxi);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_RangCarte
//* Auteur			: YP
//* Date				: 04/09/97 14:35:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le que le rang mini est bien inf$$HEX1$$e800$$ENDHEX$$rieur au rang maxi
//* Commentaires	: aucun
//*
//* Arguments		: String			asRangMini				( Val )	Valeur du rang mini
//*                 String       asRangMaxi           ( Val ) Valeur du rang maxi
//*
//* Retourne		: Boolean		TRUE  = OK : rang mini <= rang maxi
//*										FALSE = pas OK : rang mini > rang maxi
//*
//*-----------------------------------------------------------------

return ( asRangMini <= asRangMaxi )
end function

on u_sp_zn_carte.create
TriggerEvent( this, "constructor" )
end on

on u_sp_zn_carte.destroy
TriggerEvent( this, "destructor" )
end on

