-- PI056 - Pour archive

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_PACIFICA_SIN_LOT3' AND type = 'P' )
        DROP procedure sysadm.[PS_PACIFICA_SIN_LOT3]
GO

CREATE procedure [sysadm].[PS_PACIFICA_SIN_LOT3]
@dteSup     Datetime 		-- Date fin de période mensuelle
AS

DECLARE   @sPeriode     char(6),
          @sSociete     char(3)

SET @sPeriode    = Convert ( Char(4), year (@dteSup) ) + RIGHT ( '00' + Convert (varchar(2), Month(@dteSup) ), 2) 

DELETE FROM sysadm.w_pacifica_sin -- Purge de la table temporaire

------------------------------------------------------------------------------------------------
-- SINDI liste des sinistres
------------------------------------------------------------------------------------------------

INSERT INTO sysadm.w_pacifica_sin

(idappli,idprod,cdenrg,cdgest,societe,cddist,extdept,dtref,cdrejet,refclient,
client,refentprf,produit,formule,contrat,image,gtie,criter1,criter2,criter3,
criter4,criter5,criter6,criter7,criter8,criter9,sin,dtsurv,nature,etatsin,
dtouvsin,dtclosin,dtrousin,gtiesin,etatgtie,dtouvgar,dtclogar,dtougar,dtanngar,rpcorg,
rfcorg,rhcorg,rrcorg,rcpexer,rfcexer,rhcexer,rrcexer,evr,evrr,filler)

SELECT
4													as idappli,	--code de l'application
s.id_prod										as idprod,	--n° produit SPB
--données générales
'300'            								as cdenrg,  -- code enregistrement
'SPB'   			      						as cdgest,  -- Code du partenaire gestionnaire
'01'                 						as societe, -- Code de la société cliente
s.cddist 										as cddist,  -- Code distributeur
Space(5)             						as extdept, -- Référence du département
@sPeriode            						as dtref,   -- date de référence
Space(1)		       							as cdrejet,	--code rejet
--données client
Space(1)											as refclient,
Space(1)											as client,
Space(1)											as refentprf,
--données contrat
s.produit										as produit,	--code du produit, référentiel pacifica
'1'												as formule,	--code de la formule
Space(1)											as contrat,
Space(1)											as image,
s.gtie											as gtie,	--code de la garantie contrat

CASE 
	when s.produit='SU' then 
		CASE s.id_opt
			when 1 then 'A'
			when 2 then 'B'
			else Space(1)
		END
	when s.produit='PE' then convert(varchar(10),nbr_bene_tot)
	when s.produit in ('CL','LI','CU') then 
		CASE 
			when s.id_gti between 1 and 55 then '1' 
			when s.id_gti between 100 and 150 then '2'
			else Space(1)
		END
	when s.produit='FA' then (select convert(varchar(2),count(*)) from SINDI_TRT.sysadm.inter i where i.id_sin=s.id_sin and cod_inter='F' and age_sin<21)
	else Space(1)
END			
													as criter1,

CASE
	when s.produit='SU' then
		CASE s.nbr_mod
			when 2 then 'X2'
			when 3 then 'X3'
			else Space(1)
		END
	when s.produit in ('CL','LI','CU') then
		CASE 
			when s.id_opt=9 then '00'
			when s.id_opt between 1 and 8 then '0'+ convert ( varchar(1) ,s.id_opt)
			when s.id_opt between 11 and 25 then right('0'+ convert ( varchar(2) ,s.id_opt-10),2)
			when s.id_opt between 31 and 45 then right('0'+ convert ( varchar(2),s.id_opt-30),2)
			else Space(1)
		END
	when s.produit='FA' then (select convert(varchar(2),count(*)) from SINDI_TRT.sysadm.inter i where i.id_sin=s.id_sin and cod_inter='F' and age_sin>=21)
	else Space(1)
END
						 							as criter2,	

Space(1)											as criter3,	
Space(1)											as criter4,	
Space(1)											as criter5,	
Space(1)											as criter6,	
Space(1)											as criter7,	
Space(1)											as criter8,	
Space(1)											as criter9,	
convert (varchar(8),s.id_sin)				as sin,

case when s.dte_eff is null then 
	convert( varchar(10), s.cree_le, 104) else
	convert( varchar(10), s.dte_eff, 104) end
												 	as dtsurv,

'C'												as nature,

sysadm.FN_CODE_PACIFICA ( 4, 'SIN', s.cod_etat )	
													as etatsin,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end
													as dtouvsin,

case when s.cod_etat in (300,500) then convert ( varchar(10) , s.valide_le, 104 ) else Space(10) end
												 	as dtclosin,

Space(10)										as dtrousin,
s.gtiesin										as gtiesin,

sysadm.FN_CODE_PACIFICA ( 4, 'GTI', s.cod_etat )
												 	as etatgtie,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end
													as dtouvgar,

case when s.cod_etat in (300,500) then convert ( varchar(10) , s.valide_le, 104 ) else Space(10) end 	
													as dtclogar,

Space(10)		 								as dtougar,
Space(10)										as dtanngar,

(SELECT case when sum(ech.mt_reg) is null then 0 else sum (ech.mt_reg) end
FROM SINDI_TRT.sysadm.ech_reg ech
WHERE 	ech.id_sin = s.id_sin AND
			ech.cod_pos = '1'          AND
			ech.alt_reg = 'O'          AND
			ech.cod_motif   <> 'RI'    AND
			ech.dte_reg_eff < @dteSup )
									 				as rpcorg,

(SELECT case when sum(fr.mt_frais) is null then 0 else sum(fr.mt_frais) end
FROM SINDI_TRT.sysadm.frais fr
WHERE 	fr.id_sin  = s.id_sin AND
			fr.cod_pos = '1' AND
			fr.dte_reg_eff < @dteSup) 				
													as rfcorg,

0													as rhcorg,
0 													as rrcorg,

(SELECT case when sum(ech.mt_reg) is null then 0 else sum (ech.mt_reg) end
FROM SINDI_TRT.sysadm.ech_reg ech
WHERE 	ech.id_sin = s.id_sin AND
			ech.cod_pos = '1'          AND
			ech.alt_reg = 'O'          AND
			ech.cod_motif   <> 'RI'    AND
			ech.dte_reg_eff >= convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) AND
			ech.dte_reg_eff < @dteSup )
 													as rcpexer,

(SELECT case when sum(fr.mt_frais) is null then 0 else sum(fr.mt_frais) end
FROM SINDI_TRT.sysadm.frais fr
WHERE 	fr.id_sin  = s.id_sin AND
			fr.cod_pos = '1' AND
			fr.dte_reg_eff >= convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) AND
			fr.dte_reg_eff < @dteSup) 	
													as rfcexer,

0 													as rhcexer,
0 													as rrcexer,

(SELECT case when sum(ech.mt_reg) is null then 0 else sum(ech.mt_reg) end
FROM SINDI_TRT.sysadm.ech_reg ech
WHERE 	ech.id_sin = s.id_sin 		AND
			ech.cod_pos = '1'          AND
			ech.alt_reg = 'O'          AND
			ech.cod_motif   <> 'RI'    AND
			ech.dte_reg_eff < @dteSup)
	+
(SELECT case when sum(fr.mt_frais) is null then 0 else sum(fr.mt_frais) end
FROM SINDI_TRT.sysadm.frais fr
WHERE 	fr.id_sin  = s.id_sin AND
			fr.cod_pos = '1' AND
			fr.dte_reg_eff < @dteSup) 				
													as evr,			--rpcorg+rfcorg+rhcorg

0 													as evrr,
Space(1) 										as filler 

FROM   SINDI_TRT.sysadm.v_pacifica_sin s

union

SELECT
4													as idappli,	--code de l'application
s.id_prod										as idprod,	--n° produit SPB
--données générales
'300'            								as cdenrg,  	-- code enregistrement
'SPB'   			               		 	as cdgest,  	-- Code du partenaire gestionnaire
'01'                       				as societe, 	-- Code de la société cliente
s.cddist											as cddist,   	-- Code distributeur
Space(5)                  					as extdept,  	-- Référence du département
@sPeriode                 					as dtref,    	-- date de référence
Space(1)		       							as cdrejet,	--code rejet
--données client
Space(1)											as refclient,
Space(1)											as client,
Space(1)											as refentprf,
--données contrat
s.produit										as produit,	--code du produit, référentiel pacifica
'1'												as formule,	--code de la formule
Space(1)											as contrat,
Space(1)											as image,
s.gtie	 										as gtie,	--code de la garantie contrat

CASE 
	when s.produit='SU' then 
		CASE s.id_opt
			when 1 then 'A'
			when 2 then 'B'
			else Space(1)
		END
	when s.produit='PE' then convert(varchar(10),nbr_bene_tot)
	when s.produit in ('CL','LI','CU') then 
		CASE 
			when s.id_gti between 1 and 55 then '1' 
			when s.id_gti between 100 and 150 then '2'
			else Space(1)
		END
	when s.produit='FA' then (select convert(varchar(2),count(*)) from SINDI_TRT.sysadm.inter i where i.id_sin=s.id_sin and cod_inter='F' and age_sin<21)
	else Space(1)
END
													as criter1,
CASE
	when s.produit='SU' then
		CASE s.nbr_mod
			when 2 then 'X2'
			when 3 then 'X3'
			else Space(1)
		END
	when s.produit in ('CL','LI','CU') then
		CASE 
			when s.id_opt=9 then '00'
			when s.id_opt between 1 and 8 then '0'+ convert ( varchar(1) ,s.id_opt)
			when s.id_opt between 11 and 25 then right('0'+ convert ( varchar(2) ,s.id_opt-10),2)
			when s.id_opt between 31 and 45 then right('0'+ convert ( varchar(2),s.id_opt-30),2)
			else Space(1)
		END
	when s.produit='FA' then (select convert(varchar(2),count(*)) from SINDI_TRT.sysadm.inter i where i.id_sin=s.id_sin and cod_inter='F' and age_sin>=21)
	else Space(1)
END 	
													as criter2,	

Space(1)											as criter3,	
Space(1)											as criter4,	
Space(1)											as criter5,	
Space(1)											as criter6,	
Space(1)											as criter7,	
Space(1)											as criter8,	
Space(1)											as criter9,	
convert (varchar(8),s.id_sin)				as sin,

case when s.dte_eff is null then
	convert( varchar(10), s.cree_le, 104) else
	convert( varchar(10), s.dte_eff, 104) end
												 	as dtsurv,

'C'												as nature,

sysadm.FN_CODE_PACIFICA ( 4, 'SIN', s.cod_etat )
													as etatsin,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end
													as dtouvsin,

case when s.cod_etat in (300,500) then convert ( varchar(10) , s.valide_le, 104 ) else Space(10) end
													as dtclosin,

Space(10)										as dtrousin,
s.gtiesin										as gtiesin,

sysadm.FN_CODE_PACIFICA ( 4, 'GTI', s.cod_etat ) 	
													as etatgtie,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end 		
													as dtouvgar,

case when s.cod_etat in (300,500) then convert ( varchar(10) , s.valide_le, 104 ) else Space(10) end 	
													as dtclogar,

Space(10)										as dtougar,
Space(10)										as dtanngar,
0													as rpcorg,
0													as rfcorg,
0													as rhcorg,
0 													as rrcorg,
0 													as rcpexer,
0 													as rfcexer,
0 													as rhcexer,
0 													as rrcexer,
0													as evr,
0													as evrr,
Space(1) 										as filler 

FROM   SINDI_TRT.sysadm.v_pacifica_w_sin s
	
--WHERE  NOT EXISTS ( SELECT * FROM SINDI_TRT.sysadm.sinistre s2 WHERE s2.id_sin = s.id_sin )

------------------------------------------------------------------------------------------------
-- SIMPA2 Liste des sinistres
------------------------------------------------------------------------------------------------
INSERT INTO sysadm.w_pacifica_sin
SELECT
2													as idappli,	-- code de l'application
s.id_prod										as idprod,	-- n° produit SPB
--données générales
'300'            								as cdenrg,  -- code enregistrement
'SPB'   			               		 	as cdgest,  -- Code du partenaire gestionnaire
'01'                       				as societe, -- Code de la société cliente
s.cddist					 						as cddist,  -- Code distributeur
Space(5)                  					as extdept, -- Référence du département
@sPeriode                 					as dtref,   -- date de référence
Space(1)		       							as cdrejet,	-- code rejet
--données client
Space(1)											as refclient,
Space(1)											as client,
Space(1)											as refentprf,
--données contrat
s.produit										as produit,	-- code du produit, référentiel pacifica

CASE
	when s.produit in ('PI','ON') and s.cod_opt is not null
	then convert(char(1),s.cod_opt)
	else '1'
end												as formule,	--code de la formule

Space(1)											as contrat,
Space(1)											as image,
s.gtie											as gtie,		-- code de la garantie contrat

CASE 
	when s.id_prod = 901 then 'PA'
	when s.id_prod = 904 then 'JE'
	when s.id_prod = 902 then 'PR'
	when s.id_prod = 905 then 'FA'
	when s.id_prod = 921 then '1'
	when s.id_prod = 931 then '1'
	when s.id_prod = 925 then '2'
	when s.id_prod = 935 then '2'
	when s.id_prod = 6700 then 'IND'
	when s.id_prod = 6705 then 'FAM'
	when s.id_prod = 13000 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	when s.id_prod = 13100 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	when s.id_prod = 18500 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	-- salarié CA ( 2 : O / 1 : N)
	when s.id_prod like '358%' then	(case (select top 1 dosad_c_type from FUS_DOSAD_PRO.dbo.dosad d where dosad_code_prod = convert ( smallint,left(s.id_prod,len(s.id_prod)-2)) and dosad_ets = 1001 and dosad_no_doss = convert(integer
,s.id_adh))
													when 1 then 'N'
													when 2 then 'O'
													else 'N'		
												end)		
	else Space(1)
END
						 							as criter1,	

CASE s.id_prod
	when 35800 then '1' --nb app de poche 
	else Space(1)
END												as criter2,	

CASE s.id_prod
	when 35801 then '1' --nb app image et video
	else Space(1)
END												as criter3,

CASE s.id_prod
	when 35802 then '1' --nb ordinateur portable
	else Space(1)
END												as criter4,	

CASE s.id_prod
	when 35803 then '1' --nb tel portable
	else Space(1)
END												as criter5,	
Space(1)											as criter6,	
Space(1)											as criter7,	
Space(1)											as criter8,	
Space(1)											as criter9,	
convert (varchar(8),s.id_sin)				as sin,

case when s.dte_surv is null
then convert( varchar(10), s.cree_le, 104)
else convert( varchar(10), s.dte_surv, 104) end
													as dtsurv,

'M'												as nature,

sysadm.FN_CODE_PACIFICA ( 2, 'SIN', s.cod_etat )
													as etatsin,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end		
													as dtouvsin,

case when s.cod_etat in (600,200,900) then convert(varchar(10),s.valide_le,104) else Space(10) end 				
													as dtclosin,

Space(10)										as dtrousin,
s.gtiesin										as gtiesin,

sysadm.FN_CODE_PACIFICA ( 2, 'GTI', s.cod_etat ) 	
													as etatgtie,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end		
													as dtouvgar,

case when s.codetat in (600,200,900) then convert (varchar(10),s.valide_le,104) else Space(10) end 	
													as dtclogar,

Space(10)		 								as dtougar,
Space(10)		 								as dtanngar,
sum(s.mt_reg)		 							as rpcorg,
0 													as rfcorg,
0													as rhcorg,
0 													as rrcorg,
sum(case when s.dte_reg>=convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) then s.mt_reg else 0 end)
 													as rcpexer,

0 													as rfcexer,
0 													as rhcexer,
0 													as rrcexer,
sum(s.mt_reg)									as evr,
0 													as evrr,
Space(1) 										as filler 

FROM SIMPA2_PRO.sysadm.v_pacifica_sin s

WHERE s.dte_reg <= @dteSup
       

GROUP BY  s.produit, s.cddist, s.id_sin,s.gtie, s.gtiesin,sysadm.FN_CODE_PACIFICA (2, 'SIN', s.cod_etat ),
          sysadm.FN_CODE_PACIFICA (2, 'GTI', s.codetat ),s.id_prod,s.cree_le, s.dte_surv, s.dte_ouv,
          s.valide_le, s.dte_ouv, s.valide_le, s.cod_etat, s.codetat, s.cod_opt, s.id_type_carte, s.id_adh


------------------------------------------------------------------------------------------------
-- PEGASE : Liste de tous les dossiers quel que soit le code état
------------------------------------------------------------------------------------------------
INSERT INTO sysadm.w_pacifica_sin
SELECT
3													as idappli,		-- code de l'application
s.id_prod										as idprod,		-- n° produit SPB
--données générales
'300'            								as cdenrg,  	-- code enregistrement
'SPB'   			                			as cdgest,  	-- Code du partenaire gestionnaire
'01'                       				as societe, 	-- Code de la société cliente
s.cddist 										as cddist,   	-- Code distributeur
Space(5)                  					as extdept,  	-- Référence du département
@sPeriode                 					as dtref,    	-- date de référence
Space(1)		       							as cdrejet,		-- code rejet
--données client
Space(1)											as refclient,
Space(1)											as client,
Space(1)											as refentprf,
--données contrat
s.produit										as produit,		-- code du produit, référentiel pacifica
'1' 		                       			as formule,		-- code de la formule
Space(1)											as contrat,
Space(1)											as image,
s.gtie	 										as gtie,			-- code de la garantie contrat

CASE s.produit
	when 'GR' then
		CASE s.id_cond
			when 51 then 'A'
			when 52 then 'B'
			else Space(1)
		END			
	else Space(1)
END							
													as criter1,	

CASE s.produit
	when 'GR' then
		CASE 
			when s.id_opt in (1,2,3,4,5,11) then '1'  
			when s.id_opt=12 then '2'
			else space(1)
		END
	else Space(1)
END
													as criter2,

CASE s.produit
	when 'GR' then
		CASE s.id_cas
	      		WHEN 2000 THEN 'AR'
		        WHEN 2001 THEN 'CO'
			WHEN 3001 THEN 'PL'
			else Space(1)
		END
	else Space(1)
END							
													as criter3,

Space(1)											as criter4,	
Space(1)											as criter5,	
Space(1)											as criter6,	
Space(1)											as criter7,	
Space(1)											as criter8,	
Space(1)											as criter9,	
convert (varchar(8),s.id_sin)				as sin,

case when s.dte_surv is null then
	convert(varchar(10),s.cree_le,104) else
	convert( varchar(10),s.dte_surv, 104) end
												 	as dtsurv,

'C'												as nature,

sysadm.FN_CODE_PACIFICA ( 3, 'SIN', s.cod_etat )	
													as etatsin,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end
													as dtouvsin,

case when s.cod_etat in (600,900) then convert( varchar(10), s.valide_le, 104 ) else Space(10) end	
													as dtclosin,
Space(10)										as dtrousin,
s.gtiesin										as gtiesin,

sysadm.FN_CODE_PACIFICA ( 3, 'GTI', s.etat )
												 	as etatgtie,

case when s.cree is null then Space(10) else convert ( varchar(10),s.cree, 104 ) end		
													as dtouvgar,

case when s.dte_clos is null then Space(10) else convert ( varchar(10), s.dte_clos, 104 ) end
												 	as dtclogar,

Space(10)		 								as dtougar,
Space(10)		 								as dtanngar,

(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum(ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech as ech
WHERE 	ech.id_sin = s.id_sin       	AND
			ech.id_gti  = s.id_gti        AND
			ech.id_motif <> 'RI'				AND
			ech.valide_le < @dteSup) 
									  		 		as rpcorg,

(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum (ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech as ech
WHERE	ech.id_sin  = s.id_sin    AND
		ech.id_gti  = s.id_gti    AND
		ech.id_motif = 'RF'       AND
		ech.valide_le < @dteSup) 				
													as rfcorg,

0								       			as rhcorg,
0 													as rrcorg,

(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum(ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech as ech
WHERE 	ech.id_sin = s.id_sin       	AND
			ech.id_gti  = s.id_gti        AND
			ech.id_motif <> 'RI'				AND
			ech.valide_le >= convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) AND
			ech.valide_le < @dteSup) 
 													as rcpexer,

(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum (ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech as ech
WHERE	ech.id_sin  = s.id_sin    AND
		ech.id_gti  = s.id_gti    AND
		ech.id_motif = 'RF'       AND
		ech.valide_le >= convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) AND		
		ech.valide_le < @dteSup) 
						 							as rfcexer,

0						 							as rhcexer,
0 													as rrcexer,

(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum (ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech  as ech
WHERE	ech.id_sin = s.id_sin AND
		ech.id_gti  = s.id_gti     AND
		ech.id_motif  <> 'RI'       AND
		ech.valide_le < @dteSup)
	+ 
(SELECT case when sum(ech.mt_reg_tot) is null then 0 else sum (ech.mt_reg_tot) end
FROM PEGASE_TRT.sysadm.ech as ech
WHERE	ech.id_sin  = s.id_sin    	AND
		ech.id_gti  = s.id_gti  	AND
		ech.id_motif = 'RF'        AND
		ech.valide_le < @dteSup) 
							            		as evr,   	--rpcorg+rfcorg+rhcorg

0 													as evrr,		--rrcorg
Space(1) 										as filler 

FROM   PEGASE_TRT.sysadm.v_pacifica_sin s		

/*----------------------------------------------*/
/* Remise à Zéro et à blancs des valeurs        */
/*----------------------------------------------*/

UPDATE sysadm.w_pacifica_sin   SET dtsurv = ' '  WHERE dtsurv is null
UPDATE sysadm.w_pacifica_sin   SET dtouvsin = ' '   WHERE dtouvsin is null
UPDATE sysadm.w_pacifica_sin   SET dtclosin = ' '  WHERE dtclosin is null
UPDATE sysadm.w_pacifica_sin   SET dtrousin = ' '  WHERE dtrousin is null
UPDATE sysadm.w_pacifica_sin   SET dtouvgar = ' ' WHERE dtouvgar is null
UPDATE sysadm.w_pacifica_sin   SET dtclogar = ' ' WHERE dtclogar is null
UPDATE sysadm.w_pacifica_sin   SET dtougar = ' ' WHERE dtougar is null
UPDATE sysadm.w_pacifica_sin   SET dtanngar = ' ' WHERE dtanngar is null
UPDATE sysadm.w_pacifica_sin   SET rpcorg = 0 WHERE rpcorg is null
UPDATE sysadm.w_pacifica_sin   SET rfcorg = 0 WHERE rfcorg is null
UPDATE sysadm.w_pacifica_sin   SET rhcorg = 0 WHERE rhcorg is null
UPDATE sysadm.w_pacifica_sin   SET rrcorg = 0 WHERE rrcorg is null
UPDATE sysadm.w_pacifica_sin   SET rcpexer = 0 WHERE rcpexer is null
UPDATE sysadm.w_pacifica_sin   SET rfcexer = 0 WHERE rfcexer is null
UPDATE sysadm.w_pacifica_sin   SET rhcexer = 0 WHERE rhcexer is null
UPDATE sysadm.w_pacifica_sin   SET rrcexer = 0 WHERE rrcexer is null
UPDATE sysadm.w_pacifica_sin   SET evr = 0     WHERE evr is null
UPDATE sysadm.w_pacifica_sin   SET evrr = 0   WHERE evrr is null

Go

grant execute on sysadm.PS_PACIFICA_SIN_LOT3 to rolebddsinistres
go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_PACIFICA_SIN_LOT4' AND type = 'P' )
        DROP procedure sysadm.[PS_PACIFICA_SIN_LOT4]
GO

CREATE procedure [sysadm].[PS_PACIFICA_SIN_LOT4]
@dteSup     Datetime 		-- Date fin de période mensuelle
AS

DECLARE   @sPeriode     char(6),
          @sSociete     char(3)

SET @sPeriode    = Convert ( Char(4), year (@dteSup) ) + RIGHT ( '00' + Convert (varchar(2), Month(@dteSup) ), 2) 

DELETE FROM sysadm.w_pacifica_sin -- Purge de la table temporaire

------------------------------------------------------------------------------------------------
-- SIMPA2 Liste des sinistres
------------------------------------------------------------------------------------------------
INSERT INTO sysadm.w_pacifica_sin
SELECT
2													as idappli,	-- code de l'application
s.id_prod										as idprod,	-- n° produit SPB
--données générales
'300'            								as cdenrg,  -- code enregistrement
'SPB'   			               		 	as cdgest,  -- Code du partenaire gestionnaire
'01'                       				as societe, -- Code de la société cliente
s.cddist					 						as cddist,  -- Code distributeur
Space(5)                  					as extdept, -- Référence du département
@sPeriode                 					as dtref,   -- date de référence
Space(1)		       							as cdrejet,	-- code rejet
--données client
Space(1)											as refclient,
Space(1)											as client,
Space(1)											as refentprf,
--données contrat
s.produit										as produit,	-- code du produit, référentiel pacifica

CASE
	when s.produit in ('PI','ON') and s.cod_opt is not null
	then convert(char(1),s.cod_opt)
	else '1'
end												as formule,	--code de la formule

Space(1)											as contrat,
Space(1)											as image,
s.gtie											as gtie,		-- code de la garantie contrat

CASE 
	when s.id_prod = 901 then 'PA'
	when s.id_prod = 904 then 'JE'
	when s.id_prod = 902 then 'PR'
	when s.id_prod = 905 then 'FA'
	when s.id_prod = 921 then '1'
	when s.id_prod = 931 then '1'
	when s.id_prod = 925 then '2'
	when s.id_prod = 935 then '2'
	when s.id_prod = 6700 then 'IND'
	when s.id_prod = 6705 then 'FAM'
	when s.id_prod = 13000 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	when s.id_prod = 13100 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	when s.id_prod = 18500 then	(case (select distinct lib_carte from SIMPA2_PRO.sysadm.carte c where s.id_type_carte=c.id_type_carte and s.id_adh between c.val_rg_mini and c.val_rg_max)
												when 'VISA CLASSIC' then 'CLA'
												when 'VISA CLASSIC CL' then 'CLA'
												when 'VISA PREMIER' then 'PREM'
												when 'VISA INFINITE' then 'INF'
												else Space(1)
											end)	
	-- salarié CA ( 2 : O / 1 : N)
	when s.id_prod like '358%' then	(case (select top 1 dosad_c_type from FUS_DOSAD_PRO.dbo.dosad d where dosad_code_prod = convert ( smallint,left(s.id_prod,len(s.id_prod)-2)) and dosad_ets = 1001 and dosad_no_doss = convert(integer
,s.id_adh))
													when 1 then 'N'
													when 2 then 'O'
													else 'N'		
												end)

	else Space(1)
END
						 							as criter1,	

CASE s.id_prod
	when 35800 then '1' --nb app de poche 
	when 80500 then '1' --nb app de poche 
	else Space(1)
END												as criter2,	

CASE s.id_prod
	when 35801 then '1' --nb app image et video
	when 80501 then '1' --nb app image et video
	else Space(1)
END												as criter3,

CASE s.id_prod
	when 35802 then '1' --nb ordinateur portable
	when 80502 then '1' --nb ordinateur portable
	else Space(1)
END												as criter4,	

CASE s.id_prod
	when 35803 then '1' --nb tel portable
	when 80503 then '1' --nb tel portable
	else Space(1)
END												as criter5,	
Space(1)											as criter6,	
Space(1)											as criter7,	
Space(1)											as criter8,	
Space(1)											as criter9,	
convert (varchar(8),s.id_sin)				as sin,

case when s.dte_surv is null
then convert( varchar(10), s.cree_le, 104)
else convert( varchar(10), s.dte_surv, 104) end
													as dtsurv,

'M'												as nature,

sysadm.FN_CODE_PACIFICA ( 2, 'SIN', s.cod_etat )
													as etatsin,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end		
													as dtouvsin,

case when s.cod_etat in (600,200,900) then convert(varchar(10),s.valide_le,104) else Space(10) end 				
													as dtclosin,

Space(10)										as dtrousin,
s.gtiesin										as gtiesin,

sysadm.FN_CODE_PACIFICA ( 2, 'GTI', s.cod_etat ) 	
													as etatgtie,

case when s.dte_ouv is null then Space(10) else convert( varchar(10), s.dte_ouv, 104) end		
													as dtouvgar,

case when s.codetat in (600,200,900) then convert (varchar(10),s.valide_le,104) else Space(10) end 	
													as dtclogar,

Space(10)		 								as dtougar,
Space(10)		 								as dtanngar,
sum(s.mt_reg)		 							as rpcorg,
0 													as rfcorg,
0													as rhcorg,
0 													as rrcorg,
sum(case when s.dte_reg>=convert(datetime,'01/01/'+convert(char(4),datepart(year,@dteSup))) then s.mt_reg else 0 end)
 													as rcpexer,

0 													as rfcexer,
0 													as rhcexer,
0 													as rrcexer,
sum(s.mt_reg)									as evr,
0 													as evrr,
Space(1) 										as filler 

FROM SIMPA2_PRO.sysadm.v_pacifica_sin s

WHERE s.dte_reg <= @dteSup and s.id_prod in (80500,80501,80502,80503)
       

GROUP BY  s.produit, s.cddist, s.id_sin,s.gtie, s.gtiesin,sysadm.FN_CODE_PACIFICA (2, 'SIN', s.cod_etat ),
          sysadm.FN_CODE_PACIFICA (2, 'GTI', s.codetat ),s.id_prod,s.cree_le, s.dte_surv, s.dte_ouv,
          s.valide_le, s.dte_ouv, s.valide_le, s.cod_etat, s.codetat, s.cod_opt, s.id_type_carte, s.id_adh



/*----------------------------------------------*/
/* Remise à Zéro et à blancs des valeurs        */
/*----------------------------------------------*/

UPDATE sysadm.w_pacifica_sin   SET dtsurv = ' '  WHERE dtsurv is null
UPDATE sysadm.w_pacifica_sin   SET dtouvsin = ' '   WHERE dtouvsin is null
UPDATE sysadm.w_pacifica_sin   SET dtclosin = ' '  WHERE dtclosin is null
UPDATE sysadm.w_pacifica_sin   SET dtrousin = ' '  WHERE dtrousin is null
UPDATE sysadm.w_pacifica_sin   SET dtouvgar = ' ' WHERE dtouvgar is null
UPDATE sysadm.w_pacifica_sin   SET dtclogar = ' ' WHERE dtclogar is null
UPDATE sysadm.w_pacifica_sin   SET dtougar = ' ' WHERE dtougar is null
UPDATE sysadm.w_pacifica_sin   SET dtanngar = ' ' WHERE dtanngar is null
UPDATE sysadm.w_pacifica_sin   SET rpcorg = 0 WHERE rpcorg is null
UPDATE sysadm.w_pacifica_sin   SET rfcorg = 0 WHERE rfcorg is null
UPDATE sysadm.w_pacifica_sin   SET rhcorg = 0 WHERE rhcorg is null
UPDATE sysadm.w_pacifica_sin   SET rrcorg = 0 WHERE rrcorg is null
UPDATE sysadm.w_pacifica_sin   SET rcpexer = 0 WHERE rcpexer is null
UPDATE sysadm.w_pacifica_sin   SET rfcexer = 0 WHERE rfcexer is null
UPDATE sysadm.w_pacifica_sin   SET rhcexer = 0 WHERE rhcexer is null
UPDATE sysadm.w_pacifica_sin   SET rrcexer = 0 WHERE rrcexer is null
UPDATE sysadm.w_pacifica_sin   SET evr = 0     WHERE evr is null
UPDATE sysadm.w_pacifica_sin   SET evrr = 0   WHERE evrr is null
Go

grant execute on sysadm.PS_PACIFICA_SIN_LOT4 to rolebddsinistres
go