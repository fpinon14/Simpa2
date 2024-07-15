HA$PBExportHeader$w_trt_sp_ifr_confirm_maj.srw
forward
global type w_trt_sp_ifr_confirm_maj from Window
end type
type st_7 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_6 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_5 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_4 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_information from statictext within w_trt_sp_ifr_confirm_maj
end type
type p_1 from picture within w_trt_sp_ifr_confirm_maj
end type
type cb_ok from commandbutton within w_trt_sp_ifr_confirm_maj
end type
type st_3 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_2 from statictext within w_trt_sp_ifr_confirm_maj
end type
type st_1 from statictext within w_trt_sp_ifr_confirm_maj
end type
type rb_3 from radiobutton within w_trt_sp_ifr_confirm_maj
end type
type rb_2 from radiobutton within w_trt_sp_ifr_confirm_maj
end type
type rb_1 from radiobutton within w_trt_sp_ifr_confirm_maj
end type
type st_reference from statictext within w_trt_sp_ifr_confirm_maj
end type
end forward

global type w_trt_sp_ifr_confirm_maj from Window
int X=1335
int Y=689
int Width=1966
int Height=977
boolean TitleBar=true
string Title="Confirmation Action"
long BackColor=12632256
WindowType WindowType=response!
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_information st_information
p_1 p_1
cb_ok cb_ok
st_3 st_3
st_2 st_2
st_1 st_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_reference st_reference
end type
global w_trt_sp_ifr_confirm_maj w_trt_sp_ifr_confirm_maj

on open;
/*--------------------------------------------------------*/
/* Affectation de la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence que l'on tente de modifier */
/*-------------------------------------------------------*/

st_reference.Text = Message.StringParm
end on

on w_trt_sp_ifr_confirm_maj.create
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_information=create st_information
this.p_1=create p_1
this.cb_ok=create cb_ok
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_reference=create st_reference
this.Control[]={ this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_information,&
this.p_1,&
this.cb_ok,&
this.st_3,&
this.st_2,&
this.st_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_reference}
end on

on w_trt_sp_ifr_confirm_maj.destroy
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_information)
destroy(this.p_1)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_reference)
end on

type st_7 from statictext within w_trt_sp_ifr_confirm_maj
int X=1623
int Y=365
int Width=78
int Height=73
boolean Enabled=false
string Text="*"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_trt_sp_ifr_confirm_maj
int X=1619
int Y=293
int Width=78
int Height=73
boolean Enabled=false
string Text="*"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_trt_sp_ifr_confirm_maj
int X=476
int Y=697
int Width=782
int Height=73
boolean Enabled=false
string Text=" sera d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$automatiquement!"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_trt_sp_ifr_confirm_maj
int X=229
int Y=653
int Width=1340
int Height=57
boolean Enabled=false
string Text="(*) Pour les deux premiers choix le bouton ENREGISTRER"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_information from statictext within w_trt_sp_ifr_confirm_maj
int X=229
int Y=793
int Width=1354
int Height=73
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_trt_sp_ifr_confirm_maj
int X=65
int Y=89
int Width=161
int Height=141
string PictureName="k:\pb4obj\bmp\quest!.bmp"
boolean FocusRectangle=false
end type

type cb_ok from commandbutton within w_trt_sp_ifr_confirm_maj
int X=746
int Y=537
int Width=247
int Height=109
int TabOrder=1
string Text="&OK"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
Long	lRet

Choose Case True

	Case rb_1.Checked
		lRet = 1

	Case rb_2.Checked
		lRet = 2

	Case rb_3.Checked
		lRet = 3

	Case Else
		lRet = 0

End Choose

If lRet <> 0 Then
	CloseWithReturn (Parent, lRet)
Else
	st_information.Text = "Veuillez effectuer un choix!"
End If
end on

type st_3 from statictext within w_trt_sp_ifr_confirm_maj
int X=289
int Y=193
int Width=695
int Height=73
boolean Enabled=false
string Text="Que souhaitez-vous faire?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_trt_sp_ifr_confirm_maj
int X=289
int Y=133
int Width=1468
int Height=73
boolean Enabled=false
string Text="que vous tentez de modifier existe dans la table article."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_trt_sp_ifr_confirm_maj
int X=289
int Y=81
int Width=339
int Height=73
boolean Enabled=false
string Text="La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_trt_sp_ifr_confirm_maj
int X=869
int Y=437
int Width=759
int Height=73
string Text="Annuler votre modification"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_trt_sp_ifr_confirm_maj
int X=508
int Y=361
int Width=1121
int Height=73
string Text="Supprimer la valeur dans la table article"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_trt_sp_ifr_confirm_maj
int X=211
int Y=289
int Width=1418
int Height=73
string Text="Mettre $$HEX2$$e0002000$$ENDHEX$$jour la table article avec la nouvelle valeur"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_reference from statictext within w_trt_sp_ifr_confirm_maj
int X=631
int Y=81
int Width=1271
int Height=69
boolean Enabled=false
string Text="test"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

