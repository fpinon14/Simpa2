$PBExportHeader$u_transaction.sru
forward
global type u_transaction from u_trans_anc
end type
end forward

global type u_transaction from u_trans_anc
end type
global u_transaction u_transaction

type prototypes
subroutine DW_I01_MOTIF(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdMotif,string sIdPara,string sCodTypMotif,string sCodNatMotif,datetime dtCreeLe,datetime dtMajLe,string sMajPar, long dcCptTri ) RPCFUNC ALIAS FOR "sysadm.DW_I01_MOTIF"
subroutine DW_I01_PIECE(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdPce,string sIdPara,string sCodTypPce,datetime dtCreeLe,datetime dtMajLe,string sMajPar, long dcCptTri ) RPCFUNC ALIAS FOR "sysadm.DW_I01_PIECE"
subroutine DW_I01_CODECAR(string sIdTypCode,ref string sIdCode,string sLibCode,datetime dtCreeLe,datetime dtMajLe,string sMajPar,string sNomCompteur) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODECAR"
subroutine IM_S01_CODECAR(string sIdTypCode,string sIdCode,ref string sLibCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODECAR"
subroutine IM_S01_CODE(string sIdTypCode,string sIdCode,ref string sLibCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODE"
subroutine IM_S01_COURRIER(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_COURRIER"
subroutine IM_S01_DELAI(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_DELAI"
subroutine IM_S01_FRANCHISE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_FRANCHISE"
subroutine IM_S01_PLAFOND(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_PLAFOND"
subroutine IM_S02_CODE_GARANTIE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_CODE_GARANTIE"
subroutine IM_S03_CODE_GARANTIE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S03_CODE_GARANTIE"
subroutine IM_S01_MOTIF(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_MOTIF"
function long IM_S01_CARTE(long dcIdGrp) RPCFUNC ALIAS FOR "sysadm.IM_S01_CARTE"
subroutine IM_S01_ETABLISSEMENT(long dcIdProd,long dcIdEts, Ref integer iSinistre ) RPCFUNC ALIAS FOR "sysadm.IM_S01_ETABLISSEMENT"
subroutine ETABLISSEMENT_C1(long dcIdEts,ref string sLibEts) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C1"
subroutine ETABLISSEMENT_C2(ref string sLibAg,ref string sAdr1,ref string sAdr2,ref string sAdrCp,ref string sAdrVille,string sCodBq,string sCodAg) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C2"
subroutine ETABLISSEMENT_C3(long dcIdEts,ref long iNbProd) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C3"
subroutine IM_S02_PIECE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_PIECE"
subroutine IM_S02_MOTIF(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_MOTIF"
subroutine IM_S02_CODE_CONDITION(string sIdTypCode,long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_CODE_CONDITION"
subroutine IM_S02_COMPOSITION(string sIdPara,ref long iNbCompo) RPCFUNC ALIAS FOR "sysadm.IM_S02_COMPOSITION"
subroutine IM_S03_MOTIF(string sIdPara,ref long iNbNatEx) RPCFUNC ALIAS FOR "sysadm.IM_S03_MOTIF"
subroutine IM_S03_PIECE(string sIdPara,ref long iNbPiece) RPCFUNC ALIAS FOR "sysadm.IM_S03_PIECE"
subroutine IM_S01_PARAPROD(string sIdPara,ref long iNbProd) RPCFUNC ALIAS FOR "sysadm.IM_S01_PARAPROD"
subroutine DW_I01_PRODUIT(long dcIdProd,long dcIdDept,long dcIdGrp,string sLibCourt,string sLibLong,long dcCodRevSurv,long dcCodRevSous,long dcCodRevRnv,long dcCodNivOpe,long dcDurPerrnvAdh,string sUntPerrnvAdh,string sCodModeReg,string sLibBqDebit,string sRibBq,string sRibGui,string sRibCpt,string sRibCle,string sCodDestReg,string sCodAdh,long dcIdCorb,long dcIdPolice,string sNumTel,string sNumFax,long dcIdDepts,long dcCodBaseDms,long dcCodAdrDms,long dcCodProdDms,string alt_crebq_dms, long dcNbAdherent, datetime dtCreeLe,datetime dtMajLe,string sMajPar,long dcCodEuro,string sAltInfoProv,string sAltRl1,long dcDurRl1Min,long dcDurRl1Max,string sUntRl1,string sAltRl2,long dcDurRl2,string sUntRl2,string sAltSold,long dcDurSoldRl,string sUntSoldRl,long dcDurSoldPc,string sUntSoldPc,string sAltContact,long iCodTel,string sAltOuvFenVal,string sAltCmdMobile,  string sIdProdClient, string sAltCodBoutique) RPCFUNC ALIAS FOR "sysadm.DW_I01_PRODUIT"
subroutine IM_S03_PRODUIT(long dcIdProd,ref string sLibCourt) RPCFUNC ALIAS FOR "sysadm.IM_S03_PRODUIT"
subroutine IM_S04_PRODUIT(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S04_PRODUIT"
subroutine IM_S05_PRODUIT(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S05_PRODUIT"
subroutine IM_I01_CONDITION(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_CONDITION"
subroutine IM_I01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_GARANTIE"
subroutine IM_I01_MOTIF(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_MOTIF"
subroutine IM_I01_PIECE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_PIECE"

// [MIGPB11] [EMD] : Debut Migration : Report SUISSE : Les params (dtDteEff et dtDteFin) peuvent être du format date. Or SNC ne gère pas ce cas pour résoudre le Pb on le passe en string SQL fait le transtypage
//subroutine DW_I01_REVISION(long dcIdProd,long dcIdRev,string sLibRev,string sCodEffRev,datetime dtDteEff,datetime dtDteFin,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_REVISION"
subroutine DW_I01_REVISION(long dcIdProd,long dcIdRev,string sLibRev,string sCodEffRev,string dtDteEff,string dtDteFin,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_REVISION"
// [MIGPB11] [EMD] : Fin Migration

subroutine PS_SUPREVISION(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.PS_SUPREVISION"
subroutine IM_D01_CODE_CONDITION(long dcIdProd,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D01_CODE_CONDITION"
subroutine IM_D01_CODE_GARANTIE(long dcIdProd,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D01_CODE_GARANTIE"
subroutine IM_D02_MOTIF(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D02_MOTIF"
subroutine IM_D02_PIECE(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D02_PIECE"
subroutine DW_I01_CODE_GARANTIE(long dcIdProd,long dcIdGti,string sLibGti,real dcMtCmt,long dcCodRgptStat,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODE_GARANTIE"
subroutine IM_S01_CODE_GARANTIE(long dcIdProd,long dcIdGti,ref long iNbGarantie) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODE_GARANTIE"
subroutine DW_D01_CODE_CONDITION(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode) RPCFUNC ALIAS FOR "sysadm.DW_D01_CODE_CONDITION"
subroutine DW_I01_CODE_COND(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode,string sLibEvt,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODE_CONDITION"
subroutine IM_S01_CONDITION(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode,ref long iNbCondition) RPCFUNC ALIAS FOR "sysadm.IM_S01_CONDITION"
subroutine IM_S03_GARANTIE(long dcIdProd,long dcIdGti,ref long iNbGarantie) RPCFUNC ALIAS FOR "sysadm.IM_S03_GARANTIE"
subroutine DW_D01_PARA_PROD(long dcIdProd,string sIdPara) RPCFUNC ALIAS FOR "sysadm.DW_D01_PARA_PROD"
subroutine DW_I01_PARA_PROD(long dcIdProd,string sIdPara,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_PARA_PROD"
subroutine IM_I01_FRANCHISE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_FRANCHISE"
subroutine IM_I01_PLAFOND(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_PLAFOND"
subroutine IM_I01_DELAI(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_DELAI"
subroutine DW_D01_CARTE(long dcIdCarte) RPCFUNC ALIAS FOR "sysadm.DW_D01_CARTE"
subroutine DW_D01_TYPE_CARTE(string sIdTypeCarte) RPCFUNC ALIAS FOR "sysadm.DW_D01_TYPE_CARTE"
subroutine DW_I01_CARTE(ref long dcIdCarte,string sIdTypeCarte,long dcIdGrp,string sLibCarte,string sValRgMini,string sValRgMax,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CARTE"
subroutine DW_I01_TYPE_CARTE(string sIdTypeCarte,string sLibTypeCarte,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_TYPE_CARTE"
subroutine IM_S01_TYPE_CARTE(string sIdTypeCarte,ref string sLibTypeCarte) RPCFUNC ALIAS FOR "sysadm.IM_S01_TYPE_CARTE"
FUNCTION long IM_S02_CARTE(long dcIdCarte,string sRangMini,string sRangMaxi) RPCFUNC ALIAS FOR "sysadm.IM_S02_CARTE"
FUNCTION long IM_S03_CARTE(long dcIdCarte,string sRangMini,string sRangMaxi) RPCFUNC ALIAS FOR "sysadm.IM_S03_CARTE"
FUNCTION long IM_S04_CARTE(string sIdTypeCarte) RPCFUNC ALIAS FOR "sysadm.IM_S04_CARTE"
FUNCTION long IM_S05_CARTE(long dcIdCarte,string sRangMini,string sRangMaxi,ref string sText) RPCFUNC ALIAS FOR "sysadm.IM_S05_CARTE"
FUNCTION long IM_S01_AFFILIER( long dcIdCarte ) RPCFUNC ALIAS FOR "sysadm.IM_S01_AFFILIER"
subroutine IM_I01_AFFILIER(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_AFFILIER"
subroutine IM_S06_PRODUIT(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S06_PRODUIT"
subroutine DW_I01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdPolice,long dcCodTypFra,long dcCodRadical,string sAltPlaf,string sAltDel,string sAltFran,datetime dtCreeLe,datetime dtMajLe,string sMajPar, string sIdPrefixe) RPCFUNC ALIAS FOR "sysadm.DW_I01_GARANTIE" // PHG 11/08/2008 Correction bug Id_prefixe AIG
subroutine DW_D01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.DW_D01_GARANTIE"
subroutine IM_S01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti,ref long dcIdGtiRech) RPCFUNC ALIAS FOR "sysadm.IM_S01_GARANTIE"
subroutine IM_U01_PRODUIT(long dcIdProduit,long dcIdPolice) RPCFUNC ALIAS FOR "sysadm.IM_U01_PRODUIT"
subroutine DW_I01_AFFILIER(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCarte,datetime dtDteAffil,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_AFFILIER"
subroutine DW_I01_CONDITION(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCode,string dcIdTypCode,string AltReg,string AltPlaf,string AltDel,string AltFran,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CONDITION"
subroutine DW_U01_CONDITION(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCode,string sIdTypCode,string sAltReg,string sAltPlaf,string sAltDel,string sAltFran,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_U01_CONDITION"
subroutine DW_U01_PIECE(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdPce,string sIdPara,string sCodTypPce,datetime dtMajLe,string sMajPar, long lCptTri) RPCFUNC ALIAS FOR "sysadm.DW_U01_PIECE"
subroutine DW_U01_MOTIF(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdMotif,string sIdPara,string sCodTypMotif,string sCodNatMotif,datetime dtMajLe,string sMajPar, long dcCptTri) RPCFUNC ALIAS FOR "sysadm.DW_U01_MOTIF"
subroutine DW_I01_PLAFOND(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivPlaf,long dcIdRefPlaf,string sIdTypPlaf,long dcIdCptPlaf,real dcMtPlaf,string IdPara,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_PLAFOND"
subroutine DW_U01_PLAFOND(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivPlaf,long dcIdRefPlaf,string sIdTypPlaf,long dcIdCptPlaf,real dcMtPlaf,string IdPara,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_U01_PLAFOND"
subroutine DW_I01_FRANCHISE(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivFra,long dcIdRefFra,long dcIdTypFra,long dcIdCptFra,real dcMtFra,string IdPara,long dcDurMin,long dcDurMax,string sUntDel,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_FRANCHISE"
subroutine DW_U01_FRANCHISE(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivFra,long dcIdRefFra,long dcIdTypFra,long dcIdCptFra,real dcMtFra,string IdPara,long dcDurMin,long dcDurMax,string sUntDel,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_U01_FRANCHISE"
subroutine DW_I01_DELAI(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivDel,long dcIdRefDel,string sIdTypDel,long dcIdCptDel,long dcDurMin,long dcDurMax,string sUntDel,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_DELAI"
subroutine DW_U01_DELAI(long dcIdProd,long dcIdRev,long dcIdGti,string sIdNivDel,long dcIdRefDel,string sIdTypDel,long dcIdCptDel,long dcDurMin,long dcDurMax,string sUntDel,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_U01_DELAI"
subroutine DW_I01_W_INTER(long dcIdSin,long dcIdI,string sCodInter,string sCodCiv,string sNom,string sAdr1,string sAdr2,string sAdrCp,string sAdrVille,string sAdrAtt,string sNumTeld,string sNumTelb,string sNumFax,string sCodModeReg,string sRibBq,string sRibGui,string sRibCpt,string sRibCle,real dcMtAReg,real dcMtReg,string sVref1,string sVref2,string sCodeAg,string sCodeBq,long iCptCour,string sAltValide,long dcCptValide,string sAltPart,string sAltPs,string sAltPce,string sAltQuest,string sIdCour,string sIdNatCour,string sAltCourGest, long dcIdIDb, string sIdCourj, datetime dtCreeLe,datetime dtMajLe,string sMajPar, string sOrdreCheque, string num_let_cheque, string sIdFour, string sAltSuiviMail, string sAdrMail, string sAltSuiviSms, string sNumPortSms, datetime dte_naiss, string ville_naiss, string pays_naiss, integer cod_etat_ctrle_inter) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_INTER" // JFF 20/10/2008 [FNAC_PROD_ECH_TECH]
subroutine DW_D01_W_INTER(long dcIdSin,long dcIdI, string sMethode) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_INTER"
subroutine PS_X_CALC_REVISION(long dcIdProd,datetime dtDteEff,datetime dtDteAdh,ref string sIdRev) RPCFUNC ALIAS FOR "sysadm.PS_X_CALC_REVISION"
subroutine DW_I01_W_PARA_INFO(long dcIdSin,long dcIdI,string sIdPara,long dcCptTri,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_PARA_INFO"
subroutine DW_D01_W_PARA_INFO(long dcIdSin,long dcIdI) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_PARA_INFO"
subroutine DW_I01_W_FRAIS(long dcIdSin,long dcIdI,long dcIdFrais,long dcIdTypFrais,string sLibFrais,string sAltCour,real dcMtFrais,long dcCodEtat,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_FRAIS"
subroutine DW_D01_W_FRAIS(long dcIdSin,long dcIdI, long dcIdFrais) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_FRAIS"

// [MIGPB11] [EMD] : Debut Migration : Report SUISSE : Le param dDte1erUf peut être du format date. Or SNC ne gère pas ce cas pour résoudre le Pb on le passe en string SQL fait le transtypage
//subroutine DW_I01_W_GTI( long dcIdsin, long dcIdGti, datetime dDteOppo, string sHeuOppo, datetime dDte1erUf, real dcMtTotPrej, real dcMtPrejAreg, real dcMtFranaReg, real dcMtNPlafAreg, real dcMtPlafAreg, real dcMtDeduAreg, real dcMtPrejReg, real dcMtDeduReg, real dcMtFranReg, real dcMtNplafReg, real dcMtPlafReg, real dcMtProv, long dcCodDecMac, long dcCodDecOpe, long dcCodEtat, string sTxtMess, string sAltBloc, string sAltAtt, string sAltPlaf, string sAltSsui, long dcCodMotSsui, string sAltValide, long dcCptValide, long dcCptIAreg, datetime dtCreeLe, datetime dtMajLe, string sMajPar ) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_GTI"
subroutine DW_I01_W_GTI( long dcIdsin, long dcIdGti, datetime dDteOppo, string sHeuOppo,  string dDte1erUf, real dcMtTotPrej, real dcMtPrejAreg, real dcMtFranaReg, real dcMtNPlafAreg, real dcMtPlafAreg, real dcMtDeduAreg, real dcMtPrejReg, real dcMtDeduReg, real dcMtFranReg, real dcMtNplafReg, real dcMtPlafReg, real dcMtProv, long dcCodDecMac, long dcCodDecOpe, long dcCodEtat, string sTxtMess, string sAltBloc, string sAltAtt, string sAltPlaf, string sAltSsui, long dcCodMotSsui, string sAltValide, long dcCptValide, long dcCptIAreg, datetime dtCreeLe, datetime dtMajLe, string sMajPar ) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_GTI"
// [MIGPB11] [EMD] : Fin Migration

subroutine DW_D01_W_GTI(long dcIdSin,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_GTI"
subroutine DW_I01_W_PIECE(long dcIdSin,long dcIdGti,long dcIdDetail,long dcIdPce,long dcIdI,string sIdPara,long dcCptTri,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_PIECE"
subroutine DW_D01_W_PIECE(long dcIdSin,long dcIdGti,long dcIdDetail) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_PIECE"
subroutine DW_I01_W_REFUS(long dcIdSin,long dcIdGti,long dcIdDetail,long dcIdMotif,string sAltMac,string sAltOpe,long dcIdI,string sIdPara,long dcCptTri,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_REFUS"
subroutine DW_D01_W_REFUS(long dcIdSin,long dcIdGti,long dcIdDetail) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_REFUS"
subroutine DW_I01_W_PARA_PLAFOND(long dcIdSin,long dcIdGti, long dcIdDetail, string sIdTypPlaf, string sIdPara, long dcIdI, datetime dtCreeLe, datetime dtMajLe, string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_PARA_PLAFOND"
subroutine DW_D01_W_PARA_PLAFOND(long dcIdSin,long dcIdGti,long dcIdDetail) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_PARA_PLAFOND"

// [MIGPB11] [EMD] : Debut Migration : certains params peuvent être du format date or SNC ne gère pas ce cas. Pour résoudre le pb on les passe en string et SQL fait le transtypage
//subroutine DW_I01_W_DETAIL ( long dcIdsin, long dcIdGti, long dcIdDetail, long dcIdEvt, string sLibDet, datetime dDteDet, string sHeuDet, string sNumCarte, real dcMtPrej, real dcMtFran, real dcMtnPlaf, real dcMtPlaf, long dcIdiReg, string sAltBloc, string sAltCour, string sAltPlaf, string sAltReg, string sAltAtt, string sAltValide, long dcCptValide, string sAltSsui, long dcCodMotSsui, long dcCodDecMac, long dcCodDecOpe, long dcCodEtat, long dcIdCarte, string dcIdTypeCarte, datetime dtCreeLe, datetime dtMajLe, string sMajPar, datetime dte_cmd, datetime dte_livr, real dcMtValAchat, real dcMtValPublique, string sNumFacture ) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_DETAIL"
subroutine DW_I01_W_DETAIL ( long dcIdsin, long dcIdGti, long dcIdDetail, long dcIdEvt, string sLibDet, string sDteDet, string sHeuDet, string sNumCarte, real dcMtPrej, real dcMtFran, real dcMtnPlaf, real dcMtPlaf, long dcIdiReg, string sAltBloc, string sAltCour, string sAltPlaf, string sAltReg, string sAltAtt, string sAltValide, long dcCptValide, string sAltSsui, long dcCodMotSsui, long dcCodDecMac, long dcCodDecOpe, long dcCodEtat, long dcIdCarte, string dcIdTypeCarte, datetime dtCreeLe, datetime dtMajLe, string sMajPar, string sDte_cmd, string sDte_livr, real dcMtValAchat, real dcMtValPublique, string sNumFacture ) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_DETAIL"
// [MIGPB11] [EMD] : Fin Migration

subroutine DW_D01_W_DETAIL(long dcIdSin,long dcIdGti,long dcIdDetail) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_DETAIL"
FUNCTION long PS_S01_CARTE_UF( long dcIdProd, long dcCarteIdGrp) RPCFUNC ALIAS FOR "sysadm.PS_S01_CARTE_UF"
subroutine PS_S01_W_DETAIL_A_REGLER(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv,ref long iNbDetail) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_DETAIL_A_REGLER"
subroutine PS_S01_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv, Ref string dcMtPrej ) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_DETAIL_MT_PLAF"
subroutine PS_S02_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos, long dcIdGti,long dcIdEvt,datetime dtSurv,Ref string dcMtPrej) RPCFUNC ALIAS FOR "sysadm.PS_S02_W_DETAIL_MT_PLAF"
subroutine PS_S03_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPrej) RPCFUNC ALIAS FOR "sysadm.PS_S03_W_DETAIL_MT_PLAF"
subroutine PS_S04_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPrej) RPCFUNC ALIAS FOR "sysadm.PS_S04_W_DETAIL_MT_PLAF"
subroutine PS_S05_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv, Ref string dcMtPrej ) RPCFUNC ALIAS FOR "sysadm.PS_S05_W_DETAIL_MT_PLAF"
subroutine PS_S06_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos, long dcIdGti,long dcIdEvt,datetime dtSurv,Ref string dcMtPrej) RPCFUNC ALIAS FOR "sysadm.PS_S06_W_DETAIL_MT_PLAF"
subroutine PS_S07_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S07_W_DETAIL_NBEVT"
subroutine PS_S08_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,long dcIdEvt,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S08_W_DETAIL_NBEVT"
subroutine PS_S09_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S09_W_DETAIL_NBEVT"
subroutine PS_S10_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S10_W_DETAIL_NBEVT"
subroutine PS_S01_W_GTI_A_REGLER ( long dcIdSin, long dcIdProd, long dcIdEts, string sIdAdh, long dcIdGti, datetime dtSurv, ref long iNbDetail) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_GTI_A_REGLER"
subroutine PS_S01_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_GTI_MT_PLAF"
subroutine PS_S02_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S02_W_GTI_MT_PLAF"
subroutine PS_S03_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S03_W_GTI_MT_PLAF"
// [PC13321]
subroutine PS_S031_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S031_W_GTI_MT_PLAF"

subroutine PS_S04_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S04_W_GTI_MT_PLAF"
subroutine PS_S05_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S05_W_GTI_MT_PLAF"
subroutine PS_S06_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S06_W_GTI_MT_PLAF"
subroutine PS_S01_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_GTI_NBSIN"
subroutine PS_S02_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S02_W_GTI_NBSIN"
subroutine PS_S03_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S03_W_GTI_NBSIN"
subroutine PS_S04_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S04_W_GTI_NBSIN"
subroutine PS_S01_CARTE_SINISTRE(string sRang, Long dcIdProd,ref long dcIdCarte,ref string sIdTypeCarte,ref long dcIdGrp,ref long iNbAffilier) RPCFUNC ALIAS FOR "sysadm.PS_S01_CARTE_SINISTRE"
subroutine PS_S01_COMPOSITION( string sIdCour, ref string sTxtCompo) RPCFUNC ALIAS FOR "sysadm.PS_S01_COMPOSITION"
subroutine DW_I01_W_COURRIER ( long dcIdsin, long dcIdI, long dcIdCpt, string sIdCour, string sAltPart, string sAltPce, string sAltPs, string sTxtCompo1, string sTxtCompo2, long dcIdIDb, datetime dtCreeLe, datetime dtMajLe, string sMajPar, string sIdCourOrig, string sIdCanal, String sModeleWord ) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_COURRIER" // [DNTMAIL1-2] PHG 06/11/2006 :ajout IdCanal // [RS5045_REF_MATP]
subroutine DW_D01_W_COURRIER ( long dcIdSin, String sMethode ) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_COURRIER"
subroutine DW_D02_W_COURRIER ( long dcIdSin, String sMethode ) RPCFUNC ALIAS FOR "sysadm.DW_D02_W_COURRIER"
subroutine IM_D01_W_INTER_BLOB( long dcIdSin, long dcIdI, string sIdTypBlob) RPCFUNC ALIAS FOR "sysadm.IM_D01_W_INTER_BLOB"
subroutine IM_I01_W_INTER_BLOB ( long dcIdSin, long dcIdI, string sIdTypBlob, datetime dtCreeLe, datetime dtMajLe, string sMajPar ) RPCFUNC ALIAS FOR "sysadm.IM_I01_W_INTER_BLOB"
subroutine DW_I01_W_REG_GTI( long dcIdsin, long dcIdI, long dcIdGti, long dcIdRgpt, long dcIdReg, real dcMtReg, real dcMtRgpt, datetime dtCreeLe, datetime dtMajLe, string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_REG_GTI"
subroutine DW_D01_W_REG_GTI( long dcIdSin) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_REG_GTI"
subroutine PS_S01_AFFILIER_SINISTRE(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCarte,ref long iNbCarte) RPCFUNC ALIAS FOR "sysadm.PS_S01_AFFILIER_SINISTRE"
subroutine PS_VAL_W_QUEUE ( string sCodTypRecu, string sCodRecu, datetime dDteCourCli, datetime dDteRecu, long dcIdSin, long dcIdI, string sCodIProv, long dcIdProd, long dcIdEts, string sIdAdh, long dcIdsDos, long dcOption, datetime dDteAdh, datetime dDteFinGti, datetime dDteResil, long dcIdCorb, datetime dDteDecl, datetime dDteSurv, string sCodCiv, string sNom, string sPrenom, string sAdr1, string sAdr2, string sAdrCp, string sAdrVille, string sNumTelD, string sNumTelB, string sNumFax, string sTxtMess1, datetime dtCreeLe, datetime dtMajLe, string sCodOper, string sCodTravail, string sAltQueue, datetime dtDteSous, datetime dtDteOpt, long dcIdCarte, string sIdTypeCarte, long dcIdOrdre, string sCodProvPers, string sCodModeRegA, string sRibBq, string sRibGui, string sRibCpt, string sRibCle, string sAltCreBqDms, string sCodBq_B, string sCodAg_B, string sNom_B, string sAdr1_B, string sAdr2_B, string sAdrCp_B, string sAdrVille_B, string sCodModeRegB, string sNumTelD_B, string sDosMajPar, string sNumPort, string sNumImeiPort, string sMarqPort, string sModlPort, datetime dtAchPort, datetime dtOuvLigPort, string sIdContratAbonne, long lIdHlr, long  lIdOrianMarque, long lIdOrianModele, long lIdOrianBoutique, ref string sProc, ref string sNvIdSin) RPCFUNC ALIAS FOR "sysadm.PS_VAL_W_QUEUE"
function long PS_VALIDATION ( Long dcIdSin, string sCodOper, String sNoBoite, ref string sProc, ref datetime dtValideLe, string sMethode) RPCFUNC ALIAS FOR "sysadm.PS_VALIDATION"
subroutine PS_S01_STAT_SIN_STAT( Long dcIdPeriode, ref long dcNbrLig ) RPCFUNC ALIAS FOR "sysadm.PS_S01_STAT_SIN_STAT"
subroutine PS_S02_STAT_SIN_STAT( long dcIdSin, long dcIdRgpt, long dcCodEtat1, long dcCodEtat2, Integer iChoixTrt, long dcIdPeriode, ref long dcNbrLig) RPCFUNC ALIAS FOR "sysadm.PS_S02_STAT_SIN_STAT"
subroutine IM_S02_PARAGRAPHE ( string sPara, ref string sVersion ) RPCFUNC ALIAS FOR "sysadm.IM_S02_PARAGRAPHE"
subroutine DW_I01_AIDE_TARIF(ref long dcIdCode,long dcIdGti,string sLibCode,real dcMtPrej,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_AIDE_TARIF"
subroutine DW_D01_AIDE_TARIF(long dcIdCode) RPCFUNC ALIAS FOR "sysadm.DW_D01_AIDE_TARIF"
subroutine PS_VAL_REGUL( string sLibReg, string sCodModeReg, string sRibBq, string sRibGui, string sRibCpt, string sRibCle, datetime dtDteReg, real dcMtTotReg, string sCodMotReg, long dcIdRegBase, Long dcIdSin, Long dcIdI, Long dcCptReg, string sCodInter, Long dcIdRgpt, long dcIdGti, datetime dtCreeLe, string sCodOper, ref string sProc) RPCFUNC ALIAS FOR "sysadm.PS_VAL_REGUL"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
subroutine PS_VAL_REGUL_V01 ( string sLibReg, string sCodModeReg, string sRibBq, string sRibGui, string sRibCpt, string sRibCle, datetime dtDteReg, real dcMtTotReg, string sCodMotReg, long dcIdRegBase, Long dcIdSin, Long dcIdI, Long dcCptReg, string sCodInter, Long dcIdRgpt, long dcIdGti, datetime dtCreeLe, string sCodOper, ref string sProc, ref Decimal adcIdReg ) RPCFUNC ALIAS FOR "sysadm.PS_VAL_REGUL_V01"

subroutine PS_I02_ARCHIVE_RELANCES(datetime adtDateDuJour,ref long adcId_Doc,long adcId_Sin,long adcId_Inter,string asId_Cour,long adcId_Prod,long adcId_Ordre,string asId_Adh,string asCod_Inter,string asNom,string asTextComp1,string asValidePar,string asMajPar,string asTypBlob) RPCFUNC ALIAS FOR "sysadm.PS_I02_ARCHIVE_RELANCES"

//       JFF  26/04/2023 [RS5045_REF_MATP]
subroutine PS_I02_ARCHIVE_RELANCES_V01 (datetime adtDateDuJour,ref long adcId_Doc,long adcId_Sin,long adcId_Inter,string asId_Cour,long adcId_Prod,long adcId_Ordre,string asId_Adh,string asCod_Inter,string asNom,string asTextComp1,string asValidePar,string asMajPar,string asTypBlob, string asModeleWord) RPCFUNC ALIAS FOR "sysadm.PS_I02_ARCHIVE_RELANCES_V01"

//       JFF   18/10/2023 [RS6044_REL_MAIL]
subroutine PS_I02_ARCHIVE_RELANCES_V02 (datetime adtDateDuJour,ref long adcId_Doc,long adcId_Sin,long adcId_Inter,string asId_Cour,long adcId_Prod,long adcId_Ordre,string asId_Adh,string asCod_Inter,string asNom,string asTextComp1,string asValidePar,string asMajPar,string asTypBlob, string asModeleWord, String asIdCanal, Ref Long alIdArch) RPCFUNC ALIAS FOR "sysadm.PS_I02_ARCHIVE_RELANCES_V02"

subroutine PS_D01_ARCHIVE_SOLDAGE(long dcIdSin,string sCodOper,datetime dtDateDuJour,ref string sAltQueue, string sNoBoite) RPCFUNC ALIAS FOR "sysadm.PS_D01_ARCHIVE_SOLDAGE"
subroutine PS_S02_W_QUEUE_POCHETTE(long dcIdSin,string sCas,ref long dcPochette) RPCFUNC ALIAS FOR "sysadm.PS_S02_W_QUEUE_POCHETTE"
subroutine PS_S01_ROUTAGE(long dcIdSin,ref string sCodTravail,ref string sAltQueue) RPCFUNC ALIAS FOR "sysadm.PS_S01_ROUTAGE"
subroutine PS_S01_CONTACT(long dcIdSin,ref long iMaxSeq) RPCFUNC ALIAS FOR "sysadm.PS_S01_CONTACT"
subroutine PS_S02_CONTACT(long dcIdSin,string sTypMsg,ref long iNbr) RPCFUNC ALIAS FOR "sysadm.PS_S02_CONTACT"
subroutine DW_I01_W_COMMANDE(long dcIdSin,long iIdSeq,long dcIdGti,long dcIdDetail,string sIdFour,string sIdTypArt,string sIdMarqArt,string sIdModlArt,string sAdrNom,string sAdrPrenom,string sAdrLivr1,string sAdrLivr2,string sAdrLivrCpl,string sAdrCp,string sAdrVille,string sAdrTel1,string sAdrTel2,string sAdrTel3,string sAdrMail,datetime dtDteRdvCli,string sHrdvCliMin,string sHrdvCliMax,string sIdSerieAnc,string sProbleme,string sIdCmdFrn,string sIdSerieNouv,string sIdBonTransp,datetime dtDteRcpFrn,datetime dtDteEnvCli,string sCodEtat,string sCommentFrn,long lCptValide,string sNomGest,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_COMMANDE"
subroutine PS_S03_COMMANDE(string sRefCpt,ref long dcIdLotCmd) RPCFUNC ALIAS FOR "sysadm.PS_S03_COMMANDE"
subroutine PS_S04_COMMANDE(long dcIdProd,long iNbCmdes,ref long iCptCmd) RPCFUNC ALIAS FOR "sysadm.PS_S04_COMMANDE"
subroutine PS_S05_COMMANDE(string sRefCpt,ref long dcIdLotCeg) RPCFUNC ALIAS FOR "sysadm.PS_S05_COMMANDE"
subroutine PS_U01_PREP_SOLDAGE_TELEPHONIE ( long dcIdSin, string sCodOper, datetime dtDteValideLe, String sNoBoite, ref string sRetour ) RPCFUNC ALIAS FOR "sysadm.PS_U01_PREP_SOLDAGE_TELEPHONIE"
subroutine PS_X_INCREMENTER(string srefcpt,ref long dccptval) RPCFUNC ALIAS FOR "sysadm.PS_X_INCREMENTER"
subroutine PS_S01_BOUTIQUE(long dcIdProd,long iIdBoutique,ref string sAdrVille) RPCFUNC ALIAS FOR "sysadm.PS_S01_BOUTIQUE"
subroutine PS_S04_BOUTIQUE(long dcIdProd,long iIdBoutique,ref string sNom, ref string sAdrVille) RPCFUNC ALIAS FOR "sysadm.PS_S04_BOUTIQUE"
subroutine PS_U01_PARAM_CPT(string sCodAppli,string sBase,string sRefCpt,Ref long iCptVal) RPCFUNC ALIAS FOR "sysadm.PS_U01_PARAM_CPT"
subroutine PS_S01_W_COUR_BLOB_ARCH (string sMajPar,long iIdSin,datetime dDteMaxMaj,long iIdTypDoc,ref long iNbreTrouve) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_COUR_BLOB_ARCH"
function int PS_I02_ARCHIVE_BLOB_VAL (long iIIdLot, ref String sRet)  RPCFUNC ALIAS FOR "sysadm.PS_I02_ARCHIVE_BLOB_VAL"
function long PS_INSERTION_FRAIS_AUTOMATIQUE(long adcIdSin, long aiIdSeq,real adcMtFrais,datetime adtRcpFrn,ref string asRetour) RPCFUNC ALIAS FOR "sysadm.PS_INSERTION_FRAIS_AUTOMATIQUE"
subroutine PS_S02_COMMANDE_TYPE (long dcIdSin, long lIdSeq, string sIdFour,ref long iRetour) RPCFUNC ALIAS FOR "sysadm.PS_S02_COMMANDE_TYPE"
function long PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS(string asNomFichier,string asDateEtHrTrt,string asIdFour,ref string asRetour) RPCFUNC ALIAS FOR "sysadm.PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS"
subroutine PS_S01_W_GTI_CLIENT (long dcIdSin, long dcIdProd, ref string dcMtPlafReg ) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_GTI_CLIENT"
subroutine PS_S01_W_GTI_PRODUIT (long dcIdSin, long dcIdProd, ref string dcMtPlafReg ) RPCFUNC ALIAS FOR "sysadm.PS_S01_W_GTI_PRODUIT"
subroutine PS_S01_AUTORISATION (long iIdNatOper, string sIdOper, long dcIdProd, ref long iTrouve ) RPCFUNC ALIAS FOR "sysadm.PS_S01_AUTORISATION"
subroutine PS_I04_CONTACT_TRAVAIL(long iIdSin,long iIdAppli,string sMess,string sMajPar,string sErr) RPCFUNC ALIAS FOR "sysadm.PS_I04_CONTACT_TRAVAIL"
subroutine PS_S01_TAC_IMEI (long iIIdTac,ref string sMarque, ref string sModele) RPCFUNC ALIAS FOR "sysadm.PS_S01_TAC_IMEI"
subroutine PS_S06_COMMANDE (long dcIdSin,long iIdSeq,ref DateTime dtCreeLe,ref DateTime dtCmdGenLe) RPCFUNC ALIAS FOR "sysadm.PS_S06_COMMANDE"
function long PS_S02_MAILPUSH_RECP_APP_EN_CTR ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, DateTime dtDteRcpFrn, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S02_MAILPUSH_RECP_APP_EN_CTR" 
function long PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03 ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, DateTime dtDteEnvCli, String sDestCli, String sNumBonTrsp, Long iStatusGc, String sCommentFrn, String sChaine, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03"
function long PS_U01_MAJ_ID_EDT( ref string asErreur, ref string asIdDocEdt, string asEdtProgramme, string asEdtApplicatif, long adcIdSin, long aiIdArch, long aiIdLot, string asDteEdit ) RPCFUNC ALIAS FOR "sysadm.PS_U01_MAJ_ID_EDT"
function long PS_U01_MAJ_REEDITION( long adcIdSin, long aiIdArch, string asIdDocEdt, ref string asErreur ) RPCFUNC ALIAS FOR "sysadm.PS_U01_MAJ_REEDITION"
subroutine IM_S01_DEPARTEMENT (long dcIdDept,ref string sLibDept) RPCFUNC ALIAS FOR "sysadm.IM_S01_DEPARTEMENT"
function long PS_I01_MAILPUSH (  long dcIdSin, string sBase, string sMailSend, string sMailObjet, Blob bMailBody, String sBoiteMail, String sTypMail, Long iIdAppli ) RPCFUNC ALIAS FOR "sysadm.PS_I01_MAILPUSH"
subroutine PS_S07_COMMANDE (long dcIdSin, long iIdSeq, ref string sIdFour ) RPCFUNC ALIAS FOR "sysadm.PS_S07_COMMANDE"

function long PS_S01_GESTION_APPAREIL_V00 (long dcIdProd) RPCFUNC ALIAS FOR "sysadm.PS_S01_GESTION_APPAREIL_V00"
function long PS_S01_GESTION_ECHANGE_FLUX_V00 (long dcIdProd) RPCFUNC ALIAS FOR "sysadm.PS_S01_GESTION_ECHANGE_FLUX_V00"
function long PS_S01_GESTION_BOUTIQUE_V00 (long dcIdProd) RPCFUNC ALIAS FOR "sysadm.PS_S01_GESTION_BOUTIQUE_V00"
function long PS_U01_EXCEPTION_FORCAGE_OK ( long dcIdSin, string sIdOper, ref string sTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U01_EXCEPTION_FORCAGE_OK"
subroutine PS_S11_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,/*long dcIdGti,*/long dcIdEvt,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S11_W_DETAIL_NBEVT" // [DCMP060777]
subroutine PS_S12_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,/*long dcIdGti,*/long dcIdEvt,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S12_W_DETAIL_NBEVT" // [DCMP060777]
subroutine PS_S13_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,/*long dcIdGti,*/long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S13_W_DETAIL_NBEVT" // [DCMP060777]
subroutine PS_S14_W_DETAIL_NBEVT(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,/*long dcIdGti,*/long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S14_W_DETAIL_NBEVT" // [DCMP060777]
subroutine PS_S01_COUR_PROD( long lIdProd, string sIdCour, ref string sTxtCompo) RPCFUNC ALIAS FOR "sysadm.PS_S01_COUR_PROD" // DCMP 070051
subroutine PS_S01_COUR_PROD_V02 ( long lIdProd, string sIdNatCour, string sIdCour, ref string sTxtCompo) RPCFUNC ALIAS FOR "sysadm.PS_S01_COUR_PROD_V02" // [JFF][20210702]
function long PS_S01_ARTICLE_ALAPAGE ( String sCodNovalis, ref string sMtPrixHT, ref string sTVA, ref string sMarq, ref String sModl, ref String sTypArt, ref String sLibTypArt, ref String sIdFour, ref string sMarqIfr, ref string sModlIfr, ref string sMtPrixIFR ) RPCFUNC ALIAS FOR "sysadm.PS_S01_ARTICLE_ALAPAGE"
function long PS_S01_DET_ARTICLE_TEST_PRESENCE ( String sIdFour, string sIdRefFour) RPCFUNC ALIAS FOR "sysadm.PS_S01_DET_ARTICLE_TEST_PRESENCE"
function long PS_S08_COMMANDE ( String sIdFour) RPCFUNC ALIAS FOR "sysadm.PS_S08_COMMANDE"

Subroutine PS_S11_COMMANDE_V07 ( long dcIdSin, long lIdSeq, ref string sIdFour, ref string sCodEtat, ref int iStatusGc, ref string sIdRefFour, ref int iInfoSpbFrn, ref string sIdTypArt, ref long dcIdProd, ref String sInfoSpbFrnCplt, ref String sInfoFrnSpbCplt, ref string sChaineBCV ) RPCFUNC ALIAS FOR "sysadm.PS_S11_COMMANDE_V07" //* [FNAC_PROD_ECH_TECH] - [DCMP100443] // [PM166][O2M] // [vDoc7926] [VDOC9142

subroutine PS_I02_W_COUR_BLOB_ARCH ( long dcIdSin, long dcIdInter, long dcIdDoc, string sTypBlob, integer iIdTypDoc, string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_I02_W_COUR_BLOB_ARCH" // JCA DCMP 70809
subroutine PS_I02_ARCHIVE_RELANCE_ORANGE ( datetime adtDateDuJour,ref long adcId_Doc,long adcId_Sin,long adcId_Inter,string asId_Cour,long adcId_Prod,long adcId_Ordre,string asId_Adh,string asCod_Inter,string asNom,string asTextComp1,string asValidePar,string asMajPar,string asTypBlob) RPCFUNC ALIAS FOR "sysadm.PS_I02_ARCHIVE_RELANCE_ORANGE"
function integer PS_I01_TRACE_RECAP_RELANCE ( string sCodOper, string sTypTrt, datetime dtDate, integer dw1count )  RPCFUNC ALIAS FOR "sysadm.PS_I01_TRACE_RECAP_RELANCE"
subroutine PS_I01_TRACE_RELANCE ( integer idtrt, decimal idSin, decimal idInter, decimal idDocOri, decimal idDocRel, string sMess )  RPCFUNC ALIAS FOR "sysadm.PS_I01_TRACE_RELANCE"
subroutine PS_U01_TRACE_RECAP_RELANCE ( integer IdTrt, integer nbTraite )  RPCFUNC ALIAS FOR "sysadm.PS_U01_TRACE_RECAP_RELANCE"
function long PS_V01_REF_ASSUREUR ( Long dcIdSin, Datetime dDteSurv, ref string sMsg )  RPCFUNC ALIAS FOR "sysadm.PS_V01_REF_ASSUREUR" // JFF [DCMP070914] le 16/04/2008
subroutine PS_S05_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S05_W_GTI_NBSIN" // JFF [DCMP080377] le 12/06/2008
subroutine PS_S06_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S06_W_GTI_NBSIN" // JFF [DCMP080377] le 12/06/2008
subroutine PS_S09_COMMANDE (long dcIdSin, string sFourn1, string sFourn2, string sMarq, string sModl, string sdcRepartFourn1, Datetime dtDtePivot, Ref string sFournRetenu) RPCFUNC ALIAS FOR "sysadm.PS_S09_COMMANDE" // JFF [DCMP080500] le 19/06/2008
subroutine PS_S10_COMMANDE (long dcIdSin, long iIdSeq, ref string sIdRefFour, ref string sIdTypArt) RPCFUNC ALIAS FOR "sysadm.PS_S10_COMMANDE " // JFF [DCMP080615] le 08/08/2008
subroutine PS_I02_IFR ( string sCasTrt, string sLibRefRf, string sMarque, string sReference, Integer iIdCtgApp, decimal {2} dcFrequence, string sColFonct, string sValFonct, string sOperateur, String AdrMailSPB, Ref long lIdTrait, Ref long lValRet ) RPCFUNC ALIAS FOR "sysadm.PS_I02_IFR" // JFF [DCMP080388] le 05/08/2008
// [DCMP80334] - Contrôle de double validation
function long IM_S01_AUTORISATION(long iIdNatOper,string sCodOper,ref string sAlt) RPCFUNC ALIAS FOR "sysadm.IM_S01_AUTORISATION"
// [DCMP80862]
function long PS_I01_REF_CODIC_DARTY(string sProvenance,string sTypeApp,long iCodic,string sMarque,string sModele,string sMajPar,ref string sAltTraite) RPCFUNC ALIAS FOR "sysadm.PS_I01_REF_CODIC_DARTY"
function long PS_S01_CODE_CAR(string sIdCode,string sIdTypCode) RPCFUNC ALIAS FOR "sysadm.PS_S01_CODE_CAR"
// FPI - Recopie de produits
function long PS_I01_TRACE_RECOPIE_PRODUIT(decimal dcIdProdSource,decimal dcIdRevSource,decimal dcIdProdDest,decimal dcIdRevDest,string sLibLong,string sLibCourt,string sEffRevDest,string sLibRevDest,datetime dteEffRev,string sMajPar,string sAltCopieBoutique,string sSuppOption,string sSuppGti,string sResultat, ref long iIdCle) RPCFUNC ALIAS FOR "sysadm.PS_I01_TRACE_RECOPIE_PRODUIT"
// FPI - 15/01/2009 - Intégration des fichiers TAC_IMEI
function long PS_I01_TAC_IMEI(long iIdTac,string sMarque,string sModele,string sMajPar,ref string sAltTraite) RPCFUNC ALIAS FOR "sysadm.PS_I01_TAC_IMEI"
function long PS_D01_TAC_IMEI() RPCFUNC ALIAS FOR "sysadm.PS_D01_TAC_IMEI"
function long PS_I01_SMSPUSH ( long dcIdSin, string sBase, string sNumGsm, string sLogin, string MdPasse, string SmsBody, String CodeTrt, String sTypSms, Long iIdAppli ) RPCFUNC ALIAS FOR "sysadm.PS_I01_SMSPUSH" // 	[FNAC_PROD_ECH_TECH].[SMS]
// [FNAC_PROD_ECH_TECH], PHG, 10/04/2009
subroutine PS_S01_AGENCE (string sIdBq, string sIdAg,ref string sRetour,ref string sOk) RPCFUNC ALIAS FOR "sysadm.PS_S01_AGENCE"
subroutine PS_S12_COMMANDE ( long dcIdSin, long iIdSeq, ref string sRetour,ref string sOk) RPCFUNC ALIAS FOR "sysadm.PS_S12_COMMANDE"
subroutine PS_S01_DIV_DET (long dcIdSin, long iIdSeq, dec dcMtFact, ref string sRetour,ref string sOk ) RPCFUNC ALIAS FOR "sysadm.PS_S01_DIV_DET"
subroutine PS_S03_BOUTIQUE ( long dcIdSin, string sMagRempl, ref string sRetour,ref string sOk ) RPCFUNC ALIAS FOR "sysadm.PS_S03_BOUTIQUE"
subroutine PS_S13_COMMANDE ( long dcIdSin, long iIdSeq, ref string sRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S13_COMMANDE" // [DCMP090102][DCMP090140]
// [DCMP090310] - FPI - 01/07/2009
function long PS_INTEGRER_CONTACT_FACTURATION(long iIdTypTrait,string sIdSin,long iIdNatTache,string sTxtMsg,decimal{2} dcMtReg,string sNumFact,datetime dDteOdp,datetime dDteFact,datetime dDteRegSpb,string sIdOper,string sCodAction,ref string sErr) RPCFUNC ALIAS FOR "sysadm.PS_INTEGRER_CONTACT_FACTURATION"
// [CAMARA] - FPI - 03/08/2009
function long PS_U01_TRACE_FACT_A_REGL(long iIdCle,long iIdLot) RPCFUNC ALIAS FOR "sysadm.PS_U01_TRACE_FACT_A_REGL"
// [DCMP090440] - FPI - 20/10/2009
function long PS_VERIF_PARAM_FRAIS(decimal dcIdProd,string sIdFour,decimal dcIdGti,decimal dcIdProcess,ref long iIdSeq) RPCFUNC ALIAS FOR "sysadm.PS_VERIF_PARAM_FRAIS"
// [EXPANSION5.BOUTIQUES] - FPI - 06/11/2009
function long PS_I01_BOUTIQUE(decimal dcIdProd,string sCodBoutique,string sVille,string sAdrCp,string sNom,string sAdr1,string sAdr2,string sResponsable,string sLibPolice,string sFlagMaj,string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_I01_BOUTIQUE"
function long PS_V01_BOUTIQUE(decimal dcIdProd,string sCodBoutique,string sFlagMaj) RPCFUNC ALIAS FOR "sysadm.PS_V01_BOUTIQUE"
subroutine PS_S01_LIB_POLICE (decimal dcIdSin, decimal dcIdprod, decimal dcIdRev, decimal dcIdGti, ref String sLibPolice ) RPCFUNC ALIAS FOR "sysadm.PS_S01_LIB_POLICE" // [POLICE_PARTICULIERE]
function long PS_S01_LIB_POLICE_V01(decimal dcIdSin,decimal dcIdProd,decimal dcIdRev,decimal dcIdGti,long dcIdPolice,ref string sLibPolice) RPCFUNC ALIAS FOR "sysadm.PS_S01_LIB_POLICE_V01" // [PC683]
function long PS_S01_CTRL_REV(decimal dcIdprod,string sTypEffet,datetime dDteEff,ref datetime dDteMinProposee) RPCFUNC ALIAS FOR "sysadm.PS_S01_CTRL_REV"	// [20100204.FPI]
// FPI - 19/02/2010 - [DCMP100102]
function long PS_V02_SIN(decimal iIdSin) RPCFUNC ALIAS FOR "sysadm.PS_V02_SIN"
subroutine PS_S07_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S07_W_GTI_NBSIN" // JFF [DCMP100220] le 08/04/2010
subroutine PS_S08_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S08_W_GTI_NBSIN" // JFF [DCMP100220] le 08/04/2010

//*		JFF	29/04/2010	[ADRESSE_O2M] 
subroutine PS_S01_ADRESSE_O2M_V01 (long dcIdSin, string asCas, ref string asNomLigne1, ref string asNomLigne2, ref string asAdrLigne1, ref string asAdrLigne2, ref string asCP, ref string asVille ) RPCFUNC ALIAS FOR "sysadm.PS_S01_ADRESSE_O2M_V01"
// FPI - 18/06/2010 [DCMP100410]
function long PS_S09_W_GTI_NBGTI_ADHERENT(decimal dcIdSin,decimal dcIdProd,decimal dcIdEts,string sIdAdh,datetime dtSurv,decimal dcIdGti,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S09_W_GTI_NBGTI_ADHERENT"
function long PS_S10_W_GTI_NBGTI_ADHESION(decimal dcIdSin,decimal dcIdProd,decimal dcIdEts,string sIdAdh,decimal dcIdsDos,datetime dtSurv,decimal dcIdGti,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S10_W_GTI_NBGTI_ADHESION"
function long PS_S09_W_GTI_NBGTI_ADHERENT_V01(decimal dcIdSin,decimal dcIdProd,decimal dcIdEts,string sIdAdh,decimal dcIdsDos,datetime dtSurv,decimal dcIdGti,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S09_W_GTI_NBGTI_ADHERENT_V01"
function long PS_S10_W_GTI_NBGTI_ADHESION_V01(decimal dcIdSin,decimal dcIdProd,decimal dcIdEts,string sIdAdh,datetime dtSurv,decimal dcIdGti,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S10_W_GTI_NBGTI_ADHESION_V01"
// FPI - 27/07/2010 [PM72]
function long PS_GET_PARAM_FRAIS(decimal dcIdProd,string sIdFour,decimal dcIdGti,long lIdProcess,ref long iIdSeq,ref decimal{2} dcMontant,ref integer iTypRbt) RPCFUNC ALIAS FOR "sysadm.PS_GET_PARAM_FRAIS"
// FPI - 22/09/2010 [PC282]
function long PS_S11_SMSPUSH_ENVOI_BGE(decimal adcIdSin,ref string asCasRetour) RPCFUNC ALIAS FOR "sysadm.PS_S11_SMSPUSH_ENVOI_BGE"
// FPI - 07/12/2010 [20101207.FPI]
function long PS_S01_VERIF_COMPTE(string sIdappli,string sRibBq,string sRibGui,string sRibCpt,string sRibCle) RPCFUNC ALIAS FOR "sysadm.PS_S01_VERIF_COMPTE"

// JFF - 08/12/2010 [PC397][PC441][PC443]
subroutine PS_S12_W_GTI_NBGTI_PEC_ADHERENT(Long dcIdSin, long dcIdProd, long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,long dcIdGti,ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S12_W_GTI_NBGTI_PEC_ADHERENT"
subroutine PS_S11_W_GTI_NBGTI_PEC_ADHESION(Long dcIdSin, Long dcIdProd, Long dcIdEts,string sIdAdh,datetime dtSurv,Long dcIdGti,ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S11_W_GTI_NBGTI_PEC_ADHESION"
// FPI - 17/12/2010 [VDoc1306] - PC417
function long PS_S02_AFFILIER_SINISTRE(decimal dcIdProd,decimal dcIdRev,decimal dcIdGti,decimal dcIdCarte,ref datetime dtAffil) RPCFUNC ALIAS FOR "sysadm.PS_S02_AFFILIER_SINISTRE"
// FPI - 23/12/2010 [23122010.FPI]
function long DW_I01_W_COMMANDE(decimal dcIdSin,long iIdSeq,decimal dcIdGti,decimal dcIdDetail,string sIdFour,string sIdTypArt,string sIdMarqArt,string sIdModlArt,decimal{2} dcMtTtcCmde,string sAdrNom,string sAdrPrenom,string sAdrLivr1,string sAdrLivr2,string sAdrLivrCpl,string sAdrCp,string sAdrVille,string sAdrTel1,string sAdrTel2,string sAdrTel3,string sAdrMail,datetime dtRdvCli,string sHrdvCliMin,string sHrdvCliMax,string sIdSerieAnc,string sProbleme,string sIdCmdFrn,string sIdSerieNouv,string sIdBonTrsp,datetime dtRcpFrn,datetime dtEnvCli,string sCodEtat,string sCommentFrn,string sNomGest,datetime dtCreeLe,datetime dtMajLe,string sMajPar,string sIdZone,long iIdBsp,datetime dtRetPret,string sAdrCodCiv,string sIdRefFour,long iIdOrianMarque,long iIdOrianModele,datetime dtElvMobile,long iStatusGc,datetime dtEmisDevis,decimal{2} dcMtDevis,string sAltDevAcp,datetime dtDevAcp,string sAdrfcCodCiv,string sAdrfcNom,string sAdrfcPrenom,string sAdrfcLivr1,string sAdrfcLivr2,string sAdrfcLivrCpl,string sAdrfcCp,string sAdrfcVille,datetime dtRetLogis,datetime dtRetPretMin,datetime dtRetPretMax,long iIdAnn,datetime dtEnvBteFrn,datetime dtRcpBteCli,datetime dtDepBteCli,datetime dtEnvSt,datetime dtRcpMobCli,long iInfoSpbFrn,string sIdMarqArtIfr,string sIdModlArtIfr,string sInfoSpbFrnCplt,string sInfoFrnSpbCplt) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_COMMANDE"
function long DW_D01_W_DIV_DET(decimal dcIdSin,decimal dcIdGti,decimal dcIdDetail,string sNomZone) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_DIV_DET"
function long DW_I01_W_DIV_DET(decimal dcIdSin,decimal dcIdGti,decimal dcIdDetail,string sNomZone,string sLibLabel,string sIdTypListe,string sAltListeCodecar,string sIdTypZone,string sAltOblig,string sAltProt,long iCptTri,long iValNbre,decimal{2} dcValMt,datetime dtValDte,string sValCar,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_DIV_DET"
function long DW_D01_W_DIV_SIN(decimal dcIdSin,string sNomZone) RPCFUNC ALIAS FOR "sysadm.DW_D01_W_DIV_SIN"
function long DW_I01_W_DIV_SIN(decimal dcIdSin,string sNomZone,string sLibLabel,string sIdTypListe,string sAltListeCodecar,string sIdTypZone,string sAltOblig,string sAltProt,long iCptTri,long iValNbre,decimal{2} dcValMt,datetime dtValDte,string sValCar,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_W_DIV_SIN"
// FPI - 11/01/2011 [PC175]
function long PS_D01_BOUTIQUE_MCM(string sListeCodeMag) RPCFUNC ALIAS FOR "sysadm.PS_D01_BOUTIQUE_MCM"
// [PC363].[PANNE_PGC]
subroutine PS_S01_RECH_PGC_PANNE ( decimal dcIdSin, decimal dcIdProd, decimal dcIdEts, string sIdAdh, ref integer iPresence_Panne, ref integer iPresence_PGC, ref datetime dtDteRempl ) RPCFUNC ALIAS FOR "sysadm.PS_S01_RECH_PGC_PANNE "
// FPI - 05/04/2011 - [PC345]
function long PS_S13_W_GTI_NBSIN_NUM_PORT(decimal dcIdSin,decimal dcIdProd,string sNumPort,datetime dtSurv,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S13_W_GTI_NBSIN_NUM_PORT"
// FPI - 08/06/2011 [PC321.V9]
function long PS_S11_MAILPUSH_SAV_CARREFOUR(decimal adcIdSin,long aiIdSeq) RPCFUNC ALIAS FOR "sysadm.PS_S11_MAILPUSH_SAV_CARREFOUR"
// [VDoc3926]
function long PS_S01_VERIF_MODIF_MARQ_MODL(string sMarque,string sModele) RPCFUNC ALIAS FOR "sysadm.PS_S01_VERIF_MODIF_MARQ_MODL"
// FPI - 17/08/2011 - [PM72.2]
function long PS_VERIF_SIN_PARAM_FRAIS(decimal dcIdSin,ref long iTypRbt,ref decimal{2} dcMtRbt) RPCFUNC ALIAS FOR "sysadm.PS_VERIF_SIN_PARAM_FRAIS"
// JFF [PLAF_REF]
subroutine PS_S14_W_GTI_NBGTI_ADHESION (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti, Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S14_W_GTI_NBGTI_ADHESION"  // [PLAF_REF]
subroutine PS_S15_W_GTI_NBGTI_ADHERENT (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti, long dcIdsDos,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S15_W_GTI_NBGTI_ADHERENT" // [PLAF_REF]
// JFF - 27/05/2011 [PC10] [PM319-1] [RS972][OPTIM_MB3&4]
subroutine PS_S01_ARTICLE_DP150_V02 (decimal dcIdProd, string sMarqApp, string sMarqModl, ref decimal dcMtValTTC, String sChaineBCV ) RPCFUNC ALIAS FOR "sysadm.PS_S01_ARTICLE_DP150_V02"
subroutine PS_S01_CLE ( string sCle, ref integer iValeur ) RPCFUNC ALIAS FOR "sysadm.PS_S01_CLE"
// FPI [PC19] - 14/09/2011
function long PS_S12_MAILPUSH_LDE(decimal adcIdSin,long aiIdMail,ref string asCasRetour) RPCFUNC ALIAS FOR "sysadm.PS_S12_MAILPUSH_LDE"
// FPI - [VDoc4274] - 24/10/2011
function long PS_S01_POLICE(decimal dcIdProd,decimal dcIdRev,decimal dcIdGti,ref decimal dcIdCie) RPCFUNC ALIAS FOR "sysadm.PS_S01_POLICE"
// JFF - [PC581].[POINT155][VDOC5984] 22/11/2011
subroutine PS_S09_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S09_W_GTI_NBSIN"
subroutine PS_S10_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdsDos,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S10_W_GTI_NBSIN"
subroutine PS_S11_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S11_W_GTI_NBSIN"
subroutine PS_S12_W_GTI_NBSIN(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdsDos,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S12_W_GTI_NBSIN"
// [VDOC5983] JFF 09/12/2011
subroutine PS_S_COUR_PROD_PARA_APART1(decimal dcIdProd, decimal dcIdOrdre, ref string sIdPara) RPCFUNC ALIAS FOR "sysadm.PS_S_COUR_PROD_PARA_APART1"
// [RECUP_DONNEE_O2M]
function long PS_S_MAILPUSH_MAIL_AXALOT ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, String asCas, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S_MAILPUSH_MAIL_AXALOT" 
// [CONFO][CUISINE][PC680]
subroutine PS_S_W_DETAIL_NBEVT_GTI_ADHESION (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S_W_DETAIL_NBEVT_GTI_ADHESION"
subroutine PS_VERIF_CODE_RGPT_V01 (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long lIdRgpt,Ref String sChaine,Ref String sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_VERIF_CODE_RGPT_V01"
subroutine PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,Ref int iNbSin, Ref String sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION"
// :[CONFO][CUISINE][PC680]
// [PM200][PSM]
function long PS_S_ADRESSE_CENTRALE_PSM (decimal dcIdSin,string sCodMag,string asCas,ref string asNomLigne1,ref string asNomLigne2,ref string asAdrLigne1,ref string asAdrLigne2,ref string asCP,ref string asVille) RPCFUNC ALIAS FOR "sysadm.PS_S_ADRESSE_CENTRALE_PSM"
// [VDOC6993]
subroutine PS_S_VDOC6993_LIEN_ARTICLE (string sIdFour, String sIdRefFour, String sIdMarqArt,String sIdModlArt, ref String sIdMarqArtIFr, ref String sIdModlArtIFr) RPCFUNC ALIAS FOR "sysadm.PS_S_VDOC6993_LIEN_ARTICLE"
// [VDOC7271] Refonte substitution
subroutine PS_S_SUBSTITUTION (decimal dcIdProd, String sMarqAppOrig, String sModlAppOrig,integer iCptSubs, ref String sMarqAppSubs, ref String sModlAppSubs, ref Integer iNbreSubst ) RPCFUNC ALIAS FOR "sysadm.PS_S_SUBSTITUTION"
function long PS_I02_MAILPUSH(decimal adcIdSin,string asBase,string asMailFrom,string asMailSend,string asMailCc,string asMailCci,string asMailObjet,Blob bMailBody,string asBoiteMail,string asTypMail,long aiIdAppli,string asMethode,long aiIdArch,string asXMLData) RPCFUNC ALIAS FOR "sysadm.PS_I02_MAILPUSH"
// [VDOC7410] JFF 14/06/2012
subroutine PS_S_W_GTI_PLAF_ADHESION (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_PLAF_ADHESION"
subroutine PS_S_W_GTI_PLAF_ADHERENT (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,long dcIdGti,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_PLAF_ADHERENT"
// [PC767] FPI - 21/08/2012
function long PS_S16_MAILPUSH_ORANGE_REUNION(decimal adcIdSin,long aiIdSeq,ref string asCasRetour) RPCFUNC ALIAS FOR "sysadm.PS_S16_MAILPUSH_ORANGE_REUNION"
function long PS_S18_MAILPUSH_OUTREMER_TELECOM(decimal adcIdSin,long aiIdSeq,string asMtIndemn, ref string asCasRetour) RPCFUNC ALIAS FOR "sysadm.PS_S18_MAILPUSH_OUTREMER_TELECOM" // [PC874]
function long PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM(decimal adcIdSin,long aiIdSeq,ref string asCasRetour) RPCFUNC ALIAS FOR "sysadm.PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM"
function long PS_INTEGRER_CONTACT_CLIENT(long iIdClient,long iIdNatTache,string sTxtMsg,string sCodAction,string sIdOper) RPCFUNC ALIAS FOR "sysadm.PS_INTEGRER_CONTACT_CLIENT"
// [PC869] - JFF - 10/10/2012
subroutine PS_S_BOUTIQUE_ADRESSE (long dcIdProd, long iCodeMag, ref string sAdrNom, ref string sAdr1, ref string sAdr2, ref string sAdrVille, ref string sAdrCP ) RPCFUNC ALIAS FOR "sysadm.PS_S_BOUTIQUE_ADRESSE"
function long PS_U21_COMMANDE_STATUS_GC(decimal dcIdSin,long iIdSeq,string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_U21_COMMANDE_STATUS_GC"
// [PC877] - JFF - 26/11/2012
subroutine PS_S734_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S734_W_GTI_MT_PLAF"
subroutine PS_S735_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S735_W_GTI_MT_PLAF"
subroutine PS_S736_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S736_W_GTI_MT_PLAF"
subroutine PS_S737_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdsDos,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S737_W_GTI_MT_PLAF"
subroutine PS_S738_W_GTI_MT_PLAF(long dcIdSin,long dcIdProdAdh,string sIdSiren,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S738_W_GTI_MT_PLAF"
subroutine PS_S_W_SIN_NBRE_SIN_EC(long dcIdSin,long dcIdProdAdh,long dcIdEts,string sIdAdh,string sSIREN,Ref string sChaine) RPCFUNC ALIAS FOR "sysadm.PS_S_W_SIN_NBRE_SIN_EC"
// [PC801]
function long PS_S01_SINISTRE_NBSIN_REGLES(decimal dcIdSin,decimal dcIdProd,decimal dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,ref long iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S01_SINISTRE_NBSIN_REGLES"
function long PS_MAJ_TAUX_MASSE(string asIdFour,decimal{5} adcOldTaux,decimal{5} adcNewTaux,string asCodOper) RPCFUNC ALIAS FOR "sysadm.PS_MAJ_TAUX_MASSE"

subroutine PS_PRESENCE_WSIN (long dcIdSin,Ref string sRet) RPCFUNC ALIAS FOR "sysadm.PS_PRESENCE_WSIN"

// [PC801_LOT1_V2] 28/03/2013 JFF
Subroutine PS_S_RMFR (long dcIdSin, Long dcIdReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RMFR"

// [PC929] 03/04/2013 JFF
Subroutine PS_GET_VTS_PEC ( Long alIdProd, String asIdTypArt, DateTime adtDteSurv, DateTime adtDteAchat, Ref String dcTxVTs ) RPCFUNC ALIAS FOR "sysadm.PS_GET_VTS_PEC"
Subroutine PS_GET_VTS_PEC_V01(Long alIdProd,string asIdTypArt,Long alIdGti,datetime adtDteSurv,datetime adtDteAchat,ref string sdcTxVts) RPCFUNC ALIAS FOR "sysadm.PS_GET_VTS_PEC_V01"

function long PS_V01_RECOPIE_PRODUIT(decimal dcIdProdSource,string sBaseSource) RPCFUNC ALIAS FOR "sysadm.PS_V01_RECOPIE_PRODUIT"
function long PS_I02_RECOPIE_PRODUIT(decimal dcIdProdSource,string sBaseSource,string sBaseDest, string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_I02_RECOPIE_PRODUIT"

// [PC938_ORANGE_V3]
Subroutine PS_S_VAL_W_DIV_SIN ( Long alIdSin, String asNomZone, Ref String asVal ) RPCFUNC ALIAS FOR "sysadm.PS_S_VAL_W_DIV_SIN"
Subroutine PS_S_VAL_W_DIV_SIN_V01 ( Long alIdSin, String asNomZone, Ref String asVal, Ref DateTime dtMajLe ) RPCFUNC ALIAS FOR "sysadm.PS_S_VAL_W_DIV_SIN_V01"
function long PS_D01_IMEI_ORANGEV3() RPCFUNC ALIAS FOR "sysadm.PS_D01_IMEI_ORANGEV3"
function long PS_S01_CTL_IMEI_ORANGEV3 ( string sNumPort, String sNumIMEI ) RPCFUNC ALIAS FOR "sysadm.PS_S01_CTL_IMEI_ORANGEV3"
function long PS_S01_CTL_IMEI_ORANGEV3_V01(string sNumPort,string sNumImei,datetime dtDteSurv) RPCFUNC ALIAS FOR "sysadm.PS_S01_CTL_IMEI_ORANGEV3_V01"

// [VDOC9908]
function long PS_S_MAILPUSH_ENV_APP_REMPL ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, DateTime dtDteEnvCli, Long lStatusGc, String sDestCli, String sCommentFr, String sNumBonTrsp, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S_MAILPUSH_ENV_APP_REMPL"
function long PS_S01_DET_PRO(decimal dcIdProd,long iIdCodeDP) RPCFUNC ALIAS FOR "sysadm.PS_S01_DET_PRO"

// [PC938_ORANGE_V3_V10] 06/09/2013 JFF
Subroutine PS_S_RMRP_CAUTION (long dcIdSin, Long dcIdReg, String sCodMotReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RMRP_CAUTION"
// [PC938_ORANGE_V3_V10] 06/09/2013 JFF
Subroutine PS_S_RN_FRAIS_SPECIAUX  (long dcIdSin, Long dcIdReg, String sCodMotReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RN_FRAIS_SPECIAUX"

// [PC845] JFF 25/09/2013
subroutine PS_S_W_DETAIL_MT_PLAF_EVT_REGLE (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdEvt,Ref string dcMtPrej ) RPCFUNC ALIAS FOR "sysadm.PS_S_W_DETAIL_MT_PLAF_EVT_REGLE"
function long PS_S01_CTL_IMEI_ORANGECARAIBE(string sNumPort,string sNumImei,datetime dtDteSurv) RPCFUNC ALIAS FOR "sysadm.PS_S01_CTL_IMEI_ORANGECARAIBE"

// [VDOC11880]
subroutine PS_S03_W_GTI_NBSIN_DTE_SURV (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S03_W_GTI_NBSIN_DTE_SURV"
subroutine PS_S09_W_DETAIL_NBEVT_DTE_SURV(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S09_W_DETAIL_NBEVT_DTE_SURV"

// JFF 07/10/2013 [DT044-1_V5]
function long PS_S01_PARAM_FRAIS_DEFAUT(decimal dcIdProcess,ref decimal{2} dcMontant) RPCFUNC ALIAS FOR "sysadm.PS_S01_PARAM_FRAIS_DEFAUT" // [VDoc12347]
Subroutine PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT  (long dcIdSin, Long dcIdReg, String sCodMotReg, String sCodModeReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT"

// [PC947] JFF
function long PS_U_DETAIL_MAJ_FACTU_EN_XA_PC947_977 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44" 

// [PM217-2] FPI
function long Iwd_Update_Iwd_Router_Dossier(string sIdSin,string sIdCorb,string sOper,string sMess) RPCFUNC ALIAS FOR "sysadm.Iwd_Update_Iwd_Router_Dossier" 

// JFF 28/01/2014 [VDOC12917]
function long PS_I_RM_AVOIR_VDOC12917_V01 (long dcIdSin, integer iIdSeq, string sIdFour, real dcMtAvoir, string sLibRM, string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RM_AVOIR_VDOC12917_V01" 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_I_RM_AVOIR_VDOC12917_V02 (long dcIdSin, integer iIdSeq, string sIdFour, real dcMtAvoir, string sLibRM, string sCodOper, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RM_AVOIR_VDOC12917_V02" 

// JFF   30/11/2016 [PM375-1]
function long PS_I_RP_AVOIR_PM375 (long dcIdSin, integer iIdSeq, string sIdFour, real dcMtAvoir, string sLibRP, string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RP_AVOIR_PM375" 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer 00 quand V01 définitivement en prod.
function long PS_I_RP_AVOIR_PM375_V01 (long dcIdSin, integer iIdSeq, string sIdFour, real dcMtAvoir, string sLibRP, string sCodOper, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RP_AVOIR_PM375_V01" 

function long PS_I_RM_SIMPLE_PM375 (long dcIdSin, long dcIdRegBase, real dcMtRM, string sLibRM, string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RM_SIMPLE_PM375" 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer 00 quand V01 définitivement en prod.
function long PS_I_RM_SIMPLE_PM375_V01 (long dcIdSin, long dcIdRegBase, real dcMtRM, string sLibRM, string sCodOper, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RM_SIMPLE_PM375_V01" 

function long PS_I_RP_SIMPLE_PM375 (long dcIdSin, long dcIdRegBase, real dcMtRP, string sLibRP, string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RP_SIMPLE_PM375" 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer 00 quand V01 définitivement en prod.
function long PS_I_RP_SIMPLE_PM375_V01 (long dcIdSin, long dcIdRegBase, real dcMtRP, string sLibRP, string sCodOper, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RP_SIMPLE_PM375_V01" 


function long PS_I_RN_FRAIS_FACTU_PM375 ( long dcIdSin, real dcMtRN, string sLibRN, String sIdFourFct, string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RN_FRAIS_FACTU_PM375"

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer 00 quand V01 définitivement en prod.
function long PS_I_RN_FRAIS_FACTU_PM375_V01 ( long dcIdSin, real dcMtRN, string sLibRN, String sIdFourFct, string sCodOper, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_I_RN_FRAIS_FACTU_PM375_V01"


// JFF 06/02/2014 [VDOC12845]
function long PS_S_REGL_PRESTA_VDOC12845  (long dcIdSin, Ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_S_REGL_PRESTA_VDOC12845"

// JFF 13/02/2014 [DT57_CMDE_IPHONE_SFR]
function long PS_S_RECH_ART_NEUF  ( string sMarqueIfr, string sModeleIfr, Ref Decimal {2} dcMtTTC, Ref String sIdRefFour ) RPCFUNC ALIAS FOR "sysadm.PS_S_RECH_ART_NEUF"
// [PC925] - FPI - 26/03/2014
function long PS_U01_COMMANDE_SRR(decimal dcIdSin,long iIdSeq,string sIdCmdFrn) RPCFUNC ALIAS FOR "sysadm.PS_U01_COMMANDE_SRR"

// JFF   07/05/2013 [-1]
function long PS_S_MAILPUSH_ARR_PLATFORM ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, DateTime dtDteArrPlatForm, Long lStatusGc, String sCommentFr, String sNumBonTrsp, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S_MAILPUSH_ARR_PLATFORM"
function long PS_S_MAILPUSH_DEP_CENTRDISTRIB ( string sIdAppli, string sBase, long dcIdSin, long iIdSeq, DateTime dtDteDepCentrDistrib, Long lStatusGc, String sCommentFr, String sNumBonTrsp, ref string sCasRetour ) RPCFUNC ALIAS FOR "sysadm.PS_S_MAILPUSH_DEP_CENTRDISTRIB"

// JFF   16/05/2014 [VDOC14454]
subroutine PS_S_CODE_CORRES (String sIdFour, String sLibFour, Ref String sCodeSPB ) RPCFUNC ALIAS FOR "sysadm.PS_S_CODE_CORRES"
// JFF   22/03/2016 [PM289-3]
subroutine PS_S_CODE_CORRES_V01 (String sIdFour, String sIdCtg3, Ref String sCodeSPB ) RPCFUNC ALIAS FOR "sysadm.PS_S_CODE_CORRES_V01"

function long PS_S01_CTL_IMEI_ORANGEV3_V02(string sNumPort,string sNumImei,datetime dtDteSurv,ref datetime dtDteTrans) RPCFUNC ALIAS FOR "sysadm.PS_S01_CTL_IMEI_ORANGEV3_V02"

// JFF   27/08/2014 [PI052]
subroutine PS_S_WCBA_KSL_FORMAT (decimal dcIdSin, decimal dcIdInter, decimal dcIdDoc, Ref String sFormatDoc ) RPCFUNC ALIAS FOR "sysadm.PS_S_WCBA_KSL_FORMAT"

// FPI - 16/10/2014 [PC14639]
function long PS_U01_COMMANDE_SRR_V01(decimal dcIdSin,long iIdSeq,string sIdCmdFrn,string sMess,string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_U01_COMMANDE_SRR_V01"

// JFF   15/10/2014 [OPTIM_IFR]
subroutine PS_S_VERIF_TYPE_MARQ_MODL (decimal dcIdSin, String sMarque, String sModele, String sTypApp, Ref String sResult ) RPCFUNC ALIAS FOR "sysadm.PS_S_VERIF_TYPE_MARQ_MODL"

//       JFF   04/11/2014 [PM280-1]
function String FN_CODE_CAR (String sIdCode, String sIdTypCode ) RPCFUNC ALIAS FOR "sysadm.FN_CODE_CAR"

//       JFF   10/11/2014 [PC801-5]
subroutine PS_S_W_GTI_NBSIN_RESIL_ADH(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH"

//       JFF   27/06/2016 [DT247]
subroutine PS_S_W_GTI_NBSIN_RESIL_ADH_DATA (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH_DATA"

// [PI052]
subroutine PS_S_TYPE_DOC_PI052 ( long dcIdSin, long dcIdInter, long dcIdDoc, Ref String sTypFormat ) RPCFUNC ALIAS FOR "sysadm.PS_S_TYPE_DOC_PI052"

// [PM251-2]
function Long PS_U_PREPA_VAL_AUTO_PM251_V01 ( long dcIdSin, long dcIdInter, String sCodOper, String sChaine, Ref Long dcIdProd, Ref String sResult ) RPCFUNC ALIAS FOR "sysadm.PS_U_PREPA_VAL_AUTO_PM251_V01"
function Long PS_U_MAJ_CONTACT_PM251 ( long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_U_MAJ_CONTACT_PM251"

// [PC13321]
function Long PS_S_ID_SEQ_NUM_CARTE_ED ( Long dcIdSin, String sNumCarteED, Ref Long iIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_S_ID_SEQ_NUM_CARTE_ED"

// [VERIF_REVSVN]
function Long PS_S_VERIF_REV_SVN (long aiRevSvn, String asCodOper, String asChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_VERIF_REV_SVN"

//       JFF   16/02/2015 [CONSULT_RESTREINTE]
function Long PS_S_CONSULT_RESTREINTE (String asCodOper, Long dcIdSin, String asChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_CONSULT_RESTREINTE "

//       JFF   19/02/2015 [VDOC15533]
subroutine PS_S_SKU_IFR ( String sMarqIFR, String sModlIFR, Ref String sSkuIFR ) RPCFUNC ALIAS FOR "sysadm.PS_S_SKU_IFR"

//       JFF   07/04/2015 [PC13442-1]
subroutine PS_S_BOUTIQUE_ADRESSE_2 (long dcIdProd, long iCodeMag, ref string sAdrMail, ref string sAdrNom, ref string sAdr1, ref string sAdr2, ref string sAdrVille, ref string sAdrCP ) RPCFUNC ALIAS FOR "sysadm.PS_S_BOUTIQUE_ADRESSE_2"

// 		JFF	11/06/2015 [VDOC17887]
function long PS_S_CMDE_VAL_NON_GEN(string asIdFour,string asIdTypArt,string asIdRefFour,string asIdMarqArt,string asIdModlArt) RPCFUNC ALIAS FOR "sysadm.PS_S_CMDE_VAL_NON_GEN"

// [DT162] JFF 09/09/2015
subroutine PS_S750_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S750_W_GTI_MT_PLAF"
subroutine PS_S751_W_GTI_NBSIN_DTE_SURV (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S751_W_GTI_NBSIN_DTE_SURV"
// [VDOC25099] JFF 17/11/2017
subroutine PS_S755_W_GTI_NBSIN_DTE_SURV (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S755_W_GTI_NBSIN_DTE_SURV"

subroutine PS_S_LECTURE_LOT_CMD (long dcIdSin, long iIdSeq, Ref long iIdLotCmd ) RPCFUNC ALIAS FOR "sysadm.PS_S_LECTURE_LOT_CMD"

// JFF - 10/02/2016 [VDOC19467]
function long PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH (decimal dcIdSin,decimal dcIdProd,long dcIdEts,string sIdAdh,string sNumPort,datetime dtSurv,datetime dtAdhRenouv,ref integer iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH"

// JFF   29/03/2016 [DT200]
subroutine PS_S_W_QUEUE_COD_TYP_RECU ( decimal dcIdSin, Ref String sCodTypRecu ) RPCFUNC ALIAS FOR "sysadm.PS_S_W_QUEUE_COD_TYP_RECU"


//       JFF   11/04/2016 [PM336-1]
function long PS_U03_DETAIL_MAJ_FACTU_V01 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U03_DETAIL_MAJ_FACTU_V01" // [DCMP080166] Ajout sCatFact

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_U03_DETAIL_MAJ_FACTU_V02 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U03_DETAIL_MAJ_FACTU_V02" // [DCMP080166] Ajout sCatFact


//       JFF   11/04/2016 [PM336-1]
function long PS_U031_DETAIL_MAJ_FACTU_V01 (long dcIdSin, integer iIdSeq, string sIdFourn, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U031_DETAIL_MAJ_FACTU_V01" // [FACTU_VIP_CDS] PS_U031_DETAIL_MAJ_FACTU  22/10/2014

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V2 quand V3 définitivement en prod.
function long PS_U031_DETAIL_MAJ_FACTU_V02 (long dcIdSin, integer iIdSeq, string sIdFourn, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U031_DETAIL_MAJ_FACTU_V02" // [FACTU_VIP_CDS] PS_U031_DETAIL_MAJ_FACTU  22/10/2014


//       JFF   11/04/2016 [PM336-1]
function long PS_U032_DETAIL_MAJ_FACTU_V01 (long dcIdSin, String sCasIdSeq, string sIdFourn, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U032_DETAIL_MAJ_FACTU_V01" // [VDOC14469] JFF 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V2 quand V3 définitivement en prod.
function long PS_U032_DETAIL_MAJ_FACTU_V02 (long dcIdSin, String sCasIdSeq, string sIdFourn, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U032_DETAIL_MAJ_FACTU_V02" // [VDOC14469] JFF 

function long PS_U04_DETAIL_MAJ_FACTU (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U04_DETAIL_MAJ_FACTU" // [DCMP080166] Ajout sCatFact
//       JFF   11/04/2016 [PM336-1]
function long PS_U04_DETAIL_MAJ_FACTU_V02 (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U04_DETAIL_MAJ_FACTU_V02" // [DCMP080166] Ajout sCatFact [PM251-2]

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V2 quand V3 définitivement en prod.
function long PS_U04_DETAIL_MAJ_FACTU_V03 (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U04_DETAIL_MAJ_FACTU_V03" // [DCMP080166] Ajout sCatFact [PM251-2]

//       JFF   11/04/2016 [PM336-1]
function long PS_U05_DETAIL_MAJ_FACTU_V01 (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U05_DETAIL_MAJ_FACTU_V01" // [DCMP080461] Factu. Hors Prestation

//       JFF   11/04/2016 [PM336-1]
function long PS_U06_DETAIL_MAJ_FACTU_V01 (long dcIdSin, long dcIdSeq, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, string sSocCptable, string sMagRempl, string sHeuTicket, string sCaisse, string sHote, string sTicket, real dcMt_ticket, string sLstFacture, string sLstArticle1, string sLstArticle2, string sLstArticle3, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U06_DETAIL_MAJ_FACTU_V01" // [FNAC_PROD_ECH_TECH]

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V2 quand V3 définitivement en prod.
function long PS_U06_DETAIL_MAJ_FACTU_V02 (long dcIdSin, long dcIdSeq, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, string sSocCptable, string sMagRempl, string sHeuTicket, string sCaisse, string sHote, string sTicket, real dcMt_ticket, string sLstFacture, string sLstArticle1, string sLstArticle2, string sLstArticle3, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U06_DETAIL_MAJ_FACTU_V02" // [FNAC_PROD_ECH_TECH]

// [VDOC9586] // JFF 03/09/2014 [DT92_FACTU_CASTO]
//       JFF   11/04/2016 [PM336-1]
function long PS_U08_DETAIL_MAJ_FACTU_V02 (long dcIdSin, String sIdFourFactu, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_U08_DETAIL_MAJ_FACTU_V02" 
//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V2 quand V3 définitivement en prod.
function long PS_U08_DETAIL_MAJ_FACTU_V03 (long dcIdSin, String sIdFourFactu, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_U08_DETAIL_MAJ_FACTU_V03"

// [DT57_CMDE_IPHONE_SFR]
//       JFF   11/04/2016 [PM336-1]
function long PS_U09_DETAIL_MAJ_FACTU_V01 (long dcIdSin, String sIdFourFactu, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U09_DETAIL_MAJ_FACTU_V01" 

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_U09_DETAIL_MAJ_FACTU_V02 (long dcIdSin, String sIdFourFactu, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U09_DETAIL_MAJ_FACTU_V02" 

// JFF 07/10/2013 [DT044-1_V5]
function long PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V01 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V01" // [DT044-1_V5]

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02" // [DT044-1_V5]


// JFF 05/11/2013 [PM210]
function long PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V01 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V01" // [PM210]

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02 (long dcIdSin, integer iIdSeq, datetime dtDteFact,string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite ) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02" // [PM210]


// JFF 05/11/2013 [PM210]
function long PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V02 (decimal dcIdProd,decimal dcIdEts,string sIdAdh,string sIdFour, datetime dtDteFact,string sNumFact,decimal{2} dcMtFact,string sCatFact, String sChaine,ref string sAltTraite) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V02"

//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V1 quand V2 définitivement en prod.
function long PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03 (decimal dcIdProd,decimal dcIdEts,string sIdAdh,string sIdFour, datetime dtDteFact,string sNumFact,decimal{2} dcMtFact,string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine,ref string sAltTraite) RPCFUNC ALIAS FOR "sysadm.PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03"


// JFF 30/05/2017 [PC151259-2]
function long PS_U10_DETAIL_MAJ_FACTU_ADVISE (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U10_DETAIL_MAJ_FACTU_ADVISE" 


//       JFF   09/09/2022   [PM80_FA12_FRANEX]  Supprimer V0 quand V1 définitivement en prod.
function long PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01 (long dcIdSin, string sIdFourn, datetime dtDteFact, string sNumFact, real dcMtFact, string sCatFact, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sChaine, ref string sAltTraite, ref Long lIdSeq ) RPCFUNC ALIAS FOR "sysadm.PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01" 


// JFF 07/06/2016 [DT227]
subroutine PS_S_DATE_PIVOT ( string asCle, Ref DateTime dtDt1, Ref DateTime dtDt2, Ref DateTime dtDt3 ) RPCFUNC ALIAS FOR "sysadm.PS_S_DATE_PIVOT"

// FPI 14/09/2016 [PC151259]
function long PS_S_ARCHIVE_REPONSE(long idArchive,string cle,ref string val,ref string libval) RPCFUNC ALIAS FOR "sysadm.PS_S_ARCHIVE_REPONSE"

// JFF 03/11/2016 [DT276]
function long PS_S_VERIF_MARQ_MODL_IFR_V01 (decimal dcIdProd, String sIdTypArt, String sMarq, string sModl ) RPCFUNC ALIAS FOR "sysadm.PS_S_VERIF_MARQ_MODL_IFR_V01"

// JFF 07/11/2016 [PC151259]
subroutine PS_S_BOUTIQUE_ADRESSE_3 (long dcIdProd, String sIdFour, String sCodeMag, ref string sAdrMail, ref string sAdrNom, ref string sAdr1, ref string sAdr2, ref string sAdrVille, ref string sAdrCP ) RPCFUNC ALIAS FOR "sysadm.PS_S_BOUTIQUE_ADRESSE_3"

// JFF 08/12/2016 [VDOC22083]
function long PS_CTRLE_ID_FOUR_FCT_V01 ( long dcIdSin, String sIdFourFct, Ref String sIdFourAG  ) RPCFUNC ALIAS FOR "sysadm.PS_CTRLE_ID_FOUR_FCT_V01"

//       JFF   10/01/2017 [DT262][V3]
subroutine PS_S01_SINISTRE_ZVAR_DT262 ( long dcIdSin, Ref String asZvarNbreIndem, Ref String asZvarIndem) RPCFUNC ALIAS FOR "sysadm.PS_S01_SINISTRE_ZVAR_DT262"

//       JFF   02/03/2017 
subroutine PS_S_SAGA2_INTERRO_IFR ( String sMarque, String sModele, Ref Decimal {2} dcPrixPublic ) RPCFUNC ALIAS FOR "sysadm.PS_S_SAGA2_INTERRO_IFR"
function long DW_S_VDOC23002_NBCOL(string sListeIdSin) RPCFUNC ALIAS FOR "sysadm.DW_S_VDOC23002_NBCOL"

//       JFF   11/04/2017 
function long PS_S_CONTROLE_VALIDATION ( long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_S_CONTROLE_VALIDATION"
function long PS_S_CONTROLE_DBLT_REGLT ( long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_S_CONTROLE_DBLT_REGLT"

// FPI - 01/12/2017 
subroutine PS_S_BOUTIQUE_ADRESSE_4 (long dcIdProd, String sIdFour, String sCodeMag, ref string sAdrMail, ref string sAdrNom, ref string sAdr1, ref string sAdr2, ref string sAdrVille, ref string sAdrCP, ref string sAdrTel ) RPCFUNC ALIAS FOR "sysadm.PS_S_BOUTIQUE_ADRESSE_4"
function long PS_I03_BOUTIQUE(string sCodBoutique,string sNom,string sAdr1,string sAdr2,string sAdrCp,string sVille,string sNoTel,string sAdrMail,string sMajPar) RPCFUNC ALIAS FOR "sysadm.PS_I03_BOUTIQUE"

//  JFF   23/01/2018 [PM407-1]
function long PS_S_PM407_CONSULT_KSL (long dcIdSin, long dcIdInter, long dcIdDoc ) RPCFUNC ALIAS FOR "sysadm.PS_S_PM407_CONSULT_KSL"
function long PS_S_PM407_NOUVEAU_SYSTEME (String sCas, long dcIdProd, Long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_S_PM407_NOUVEAU_SYSTEME"

// FPI - 23/02/2018 [PSM_FERME]
function long PS_I_CTL_BOUTIQUE_PSM(decimal dcIdSin,string sCodeMag,string sCodOper,string sRequest,string sResponse) RPCFUNC ALIAS FOR "sysadm.PS_I_CTL_BOUTIQUE_PSM"

//  JFF   06/03/2018 [DT341]
subroutine PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL"

// [PC151425-1] 11/06/2013 JFF
Subroutine PS_S_REMB_RNFR (long dcIdSin, Long dcIdReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_REMB_RNFR"

// [DT339]
function long PS_U_COMMANDE_AAS(decimal dcIdSin,long iIdSeq,string sMarq,string sModl,string sMarqIfr,string sModlIfr,string sIdSerieNouv,decimal{2} dcMtTTCCmde) RPCFUNC ALIAS FOR "sysadm.PS_U_COMMANDE_AAS"

// [DT344]
// JFF   08/10/2024 [MCO194]
function long PS_S_SOUPLESSE_V01 (decimal dcIdProd,decimal id_rev, decimal dcIdGti,string sIdSpl ) RPCFUNC ALIAS FOR "sysadm.PS_S_SOUPLESSE_V01"

// [PC171999]
subroutine PS_S_W_GTI_MT_PLAF_756 (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,string sTypPers, long dcIdGti,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_MT_PLAF_756"
subroutine PS_S_W_DETAIL_MT_PLAF_756 (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,string sTypPers,long dcIdGti,long dcIdEvt,datetime dtSurv,datetime dtAdhRenouv,Ref string dcMtPrej) RPCFUNC ALIAS FOR "sysadm.PS_S_W_DETAIL_MT_PLAF_756"

// [CONS_REST_CARDIF]
function long PS_S_CONS_RESTR_EXCL(long dcIdSin, string sIdOper, String sTable ) RPCFUNC ALIAS FOR "sysadm.PS_S_CONS_RESTR_EXCL"

// [MSG_SIM_VERSION_BASE]
subroutine PS_S_DETECT_VERSION_BASE_SIM ( Ref datetime dtDteVersBaseSim, Ref Integer iAlerte ) RPCFUNC ALIAS FOR "sysadm.PS_S_DETECT_VERSION_BASE_SIM"

//  JFF   18/12/2018 [PM471-1]
subroutine PS_S_LIB_CIE ( decimal dcIdSin, decimal dcIdRev, decimal dcIdGti, ref String sLibCie ) RPCFUNC ALIAS FOR "sysadm.PS_S_LIB_CIE"

//  JFF   10/01/2019 [SHUNT_WS_SEPA]
function long PS_S02_AGENCE ( string sIdBq, string sIdAg ) RPCFUNC ALIAS FOR "sysadm.PS_S02_AGENCE"

//  JFF   14/02/2019 [PM473-1]
function long PS_U_TRT_PM260 ( decimal dcIdSin, string sCas ) RPCFUNC ALIAS FOR "sysadm.PS_U_TRT_PM260"
function long PS_CTLE_DOS_CREE_EN_SIM ( decimal dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_CTLE_DOS_CREE_EN_SIM"

//  JFF   27/05/2019 [PM478-1]
function long PS_U_PM02_PM478_MAJ_CUM_FTU_BRK (long lIdCum, long lIdTrt, long lIdPeriode, long lIdSin, long lIdSeq, string sAccordBrk, real dcMtFactTtcModifBrk, string sCommentBrk, real dcMtFactTtcForceSPB, string sCommentSPB,string sCodOper, ref string sResult ) RPCFUNC ALIAS FOR "sysadm.PS_U_PM02_PM478_MAJ_CUM_FTU_BRK" 

//  JFF   24/06/2019 [PC192235]
subroutine PS_S757_W_GTI_MT_PLAF (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Long dcIdGti, Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S757_W_GTI_MT_PLAF"
subroutine PS_S758_W_GTI_NBGTI_DTE_SURV (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,datetime dtAdhRenouv,Long dcIdGti, Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S758_W_GTI_NBGTI_DTE_SURV"

//  JFF   07/08/2019 [PM462-1][V3]
Function Long PS_I_PM462_1_CTRLE_REMB_FRANCHISE (long dcIdSin,String sCas,decimal adcMtFranCBprej) RPCFUNC ALIAS FOR "sysadm.PS_I_PM462_1_CTRLE_REMB_FRANCHISE"

// FPI 	07/10/2019	[VDOC28472]
function long PS_S_VDOC28472(decimal dcIdSin,decimal{2} dcMtReg,string sIdFour,ref string sRet) RPCFUNC ALIAS FOR "sysadm.PS_S_VDOC28472"

// [PM462-1][V3] 08/10/2019 JFF
Subroutine PS_S_RPFR (long dcIdSin, Long dcIdReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RPFR"
function long PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB ( long dcIdSin, long iIdSeq, Ref Decimal {2} dcMtFranchiseARemb ) RPCFUNC ALIAS FOR "sysadm.PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB"
Subroutine PS_S_FM_ALD_C_CAS_PART (long dcIdSin, Long dcIdReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_FM_ALD_C_CAS_PART"
Subroutine PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART (long dcIdSin, Long dcIdReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART "
function long PS_S_PRESENCE_FRANCHISE_CB ( long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_S_PRESENCE_FRANCHISE_CB"

// JFF      22/10/2019   [PI087_PM473_2]
function long PS_I_PI087_TRACE_DOSSIER_V01 ( long dcIdSin, String sCas, String sCodOper, Long dcIdInter, Long dcIdDoc ) RPCFUNC ALIAS FOR "sysadm.PS_I_PI087_TRACE_DOSSIER_V01"

//	JFF   31/10/2019	[VDOC28559]
subroutine PS_S_ID_CIE ( long dcIdSin, long dcIdRev, long dcIdGti, ref long dcIdCie ) RPCFUNC ALIAS FOR "sysadm.PS_S_ID_CIE"
Function long PS_S03_DET_PRO ( long dcIdProd, long iIdCodeDP, ref string sIdTypCalc, ref long iIdCodeNum, ref string sIdCodeCar, ref Long iValNum, ref string sValCar, ref string sValCar2 ) RPCFUNC ALIAS FOR "sysadm.PS_S03_DET_PRO"

// JFF   26/11/2019 [PC192290]
subroutine PS_S734_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdEvt, datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S734_W_DETAIL_MT_PLAF"

// JFF   29/11/2019 [TRACE_TS_COURRIER]
subroutine PS_I_TRACE_TS_COURRIER (long dcIdSin, string sIdSql, string sTRypeTrt, string sIdCour, long dcIdInter, long dcIddoc, string sCodOper, Int iRetour,Ref long iIdentidy ) RPCFUNC ALIAS FOR "sysadm.PS_I_TRACE_TS_COURRIER"

//       JFF   06/01/2020 
function String FN_CODE_NUM (Int iIdCode, String sIdTypCode ) RPCFUNC ALIAS FOR "sysadm.FN_CODE_NUM"

// [MSG_SIM_VERSION_BASE]
subroutine PS_S_DETECT_SQL_QUOT_BASE_SIM ( Ref datetime adtDteSqlQuotBaseSim, Ref Integer iAlerte ) RPCFUNC ALIAS FOR "sysadm.PS_S_DETECT_SQL_QUOT_BASE_SIM"

//       JFF   19/02/2020 
function Int PS_S_TRACE_JOURNAL_DELAI ( ) RPCFUNC ALIAS FOR "sysadm.PS_S_TRACE_JOURNAL_DELAI"

// JFF   29/11/2019 [TRACE_TS_COURRIER]
subroutine PS_S_RECUP_ID_CLIENT (long iIdSin, ref long iIdCli ) RPCFUNC ALIAS FOR "sysadm.PS_S_RECUP_ID_CLIENT"

// JFF   23/06/2020 [PC202553_SELECTRA]
subroutine PS_S_RECUP_PARAM_ZONE_DIV_PRO (long asdcIdProd, string asNomZone, Ref string asIdTypListe, Ref String asAltListeCodeCar, Ref string asIdTypZone ) RPCFUNC ALIAS FOR "sysadm.PS_S_RECUP_PARAM_ZONE_DIV_PRO"
subroutine PS_S_SYS_EXPLOIT_APP_IFR (String asMarqueIfr, string asModeleIfr, Ref string asSysExploit ) RPCFUNC ALIAS FOR "sysadm.PS_S_SYS_EXPLOIT_APP_IFR"

// JFF   26/08/2020 [CTRLE_SUPL_PM72]
function Int PS_S_CTRLE_EXISTS_RGLT ( long dcIdSin ) RPCFUNC ALIAS FOR "sysadm.PS_S_CTRLE_EXISTS_RGLT"


// JFF   08/09/2020 [PC202551]
subroutine PS_S759_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S759_W_GTI_MT_PLAF"
subroutine PS_S759_W_DETAIL_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdEvt, datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S759_W_DETAIL_MT_PLAF"

// JFF   15/09/2020 [DT386_COST_CENTER]
Subroutine PS_S_RN_AVEC_COST_CENTER  (long dcIdSin, Long dcIdReg, String sCodMotReg, String sCodModeReg, Ref string sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_RN_AVEC_COST_CENTER"

// JFF   07/05/2013 [DT509]
subroutine PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611 (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,long dcIdGti,datetime dtSurv,datetime dtAdhRenouv, long dcIdNatSin, Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611"

// JFF   02/11/2020 [VDOC]
subroutine PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION  (long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh, long dcIdGti, datetime dtSurv,Ref int iNbSin) RPCFUNC ALIAS FOR "sysadm.PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION"

// JFF   03/03/2020 
subroutine PS_DECRYPTE_NUM_CARTE ( Ref String asRacine, String asValSubst ) RPCFUNC ALIAS FOR "sysadm.PS_DECRYPTE_NUM_CARTE"

// JFF   07/06/2021 [RS-496]
subroutine PS_S_PRESENCE_PRE_SCRIPT  (	Long aiIdProd, String asIdCanal, Ref Long aiIdScriptDeb ) RPCFUNC ALIAS FOR "sysadm.PS_S_PRESENCE_PRE_SCRIPT"

// JFF   06/10/2021 
subroutine PS_S762_W_GTI_MT_PLAF(long dcIdSin,long dcIdProd,long dcIdEts,string sIdAdh,datetime dtSurv,Ref string dcMtPlafReg) RPCFUNC ALIAS FOR "sysadm.PS_S762_W_GTI_MT_PLAF"

// JFF   15/12/2021 RS1569
subroutine PS_S_MODIF_NUM_CARTE_EN_X (long dcIdSin, String sLes6PremiersCB, Ref string sLe7et8EnRetourCB ) RPCFUNC ALIAS FOR "sysadm.PS_S_MODIF_NUM_CARTE_EN_X"

// JFF   12/05/2022 RS2980
subroutine PS_U_MARQUAGE_PRIX_IFR_A_REVOIR (string sMarqIfr, String sModlIfr, Ref string sCodeRet ) RPCFUNC ALIAS FOR "sysadm.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR"

// JFF   24/08/2022 RS3552
function int PS_S_GTI_COUVERTE_SUR_REV (long dcIdProd, long dcIdRev, Long dcIdGti ) RPCFUNC ALIAS FOR "sysadm.PS_S_GTI_COUVERTE_SUR_REV"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
function int PS_S_PM80_CTRLE_VENTIL_REG_BASE ( Long adcIdSin, Ref Int adcIdRegBase, Integer aiIdSeq, Ref DateTime adtDteRegBase, Ref DateTime adtDtePivotMepPM80, Ref string asResult ) RPCFUNC ALIAS FOR "sysadm.PS_S_PM80_CTRLE_VENTIL_REG_BASE"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
function int PS_S02_REG_FRAIS_ANNEXE_FRN ( Long adcIdSin, Int adcIdReg ) RPCFUNC ALIAS FOR "sysadm.PS_S02_REG_FRAIS_ANNEXE_FRN" 

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
function int PS_S03_REG_FRAIS_ANNEXE_FRN ( Long adcIdSin, Int adcIdReg, Ref DateTime adtPivotMEP_PM80 ) RPCFUNC ALIAS FOR "sysadm.PS_S03_REG_FRAIS_ANNEXE_FRN" 

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
function long PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 (long dcIdSin, long dcIdI, Long dcIdGti, Long dcIdDetail, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, String sCodOper ) RPCFUNC ALIAS FOR "sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
subroutine PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF ( Long adcIdSin, Int adcIdRegBase, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, Ref string asVentilFraisOrig, Ref string asVentilFraisEnCoursAff, Ref string asVentilFraisEnCoursCtrle ) RPCFUNC ALIAS FOR "sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
function long PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO ( Long adcIdSin, Int adcIdRegBase, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, Ref decimal{2} adcMtFraisAnexExistant, Ref decimal{2} adcMtFraisAPasser, Ref Long alTypeDuFrais, Ref decimal{2} adcMtDifFraisAnx ) RPCFUNC ALIAS FOR "sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO"

//       JFF   09/09/2022 [PM80_FA12_FRANEX]
subroutine PS_I_REG_FRAIS_ANNEXE_FRN_V01 ( Long adcIdSin, Int adcIdReg, long dcIdI, Long dcIdGti, Long dcIdDetail, decimal{2} dcMtIndemPrinc_1, decimal{2} dcMtFraisAnex_2, decimal{2} dcMtFraisAnex_3, decimal{2} dcMtFraisAnex_4, decimal{2} dcMtFraisAnex_5, decimal{2} dcMtFraisAnex_6, decimal{2} dcMtFraisAnex_7, decimal{2} dcMtFraisAnex_8, decimal{2} dcMtFraisAnex_9, decimal{2} dcMtFraisAnex_10, decimal{2} dcMtFraisAnex_11, string asCodOper ) RPCFUNC ALIAS FOR "sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01"

//       JFF   27/12/2022 Ctrle Rep Courrier
function long PS_U_DATE_PIVOT_CTRLE_REP_COURRIER ( String asCle, Integer aiFrequenceMin ) RPCFUNC ALIAS FOR "sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER"
function long PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01 ( String asCle, Integer aiFrequenceMin, String asRepCourDest ) RPCFUNC ALIAS FOR "sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01"

//       JFF   02/01/2023 [RS_4166_PND_CORUS]
function long PS_S_RS4166_CTRLE_DATA_PND_CORUS ( Long adcIdSin, Long adcIdInter, Long adcIdDoc, String asCodInter, String asIdCour, String asDteEdit, Ref String asDetRetPnd, Ref String asCreelePnd, Ref String asIdProd ) RPCFUNC ALIAS FOR "sysadm.PS_S_RS4166_CTRLE_DATA_PND_CORUS"
function long PS_S_RS4166_CTRLE_ADH_FFM ( Long alIdProdAdh, long aiIdEts, Long alIdAdh, Long alsDos, String asDteRetPnd, Ref Long alIdCLi, Ref String asCreeLePnd ) RPCFUNC ALIAS FOR "sysadm.PS_S_RS4166_CTRLE_ADH_FFM"

//       JFF   30/05/2023 [PMO89_RS4822]
function String FN_GET_NOM_PRENOM (String sLib, String sPartie ) RPCFUNC ALIAS FOR "sysadm.FN_GET_NOM_PRENOM"

//       JFF  26/04/2023 [RS5045_REF_MATP]
subroutine PS_S_W_COURRIER_MODELE_WORD ( Long adcIdSin, Ref String asChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_W_COURRIER_MODELE_WORD"

//       JFF  18/10/2023 [RS6044_REL_MAIL]
subroutine PS_S_INTER_ADR_MAIL_INTER  ( Long adcIdSin, Long adcIdInter, Ref String asAdrMail ) RPCFUNC ALIAS FOR "sysadm.PS_S_INTER_ADR_MAIL_INTER"
subroutine PS_U_AFFECTER_UN_ID_ARCH (Long adcIdSin, Long adcIdInter, Long adcIdDoc, Ref Long aiIdArch ) RPCFUNC ALIAS FOR "sysadm.PS_U_AFFECTER_UN_ID_ARCH"

//	 JFF   29/11/2023  CCO => Ticket 399863, on ajoute 2172 [OPTIM_UE_ROUTAGE]
subroutine PS_IWD_CORB_FAM (Long adcIdSin, Ref String asIdIwd, Ref String asIdCorb, Ref Long alIdFam ) RPCFUNC ALIAS FOR "sysadm.PS_IWD_CORB_FAM"

//  JFF  11/12/2023 [RS6244]
subroutine PS_S_MAX_MAJ_LE  ( Ref Datetime adtMaxMajLeArticle ) RPCFUNC ALIAS FOR "sysadm.PS_S_MAX_MAJ_LE"

//  JFF  28/02/2024 [MCO_190_191_BECLM]
subroutine PS_S_RECUP_FLOW_NAME_BECLM  ( Long adcIdSin, int adcIdRev, Ref String asFlowNameBeCLM ) RPCFUNC ALIAS FOR "sysadm.PS_S_RECUP_FLOW_NAME_BECLM"

//  JFF  19/03/2024 [HP252_276_HUB_PRESTA]
subroutine PS_HP276_S_S2_DATA_DOSSIER  ( Long adcIdSin, Ref string asIdAdh, Ref int aiIdGrpContractant, Ref String asLibGrpContractant) RPCFUNC ALIAS FOR "sysadm.PS_HP276_S_S2_DATA_DOSSIER"

//  JFF  19/03/2024 [HP252_276_HUB_PRESTA]
subroutine PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV  ( Long adcIdSin, Ref Int aiIdSeqSavRet ) RPCFUNC ALIAS FOR "sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV"

//  JFF  19/03/2024 [HP252_276_HUB_PRESTA]
subroutine PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG  ( Long adcIdSin, Ref Int aiIdSeqOrig, Ref String asIdHubPrestaOrig, Ref String asIdFourOrig ) RPCFUNC ALIAS FOR "sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG"

//  JFF  19/03/2024 [HP252_276_HUB_PRESTA]
subroutine PS_HP276_S_S2_LIB_ACTIVITY_MAPPING  ( String asActivityCode, String asActivityReturnCode, String asActivityReasonCode, Ref String asLibActivity ) RPCFUNC ALIAS FOR "sysadm.PS_HP276_S_S2_LIB_ACTIVITY_MAPPING"

//  JFF  12/08/2024 [MCO834_JOUVRE]
function Integer PS_S_PROCHAIN_JOUR_OUVRE_DU_MEME_MOIS_CALENDAIRE ( DateTime dtDteSource, Ref Integer iPJOMMC, ref DateTime dtDtePossible ) RPCFUNC ALIAS FOR "sysadm.PS_S_PROCHAIN_JOUR_OUVRE_DU_MEME_MOIS_CALENDAIRE"

//  JFF  05/08/2024  [MCO602_PNEU]
function Integer PS_S_PRODUIT_ADH_SAGA2 ( Long lIdProd ) RPCFUNC ALIAS FOR "sysadm.PS_S_PRODUIT_ADH_SAGA2"

// JFF	10/09/2024 [20240910162546267] Changement chemin UNC Serveur fichier prod
function String FN_GET_CHEMIN ( String asCleChem ) RPCFUNC ALIAS FOR "sysadm.FN_GET_CHEMIN"


end prototypes
type variables
Private:
	CONSTANT String	K_IDSQL="SQL"
	String idSql=""
end variables

forward prototypes
public function string uf_getidsql ()
public subroutine uf_setidsql ()
end prototypes

public function string uf_getidsql ();if isNull(idSql) Then idSql=""

If idSql="" Then uf_setidsql( )

Return idSql
end function

public subroutine uf_setidsql ();ContextKeyword Cnx_KeyWord
String  sRet[]

This.GetContextService ( "Keyword", Cnx_KeyWord )
Cnx_KeyWord.GetContextKeyWords ( K_IDSQL, sRet )

This.idSql=""

if UpperBound ( sRet ) = 1 Then
	If	IsNull ( sRet[1] ) Or Len ( Trim ( sRet[1] ) ) = 0	Then
		sRet[1] = ""
	End If
	
	idSql=sRet[1]
End if
end subroutine

on u_transaction.create
call super::create
end on

on u_transaction.destroy
call super::destroy
end on

event constructor;call super::constructor;uf_setidsql( )
end event

