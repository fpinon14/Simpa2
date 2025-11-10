HA$PBExportHeader$w_trt_sp_ifr_consultation_equiv.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des $$HEX1$$e900$$ENDHEX$$quivalences fonctionnelles
forward
global type w_trt_sp_ifr_consultation_equiv from Window
end type
type uo_pilote from u_sp_ifr_pilote within w_trt_sp_ifr_consultation_equiv
end type
type pb_retour from picturebutton within w_trt_sp_ifr_consultation_equiv
end type
end forward

global type w_trt_sp_ifr_consultation_equiv from Window
int X=1335
int Y=689
int Width=3566
int Height=1753
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
uo_pilote uo_pilote
pb_retour pb_retour
end type
global w_trt_sp_ifr_consultation_equiv w_trt_sp_ifr_consultation_equiv

on open;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Consultation_Equiv
//* Evenement 		: Open
//* Auteur			: PLJ
//* Date				: 24/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

stPass = Message.PowerObjectParm

This.Title = "Consultation Equivalence Fonctionnelle"

This.Width  = 3570
This.Height = 1762

uo_pilote.Uf_Initialiser ( stPass.dwNorm [1], stPass.dwNorm [2] )
uo_pilote.Uf_Preparer    ( stPass.sTab[1], stPass.sTab[2], stPass.sTab[3], 0 )



end on

on close;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Consultation_Equiv
//* Evenement 		: Close
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

uo_pilote.Uf_Filtrer_Init ()


end on

on w_trt_sp_ifr_consultation_equiv.create
this.uo_pilote=create uo_pilote
this.pb_retour=create pb_retour
this.Control[]={ this.uo_pilote,&
this.pb_retour}
end on

on w_trt_sp_ifr_consultation_equiv.destroy
destroy(this.uo_pilote)
destroy(this.pb_retour)
end on

type uo_pilote from u_sp_ifr_pilote within w_trt_sp_ifr_consultation_equiv
int X=33
int Y=161
int Width=3489
int Height=1477
int TabOrder=20
boolean Border=false
end type

on ue_cocher;call u_sp_ifr_pilote::ue_cocher;This.uf_Activer_AffRech (True)
end on

on uo_pilote.destroy
call u_sp_ifr_pilote::destroy
end on

type pb_retour from picturebutton within w_trt_sp_ifr_consultation_equiv
int X=28
int Y=17
int Width=234
int Height=137
int TabOrder=10
string Text="&Retour"
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
boolean OriginalSize=true
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Consultation_Equiv::pb_retour
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


Close (Parent)
end on

