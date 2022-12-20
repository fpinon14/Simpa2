@echo off
SET MOTEUR=FIL
SET BASE=SIMPA2_RECOMPILE
SET SOURCE=P:\WorkSVN\Repository_MIGPB11FR\France\Framework4\Trunk\SIMPA2\SQL\CP
SET CIBLE=P:\WorkSVN\Repository_MIGPB11FR\France\Framework4\Trunk\SIMPA2\SQL\Out
SET PARAM=/Pfil_sysadm /a4096 /n


DEL %CIBLE%\*.OUT

CLS
@echo ********************** ATTENTION *************************
@echo * RECOMPILATION TOTALE DES TOUTE LES PROCEDURES STOCKEES *
@echo *               SUR [%MOTEUR%].[%BASE%]                  *
@echo ********************** ATTENTION *************************
@ECHO.
@ECHO.
@echo Appuyer sur Ctrl-C pour arreter

isql /Usysadm /S%MOTEUR% /d%BASE% /iK:\PB4OBJ\SQL\CP\PB4OBJ_M.CP /o%CIBLE%\PB4OBJ_M.OUT %PARAM%
isql /Usysadm /S%MOTEUR% /d%BASE% /iK:\PB801\SPBOBJ\SQL\CP\DEPARTEM.CP /o%CIBLE%\DEPARTEM.OUT %PARAM%
 
for /F %%J in ('dir /b %SOURCE%\*.cp') do (
	for /f "tokens=1 delims=. " %%K in ("%%J") do (
	  Echo. Compilation de %%J
      isql /Usysadm /S%MOTEUR% /d%BASE% /i%SOURCE%\%%J /o%CIBLE%\%%K.OUT %PARAM% 
	)
)

Echo. Exécution du GRANT
isql /Usysadm /S%MOTEUR% /d%BASE% /ik:\pb4spb\SQL\CP\grant.CP /o%CIBLE%\grant.OUT %PARAM%

pause