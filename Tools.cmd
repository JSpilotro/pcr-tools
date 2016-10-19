:: Off Process PCR Tools.

CLS
@echo off
TITLE Starting up ToolBox 

:: CHECK WINDOWS VERSION
for /f "tokens=2 delims=[]" %%x in ('ver') do set WINVER=%%x 
set WINVER=%WINVER:Version =% 

ECHO %WINVER%

:COMMONTOOLS

ECHO.
ECHO Initiating Windows Installer for Safe Mode...
ECHO Enabling Windows Installer in Safe Mode (Minimal)
%windir%\system32\REG.EXE ADD "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /VE /T REG_SZ /F /D "Service" > NUL
IF %ERRORLEVEL% GTR 0 GOTO ERR
IF %ERRORLEVEL% EQU 0 ECHO Windows Installer service is now available in Safe Mode (Minimal).
ECHO .

REM update registry to allow MSISERVER to run in Safe Mode w/Networking
ECHO Enabling Windows Installer in Safe Mode (Networking)
%windir%\system32\REG.EXE ADD "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /VE /T REG_SZ /F /D "Service" > NUL
IF %ERRORLEVEL% GTR 0 GOTO ERR
IF %ERRORLEVEL% EQU 0 ECHO Windows Installer service is now available in Safe Mode (Networking).
ECHO .

REM start the Windows Installer service
ECHO Starting Windows Installer service
%windir%\system32\NET.EXE start msiserver > NUL
IF %ERRORLEVEL% GTR 0 GOTO ERR
IF %ERRORLEVEL% EQU 0 ECHO The Windows Installer service been has started.
ECHO .
ECHO You may now add or remove programs from the computer.

GOTO MSIDONE

:ERR
ECHO .
ECHO An error has occurred trying to enabled MSI in Safe Mode.

:MSIDONE


ECHO.
ECHO Initiating Add Remove Programs and MSCONFIG....
start appwiz.cpl

start MSCONFIG
PAUSE


ECHO.
ECHO Initiating HiJackThis...
start HiJackThis\HijackThis.exe
PAUSE



IF %WINVER% == 5.1.2600 (
ECHO.
ECHO Initiating SmitFraudFix...
start SmitfraudFix.exe
PAUSE

) 

ECHO.
ECHO Initiating CCleaner ...
start CCleaner\ccsetup307_slim.exe
::/D=C:\dirhere
::/S
::/AUTO
PAUSE


ECHO.
ECHO Initiating Malwarebytes...
start Malwarebytes\mbam-setup.exe 
::/silent
PAUSE


ECHO.
ECHO Initiating Superantispyware...
start SUPERAntiSpyware.exe

