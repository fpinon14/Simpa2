-------------------------------------------------------------------
--
-- Fic hier             :       STAT_SIN.CP
-- Auteur               :       FABRY JF
-- Date                 :       08/07/2016
--
-- Commentaires         :       PS affèrant à la table STAT_SIN
--
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_U_STAT_SIN_REDRESS
-- Auteur               :       FABRY JF
-- Date                 :       08/07/2016
-- Libellé              :        
-- Commentaires         :       [VDOC21291]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_STAT_SIN_REDRESS' AND type = 'P' )
        DROP procedure sysadm.PS_U_STAT_SIN_REDRESS
GO

CREATE procedure sysadm.PS_U_STAT_SIN_REDRESS
AS

Declare @iMaxPer integer
Declare @sMaxPer VarChar ( 10 )
Declare @dtDtePivot DateTime

Select @iMaxPer = max ( id_periode ) From sysadm.stat_sin
Select @sMaxPer = Convert ( VarChar ( 10) , @iMaxPer  )

Set @dtDtePivot = '01/' + Right ( @sMaxPer, 2 ) + '/' + Left ( @sMaxPer, 4 ) 
Set @dtDtePivot = DateAdd ( month, 1, @dtDtePivot )

Update sysadm.stat_sin
Set    cod_etat = g.cod_etat
from   stat_sin st,
		gar_sin g
where st.id_periode > 201001
And   st.id_periode = ( 
			Select max ( st1.id_periode )
			From   stat_sin st1
			Where  st1.id_sin = st.id_sin
			And    st1.id_gti = st.id_gti )
And  g.id_sin = st.id_sin
And  g.id_gti = st.id_gti
And  g.cod_etat <> st.cod_etat
And  g.valide_le <= @dtDtePivot

Go

