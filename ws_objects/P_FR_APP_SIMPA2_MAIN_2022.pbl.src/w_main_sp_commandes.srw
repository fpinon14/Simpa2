HA$PBExportHeader$w_main_sp_commandes.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre MAIN pour le module des traitements journaliers
forward
global type w_main_sp_commandes from w_main
end type
end forward

global type w_main_sp_commandes from w_main
integer width = 3209
integer height = 1876
string menuname = "m_main_sp_commandes"
long backcolor = 12632256
end type
global w_main_sp_commandes w_main_sp_commandes

type variables
Private : 

n_cst_OpCon_XPS invOpcon

Int  iiTimer, iiTrt

String	isRepFicOpcon
String	K_FICFINTRT = "FIN_TRT"
end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet         : w_main_sp_commandes
//* Evenement     : open
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 10:07:34
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de l'automatisation des commandes avec Opcon/XMS
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
/* Si on n'est pas en mode automatique lanc$$HEX2$$e9002000$$ENDHEX$$par OpCon/XMS, on      */
/* sort.                                                            */
/*------------------------------------------------------------------*/
If Not gbOpcon Then Return

invOpcon = Create n_cst_OpCon_XPS

This.Hide ()

isRepFicOpcon =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "OPCON_OUT", &
					  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" ) 

invOpcon .uf_Initialiser ( This.MenuId )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$clenchement de la fermeture SIMPA2 par un Timer afin de        */
/* d$$HEX1$$e900$$ENDHEX$$caler cette tache de 3 secondes.                               */
/*------------------------------------------------------------------*/
iiTimer = 0

//Migration PB8-WYNIWYG-03/2006 CP
//If FileExists ( isRepFicOpcon + K_FICFINTRT ) Then
If f_FileExists ( isRepFicOpcon + K_FICFINTRT ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	If FileDelete ( isRepFicOpcon + K_FICFINTRT ) Then
		iiTrt = 1
		Timer ( 2, This )
	Else
		iiTrt = 99
		Timer ( 2, This )
	End If
Else
	iiTrt = 1
	Timer ( 2, This )
End If


end event

event timer;call super::timer;//*-----------------------------------------------------------------
//*
//* Objet         : w_main_sp_commandes
//* Evenement     : Timer
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 10:07:34
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$clenchement de la fermeture de SIMPA2
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*			FPI	03/12/2010	[PC175]
//				FPI	18/09/2013	[VDOC12140]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Traitement de la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des commandes      						  */
/*------------------------------------------------------------------*/
If iiTrt = 1 Then

	iiTrt = 2 
	invOpcon.uf_LancerTrt ( "GEN_FIC_CMD" )

/*------------------------------------------------------------------*/
/* Traitement de l'int$$HEX1$$e900$$ENDHEX$$gration du fichier Article                   */
/*------------------------------------------------------------------*/
ElseIf iiTrt = 2 Then 


//Migration PB8-WYNIWYG-03/2006 CP	
//	If FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
	If f_FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
		iiTrt = 3 
		If FileDelete ( isRepFicOpcon + K_FICFINTRT ) Then
			invOpcon.uf_LancerTrt ( "INT_FIC_ARTICLE" )				
		Else
			iiTrt = 99
		End If
	End If

/*------------------------------------------------------------------*/
/* Traitement de l'int$$HEX1$$e900$$ENDHEX$$gration du suivi de commande                 */
/*------------------------------------------------------------------*/
ElseIf iiTrt = 3 Then 


//Migration PB8-WYNIWYG-03/2006 CP	
//	If FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
	If f_FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
		iiTrt = 4 // [PC175] ald 98 
		If FileDelete ( isRepFicOpcon + K_FICFINTRT ) Then
			invOpcon.uf_LancerTrt ( "INT_FIC_SUIVICMD" )	
		Else
			iiTrt = 99
		End If
	End If

ElseIf iiTrt = 4 Then 

	If f_FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
		
		iiTrt = 98 
		If FileDelete ( isRepFicOpcon + K_FICFINTRT ) Then
			
			invOpcon.uf_LancerTrt ( "INT_FIC_AUTRE" )	// [VDOC12140] - changement de nom
			
		Else
			iiTrt = 99
		End If
	End If

/*------------------------------------------------------------------*/
/* Traitement du fichier de sortie.											  */
/*------------------------------------------------------------------*/
ElseIf iiTrt = 98 Then 


//Migration PB8-WYNIWYG-03/2006 CP	
//	If FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
	If f_FileExists ( isRepFicOpcon + K_FICFINTRT ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
		iiTrt = 99 
		FileDelete ( isRepFicOpcon + K_FICFINTRT )
		invOpcon.uf_LancerTrt ( "OK?" )	
	End If

/*------------------------------------------------------------------*/
/* Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre                                          */
/*------------------------------------------------------------------*/
ElseIf iiTrt = 99 Then

	iiTimer ++
	FileDelete ( isRepFicOpcon + K_FICFINTRT )

	If iiTimer >= 3 Then 
		Timer ( 0, This )	

		/*------------------------------------------------------------------*/
		/* Simule le click sur le bouton 'Quitter' de SIMPA2                */
		/*------------------------------------------------------------------*/
		gWMdi.MenuId.Item[8].PostEvent ( Clicked! )
	End If

End If

end event

on close;call w_main::close;//*-----------------------------------------------------------------
//*
//* Objet         : w_main_sp_commandes
//* Evenement     : Close
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 10:07:34
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de l'automatisation des commandes avec Opcon/XMS
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


If IsValid ( invOpcon ) Then DesTroy ( invOpcon )


end on

on w_main_sp_commandes.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_sp_commandes" then this.MenuID = create m_main_sp_commandes
end on

on w_main_sp_commandes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

