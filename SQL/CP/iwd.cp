------------------------------------------------------------------------
-- Début [PM217-2] IWD - FS - 02/10/2013 : Objets nécessaires pour ce PM
--   
-- le 06/02/2014 constitution de ce fichier / retrait du script quotidien Simpa2_Trt
--
-- Table w_queue      Ajout de colonnes spécifiques pour iwd
-- Table update_iwd   Table des actions à faire par iwd
-- Vue   v_iwd_queue  Vue pour iwd
-- Trigger Iwd_Tr_Queue_Update  - Trigger Maj w_queue.cod_etat de 1 à 5
-- Trigger Iwd_Tr_Queue_Delete  - Suppression d'une ligne dans w_queue
-- Trigger Iwd_Tr_Queue_Insert  - Insertion d'une ligne dans w_queue
-- Procédure Iwd_Queue_Recycler_Etat       - [VDOC19886] : Recyclage quotidien des workflows restés en canal 'T'
-- Procédure Iwd_Queue_Charger_Vue         - Chargement de la vue
-- Procédure Iwd_Queue_Modifier_Etat       - Modification de etat_iwd et id_iwd sur w_queue
-- Procédure Iwd_Update_Iwd_Niveau_Dbval   - Maj du niveau requis pour la double validation
-- Procédure Iwd_Update_Iwd_Router_Dossier - Routage d'un dossier
-- Procédure Iwd_Update_Iwd_Supprimer      - suppression de update_iwd
------------------------------------------------------------------------

	-- [PM217-2] IWD : Modification de la table w_queue
			
	--	Alter table sysadm.w_queue add etat_iwd integer null, id_iwd varchar(50) null, responsable_iwd integer null , routage_iwd varchar(4) null
	--	Go

	-- [PM217-2] IWD : Vue v_iwd_queue

	IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[sysadm].[v_iwd_queue]'))
	DROP VIEW [sysadm].v_iwd_queue
	GO

  
	 CREATE view [sysadm].[v_iwd_queue]  -- Vue v_iwd_queue  
	 as  
       Select   
           rtrim (q.id_sin) as ExternalId,   
           rtrim (q.id_sin) as claimNumber  ,  
           rtrim (q.id_corb)as IWD_ext_productSubtype, -- FS le 21/09/16 ; Attente Go de OLP pour remplacer par id_prod  
           rtrim (q.id_corb) as IWD_category,     -- OLP Vu avec FS le 21/09/16, remplacement de id_prod par id_corb  
           rtrim (q.nom)as LastName,  
           cast (q.cod_etat as int) as cod_etat,  
           rtrim (q.alt_occupe)as alt_occupe,  
           q.trv_cree_le,  
           rtrim (q.cod_recu)as IWD_channel,  
           q.etat_iwd,  
           q.id_iwd,  
           q.id_contact,  
           rtrim (q.dos_maj_par) as dos_maj_par,  
           rtrim (q.dos_maj_par) as IWD_ext_sourceProcessType,  
           cast (q.cod_etat as int) as IWD_businessValue,  
           q.dos_maj_le  as IWD_ext_sourceCreatedDateTime,  
           dp.id_code_num  as departement,  
           sysadm.FN_CODE_NUM ( dp.id_code_num, '-UO' ) as lib_departement,  
           CASE  
          WHEN upper(txt_mess1) like '%DEMANDE SC24 EST%' THEN 1   
          Else 0  
          END as flagSC24,  
          rtrim(q.routage_iwd) as routage_iwd  
                  FROM   sysadm.w_queue q  
            inner join sysadm.det_pro dp on dp.id_prod = q.id_prod and dp.id_code_dp = 99 and dp.id_typ_code_dp = '-DP'   
            where etat_iwd is not NULL  
	GO

	grant select, insert, delete, update on sysadm.v_iwd_queue to rolebddsinistres
	go

	-- [PM217-2] IWD : table update_iwd

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[update_iwd]') AND type in (N'U'))
	DROP TABLE [sysadm].update_iwd
	GO

	CREATE TABLE [sysadm].update_iwd -- [PM217-2] IWD : create table update_iwd
	(
		[id_sin]           int not null,
		[cod_etat]         int not null,
		[alt_occupe]       char(1) not null default 'N',
		[flag_update_iwd]  int null,
		[id_iwd]           varchar(50) null,
		[queue]            varchar(50) null ,
		[niveau_dbval_iwd] integer null, 
		[routage_iwd]      varchar(4) null,
		[maj_le]           datetime not null,
		[txt_mess_iwd]     varchar(254)
		
		CONSTRAINT [pk_update_iwd] PRIMARY KEY CLUSTERED ( [id_sin] ASC )
	 )

	Go

	grant select, insert, delete, update on sysadm.update_iwd to rolebddsinistres
	Go
	
	-- [PM217-2] IWD : Les triggers
	
	IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Tr_Queue_Update]'))
	DROP TRIGGER [sysadm].Iwd_Tr_Queue_Update
	GO

	-- [PM217-2] A.PAPILLON le 18/02/2014 : Modification de la procédure
	-- [VDOC20283] FS le 01/04/2016 : Gestion du passage état 5 à 1
	-- JFF      12/02/2016   [PI062]
					
	CREATE TRIGGER [sysadm].[Iwd_Tr_Queue_Update] -- [PM217-2] IWD : Iwd_Tr_Queue_Update trigger update w_queue : Maj cod_etat 1 à 5 + alt_occupe
	ON [sysadm].[w_queue]
	FOR UPDATE
	AS
	--------------------------------------------------------------------
	-- FS le 10/10/2013 : [PM217-2] IWD : w_queue trigger update : Maj cod_etat et alt_occupe
	-- JFF      12/02/2016   [PI062]
	-- JFF Le 28/11/2023 : [RS6179] Trace des données w_queue
	--------------------------------------------------------------------
		If sysadm.FN_CLE_NUMERIQUE ( 'RS6179_TRG_WQ') > 0 
		 Begin

			-- [RS6179] JFF 28/11/2023
			INSERT INTO [sysadm].[w_queue_histo]
			   ([action]
			   ,[cree_le_action]
			   ,[id_sin]
			   ,[id_corb]
			   ,[id_prod]
			   ,[nom]
			   ,[cod_etat]
			   ,[cod_action]
			   ,[alt_occupe]
			   ,[alt_bloc]
			   ,[trv_cree_le]
			   ,[trv_maj_le]
			   ,[trv_maj_par]
			   ,[trv_route_le]
			   ,[trv_route_par]
			   ,[trv_edite_le]
			   ,[trv_edite_par]
			   ,[txt_mess1]
			   ,[txt_mess2]
			   ,[dos_maj_le]
			   ,[dos_maj_par]
			   ,[cod_recu]
			   ,[cod_i_prov]
			   ,[dte_recu]
			   ,[cod_typ_recu]
			   ,[dte_cour_cli]
			   ,[id_contact]
			   ,[etat_iwd]
			   ,[id_iwd]
			   ,[responsable_iwd]
			   ,[routage_iwd])

				SELECT 
					  'U'
					  ,GETDATE()
					  ,i.[id_sin]
					  ,i.[id_corb]
					  ,i.[id_prod]
					  ,i.[nom]
					  ,i.[cod_etat]
					  ,i.[cod_action]
					  ,i.[alt_occupe]
					  ,i.[alt_bloc]
					  ,i.[trv_cree_le]
					  ,i.[trv_maj_le]
					  ,i.[trv_maj_par]
					  ,i.[trv_route_le]
					  ,i.[trv_route_par]
					  ,i.[trv_edite_le]
					  ,i.[trv_edite_par]
					  ,i.[txt_mess1]
					  ,i.[txt_mess2]
					  ,i.[dos_maj_le]
					  ,i.[dos_maj_par]
					  ,i.[cod_recu]
					  ,i.[cod_i_prov]
					  ,i.[dte_recu]
					  ,i.[cod_typ_recu]
					  ,i.[dte_cour_cli]
					  ,i.[id_contact]
					  ,i.[etat_iwd]
					  ,i.[id_iwd]
					  ,i.[responsable_iwd]
					  ,i.[routage_iwd]
  
				FROM deleted d, inserted i
				Where i.id_sin = d.id_sin
		 End 

	IF UPDATE(cod_etat) -- Maj w_queue.cod_etat de 1 à 5
		BEGIN

			UPDATE sysadm.update_iwd
			SET    cod_etat = '5'
				 , alt_occupe = i.alt_occupe
				 , flag_update_iwd = 1
				 , id_iwd = i.id_iwd
				 , queue = 'iWD_Completed'
				 , routage_iwd = NULL
			FROM   inserted i
				 , deleted d
			WHERE
				-- convert( varchar(10),sysadm.update_iwd.id_sin) = i.id_sin And -- [PI062] modifié 20170612
				   sysadm.update_iwd.id_sin = CAST(i.id_sin AS INT)
				   AND -- [PI062]

				i.id_sin = d.id_sin
				   AND i.id_iwd IS NOT NULL
				   AND i.etat_iwd = 2
				   AND i.alt_occupe = 'N'
				   AND i.cod_etat = '5'
				   AND -- Nouvel état = 5
				d.cod_etat = '1'; -- Ancien état = 1

			INSERT INTO [sysadm].[update_iwd] (   [id_sin]
												, [cod_etat]
												, [alt_occupe]
												, [flag_update_iwd]
												, [id_iwd]
												, [queue]
												, [routage_iwd]
												, [maj_le]
											  )
						SELECT i.id_sin
							 , 5               -- cod_etat
							 , i.alt_occupe    -- alt_occupe
							 , 1               -- flag update iwd
							 , i.id_iwd        -- id_iwd de w_queue
							 , 'iWD_Completed' -- queue
							 , NULL            -- routage_iwd
							 , GETDATE()
						FROM   inserted i
							 , deleted d
						WHERE  i.id_sin = d.id_sin
							   AND i.id_iwd IS NOT NULL
							   AND i.etat_iwd = 2
							   AND i.alt_occupe = 'N'
							   AND i.cod_etat = '5'
							   AND d.cod_etat = '1'
							   AND NOT EXISTS (   SELECT *
												  FROM   sysadm.update_iwd v
												  WHERE  v.id_sin = CAST(i.id_sin AS INT)
											  ); -- [PI062]

		END;

	IF UPDATE(alt_occupe) -- Report du alt_occupe sur update_iwd si passe de O à N
		BEGIN

			UPDATE sysadm.update_iwd
			SET    alt_occupe = i.alt_occupe
				 , maj_le = GETDATE()
			FROM   inserted i
				 , deleted d
			WHERE
				-- convert( varchar(10),sysadm.update_iwd.id_sin ) = i.id_sin and -- [PI062]
				   sysadm.update_iwd.id_sin = CAST(i.id_sin AS INT)
				   AND -- [PI062]
				i.id_sin = d.id_sin
				   AND i.id_iwd IS NOT NULL
				   AND i.etat_iwd = 2
				   AND (   (   i.alt_occupe = 'N'
							   AND d.alt_occupe = 'O'
						   )
						   OR (   i.alt_occupe = 'O'
								  AND d.alt_occupe = 'N'
							  )
					   );

		END;

	IF UPDATE(alt_bloc) -- Maj w_queue.alt_bloc de 'N' à 'O' ou de 'O' à 'N'
		BEGIN

			-- La ligne dans update_iwd existe : maj

			UPDATE sysadm.update_iwd
			SET    [flag_update_iwd] = 1
				 , [routage_iwd] = 'COR#'
				 , [queue] = 'iWD_Captured'
				 , [maj_le] = GETDATE()
			FROM   inserted i
				 , deleted d
			WHERE
				--				convert( varchar(10),sysadm.update_iwd.id_sin ) = i.id_sin and -- [PI062]
				   sysadm.update_iwd.id_sin = CAST(i.id_sin AS INT)
				   AND -- [PI062]
				i.id_sin = d.id_sin
				   AND i.id_iwd IS NOT NULL
				   AND i.etat_iwd = 2
				   AND i.alt_bloc = 'O'
				   AND -- Nouvelle valeur = 'O'
				d.alt_bloc = 'N'; -- Ancienne valeur = 'N'

			-- La ligne dans update_idw n'existe pas : insert

			INSERT INTO [sysadm].[update_iwd] (   [id_sin]
												, [cod_etat]
												, [alt_occupe]
												, [flag_update_iwd]
												, [id_iwd]
												, [queue]
												, [routage_iwd]
												, [maj_le]
											  )
						SELECT i.id_sin
							 , i.cod_etat     -- cod_etat
							 , i.alt_occupe   -- alt_occupe
							 , 1              -- flag update iwd
							 , i.id_iwd       -- id_iwd de w_queue
							 , 'iWD_Captured' -- queue
							 , 'COR#'         -- routage_iwd
							 , GETDATE()
						FROM   inserted i
							 , deleted d
						WHERE  i.id_sin = d.id_sin
							   AND i.id_iwd IS NOT NULL
							   AND i.etat_iwd = 2
							   AND i.alt_bloc = 'O'
							   AND d.alt_bloc = 'N'
							   AND
							--				  not exists ( select * from sysadm.update_iwd v Where convert( varchar(10),v.id_sin) = i.id_sin ) -- [PI062]
							NOT EXISTS (   SELECT *
										   FROM   sysadm.update_iwd v
										   WHERE  v.id_sin = CAST(i.id_sin AS INT)
									   ); -- [PI062]

		END;

	IF UPDATE(trv_maj_le) -- Maj w_queue.alt_bloc de 'O' à 'O' resté bloqué + trv_maj_le modifiée
		BEGIN

			-- Resté bloqué : La ligne dans update_iwd existe : maj

			UPDATE sysadm.update_iwd
			SET    [flag_update_iwd] = 1
				 , [routage_iwd] = 'COR#'
				 , [queue] = 'iWD_Captured'
				 , [maj_le] = GETDATE()
			FROM   inserted i
				 , deleted d
			WHERE
				--			convert( varchar(10),sysadm.update_iwd.id_sin) = i.id_sin And -- [PI062]
				   sysadm.update_iwd.id_sin = CAST(i.id_sin AS INT)
				   AND -- [PI062]
				i.id_sin = d.id_sin
				   AND i.id_iwd IS NOT NULL
				   AND i.etat_iwd = 2
				   AND i.alt_bloc = 'O'
				   AND -- Nouvelle valeur = 'O'
				d.alt_bloc = 'O'
				   AND -- Ancienne valeur = 'O'
				i.trv_maj_le <> d.trv_maj_le; -- Date modifiée

			-- Resté bloqué : La ligne dans update_idw n'existe pas : insert

			INSERT INTO [sysadm].[update_iwd] (   [id_sin]
												, [cod_etat]
												, [alt_occupe]
												, [flag_update_iwd]
												, [id_iwd]
												, [queue]
												, [routage_iwd]
												, [maj_le]
											  )
						SELECT i.id_sin
							 , i.cod_etat     -- cod_etat
							 , i.alt_occupe   -- alt_occupe
							 , 1              -- flag update iwd
							 , i.id_iwd       -- id_iwd de w_queue
							 , 'iWD_Captured' -- queue
							 , 'COR#'         -- routage_iwd
							 , GETDATE()
						FROM   inserted i
							 , deleted d
						WHERE  i.id_sin = d.id_sin
							   AND i.id_iwd IS NOT NULL
							   AND i.etat_iwd = 2
							   AND i.alt_bloc = 'O'
							   AND -- Nouvelle valeur = 'O'
							d.alt_bloc = 'O'
							   AND -- Ancienne valeur = 'O'
							i.trv_maj_le <> d.trv_maj_le
							   AND -- Date modifiée
							--				  not exists ( select * from sysadm.update_iwd v Where convert( varchar(10),v.id_sin) = i.id_sin ) -- [PI062]
							NOT EXISTS (   SELECT *
										   FROM   sysadm.update_iwd v
										   WHERE  v.id_sin = CAST(i.id_sin AS INT)
									   ); -- [PI062]

		END;


	go


	IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Tr_Queue_Delete]'))
	DROP TRIGGER [sysadm].Iwd_Tr_Queue_Delete
	GO

	CREATE TRIGGER [sysadm].[Iwd_Tr_Queue_Delete]  -- [PM217-2] IWD : trigger Iwd_Tr_Queue_Delete delete sur w_queue
				ON [sysadm].[w_queue]
		FOR delete
		As
		--------------------------------------------------------------------
		-- FS le 10/10/2013 [PM217-2] IWD : w_queue trigger delete
		-- JFF      12/02/2016   [PI062]
		-- JFF Le 28/11/2023 : [RS6179] Trace des données w_queue
		--------------------------------------------------------------------
		If sysadm.FN_CLE_NUMERIQUE ( 'RS6179_TRG_WQ') > 0 
		 Begin
			INSERT INTO [sysadm].[w_queue_histo]
			   ([action]
			   ,[cree_le_action]
			   ,[id_sin]
			   ,[id_corb]
			   ,[id_prod]
			   ,[nom]
			   ,[cod_etat]
			   ,[cod_action]
			   ,[alt_occupe]
			   ,[alt_bloc]
			   ,[trv_cree_le]
			   ,[trv_maj_le]
			   ,[trv_maj_par]
			   ,[trv_route_le]
			   ,[trv_route_par]
			   ,[trv_edite_le]
			   ,[trv_edite_par]
			   ,[txt_mess1]
			   ,[txt_mess2]
			   ,[dos_maj_le]
			   ,[dos_maj_par]
			   ,[cod_recu]
			   ,[cod_i_prov]
			   ,[dte_recu]
			   ,[cod_typ_recu]
			   ,[dte_cour_cli]
			   ,[id_contact]
			   ,[etat_iwd]
			   ,[id_iwd]
			   ,[responsable_iwd]
			   ,[routage_iwd])

				SELECT 
					  'D'
					  ,GETDATE()
					  ,[id_sin]
					  ,[id_corb]
					  ,[id_prod]
					  ,[nom]
					  ,[cod_etat]
					  ,[cod_action]
					  ,[alt_occupe]
					  ,[alt_bloc]
					  ,[trv_cree_le]
					  ,[trv_maj_le]
					  ,[trv_maj_par]
					  ,[trv_route_le]
					  ,[trv_route_par]
					  ,[trv_edite_le]
					  ,[trv_edite_par]
					  ,[txt_mess1]
					  ,[txt_mess2]
					  ,[dos_maj_le]
					  ,[dos_maj_par]
					  ,[cod_recu]
					  ,[cod_i_prov]
					  ,[dte_recu]
					  ,[cod_typ_recu]
					  ,[dte_cour_cli]
					  ,[id_contact]
					  ,[etat_iwd]
					  ,[id_iwd]
					  ,[responsable_iwd]
					  ,[routage_iwd]
  
				FROM deleted d	
		 End 
		
		Begin -- Maj de la ligne sur update_iwd

		-- [RS6179] JFF 28/11/2023

			update sysadm.update_iwd set
			 	 [cod_etat]        = d.cod_etat  , -- Report état de w_queue
				 [alt_occupe]      = 'N', 
				 [flag_update_iwd] = 1  ,
				 [id_iwd]          = d.id_iwd, -- Report id_iwd de w_queue
				 [queue]           = 'iWD_Completed',
				 [maj_le]          = GETDATE()
			from deleted d
			where cast ( update_iwd.id_sin as CHAR(10) ) = d.id_sin -- [PI062]
			      And d.id_iwd   is not null 
			
			INSERT INTO [sysadm].[update_iwd]
				([id_sin]
				,[cod_etat]
				,[alt_occupe]
				,[flag_update_iwd]
				,[id_iwd]
				,[queue]
				,[routage_iwd]
				,[maj_le])
			Select
				 d.id_sin,
				 d.cod_etat     , -- cod_etat
				 'N'			, -- alt_occupe
				 1              , -- flag update iwd
				 d.id_iwd       , -- id_iwd de w_queue
				 'iWD_Completed', -- queue
				 null          , -- routage_iwd
				 GETDATE()
			From 
				deleted d
			Where 
				not exists ( select * from sysadm.update_iwd v Where convert( varchar(10),v.id_sin) = d.id_sin ) -- [PI062]
				And d.id_iwd   is not null  	 

		End -- / fin maj
GO	
	
	
	IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Tr_Queue_Insert]'))
	DROP TRIGGER [sysadm].Iwd_Tr_Queue_Insert
	GO
  
	CREATE TRIGGER [sysadm].[Iwd_Tr_Queue_Insert]  -- [PM217-2] IWD : Iwd_Tr_Queue_Update trigger update w_queue : Maj cod_etat 1 à 5 + alt_occupe
			ON [sysadm].[w_queue]
	FOR insert
	As
	--------------------------------------------------------------------
	-- FS  le 10/10/2013 : [PM217-2] IWD : w_queue trigger insert : Maj cod_etat et etat_iwd
	-- FS  le 07/11/2023 [Pmo70] Correctif prendre les corbeilles de famille 217 et 2172
	-- JFF Le 28/11/2023 : [RS6179] Trace des données w_queue
	--------------------------------------------------------------------
		-- [RS6179] JFF 28/11/2023
		-- [RS6179_TRG_WQ]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS6179_TRG_WQ') > 0 
		 Begin
			INSERT INTO [sysadm].[w_queue_histo]
			   ([action]
			   ,[cree_le_action]
			   ,[id_sin]
			   ,[id_corb]
			   ,[id_prod]
			   ,[nom]
			   ,[cod_etat]
			   ,[cod_action]
			   ,[alt_occupe]
			   ,[alt_bloc]
			   ,[trv_cree_le]
			   ,[trv_maj_le]
			   ,[trv_maj_par]
			   ,[trv_route_le]
			   ,[trv_route_par]
			   ,[trv_edite_le]
			   ,[trv_edite_par]
			   ,[txt_mess1]
			   ,[txt_mess2]
			   ,[dos_maj_le]
			   ,[dos_maj_par]
			   ,[cod_recu]
			   ,[cod_i_prov]
			   ,[dte_recu]
			   ,[cod_typ_recu]
			   ,[dte_cour_cli]
			   ,[id_contact]
			   ,[etat_iwd]
			   ,[id_iwd]
			   ,[responsable_iwd]
			   ,[routage_iwd])

				SELECT 
					  'I'
					  ,GETDATE()
					  ,[id_sin]
					  ,[id_corb]
					  ,[id_prod]
					  ,[nom]
					  ,[cod_etat]
					  ,[cod_action]
					  ,[alt_occupe]
					  ,[alt_bloc]
					  ,[trv_cree_le]
					  ,[trv_maj_le]
					  ,[trv_maj_par]
					  ,[trv_route_le]
					  ,[trv_route_par]
					  ,[trv_edite_le]
					  ,[trv_edite_par]
					  ,[txt_mess1]
					  ,[txt_mess2]
					  ,[dos_maj_le]
					  ,[dos_maj_par]
					  ,[cod_recu]
					  ,[cod_i_prov]
					  ,[dte_recu]
					  ,[cod_typ_recu]
					  ,[dte_cour_cli]
					  ,[id_contact]
					  ,[etat_iwd]
					  ,[id_iwd]
					  ,[responsable_iwd]
					  ,[routage_iwd]
  
				FROM inserted i
		 End 

	Begin 
	
		update sysadm.w_queue set etat_iwd = 1 
		from
		inserted i inner join sysadm.famille f on ( f.id_fam = 217 or f.id_fam=2172 )  and f.id_typ_code = '-CO' and f.id_code = i.id_corb
		Where
		  i.id_sin = sysadm.w_queue.id_sin 
		  and sysadm.w_queue.dos_maj_par not in ( 'ML', 'IMGA', 'EADR' )
		  and sysadm.w_queue.cod_recu <> 'T'

	  
	End

	go	
	-- [PM217-2] IWD : Les procédures 

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Queue_Charger_Vue]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Queue_Charger_Vue]
	GO

	CREATE procedure [sysadm].[Iwd_Queue_Charger_Vue] --PM217-2 : Procédure [Iwd_Queue_Charger_Vue]
		
	AS
  --------------------------------------------------------------------                  
  -- FS le 10/10/2013 : PM217-2 : Procédure Iwd_Queue_Charger_Vue chargement d'un élément
  --------------------------------------------------------------------
      SELECT TOP (50)
            ExternalId,
            claimNumber  ,
            IWD_ext_productSubtype,
            IWD_category, 
            LastName,
            cod_etat,
            alt_occupe, 
            [trv_cree_le],
            dos_maj_par,
            IWD_ext_sourceProcessType,
            IWD_channel,
            [etat_iwd],
            [id_iwd],
            'SIMPA2' as CRM,
            IWD_ext_sourceCreatedDateTime,
            claimNumber  ,
            departement,
            flagSC24,
            IWD_businessValue
            
        FROM 
            [sysadm].[v_iwd_queue] 
        where etat_iwd = '1'

	Go
	
	grant execute on sysadm.[Iwd_Queue_Charger_Vue] to rolebddsinistres
	go

	-- JFF      12/02/2016   [PI062]
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Queue_Modifier_Etat]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Queue_Modifier_Etat]
	GO
	
	CREATE procedure [sysadm].[Iwd_Queue_Modifier_Etat] --PM217-2 : Procédure Iwd_Queue_Modifier_Etat
	    @iIdSin    integer,          -- Identifiant du sinistre
		@iEtat_iwd integer    = null,-- Nouveau code état / Null si pas d'update requis
		@sId_iwd   varchar(50)= null -- Nouveau id iwd / Null si pas d'update requis
	AS
		--------------------------------------------------------------------		      
		-- FS le 10/10/2013  : PM217-2 : Procédure Iwd_Queue_Modifier_Etat
		--------------------------------------------------------------------

	  Declare @sIdSin VarChar ( 10 ) -- [PI062]

	  Set @sIdSin = Convert ( VarChar ( 10 ), @iIdSin ) -- [PI062]

	  Update sysadm.w_queue set etat_iwd = @iEtat_iwd Where id_sin = @sIdSin And @iEtat_iwd is not null  -- [PI062]
	  
	  Update sysadm.w_queue set id_iwd = @sId_iwd Where id_sin = @sIdSin And @sId_iwd is not null  -- [PI062]
	  
	Go
	
	grant execute on sysadm.Iwd_Queue_Modifier_Etat to rolebddsinistres
	Go

	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Queue_Recycler_Etat]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Queue_Recycler_Etat]
	GO

	CREATE procedure [sysadm].[Iwd_Queue_Recycler_Etat]
	AS
	------------------------------------------------------------------------------------------		      
	-- FS le 10/02/2016  : -- Procédure Iwd_Queue_Recycler_Etat       - [VDOC19886] : Recyclage quotidien des workflows restés en canal 'T'
	------------------------------------------------------------------------------------------

		Update 
			sysadm.w_queue 
		set 
			etat_iwd = 1
		where
			 sysadm.w_queue.cod_etat = 1 
		 And sysadm.w_queue.cod_recu = 'T' 
		 And sysadm.w_queue.dos_maj_par not in ( 'ML', 'IMGA', 'EADR' ) 
		 And sysadm.w_queue.alt_bloc = 'N'
		 And sysadm.w_queue.etat_iwd is null
		 And sysadm.w_queue.trv_cree_le <= Dateadd( hour, -24, getdate() )

		 Select 'Iwd_Queue_Recycler_Etat','Examen des travaux en canal "T" avant le ',  Dateadd( hour, -24, getdate() ), Convert ( varchar(15),@@ROWCOUNT ) + ' ligne(s)'

	 Go


	grant execute on sysadm.Iwd_Queue_Recycler_Etat to rolebddsinistres
	Go

	-- JFF      12/02/2016   [PI062]
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Update_Iwd_Niveau_Dbval]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Niveau_Dbval]
	GO
	
	CREATE procedure [sysadm].[Iwd_Update_Iwd_Niveau_Dbval] --PM217-2 : Procédure Iwd_Queue_Modifier_Responsable
	    @iIdSin    integer,           -- Identifiant du sinistre 
		@iNiveau_dbval integer=null -- Code du niveau requis pour double validation
		
	AS
		-------------------------------------------------------------------------		      
		-- FS le 20/11/2013  : PM217-2 : Procédure Iwd_Queue_Modifier_Responsable
		-- (Attention nom de paramétres déclarés dans n_cst_se_double_val::uf_maj_responsable_iwd)
		-------------------------------------------------------------------------
		
		Declare @sTxtMess varchar(508)
		Declare @sTxtPart1 varchar(254)
		Declare @sTxtPart2 varchar(254)
		Declare @sTxtdbval varchar(60)

		Declare @sIdSin VarChar ( 10 ) -- [PI062]

		Set @sIdSin = Convert ( VarChar ( 10 ), @iIdSin ) -- [PI062]
				
		Set @sTxtdbval = 'Double validation requise niveau ' + CONVERT ( varchar(10), @iNiveau_dbval )
		
			update sysadm.update_iwd set
			 	 [queue]            = 'iWD_Captured',
				 [niveau_dbval_iwd] = @iNiveau_dbval,
				 [maj_le]           = GETDATE(),
				 [txt_mess_iwd]     = @sTxtdbval
			Where id_sin = @iIdSin	
			
		-- Mise à jour sur w_queue avec @sTxtdbval		
					
			Select @sTxtMess = isnull(rtrim(txt_mess1),'') +
				   isnull(rtrim(txt_mess2),'') +
				   @sTxtdbval
			From sysadm.w_queue where id_sin = @sIdSin -- [PI062]
	 
			 Set @sTxtPart1 = nullif ( LEFT ( @sTxtMess, 254), '' )
			 Set @sTxtPart2 = nullif (SUBSTRING(@sTxtMess, 255, LEN(@sTxtMess) ), '')

			 update sysadm.w_queue set txt_mess1 = @sTxtPart1, txt_mess2 = @sTxtPart2 where id_sin = @sIdSin -- [PI062]	 
			
	Go
	
	grant execute on sysadm.Iwd_Update_Iwd_Niveau_Dbval to rolebddsinistres
	Go

-- JFF      12/02/2016   [PI062]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Update_Iwd_Router_Dossier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Router_Dossier]
GO
	
CREATE procedure [sysadm].[Iwd_Update_Iwd_Router_Dossier] --PM217-2 : Procédure Iwd_Queue_Modifier_Etat
    @sIdSin   varchar(10),  -- Identifiant du sinistre  -- [PI062]
	@sIdCorb  varchar(3),  -- Numéro de la corbeille
	@sOper    varchar(4),  -- Routé vers @sOper trigramme / RSP responsable / DRE département réclamation
	@sMess    varchar(508) -- Message de routage
AS
        --------------------------------------------------------------------              
        -- FS le 26/12/2013  : PM217-2 : Iwd_Update_Iwd_Router_Dossier
        --------------------------------------------------------------------
        -- [VDOC17582] FS le 29/06/2015 Si opérateur DR alors liste + DRSO ( support aux opérations )
        --------------------------------------------------------------------
        
        Declare @sTxtMess varchar(508)
        Declare @sTxtPart1 varchar(254)
        Declare @sTxtPart2 varchar(254)
        Declare @sTxtRoutage varchar(254)
        
        Set @sTxtRoutage = Left('-IWD travail routé à ' + @sOper + ' ' + @sMess,254)
  
        -- Cas 1 : Routé DRE,RSP + La ligne existe dans update_iwd
              
        update sysadm.update_iwd set
                    [queue]       = 'iWD_Captured',
                    [routage_iwd] = @sOper,
                    [maj_le]      = GETDATE(),
                    [alt_occupe]  = 'N',
                    [txt_mess_iwd] =       @sTxtRoutage                 
              Where id_sin       = CONVERT(integer, @sIdSin ) And  @sOper in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' )
              
              
        -- Cas 2 : Routé DRE,RSP + La ligne n'existe pas dans update_iwd
        
        INSERT INTO [sysadm].[update_iwd]
                    ([id_sin]
                    ,[cod_etat]
                    ,[alt_occupe]
                    ,[flag_update_iwd]
                    ,[id_iwd]
                    ,[queue]
                    ,[routage_iwd]
                    ,[maj_le]
                    ,[txt_mess_iwd]
                    )
              Select
                    q.id_sin       , -- id_sin  
                     q.cod_etat     , -- cod_etat
                    'N',               -- alt_occupe
                    1              , -- flag update iwd
                    q.id_iwd       , -- id_iwd de w_queue
                    'iWD_Captured', -- queue
                    @sOper          , -- routage_iwd
                    GETDATE(), 
                     @sTxtRoutage
              From 
                    sysadm.w_queue q
              Where q.id_sin   = @sIdSin And
                      q.id_iwd   is not null And
                      q.etat_iwd = 2         And
                      @sOper in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' ) And
                      not exists ( select * from sysadm.update_iwd v Where v.id_sin = q.id_sin )
                      
  -- Cas 3 : Routé à soi même = cloture de l'action = delete
  
  Delete from sysadm.update_iwd Where id_sin = CONVERT(integer, @sIdSin ) and @sOper not in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' )
  
        
        -- Mise à jour sur w_queue avec @sTxtRoutage         
                          
              Select @sTxtMess = isnull(rtrim(txt_mess1),'') +
                       isnull(rtrim(txt_mess2),'') +
                       @sTxtRoutage
              From sysadm.w_queue where id_sin = @sIdSin
  
              Set @sTxtPart1 = nullif ( LEFT ( @sTxtMess, 254), '' )
              Set @sTxtPart2 = nullif (SUBSTRING(@sTxtMess, 255, LEN(@sTxtMess) ), '')

              update sysadm.w_queue set txt_mess1 = @sTxtPart1, txt_mess2 = @sTxtPart2 where id_sin = @sIdSin  

GO

grant execute on sysadm.Iwd_Update_Iwd_Router_Dossier to rolebddsinistres
Go
	
-- [PM217-2] A.PAPILLON le 18/02/2014 : Modification de la procédure      
-- JFF      12/02/2016   [PI062]
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Update_Iwd_Supprimer]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Supprimer]
	GO

	CREATE procedure [sysadm].[Iwd_Update_Iwd_Supprimer] --PM217-2 : Procédure Iwd_Update_Iwd_Supprimer
          @sIdIwd    varchar(50)          -- Identifiant iwd du sinistre à supprimer
            
      AS

            Set nocount on
            
            -- Réinitialisation des flags sur w_queue
            
      if exists (select *
            From sysadm.update_iwd u , sysadm.w_queue 
            Where cast( u.id_sin as CHAR(10) )= w_queue.id_sin And  -- [PI062]
                  u.id_iwd = @sIdIwd 
                  and u.queue = 'iWD_Completed')   
                  
                  Begin
                        
                        update sysadm.w_queue
                          Set 
                               id_iwd = null,
                               etat_iwd = 1
                        From sysadm.update_iwd u
                        Where
                         CAST(u.id_sin AS CHAR(10)) = sysadm.w_queue.id_sin And  -- [PI062]
                         u.queue  = 'iWD_Completed' And
						 u.id_iwd = @sIdIwd
						 
				
                  End
                  
                  Delete from sysadm.update_iwd where id_iwd = @sIdIwd
      
					-- Suppression de la ligne dans update_iwd

Go					

grant execute on sysadm.Iwd_Update_Iwd_Supprimer to rolebddsinistres
Go

/* Ancienne version du 13/02/2014 avant modif FS
	
		CREATE procedure [sysadm].[Iwd_Update_Iwd_Supprimer] --PM217-2 : Procédure Iwd_Update_Iwd_Supprimer
          @sIdIwd    varchar(50)          -- Identifiant iwd du sinistre à supprimer
            
      AS
      
            Set nocount on
            
            -- Réinitialisation des flags sur w_queue
            
      if exists (select *
            From sysadm.update_iwd u , sysadm.w_queue 
            Where u.id_sin = w_queue.id_sin And
                  u.id_iwd = @sIdIwd 
                  and u.queue = 'iWD_Completed')   
                  
                  Begin
                        
                        update sysadm.w_queue
                          Set 
                                id_iwd = null,
                               etat_iwd = 1
                        From sysadm.update_iwd u
                        Where u.id_sin = sysadm.w_queue.id_sin And
                               u.id_iwd = @sIdIwd
                  End
      
            -- Suppression de la ligne dans update_iwd

                  Delete from sysadm.update_iwd where id_iwd = @sIdIwd

	go
	
	*/
	
	grant execute on sysadm.Iwd_Update_Iwd_Supprimer to rolebddsinistres
	Go
	
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Update_Iwd_Charger]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Charger]
	GO
	
	CREATE procedure [sysadm].[Iwd_Update_Iwd_Charger] --PM217-2 : Procédure Iwd_Update_Iwd_Charger
	AS
		
	      SELECT id_iwd AS InteractionId,
                        cod_etat,
                        cast ([alt_occupe]as varchar(1)) as alt_occupe,
                        queue as Queue,
                        cast ([niveau_dbval_iwd]as int) as responsable_iwd ,
                        cast ([routage_iwd]     as varchar(50)) as routage_iwd, 
                         cast ([txt_mess_iwd]   as varchar (254)) as txt_mess_iwd
                  FROM 
                               sysadm.update_iwd 
              WHERE 
                  (flag_update_iwd = 1) and alt_occupe ='N'


			
	Go

	grant execute on sysadm.Iwd_Update_Iwd_Charger to rolebddsinistres
	Go
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Update_Iwd_Modifier_flag]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Modifier_flag]
	GO
	
	CREATE procedure [sysadm].[Iwd_Update_Iwd_Modifier_flag] --PM217-2 : Procédure Iwd_Update_Iwd_Modifier_flag
	@sIdIwd varchar(50) -- Identifiant interactionId
	AS
	
	UPDATE sysadm.update_iwd SET [flag_update_iwd]=4 where id_iwd=@sIdIwd
	
	commit tran
	
	Go
	
	grant execute on sysadm.Iwd_Update_Iwd_Modifier_flag to rolebddsinistres
	Go
	

	/* * *  Maintien provisoire pour compatibilité / ancienne commande plus utilisée depuis la fenêtre de routage* * */
	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Iwd_Queue_Router_Dossier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Queue_Router_Dossier]
GO
	
CREATE procedure [sysadm].[Iwd_Queue_Router_Dossier] --PM217-2 : Procédure Iwd_Queue_Modifier_Etat
	    @sIdSin   varchar(7),  -- Identifiant du sinistre
		@sIdCorb  varchar(3),  -- Numéro de la corbeille
		@sOper    varchar(4),  -- Routé vers @sOper trigramme / RSP responsable / DRE département réclamation
		@sMess    varchar(508) -- Message de routage
	AS
		--------------------------------------------------------------------		      
		-- FS le 26/12/2013  : PM217-2 : Iwd_Queue_Router_Dossier
		--------------------------------------------------------------------
			/* * *  Maintien provisoire pour compatibilité * * */
		
		update sysadm.w_queue set txt_mess1 = 'IWD travail routé à ' + @sOper where id_sin = @sIdSin
		update sysadm.w_queue set routage_iwd = UPPER ( @sOper ) where id_sin = @sIdSin
		-- Appel provisoire pour compatibilité nouvelle version
		EXECUTE [sysadm].[Iwd_Update_Iwd_Router_Dossier]  @sIdSin ,@sIdCorb ,@sOper  ,@sMess
GO

grant execute on sysadm.Iwd_Queue_Router_Dossier to rolebddsinistres
Go


------------------------------------------------------------------------
-- Fin   [PM217-2] IWD - FS - 02/10/2013 : Objets nécessaires pour ce PM
------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'Iwd_Update_Iwd_Mail' AND type = 'P' )
       DROP procedure sysadm.Iwd_Update_Iwd_Mail
GO

CREATE procedure sysadm.Iwd_Update_Iwd_Mail
AS

declare 
	@sDestinataire       Varchar(255),
	@sCCi       Varchar(255),
	@dtDj	datetime,
	@dtDeb	datetime,
	@dtFin	datetime,
	@sDtj varchar(10),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int,
	@sRetourErrMail         VarChar(255)

Begin

	-- Definition des champs MailTo et Cci de l'eventuel mail à envoyer.
	Set @sDestinataire = 'cbourdoiseau@spb.eu,opons@spb.eu,mboudier@spb.eu'
	
	-- Pour debbugage et verif eventuelle, Mise en copie pour ES
	-- Set @sCCi = 'jff@spb.fr, phg@spb.fr'
	Set @sCCi = '' --'jff@spb.fr, phg@spb.fr'

	Set @sDtj = convert ( varchar(10), GetDate(),112 )


	-- chemin d'enregistrement du Result Set
	Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Iwd\'
	Set @sFileName	= 'update_iwd_' + @sDtj
	Set @sFileExt	= 'xls'

	SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

	SET @sNomServeur = @@servername
	-- Options additionelles pour osql
	-- /s"	" 	=> Separateur Tabulation
	-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
	-- /u	=> Unicode
	Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				'select * from SIMPA2_PRO.sysadm.update_iwd " /o' 
				+ @sFicOut + ' -w5000' + @sOsqlOption
	Else
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				'select * from SIMPA2_TRT.sysadm.update_iwd " /o' 
				+ @sFicOut + ' -w5000' + @sOsqlOption
				
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

	Set @sObjet    = 'Extraction de la table update_iwd du ' + convert(varchar(10), getdate(), 103) 
	set @sMessage  = 'Veuillez trouver ci-joint le contenu de la table update_iwd au ' + + convert(varchar(10), getdate(), 103)  + '.' + Char(13)+ Char(10) +
         'Veuillez détacher sur votre disque le fichier pour pouvoir l''ouvrir.'+ Char(13)+ Char(10)

	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DEI-ES.'
	END

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			@sDestinataire, 
			@sMessage, 
			@sObjet, 
			'', 
			@sCCi, 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
End

GO

grant execute on sysadm.Iwd_Update_Iwd_Mail to rolebddsinistres
go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'Iwd_Purge_Update_Iwd' AND type = 'P' )
       DROP procedure sysadm.Iwd_Purge_Update_Iwd
GO

CREATE procedure sysadm.Iwd_Purge_Update_Iwd
AS
	Declare @dtPivot datetime
	
	Set @dtPivot=DATEADD(day,-1,GETDATE())

	delete from sysadm.update_iwd
	where flag_update_iwd=4 and maj_le < @dtPivot
	
	update sysadm.update_iwd set alt_occupe='N'
	where alt_occupe='O' and maj_le < @dtPivot
Go

grant execute on sysadm.Iwd_Purge_Update_Iwd to rolebddsinistres
go


----------------------------------------------------------------------------------------------------
-- [sysadm].[Iwd_Param_Corbeille_V100] FS le 31/12/2019 Procédure de paramétrage des corbeilles
----------------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'Iwd_Param_Lire_Corbeille_V100' AND type = 'P' )
       DROP procedure [sysadm].[Iwd_Param_Lire_Corbeille_V100]
GO


CREATE procedure [sysadm].[Iwd_Param_Lire_Corbeille_V100]
AS

-- Les corbeilles présentes

Select 
		fa.id_fam, fa.id_typ_code, fa.id_code as id_corb, lc.lib_code as lib_corb,
		'O' as alt_217,
		isnull( (Select 'O' From sysadm.famille fa218 Where fa218.id_fam = 218 and fa218.id_code = fa.id_code), 'N') as alt_218,
		fa.cree_le, fa.maj_le, fa.maj_par,
		'N' as alt_maj
	from sysadm.famille fa
		 inner join sysadm.code lc on fa.id_typ_code = lc.id_typ_code and fa.id_code = lc.id_code
	where
	fa.id_fam = 217

-- Les corbeilles absentes

Union 

	Select 
		217 as id_fam, c.id_typ_code, c.id_code as id_corb, c.lib_code as lib_corb,
		'N' as alt_217,
		isnull( (Select 'O' From sysadm.famille fa218 Where fa218.id_fam = 218 and fa218.id_code = c.id_code), 'N') as alt_218,
		getdate() as cree_le, getdate() as maj_le, null maj_par,
		'N' as alt_maj
	from sysadm.code c
	Where
	c.id_typ_code = '-CO' and
	not exists 
	( select * from sysadm.famille v 
	   Where  v.id_fam = 217 and
			  v.id_typ_code = c.id_typ_code and
			  v.id_code = c.id_code )
Order by id_corb
Go

grant execute on [sysadm].[Iwd_Param_Lire_Corbeille_V100] to rolebddsinistres
go


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'Iwd_Param_Maj_Corbeille_V100' AND type = 'P' )
       DROP procedure [sysadm].[Iwd_Param_Maj_Corbeille_V100]
GO

CREATE procedure [sysadm].[Iwd_Param_Maj_Corbeille_V100]
@iIdCorb Integer,    -- Identifiant de la corbeille
@sAlt217 Varchar(1), -- Présence dans la famille 217 (capturée)
@sAlt218 Varchar(1), -- Présence dans la famille 218 (interdite en interro libre)
@dtCreeLe Datetime,  -- Date création
@dtMajLe  Datetime,  -- Date maj
@sMajPar Varchar(4)  -- Opérateur maj
AS
Set nocount on

-- Création dans la famille 217

	Insert into sysadm.famille 
	(id_fam, id_typ_code, id_code, lib_fam, cree_le, maj_le, maj_par)
	Select
	 217, '-CO', id_code, lib_code, @dtCreeLe, @dtMajLe, @sMajPar
	From sysadm.code 
	Where 
	id_typ_code = '-CO' And
	id_code = @iIdCorb And
	@sAlt217 = 'O' And
	 not exists ( Select * from sysadm.famille v where v.id_fam = 217 and v.id_typ_code = '-CO' and v.id_code = @iIdCorb )


-- Création dans la famille 218

	Insert into sysadm.famille 
	(id_fam, id_typ_code, id_code, lib_fam, cree_le, maj_le, maj_par)
	Select
	 218, '-CO', id_code, lib_code, @dtCreeLe, @dtMajLe, @sMajPar
	From sysadm.code 
	Where 
	id_typ_code = '-CO' And
	id_code = @iIdCorb And
	@sAlt217 = 'O' And  -- Création dans famille 218 seulement si la corbeille est active en 217
	@sAlt218 = 'O' And
	 not exists ( Select * from sysadm.famille v where v.id_fam = 218 and v.id_typ_code = '-CO' and v.id_code = @iIdCorb )

-- Suppression dans la famille 217

	Delete from sysadm.famille
	Where
	 id_fam      = 217       And
	 id_typ_code = '-CO'     And
	 id_code     = @iIdCorb  And
	 @sAlt217    = 'N'	     And
	  exists ( Select * from sysadm.famille v where v.id_fam = 217 and v.id_typ_code = '-CO' and v.id_code = @iIdCorb )

-- Suppression dans la famille 218

	Delete from sysadm.famille
	Where
	 id_fam      = 218       And
	 id_typ_code = '-CO'     And
	 id_code     = @iIdCorb  And
	 ( @sAlt218='N' or @sAlt217='N' )   And -- si retrait de la famille 217 je retire de la famille 218
	  exists ( Select * from sysadm.famille v where v.id_fam = 218 and v.id_typ_code = '-CO' and v.id_code = @iIdCorb )
go

grant execute on [sysadm].[Iwd_Param_Maj_Corbeille_V100] to rolebddsinistres
go

