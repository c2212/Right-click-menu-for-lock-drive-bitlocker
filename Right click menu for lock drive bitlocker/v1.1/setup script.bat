@echo off
::setup script
echo -----Setup script for add Lock menu in bitlocker drive-----^


::path
set spath=%~dp0
set btpath=%PROGRAMFILES%\Script_Folder

:start

echo press 1 and enter for install
echo press 2 and enter for unintall
echo press 3 and enter for exit

set /p a=Enter the value:
if %a%==1 (goto :intall)
if %a%==2 (goto :unintall)
if %a%==3 (exit)
goto :error

:intall
  ::create and move file 
  if not exist "%btpath%" (md "%btpath%")
  if exist "%btpath%\lock-bde.bat" (del /f /q /a:- "%btpath%\lock-bde.bat")
  if exist "%btpath%\lock-bde.bat" (del /f /q /a:- "%btpath%\lock-bde.exe")

  ::robocopy "%spath%\" "%btpath%" "lock-bde.exe"
  xcopy "%spath%\lock-bde.exe" "%btpath%\" /c /q /i /h /y

  ::clear this key in registry
  reg delete "HKCR\Drive\shell\lock-bde" /f 2>nul
  ::add in registry
  ::HKCR is HKEY_CLASSES_ROOT

  reg add "HKCR\Drive\shell\lock-bde" /d Lock /f

  ::HasLUAShield add Shield icon
  reg add "HKCR\Drive\shell\lock-bde" /v HasLUAShield /t REG_SZ /f

  reg add "HKCR\Drive\shell\lock-bde" /v NoWorkingDirectory /t REG_SZ /f

  reg add "HKEY_CLASSES_ROOT\Drive\shell\lock-bde\command" /d "cmd /q /c \"%btpath%\lock-bde.exe\" %%1" /f

  echo Do you want hide lock option from right click menu on drive.the lock only shows up when you press shift + right click on drive 
  :s1
  set /p e=y or n:
  if %e%==y (goto :extended)
  if %e%==Y (goto :extended)
  if %e%==n (goto :noextended)
  if %e%==N (goto :noextended)
  goto :er1

    :extended
    ::Extended is optional
    ::Extended used to hide Lock,to see Lock menu press shift + right click on drive
    reg add "HKEY_CLASSES_ROOT\Drive\shell\lock-bde" /v Extended /t REG_SZ /f
    echo Extended added
    goto :next

    :noextended
    echo Extended not added
    goto :next

    :er1
    echo Unknown value
    goto :s1

  :next
  echo ----install complete---
goto :end

:unintall
  reg delete "HKCR\Drive\shell\lock-bde" /f
  if exist "%btpath%\lock-bde.bat" (del /f /q /a:- "%btpath%\lock-bde.bat")
  del /f /q /a:- "%btpath%\lock-bde.exe"

  echo ----uninstall complete---
goto :end

:error
  echo Unknown value

:end

goto :start
pause