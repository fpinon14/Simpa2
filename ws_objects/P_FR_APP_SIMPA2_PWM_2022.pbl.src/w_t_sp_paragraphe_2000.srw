HA$PBExportHeader$w_t_sp_paragraphe_2000.srw
forward
global type w_t_sp_paragraphe_2000 from w_8_traitement
end type
type pb_word from picturebutton within w_t_sp_paragraphe_2000
end type
type st_alerte from statictext within w_t_sp_paragraphe_2000
end type
type pb_suppencours from picturebutton within w_t_sp_paragraphe_2000
end type
end forward

global type w_t_sp_paragraphe_2000 from w_8_traitement
integer x = 791
integer y = 40
integer width = 2277
integer height = 1748
string title = "Gestion des paragraphes"
event ue_droitecriture pbm_custom39
pb_word pb_word
st_alerte st_alerte
pb_suppencours pb_suppencours
end type
global w_t_sp_paragraphe_2000 w_t_sp_paragraphe_2000

type variables
Private :
	N_Cst_Sp_Paragraphe_2000	invSpParagraphe
	
Public :
	Boolean ibScission = False
	
	
	
end variables

forward prototypes
public function boolean wf_preparervalider ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparersupprimer ()
end prototypes

event ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_paragraphe_2000
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
//* #1 MADM   15/06/2006  Ajouter le Picture Bouton Annuler l'encours
//*
//*-----------------------------------------------------------------

PictureButton TbPict []

TbPict[1] = pb_valider
TbPict[2] = pb_supprimer
TbPict[3] = pb_word

/*-------------------------------------------------*/
/* #1  MADM   15/06/2006                           */
/*-------------------------------------------------*/
TbPict[4] = pb_suppencours

F_Droit_Ecriture_Param ( tbPict, "" )


end event

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_PreparerValider	(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Boolean bRet

bRet = invSpParagraphe.uf_Valider ()

Return ( bRet )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_PreparerModifier		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM le 08/06/2006 Projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

String   sCol [ 2 ]				// Champ $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger contre la saisie.
String	sTxtPara, sIdPara		// Texte du paragraphe.
String   sIdCanal 

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend inaccessible en saisie le Code Paragraphe                   */
/*------------------------------------------------------------------*/
sCol [ 1 ] 		= "ID_PARA"
dw_1.Uf_Proteger ( sCol, "1" )
/*------------------------------------------------------------------*/
/* Rend inaccessible en saisie le Canal du Paragraphe               */
/*------------------------------------------------------------------*/
sCol [ 2 ] 		= "ID_CANAL"
dw_1.Uf_Proteger ( sCol, "2" )

dw_1.ilPremCol = 3
dw_1.ilDernCol = 10

sIdPara = istPass.sTab[1]
sIdCanal = istPass.sTab[2]

If	Not ( invSpParagraphe.uf_Preparer ( "M", sIdPara, sIdCanal ) )	Then	
	Return ( False )
End If

Return ( True ) 
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_PreparerInserer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Insertion
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM le 08/06/2006 : Projet DNTMAIL
//*-----------------------------------------------------------------

Boolean bRet
String  sCol [ 2 ]		// Champ $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend accessible en saisie le Code Paragraphe                     */
/*------------------------------------------------------------------*/
sCol [ 1 ] 		= "ID_PARA"
sCol [ 2 ] 		= "ID_CANAL"

dw_1.Uf_Proteger ( sCol, "0" )

/*------------------------------------------------------------------*/
/* Ajout de 2 colonnes $$HEX2$$e0002000$$ENDHEX$$la datawindow : ID_CANAL et alt_scinder    */
/* Passage du nouveau param$$HEX1$$e900$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$la fonction uf_preparer           */
/*------------------------------------------------------------------*/
dw_1.ilPremCol = 1
//dw_1.ilDernCol = 8
dw_1.ilDernCol = 10

If	Not ( invSpParagraphe.uf_Preparer ( "C", "", "" ) )	Then
	Return ( FALSE )
End If

Return ( TRUE )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_Controler_Saisie		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String				
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sPos

sPos = invSpParagraphe.uf_ControlerSaisie ()

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_Controler_Gestion			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de gestion
//*
//* Arguments		: Aucun
//*
//* Retourne		: String				
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String		sCol 		// Nom de la colonne en Erreur.

sCol = invSpParagraphe.uf_ControlerGestion ()

Return ( sCol )	
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Paragraphe::wf_PreparerSupprimer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Boolean bRet

bRet = invSpParagraphe.uf_Supprimer ()

Return ( bRet )
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Paragraphe_2000
//* Evenement 		: Ue_Initialiser				(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 09/04/1999 14:38:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des paragraphes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM 	08/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL			  
//*-----------------------------------------------------------------

//String		sCol [ 1 ]		// Tableau contenant les champs dont 
									// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.
String		sCol [ 2 ]		
datawindowchild  dwchildCanal

invSpParagraphe = Create N_Cst_Sp_Paragraphe_2000

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol[1] 			= "ID_PARA"
sCol[2] 			= "ID_CANAL"

dw_1.Uf_InitialiserCouleur ( sCol )
dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion             */
/*------------------------------------------------------------------*/
invSpParagraphe.uf_Initialiser ( dw_1, itrTrans, st_alerte, pb_suppencours, pb_valider, pb_retour )

/*------------------------------------------------------------------*/
/* #1 Initialisation de la transaction de DW_1                      */
/* chargement de la dddw des m$$HEX1$$e900$$ENDHEX$$dias											  */	
/*------------------------------------------------------------------*/

Dw_1.Uf_SetTransObject ( itrTrans )
Dw_1.GetChild ( "ID_CANAL", dwchildCanal )
dwchildCanal.SetTransObject ( itrTrans )
dwchildCanal.Retrieve ( "-MS" )


end event

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Paragraphe_2000
//* Evenement 		: Ue_MajAccueil
//* Auteur			: Erick John Stark
//* Date				: 09/04/1999 14:38:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM le 08/06/2006 Projet DNTMAIL1 Ajout de la colonne ID_CANAL				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sMajLe		// Variable tampon pour MAJ_LE.

sTab				= "~t"
sMajLe			= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	dw_1.GetItemString ( 1, "ID_PARA"  ) + sTab	+ &
						dw_1.GetItemString ( 1, "ID_CANAL"  ) + sTab	+ &
						dw_1.GetItemString ( 1, "CPT_VER"  ) + sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_PARA" ) + sTab	+ &
						sMajLe								 		 + sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR"  )
end event

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Paragraphe_2000
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 09/04/1999 14:38:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du NVUO.                                             */
/*------------------------------------------------------------------*/
DESTROY invSpParagraphe

end on

on w_t_sp_paragraphe_2000.create
int iCurrent
call super::create
this.pb_word=create pb_word
this.st_alerte=create st_alerte
this.pb_suppencours=create pb_suppencours
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_word
this.Control[iCurrent+2]=this.st_alerte
this.Control[iCurrent+3]=this.pb_suppencours
end on

on w_t_sp_paragraphe_2000.destroy
call super::destroy
destroy(this.pb_word)
destroy(this.st_alerte)
destroy(this.pb_suppencours)
end on

event show;call super::show;
//On n'est pas en Mode scission

ibScission = False
end event

event ue_retour;//*****************************************************************************
//
// Objet 		: W_t_sp_paragraphe_2000
// Evenement 	: Ue_Retour   OVERRIDE
//	Auteur		: MADM
//	Date			: 22/06/2006
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fermeture de la fenetre de traitement
// Commentaires: Le fenetre n'est pas r$$HEX1$$e900$$ENDHEX$$ellement ferm$$HEX1$$e900$$ENDHEX$$e mais seulement cach$$HEX1$$e900$$ENDHEX$$e
//					  c'est la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil qui la fermera 
//					  d$$HEX1$$e900$$ENDHEX$$finitivement
//					  
// ----------------------------------------------------------------------------




ibScission = invSpParagraphe.ibScission

super::event ue_retour(0,0)
end event

type dw_1 from w_8_traitement`dw_1 within w_t_sp_paragraphe_2000
integer x = 23
integer y = 192
integer width = 2231
integer height = 1468
string dataobject = "d_sp_paragraphe_2000"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:37:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion ou de la suppression  
//*					 	d'un paragraphe.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 				   
//*-----------------------------------------------------------------

String	sSqlPreview			// SqlPreview de la datawindow Dw_1.
String	sIdPara, sLibPara, sAltEnCours, sCptVer, sTxtPara, sMajPar, sIdCanal
DateTime	dtCreeLe, dtMajLe

Long		lCpt
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview 		= dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

/*------------------------------------------------------------------*/
/* Probl$$HEX1$$e800$$ENDHEX$$me Myst$$HEX1$$e800$$ENDHEX$$re du 30/03/2004 (JFF): Je courcircuite l'appel    */
/* de la PS dans laquelle le passage de txt_para pose soudain un    */
/* souci et tronque la chaine. Je laisse donc partir l'INSERT       */
/* g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par la DW.                                                */
/*------------------------------------------------------------------*/

//	sIdPara		= This.GetItemString ( 1, "ID_PARA" )
//	sLibPara		= This.GetItemString ( 1, "LIB_PARA" )
//	sAltEnCours	= This.GetItemString ( 1, "ALT_ENCOURS" )
//	sCptVer		= This.GetItemString ( 1, "CPT_VER" )
//	sTxtPara		= This.GetItemString ( 1, "TXT_PARA" )
//	dtCreeLe		= This.GetItemDateTime ( 1, "CREE_LE" )
//	dtMajLe		= This.GetItemDateTime ( 1, "MAJ_LE" )
//	sMajPar		= This.GetItemString ( 1, "MAJ_PAR" )
//
//	itrTrans.DW_I01_PARAGRAPHE_SPB	(						&
//												sIdPara,				&
//												sLibPara,			&
//												sAltEnCours,		&
//												sCptVer,				&
//												sTxtPara,			&
//												dtCreeLe,			&
//												dtMajLe,				&
//												sMajPar				&
//												)
//
//	If	itrTrans.SqlCode <> 0	Then										
//		This.SetActionCode ( 1 )
//	Else
//		This.SetActionCode ( 2 )
//	End If

Case	"DELE"
		sIdPara = This.GetItemString ( 1, "ID_PARA", DELETE!, FALSE )
		
				
		itrTrans.DW_D01_PARAGRAPHE ( sIdPara )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Spb_Paragraphe::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 11:54:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: (Val)	Long		Row
//*					  (Val)	DwObject	Dwo
//*					  (Val)	String	Data
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String		sVal			// Valeur du champ saisi.
Integer		iAction		// valeur du SetActionCode.
//string      sidcanal, sidpara

//sidcanal = "MU"

iAction	= 0
sVal 		= This.GetText ( )

iAction = invSpParagraphe.Uf_ControlerZone ( isNomCol, sVal )



//Migration PB8-WYNIWYG-03/2006 FM
//SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 FM




end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Spb_Paragraphe::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 11:54:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

// [MIGPB8COR] - PHG
//invSpParagraphe.Uf_GererMessage ( isErrCol )
// remplace par
if ibErreur then
	return invSpParagraphe.Uf_GererMessage ( isErrCol )
Else
	return AncestorReturnValue
End If






end event

type st_titre from w_8_traitement`st_titre within w_t_sp_paragraphe_2000
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_paragraphe_2000
integer x = 27
integer y = 20
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_paragraphe_2000
integer x = 279
integer y = 20
integer taborder = 30
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_paragraphe_2000
boolean visible = false
integer x = 2409
integer y = 196
integer taborder = 0
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_paragraphe_2000
boolean visible = false
integer x = 279
integer y = 20
integer taborder = 0
boolean enabled = false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_paragraphe_2000
boolean visible = false
integer x = 530
integer y = 20
integer taborder = 40
end type

type pb_word from picturebutton within w_t_sp_paragraphe_2000
integer x = 1998
integer y = 20
integer width = 233
integer height = 136
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saisir $$HEX1$$a700$$ENDHEX$$"
string picturename = "k:\pb4obj\bmp\8_word.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Paragraphe_2000::Pb_Word
//* Evenement 		: Clicked!
//* Auteur			: Erick John Stark
//* Date				: 09/04/1999 14:38:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

invSpParagraphe.uf_Gestion_Paragraphe ()


end on

type st_alerte from statictext within w_t_sp_paragraphe_2000
integer x = 640
integer y = 28
integer width = 923
integer height = 136
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_suppencours from picturebutton within w_t_sp_paragraphe_2000
integer x = 1577
integer y = 20
integer width = 379
integer height = 136
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler L~'encours"
string picturename = "K:\PB4OBJ\BMP\8_ANNU.BMP"
alignment htextalign = left!
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_SuppEncours
//* Evenement 		: clicked
//* Auteur			: MADM
//* Date				: 12/06/2006 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Permet de modifier l'encours d'un paragraphe de Oui $$HEX2$$e0002000$$ENDHEX$$Non et
//*                 mettre $$HEX2$$e0002000$$ENDHEX$$jour le Blob 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


invSpParagraphe.uf_Annuler_Encours ()
end event

