HA$PBExportHeader$w_a_sp_paragraphe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des paragraphes.
forward
global type w_a_sp_paragraphe from w_a_spb_paragraphe
end type
type pb_docword from picturebutton within w_a_sp_paragraphe
end type
type st_encours from statictext within w_a_sp_paragraphe
end type
end forward

global type w_a_sp_paragraphe from w_a_spb_paragraphe
pb_docword pb_docword
st_encours st_encours
end type
global w_a_sp_paragraphe w_a_sp_paragraphe

type variables
Private :

U_SP_GS_PARAGRAPHE	uo_para

W_T_Sp_Paragraphe_2000    iwin

Public : 
      String	isClause
		
 Protected :
      s_Interro  istInterro

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 29/04/1999 15:04:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positinne les objets sur la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*
//*-----------------------------------------------------------------


// Placement du staticText st_EnCours.
st_EnCours.x	   = 1642
st_EnCours.y 	   = 37
st_EnCours.Width  = 1742
st_EnCours.Height = 141
st_EnCours.Border = False

end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_paragraphe
//* Evenement 		: ue_initialiser
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 14:38:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initilisation des objets
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

wf_PositionnerObjets()

uo_para = CREATE U_SP_GS_PARAGRAPHE




end event

event ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_paragraphe
//* Evenement 		:	ue_modifier - OVERRIDE
//* Auteur			:	YP
//* Date				:	13/06/97 17:14:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un paragraphe
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL				  
//*-----------------------------------------------------------------

istPass.bInsert = False

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du paragraphe                             */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "PARAGRAPHE.ID_PARA" )
istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_PARA" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* #1 R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le 2$$HEX1$$e900$$ENDHEX$$me identifiant du paragraphe                    */
/*------------------------------------------------------------------*/
 istPass.sTab[2] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CANAL" )

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un paragraphe.                         */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( iwin, istPass ) 


end event

on ue_item6;call w_a_spb_paragraphe::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_paragraphe
//* Evenement 		: Item_6
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 14:42:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Construction d'un Doc Word
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

 uo_Para.uf_bibleparagraphes ( dw_1, st_EnCours )
end on

on ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_paragraphe
//* Evenement 		:	ue_creer - OVERRIDE
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:13:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un paragraphe - ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de
//*                	traitement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.bInsert = True

f_OuvreTraitement ( W_T_Sp_Paragraphe_2000, istPass )
end on

on w_a_sp_paragraphe.create
int iCurrent
call super::create
this.pb_docword=create pb_docword
this.st_encours=create st_encours
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_docword
this.Control[iCurrent+2]=this.st_encours
end on

on w_a_sp_paragraphe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_docword)
destroy(this.st_encours)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_paragraphe
//* Evenement 		: close
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 14:39:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Destruction des ojets instanci$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY uo_para
If IsValid(uo_para) Then DESTROY uo_para
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_paragraphe
//* Evenement 		:	ue_preparer_interro_dntmail
//* Auteur			:	MADM
//* Date				:	08/06/2006 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise l'object de transaction pour les dddw
//*					   des m$$HEX1$$e900$$ENDHEX$$dias de sortie.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL1 Ajout du canal			  
//*-----------------------------------------------------------------

DataWindowChild		dwCanal		// DDDW pour les m$$HEX1$$e900$$ENDHEX$$dias de sortie


//*-------------------------------------------------------------------------------------
//* On peuple la DDDW avec les m$$HEX1$$e900$$ENDHEX$$dias de sortie existant
//* A l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre La colonne ID_CANAL est renseign$$HEX2$$e9002000$$ENDHEX$$avec la cha$$HEX1$$ee00$$ENDHEX$$ne "AUCUN" 			  
//*--------------------------------------------------------------------------------------

W_Interro.dw_1.Uf_SetTransObject ( itrTrans )

W_Interro.Dw_1.GetChild ( "ID_CANAL", dwCanal )
 
 
dwCanal.SetTransObject ( itrTrans )
dwCanal.Retrieve		 ("-MS" )

W_Interro.Dw_1.setitem (1,"ID_CANAL" , "AUCUN")
end event

event ue_enablefenetre;call super::ue_enablefenetre;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_EnableFenetre - Extend
//	Auteur		: MADM
//	Date			: 16/06/2006
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Activation de la fenetre lors de la fermeture d'une fenetre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String   sIdPara
String   sTab
s_Pass   stPass

/*------------------------------------------------------------------*/
/* On vient de la scission, on va faire un reset de la datawindow   */
/* d'accueil et afficher les lignes issues de la scission           */
/*------------------------------------------------------------------*/

If	IsValid ( iwin )	Then
	If	 	iwin.ibScission	Then
			/*------------------------------------------------------------------*/
			/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du paragraphe                             */
			/*------------------------------------------------------------------*/
			sIdPara = dw_1.GetItemString ( 1, "ID_PARA" )
			
			dw_1.Reset ()
			iwin.ibScission = False
				
			//Rearmer la DW accueil istInterro
			istInterro				= Message.PowerObjectParm
		  
         /*------------------------------------------------------------------*/
			/* On arme les clause where et on initialise la structure           */
			/*------------------------------------------------------------------*/
		   isClause = " Where sysadm.paragraphe.id_para = '"+sIdPara+"'"
		   isClauseFrancais = " sysadm.paragraphe.id_para = '"+sIdPara+"'"

		   stPass.sTab[1] = isClause
		   stPass.sTab[2] = isClauseFrancais

		   Message.PowerObjectParm = stPass
           
			THIS.TriggerEvent ("ue_fin_interro")

      
	End If
End If

end event

type pb_retour from w_a_spb_paragraphe`pb_retour within w_a_sp_paragraphe
integer taborder = 40
end type

type pb_interro from w_a_spb_paragraphe`pb_interro within w_a_sp_paragraphe
integer taborder = 60
end type

type pb_creer from w_a_spb_paragraphe`pb_creer within w_a_sp_paragraphe
integer taborder = 50
end type

type dw_1 from w_a_spb_paragraphe`dw_1 within w_a_sp_paragraphe
integer taborder = 30
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_paragraphe
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:49:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PNOLIMIT]
//* Commentaires	: On enl$$HEX1$$e800$$ENDHEX$$ve la limite des 150 lignes
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


ilMaxLig = 0

end event

type pb_tri from w_a_spb_paragraphe`pb_tri within w_a_sp_paragraphe
integer taborder = 70
end type

type pb_imprimer from w_a_spb_paragraphe`pb_imprimer within w_a_sp_paragraphe
end type

type pb_docword from picturebutton within w_a_sp_paragraphe
integer x = 1234
integer y = 16
integer width = 233
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Doc Word"
string picturename = "k:\pb4obj\bmp\8_word.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_docword
//* Evenement 		: clicked
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 14:41:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Parent.TriggerEvent ("ue_item6")
end on

type st_encours from statictext within w_a_sp_paragraphe
boolean visible = false
integer x = 1957
integer y = 224
integer width = 224
integer height = 256
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

