HA$PBExportHeader$n_cst_debug_struct_pb11.sru
$PBExportComments$Objet temporaire de d$$HEX1$$e900$$ENDHEX$$bugage du pb de retour de structure par une fct.
forward
global type n_cst_debug_struct_pb11 from nonvisualobject
end type
end forward

global type n_cst_debug_struct_pb11 from nonvisualobject autoinstantiate
end type

type variables
string isFicLog
boolean ibOkToCompare = FALSE
end variables

forward prototypes
public function boolean uf_compstplafondpec (s_plafond_pec astppeca, s_plafond_pec astppecb)
public subroutine uf_verifstruct (s_plafond_pec astplafpeca, s_plafond_pec astplafpecb, string sinfo)
end prototypes

public function boolean uf_compstplafondpec (s_plafond_pec astppeca, s_plafond_pec astppecb);boolean bComp

bComp = 	( aStpPecA.dcplafevt 			= aStpPecB.dcplafevt ) and &
				( aStpPecA.dcplafgti 				= aStpPecB.dcplafgti ) and &
				( aStpPecA.dcplafmtpec 			= aStpPecB.dcplafmtpec ) and &
				( aStpPecA.dcplafvalach			= aStpPecB.dcplafvalach ) and &
				( aStpPecA.dcplafvalpublique 	= aStpPecB.dcplafvalpublique ) and &
				( trim( aStpPecA.sPlafAutre ) 	= trim( aStpPecB.sPlafAutre ) ) and &
				( trim( aStpPecA.sTypParaVer)	= trim( aStpPecB.sTypParaVer ) )


return bComp


end function

public subroutine uf_verifstruct (s_plafond_pec astplafpeca, s_plafond_pec astplafpecb, string sinfo);//[BUG_STRUCTPB11]
if iboktocompare then
	If Not uf_compstplafondpec( astPlafPecA, astPlafPecB ) Then
		f_tracelog( isFicLog, "[DEBUG]", "Erreur de retour de fct avec structure : "+sInfo, stGlb)
	End If
End If

end subroutine

event constructor;n_cst_string lnvString

isFiclog = ProfileString(stglb.sfichierini,"APPLICATION", "FICHIER_LOG", "")
ibOkToCompare = Not lnvString.of_isEmpty( isFicLog)


end event

on n_cst_debug_struct_pb11.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_debug_struct_pb11.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

