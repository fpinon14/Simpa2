HA$PBExportHeader$n_cst_attrib_key.sru
$PBExportComments$[O2M] Attribut Descripteur de Cl$$HEX1$$e900$$ENDHEX$$, a utiliser avec F_RechDetPro_withKey ( Permet de d$$HEX1$$e900$$ENDHEX$$crire une cl$$HEX2$$e9002000$$ENDHEX$$de la forme "Key=Value" )
forward
global type n_cst_attrib_key from nonvisualobject
end type
end forward

global type n_cst_attrib_key from nonvisualobject autoinstantiate
end type

type variables
public:
string	isKeyName
any		iaKeyValue

end variables

forward prototypes
public function string uf_getstringkey ()
end prototypes

public function string uf_getstringkey ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_key::uf_getstringkey
//* Auteur			: Pierre-Henri Gillot
//* Date				: 10/12/2007 13:26:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [O2M]: REtourne la cl$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$crite sous forme de chaine
//*					  "Key=Value"
//*
//* Arguments		: 
//*
//* Retourne		: string : La chaine "isKeyName=iaKeyValue" si KeyName d$$HEX1$$e900$$ENDHEX$$fini;
//*					  NULL sinon.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

n_cst_string lnv_string
string sValue
sValue = string(iaKeyValue)
if lnv_string.of_IsEmpty(sValue) Then sValue = ""
if lnv_string.of_IsEmpty(isKeyName) Then SetNull(sValue) // La chaine retourn$$HEX2$$e9002000$$ENDHEX$$sera nulle

return upper(isKeyName)+"="+sValue

end function

on n_cst_attrib_key.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_attrib_key.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

