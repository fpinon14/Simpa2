HA$PBExportHeader$u_libelle_dga.sru
forward
global type u_libelle_dga from userobject
end type
type dw_1 from datawindow within u_libelle_dga
end type
end forward

global type u_libelle_dga from userobject
integer width = 562
integer height = 420
dw_1 dw_1
end type
global u_libelle_dga u_libelle_dga

type variables
Private :
	String		isVarValue[]
	Long		ilNbVar
end variables

forward prototypes
public function integer u_charge_code (string astyplib, ref string ascode[])
public function integer u_charge_libelle (string astyplib, ref string ascode[])
public function boolean u_addvalue (string asvar, string asvalue)
public function boolean u_addvaluesep (string asvar, string asvalue, string asseparator)
public function boolean u_creevariable (string asfic, boolean abretour)
public function boolean u_variablechaine (ref string ascahine, s_spb astspb)
public subroutine uf_initialisation (ref u_transaction atrtrans)
public function boolean uf_setvalue (string asvar, string asvalue)
public function long uf_retrieve (string astyplib)
public subroutine uf_initialiser_tableau (ref string astab[])
public subroutine Uf_Recuperer_tableau_variable (ref string astab[])
public subroutine uf_creer_chaine (ref string aschaine, s_spb astspb)
public subroutine uf_recuperer_tableau_variable_pi052 (ref string astbvar[])
end prototypes

public function integer u_charge_code (string astyplib, ref string ascode[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_Charge_Code
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de remplir un tableau avec les codes 
//*						retrouv$$HEX2$$e9002000$$ENDHEX$$dans la table des codes
//* Commentaires	:	
//*
//* Arguments		:	String	asTypeLib	(Val)	Code concern$$HEX1$$e900$$ENDHEX$$.
//*						String	asCode[]		(Ref) Tableau $$HEX2$$e0002000$$ENDHEX$$charger
//*
//* Retourne		:	Integer	Le nombre de codes lus
//*-----------------------------------------------------------------

Integer	iCpt = 1

Long		lNbLig
Long		lCpt

String	sType

lNbLig	=	Dw_1.RowCount()

For lCpt = 1 To lNbLig

	sType	=	Dw_1.GetItemString ( lCpt, "cod_type" )
	If sType = asTypLib Then

		asCode[iCpt] = Dw_1.GetItemString ( lCpt, "cod_lib" )
		iCpt++
	End If
Next

Return ( iCpt - 1 )
end function

public function integer u_charge_libelle (string astyplib, ref string ascode[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_Charge_libelle
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de remplir un tableau avec les libelle 
//*						retrouv$$HEX2$$e9002000$$ENDHEX$$dans la table des codes
//* Commentaires	:	
//*
//* Arguments		:	String	asTypeLib	(Val)	Code concern$$HEX1$$e900$$ENDHEX$$.
//*						String	asCode[]		(Ref) Tableau $$HEX2$$e0002000$$ENDHEX$$charger
//*
//* Retourne		:	Integer	Le nombre de codes lus
//*-----------------------------------------------------------------
Integer	iCpt

Long		lNbLig
Long		lCpt

String	sType

lNbLig	=	Dw_1.RowCount()

For lCpt = 1 To lNbLig

	sType	=	Dw_1.GetItemString ( lCpt, "cod_type" )
	If sType = asTypLib Then

		asCode[iCpt] = Dw_1.GetItemString ( lCpt, "lib" )
		iCpt++
	End If
Next

Return ( iCpt )
end function

public function boolean u_addvalue (string asvar, string asvalue);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_addvalue
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'ajouter une valeur $$HEX2$$e0002000$$ENDHEX$$une varaible de fusion
//* Commentaires	:	Fait pour les variable liste
//*
//* Arguments		:	String	asVar		(Val)	Nom de la variable de fusion.
//*						String	asValue	(Val) Valeur $$HEX2$$e0002000$$ENDHEX$$ajouter
//*
//* Retourne		:	Boolean	True : Ok la variable $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e
//*						et la valeur est bien ajout$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------

String	sDwFind
Long		lRow

sDwFind = "cod_lib='" + asVar + "'"

lRow = dw_1.Find ( sDwFind, 1 , ilNbVar )

If ( lRow > 0 ) Then
	If isVarValue[ lRow ] = "" Then
		isVarValue[ lRow ] = asValue
	Else
		isVarValue[ lRow ] = isVarvalue[ lRow ] + Char(11) + asValue
	End If
	Return ( True )
Else
	Return ( False )
End If


end function

public function boolean u_addvaluesep (string asvar, string asvalue, string asseparator);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_AddvalueSep
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'ajouter une valeur $$HEX2$$e0002000$$ENDHEX$$une varaible de fusion
//*						En pr$$HEX1$$e900$$ENDHEX$$sisant le s$$HEX1$$e900$$ENDHEX$$parateur
//* Commentaires	:	Fait pour les variable liste
//*
//* Arguments		:	String	asVar			(Val)	Nom de la variable de fusion.
//*						String	asValue		(Val) Valeur $$HEX2$$e0002000$$ENDHEX$$ajouter
//*						String	asSeparator	(Val) Caract$$HEX1$$e800$$ENDHEX$$re de s$$HEX1$$e900$$ENDHEX$$paration
//*
//* Retourne		:	Boolean	True : Ok la variable $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e
//*						et la valeur est bien ajout$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------

String	sDwFind
Long		lRow

sDwFind = "cod_lib='" + asVar + "'"

lRow = dw_1.Find ( sDwFind, 1 , ilNbVar )

If ( lRow > 0 ) Then
	If isVarValue[ lRow ] = "" Then
		isVarValue[ lRow ] = asValue
	Else
		isVarValue[ lRow ] = isVarvalue[ lRow ] + asSeparator + asValue
	End If
	Return ( True )
Else
	Return ( False )
End If


end function

public function boolean u_creevariable (string asfic, boolean abretour);//======================================================================
// F_CreerVariable : Cr$$HEX1$$e900$$ENDHEX$$ation du fichier de variables ( DATA.DAT )
//
//
// Auteur PR le 19/04/95
//
// --> asFic : Nom du fichier $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er
//
// <-- True / False si probl$$HEX1$$e800$$ENDHEX$$me
//======================================================================

Boolean bOk = True
Integer i
String sVar
Blob blVar 
// .... Partie Adresse SPB

sVar = "ESPNOM~tESPAD1~tESPAD2~tESPCPO~tESPVIL~tESPLID~tESPLIV~tESPRSO"

For i = 1 To dw_1.RowCount()
	sVar = sVar + "~t" + dw_1.GetItemString( i,"cod_lib")
Next


If abRetour Then	sVar = sVar + "~r~n"

// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
//blVar = Blob ( sVar )
blVar = Blob ( sVar, EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration
bOk = F_EcrireFichierBlob( blVar , asFic )

Return bOk





end function

public function boolean u_variablechaine (ref string ascahine, s_spb astspb);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_variablechaine
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:47:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Retourne sous forme de chaine, les valeurs par 
//*						rapport aux variable de fusion
//* Commentaires	:	
//*
//* Arguments		:	String	asChaine	(Raf)	Zone de r$$HEX1$$e900$$ENDHEX$$ception des donn$$HEX1$$e900$$ENDHEX$$es.
//*
//* Retourne		:	Boolean Ok la variable est bien charg$$HEX1$$e900$$ENDHEX$$e.
//*
//*-----------------------------------------------------------------


Return f_VariableChaine( astSPB, isVarValue, asCahine )

end function

public subroutine uf_initialisation (ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_Initialisation (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/06/1998 10:34:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialise le UserObject
//*
//* Arguments		: U_Transaction	atrTrans			(Val)	Objet de transaction
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String	sDataObject, sMoteur

sDataobject = "d_libelle_"
sMoteur		= Left ( Upper ( atrTrans.DBMS ), 3 )

// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
//If sMoteur = "SNC" Then sMoteur = "MSS"
sMoteur = "MSS"
// [:PI056]
// [MIGPB11] [EMD] : Fin Migration

/*------------------------------------------------------------------*/
/* On assigne le DataObject en fonction du moteur.                  */
/*------------------------------------------------------------------*/
Choose Case sMoteur
	Case "GUP"
		sDataObject = sDataObject + sMoteur
	
	Case "MSS"
		sDataObject = sDataObject + sMoteur
End Choose

dw_1.DataObject = sDataObject

dw_1.SetTransObject ( atrTrans )

end subroutine

public function boolean uf_setvalue (string asvar, string asvalue);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_SetValue (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/06/1998 10:59:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche de la variable dans la DW et remplacement par le contenu
//*
//* Arguments		: String			asVar				(Val)	Nom de la variable
//*					  String			asValue			(Val)	Contenu de la variable
//*
//* Retourne		: Boolean		True	= La variable existe
//*										False	= La variable n'existe pas
//*
//*-----------------------------------------------------------------

String sRech

Long lLig

sRech = "COD_LIB = '" + asVar + "'"

lLig = dw_1.Find ( sRech, 1, ilNbVar )
If	lLig	> 0	Then
/*------------------------------------------------------------------*/
/* On arme le contenu de la variable dans le tableau.               */
/*------------------------------------------------------------------*/
	isVarValue [ lLig ] = asValue
	Return ( True )
Else
	Return ( False )
End If





end function

public function long uf_retrieve (string astyplib);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_Retrieve (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/06/1998 10:55:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la liste des variables.
//*
//* Arguments		: String			asTypLib			(Val)	Valeur de la zone
//*
//* Retourne		: Long			Nombre de variables r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es
//*
//*-----------------------------------------------------------------

String sVide[]

ilNbVar = dw_1.Retrieve ( asTypLib )
sVide [ ilNbVar ] = ""

Uf_Initialiser_Tableau ( sVide [] )

Return ( ilNbVar )





end function

public subroutine uf_initialiser_tableau (ref string astab[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_Initialiser_Tableau (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/06/1998 11:05:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialise le tableau des variables $$HEX2$$e0002000$$ENDHEX$$vide
//*
//* Arguments		: String			asTab[]			(R$$HEX1$$e900$$ENDHEX$$f) Contenu du tableau $$HEX2$$e0002000$$ENDHEX$$initialiser
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

isVarValue [] = asTab []


end subroutine

public subroutine Uf_Recuperer_tableau_variable (ref string astab[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_Recuperer_Tableau_Variable (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/06/1998 11:05:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le tableau des variables
//*
//* Arguments		: String			asTab[]			(R$$HEX1$$e900$$ENDHEX$$f) Contenu du tableau $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cuperer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La variable isVarValue $$HEX1$$e900$$ENDHEX$$tant PRIVATE, cette fonction permet de   */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le tableau actuellement arm$$HEX1$$e900$$ENDHEX$$.                          */
/*------------------------------------------------------------------*/

asTab [] = isVarValue []


end subroutine

public subroutine uf_creer_chaine (ref string aschaine, s_spb astspb);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle_Dga::Uf_Creer_Chaine (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 09/07/1998 14:45:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne une chaine de caract$$HEX1$$e800$$ENDHEX$$res correspondant $$HEX2$$e0002000$$ENDHEX$$la liste des variables arm$$HEX1$$e900$$ENDHEX$$es.
//*
//* Arguments		: String			asText				(R$$HEX1$$e900$$ENDHEX$$f)	Chaine de caract$$HEX1$$e800$$ENDHEX$$res qui va $$HEX1$$ea00$$ENDHEX$$tre arm$$HEX1$$e900$$ENDHEX$$e
//*					  S_SPB			astSpb				(Val) Structure globale pour les coordonn$$HEX1$$e900$$ENDHEX$$es SPB
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

F_VariableChaine ( astSpb, isVarValue, asChaine )


int i


end subroutine

public subroutine uf_recuperer_tableau_variable_pi052 (ref string astbvar[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Libelle::Uf_Recuperer_Tableau_Variable_PI052 (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/06/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PI052]
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le tableau des codes des variables
//*
//* Arguments		: String			asTabVar[]			(R$$HEX1$$e900$$ENDHEX$$f) Contenu du tableau $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cuperer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lCpt, lTot 
String astbNul[]

astbVar = astbNul

lTot = Dw_1.RowCount ()

For lCpt = 1 to lTot 
	astbVar[ lCpt ] = Dw_1.GetItemString ( lCpt, "COD_LIB" )
Next




end subroutine

on u_libelle_dga.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_libelle_dga.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_libelle_dga
boolean visible = false
integer x = 27
integer y = 28
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
end type

