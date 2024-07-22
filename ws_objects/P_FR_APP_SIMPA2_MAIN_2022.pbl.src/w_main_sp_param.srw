HA$PBExportHeader$w_main_sp_param.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre MAIN pour le module de param$$HEX1$$e900$$ENDHEX$$trage de l'application SIMPA 2.
forward
global type w_main_sp_param from w_main
end type
end forward

global type w_main_sp_param from w_main
integer x = 0
integer y = 0
integer width = 3639
integer height = 2372
string title = "PARAMETRAGE SIMPA 2"
string menuname = "m_main_sp_param"
long backcolor = 12632256
event ue_droitecriture pbm_custom01
end type
global w_main_sp_param w_main_sp_param

event ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_main_sp_param
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*
//*-----------------------------------------------------------------

String sNomFic, sIdOper
int 	 iDroit, iFic
PictureButton TbPict []
Boolean bOuvFen

bOuvFen = True

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sNomFic = stGlb.sWinDir + "\TEMP\AUTO20"
sNomFic = stGlb.sRepTempo + "AUTO20"
sIdOper = Upper ( stGlb.sCodOper )

/*------------------------------------------------------------------*/
/* Si le fichier donnant le droit d'$$HEX1$$e900$$ENDHEX$$crire dans le param Existe,    */
/* on le supprime.                                                  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If FileExists ( sNomFic ) Then
If f_FileExists ( sNomFic ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	bOuvFen = FileDelete ( sNomFic )
End If

/*------------------------------------------------------------------*/
/* Lecteur de l'autorisation 200, donnant droit $$HEX2$$e0002000$$ENDHEX$$l'acc$$HEX1$$e800$$ENDHEX$$s au         */
/* param$$HEX1$$e800$$ENDHEX$$trage en $$HEX1$$e900$$ENDHEX$$criture.                                         */
/*------------------------------------------------------------------*/
If bOuvFen Then

	iDroit = 0

	Select count (*)
	into   :iDroit
	From	 sysadm.autorisation
	Where  id_nat_oper = 200
	And 	 id_oper = :sIdOper 
	Using  SQLCA ;

	If iDroit > 0 Then
		iFic = FileOpen ( sNomFic, LineMode!, Write!, Shared!, Replace! ) 
		FileClose ( iFic )
	End If

End If

If bOuvFen Then F_Droit_Ecriture_Param ( tbPict, "BOX" )
end event

on show;call w_main::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_main_sp_param
//* Evenement     : show
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 17:12:36
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

end on

on w_main_sp_param.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_sp_param" then this.MenuID = create m_main_sp_param
end on

on w_main_sp_param.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

