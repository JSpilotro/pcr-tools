:: Off Process PCR Tools Last stage

CLS
@echo off
TITLE Stage 3 - Off Process PCR Tool


:: CHECK WINDOWS VERSION
for /f "tokens=2 delims=[]" %%x in ('ver') do set WINVER=%%x 
set WINVER=%WINVER:Version =% 

ECHO %WINVER%


ECHO Detecting OS processor type...

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
@echo off
ECHO 64BIT SYSTEM DETECTED.

set ccleanerpath="C:\Program Files (x86)\CCleaner"
set mbampath="C:\Program Files (x86)\Malwarebytes' Anti-Malware"
set saspath="C:\Program Files\SUPERAntiSpyware"

) ELSE (
@echo off
ECHO 32BIT SYSTEM DETECTED.

set ccleanerpath="C:\Program Files\CCleaner"
set mbampath="C:\Program Files\Malwarebytes' Anti-Malware"
set saspath="C:\Program Files\SUPERAntiSpyware"
)

ECHO PATHS SET AS..
ECHO %ccleanerpath%
ECHO %mbampath%
ECHO %saspath%
PAUSE

IF %WINVER% == 5.1.2600 (
GOTO :WINDOWSXP

) ELSE IF %WINVER% == 5.2.3790 (
GOTO :WINDOWSXP64

) ELSE IF %WINVER% == 6.0.6000  (
GOTO :WINDOWSVISTA

) ELSE IF %WINVER% == 6.0.6001  (
GOTO :WINDOWSVISTA

) ELSE IF %WINVER% == 6.0.6002  (
GOTO :WINDOWSVISTA

) ELSE IF %WINVER% == 6.1.7600 (
GOTO :WINDOWS7

) ELSE (
ECHO VERSION NOT RETRIEVED - Uninstall Manually - Starting Add/Remove Programs...
start appwiz.cpl
PAUSE

ECHO starting IE Properties...
start inetcpl.cpl

GO TO :END

)





:: WINDOWS VERSION CHECK

IF %64BIT% == 1 (
ECHO 64BIT
)



:WINDOWSXP

ECHO WINDOWS XP
ECHO Intiating Dial-a-Fix...
start Dial-a-Fix\Dial-a-fix.exe
PAUSE




GOTO COMMONTOOLS

:WINDOWSXP64

ECHO WINDOWSXP 64
PAUSE
GOTO COMMONTOOLS

:WINDOWSVISTA

ECHO WINDOWS VISTA
PAUSE

PAUSE

GOTO COMMONTOOLS

:WINDOWS7

ECHO WINDOWS 7
PAUSE

GOTO COMMONTOOLS









:COMMONTOOLS

ECHO.
ECHO
ECHO Enabling Firewall...
netsh firewall set opmode enable

netsh advfirewall set currentprofile state on
PAUSE


ECHO.
ECHO Reset IE Settings...
start inetcpl.cpl
PAUSE


ECHO.
ECHO Uninstall CCleaner...

cd %ccleanerpath%
start uninst.exe /S
PAUSE


ECHO.
ECHO Unistall Malwarebytes...

cd %mbampath%
start unins000.exe /SILENT
PAUSE

::rp unistall
::C:\Program Files\RP Malware Removal Tool/unins000.exe

ECHO.
ECHO Unistall SuperAntiSpyware... 

cd %saspath%
start Uninstall.exe


:END


:: SELF DELETING BATCH FILE
:: del %0
:: copy to c: make batch file seperate out of tools file then rmdir?

:: Add automatic deletion of tools?



