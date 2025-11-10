HA$PBExportHeader$w_sp_gamme.srw
$PBExportComments$/* SFR */ Fen$$HEX1$$ea00$$ENDHEX$$tre permettant de d$$HEX1$$e900$$ENDHEX$$terminer la gamme du mobile de l'assur$$HEX1$$e900$$ENDHEX$$, et de voir les diff$$HEX1$$e900$$ENDHEX$$rents mobiles / gammes
forward
global type w_sp_gamme from Window
end type
type dw_gammes_four from datawindow within w_sp_gamme
end type
type dw_gammes from datawindow within w_sp_gamme
end type
type pb_retour from u_pbretour within w_sp_gamme
end type
type dw_four_gamme from datawindow within w_sp_gamme
end type
type bm_fleche from picture within w_sp_gamme
end type
type dw_lst_gamme from datawindow within w_sp_gamme
end type
end forward

global type w_sp_gamme from Window
int X=1335
int Y=625
int Width=2021
int Height=705
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
event ue_retour pbm_custom75
event ue_initialiser pbm_custom65
dw_gammes_four dw_gammes_four
dw_gammes dw_gammes
pb_retour pb_retour
dw_four_gamme dw_four_gamme
bm_fleche bm_fleche
dw_lst_gamme dw_lst_gamme
end type
global w_sp_gamme w_sp_gamme

type variables
n_cst_gamme	invGamme

Long		ilRetGamme

s_Pass		istPass

u_transaction	itrTrans
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
end prototypes

on ue_retour;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme
//* Evenement     : ue_Retour
//* Auteur        : Catherine Abdmeziem
//* Date          : 13/09/2002 16:01:36
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

ilRetGamme = invGamme.uf_GetGamme ( )
CloseWithReturn ( This, ilRetGamme )
end on

on ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme
//* Evenement     : Ue_Initialiser
//* Auteur        : Catherine Abdmeziem
//* Date          : 13/09/2002 16:00:31
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  :
//*
//* Arguments     : Aucun
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

String			sTypeTrt
u_onglets		uoOng
s_Pass			stPass

stPass = istPass

/*------------------------------------------------------------------*/
/* Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre : titre, positionnement de la       */
/* fen$$HEX1$$ea00$$ENDHEX$$tre, des objets                                              */
/*------------------------------------------------------------------*/
This.Title = "D$$HEX1$$e900$$ENDHEX$$termination de la gamme du mobile"

/*------------------------------------------------------------------*/
/* Initialisation de idw_wsin de u_gs_sp_sinistre_anc :             */
/* dwMaster = dw_wsin                                               */
/* initialisation de sTypeTrt $$HEX2$$e0002000$$ENDHEX$$'C' pour consultation,              */
/* mais cette variable n'est pas utilis$$HEX1$$e900$$ENDHEX$$e dans                      */
/* u_gs_sp_sinistre_anc, mais dans les descendants.                 */
/* Pas besoin pour gamme. idem pour uoOng                           */
/*------------------------------------------------------------------*/
sTypeTrt = 'C'
invGamme.uf_Initialisation ( stPass.dwMaster, itrTrans, uoOng, sTypeTrt )

/*------------------------------------------------------------------*/
/* Initialisation de idw_produit de u_gs_sp_sinistre_anc :          */
/* dwNorm1 = dw_produit                                             */
/*------------------------------------------------------------------*/
invGamme.uf_Initialiser_dw ( stPass.dwNorm [ 1 ], stPass.dwNorm [ 4 ], TRUE )

/*------------------------------------------------------------------*/
/* Initialisation des autres dw                                     */
/*------------------------------------------------------------------*/
stPass.dwNorm [ 4 ] = dw_Gammes
stPass.dwNorm [ 5 ] = dw_Gammes_Four
stPass.dwNorm [ 6 ] = dw_Four_Gamme
stPass.dwNorm [ 7 ] = dw_Lst_Gamme

invGamme.uf_Initialiser_dw_desc ( stPass )

invGamme.uf_InitialiserFenetre ( bm_fleche )
end on

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction      : W_Sp_Gamme::Wf_Positionnerobjets ( PRIVATE )
//* Auteur        : Catherine Abdmeziem
//* Date          : 20/09/2002 12:09:24
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Positionnement de la fen$$HEX1$$ea00$$ENDHEX$$tre, du bouton et des 2 dws
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* position de d$$HEX1$$e900$$ENDHEX$$part / position en 1,1 de l'appli                  */
/*------------------------------------------------------------------*/
This.X		=	44
This.Y		=	480
This.width	=	3585
This.height	=	1685

/*------------------------------------------------------------------*/
/* position de d$$HEX1$$e900$$ENDHEX$$part / position en 2190, 1070 de l'appli lanc$$HEX1$$e900$$ENDHEX$$e    */
/* par Sherpa                                                       */
/*------------------------------------------------------------------*/
This.X		=	2253
This.Y		=	1549

bm_fleche.X			=	10000
bm_fleche.Y			=	10000
bm_fleche.width	=	129
bm_fleche.height	=	65

pb_Retour.X			=	10
pb_Retour.Y			=	9
pb_Retour.Width	=	234
pb_Retour.Height	=	137

dw_Four_Gamme.X		=	321
dw_Four_Gamme.Y		=	65
dw_Four_Gamme.Width	=	3155
dw_Four_Gamme.Height	=	265

dw_Lst_Gamme.X			=	106
dw_Lst_Gamme.Y			=	389
dw_Lst_Gamme.Width	=	3370
dw_Lst_Gamme.Height	=	1169

end subroutine

on open;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme
//* Evenement     : Open
//* Auteur        : Catherine Abdmeziem
//* Date          : 13/09/2002 16:01:05
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des param$$HEX1$$e800$$ENDHEX$$tres
istPass	=	Message.PowerObjectParm
itrTrans	=	istPass.trTrans

wf_PositionnerObjets ( )

invGamme	=	Create n_cst_gamme

TriggerEvent ( This, "ue_initialiser" )


end on

on w_sp_gamme.create
this.dw_gammes_four=create dw_gammes_four
this.dw_gammes=create dw_gammes
this.pb_retour=create pb_retour
this.dw_four_gamme=create dw_four_gamme
this.bm_fleche=create bm_fleche
this.dw_lst_gamme=create dw_lst_gamme
this.Control[]={ this.dw_gammes_four,&
this.dw_gammes,&
this.pb_retour,&
this.dw_four_gamme,&
this.bm_fleche,&
this.dw_lst_gamme}
end on

on w_sp_gamme.destroy
destroy(this.dw_gammes_four)
destroy(this.dw_gammes)
destroy(this.pb_retour)
destroy(this.dw_four_gamme)
destroy(this.bm_fleche)
destroy(this.dw_lst_gamme)
end on

on close;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme :: Close
//* Evenement     : Close
//* Auteur        : Catherine Abdmeziem
//* Date          : 25/09/2002 11:20:03
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : aucun
//*
//* Retourne      : aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

If IsValid ( invGamme ) Then Destroy invGamme
end on

type dw_gammes_four from datawindow within w_sp_gamme
int X=1697
int Y=157
int Width=243
int Height=101
int TabOrder=50
boolean Visible=false
boolean Enabled=false
string DataObject="dddw_gammes"
boolean LiveScroll=true
end type

type dw_gammes from datawindow within w_sp_gamme
int X=1697
int Y=29
int Width=243
int Height=101
int TabOrder=30
boolean Visible=false
boolean Enabled=false
string DataObject="dddw_gammes"
boolean LiveScroll=true
end type

type pb_retour from u_pbretour within w_sp_gamme
int X=10
int Y=9
int Width=234
int Height=137
int TabOrder=10
boolean OriginalSize=false
end type

type dw_four_gamme from datawindow within w_sp_gamme
int X=321
int Y=65
int Width=485
int Height=417
int TabOrder=20
string DataObject="d_trt_gamme"
boolean Border=false
boolean LiveScroll=true
end type

on itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme::dw_Four_Gamme
//* Evenement     : Itemchanged
//* Auteur        : Catherine Abdmeziem
//* Date          : 19/09/2002 10:28:28
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Raffraichissement de la liste des mod$$HEX1$$e800$$ENDHEX$$les / gammes et/ou de la dddw des gammes
//*
//* Arguments     : Aucun
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

invGamme.uf_ControlerZone ( This.GetColumnName ( ), This.GetText ( ) )
end on

type bm_fleche from picture within w_sp_gamme
int X=1418
int Y=57
int Width=129
int Height=65
string PictureName="k:\pb4obj\bmp\fleche.bmp"
boolean FocusRectangle=false
end type

type dw_lst_gamme from datawindow within w_sp_gamme
int X=901
int Y=65
int Width=485
int Height=417
int TabOrder=40
string DataObject="d_liste_gamme"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet         : W_Sp_Gamme
//* Evenement     : RowFocusChanged
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 02/10/2002 12:28:15
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

Long lNumLgn

lNumLgn = dw_lst_gamme.GetRow ()
If lNumLgn <> 0 Then invGamme.uf_ClickLgn ( lNumLgn )
end on

