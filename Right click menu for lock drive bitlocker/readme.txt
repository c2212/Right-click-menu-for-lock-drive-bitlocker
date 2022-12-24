exe-format:64 bit

use Setup script .bat or .exe file .bat required run as admin
Setup script.exe converted from .bat (Setup script.exe and Setup script.bat are same)

Setup script:

create folder and file:-

%PROGRAMFILES%\Script_Folder\lock-bde.exe
something like this: C:\Program Files\Script_Folder\lock-bde.exe

create registry key:-

HKEY_CLASSES_ROOT\Drive\shell\lock-bde


-Manual Mode-
create a text file and rename it lock-bde.bat and write this line and save it any path

lock-bde.bat:-

@echo off
manage-bde -lock %~d1

and create new key in registry name lock-bde
HKEY_CLASSES_ROOT\Drive\shell\

in HKEY_CLASSES_ROOT\Drive\shell\lock-bde

Name                    Type                Data
(Default)               REG_SZ              Lock
HasLUAShield            REG_SZ              
NoWorkingDirectory      REG_SZ              
Extended                REG_SZ              

HasLUAShield show shield on Lock
Extended hide Lock menu, to see Lock menu press shift + right click on drive
Extended is optional

create new key in registry name command

in HKEY_CLASSES_ROOT\Drive\shell\lock-bde

Name                    Type                Data
(Default)               REG_SZ              cmd /q /c powershell "start 'C:\Program Files\Script_Folder\lock-bde.bat' %1 -v runas"


setup script v1 do same as above
setup scriptv1.1 use lock-bde.exe
exe made by Bat To Exe Converter



