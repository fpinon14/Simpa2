HA$PBExportHeader$n_cst_attrib_rdc.sru
$PBExportComments$[RUEDUCOMMERCE]
forward
global type n_cst_attrib_rdc from nonvisualobject
end type
end forward

global type n_cst_attrib_rdc from nonvisualobject
end type
global n_cst_attrib_rdc n_cst_attrib_rdc

type variables
public:
datawindowchild	idwMarques
decimal				idcMtpec  
datawindow			idwDetPro
integer				iiIdProd

string isRefFour
string isMarqArt
string isModlArt
string isRefFdp
string isCodePays
decimal idcMtTTCCmde

protected:

string  isSaisie
end variables

forward prototypes
public subroutine uf_setparams (ref datawindow adwsaisie)
public function string uf_getsaisie ()
end prototypes

public subroutine uf_setparams (ref datawindow adwsaisie);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_rdc::uf_setparams
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 13:45:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: ref datawindow adwsaisie	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

isSaisie = "OK"

isReffour = adwsaisie.GetItemString(1,"ID_REF_FOUR")
ismarqart = adwsaisie.GetItemString(1,"ID_MARQ_ART")
ismodlart = adwsaisie.GetItemString(1,"ID_MODL_ART")
isreffdp = adwsaisie.GetItemString(1,"REF_FDP")
iscodepays = adwsaisie.GetItemString(1,"CODE_PAYS")
idcMtTTCCmde = adwsaisie.getitemnumber(1,"MT_TTC_CMDE")

end subroutine

public function string uf_getsaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_rdc::uf_getsaisie
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 13:47:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if isSaisie = "OK" Then
	isSaisie = "ID_REF_FOUR=" + isreffour
	isSaisie += ";ID_MARQ_ART=" + ismarqart
	isSaisie += ";ID_MODL_ART=" + ismodlart
	isSaisie += ";MT_TTC_CMDE=" + string(idcmtttccmde,"######.00")
	isSaisie += ";REF_FDP=" + isReffdp
	isSaisie += ";CODE_PAYS=" + isCodepays
End if

Return isSaisie
end function

on n_cst_attrib_rdc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_attrib_rdc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_attrib_rdc
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 13:50:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

isSaisie = "[ANNULER]"
end event

