@echo off
cls

set "filenameFilesAdd=ContextMenu-CompressFiles-Add.reg"
set "filenameFilesRemove=ContextMenu-CompressFiles-Remove.reg"
set "filenameFoldersAdd=ContextMenu-CompressFolders-Add.reg"
set "filenameFoldersRemove=ContextMenu-CompressFolders-Remove.reg"
set "filenameTemp=temp.reg"

set "regkeyFiles=HKEY_CLASSES_ROOT\Folder\shell\Compress Files"
set "regfullkeyFiles=HKEY_CLASSES_ROOT\Folder\shell\Compress Files\command"
set "regkeyFolders=HKEY_CLASSES_ROOT\Folder\shell\Compress Folders"
set "regfullkeyFolders=HKEY_CLASSES_ROOT\Folder\shell\Compress Folders\command"

set "batfilePath=%cd:\=\\%"


:: Menu subroutine:
:Menu
echo Select your option (Number+Enter)
echo.
echo 1. Add 'Compress Files' to ContextMenu
echo 2. Remove 'Compress Files' from ContextMenu
echo 3. Add 'Compress Folders' to ContextMenu
echo 4. Remove 'Compress Folders' from ContextMenu
echo 5. Make manual Add/Remove files
echo 6. Exit
echo.

set /p var=
if %var%==1 call :Menu-Files-Add
if %var%==2 call :Menu-Files-Remove
if %var%==3 call :Menu-Folders-Add
if %var%==4 call :Menu-Folders-Remove
if %var%==5 call :Menu-MakeFiles
if %var%==6 goto exit
if %var% GTR 6 echo Error
echo.
goto :Menu


:: Menu options subroutines:
:: Menu-Files-Add, Menu-Files-Remove, Menu-Folders-Add, Menu-Folders-Remove, Menu-MakeFiles
:Menu-Files-Add
call :MakeFile-Files-Add
call %filenameTemp%
call :DeleteFile-Temp
goto :EOF

:Menu-Files-Remove
call :MakeFile-Files-Remove
call %filenameTemp%
call :DeleteFile-Temp
goto :EOF

:Menu-Folders-Add
call :MakeFile-Folders-Add
call %filenameTemp%
call :DeleteFile-Temp
goto :EOF

:Menu-Folders-Remove
call :MakeFile-Folders-Remove
call %filenameTemp%
call :DeleteFile-Temp
goto :EOF

:Menu-MakeFiles
echo Generating file... '%filenameFilesAdd%'
call :MakeFile-Files-Add
@move %filenameTemp% %filenameFilesAdd% >nul
echo Generating file... '%filenameFilesRemove%'
call :MakeFile-Files-Remove
@move %filenameTemp% %filenameFilesRemove% >nul
echo Generating file... '%filenameFoldersAdd%'
call :MakeFile-Folders-Add
@move %filenameTemp% %filenameFoldersAdd% >nul
echo Generating file... '%filenameFoldersRemove%'
call :MakeFile-Folders-Remove
@move %filenameTemp% %filenameFoldersRemove% >nul
goto :EOF


:: Make file subroutines: Files-ContextMenu-Add.reg & Files-ContextMenu-Remove.reg
:MakeFile-Files-Add
echo Windows Registry Editor Version 5.00 > %filenameTemp%
echo. >> %filenameTemp%
echo [%regkeyFiles%] >> %filenameTemp%
echo. >> %filenameTemp%
echo [%regfullkeyFiles%] >> %filenameTemp%
echo @="%batfilePath%\\CompressFiles.bat \"%%1\"" >> %filenameTemp%
goto :EOF

:MakeFile-Files-Remove
echo Windows Registry Editor Version 5.00 > %filenameTemp%
echo. >> %filenameTemp%
echo [-%regkeyFiles%] >> %filenameTemp%
goto :EOF


:: Make files subroutines: Folders-ContextMenu-Add.reg & Folders-ContextMenu-Remove.reg
:MakeFile-Folders-Add
echo Windows Registry Editor Version 5.00 > %filenameTemp%
echo. >> %filenameTemp%
echo [%regkeyFolders%] >> %filenameTemp%
echo. >> %filenameTemp%
echo [%regfullkeyFolders%] >> %filenameTemp%
echo @="%batfilePath%\\CompressFolders.bat \"%%1\"" >> %filenameTemp%
goto :EOF

:MakeFile-Folders-Remove
echo Windows Registry Editor Version 5.00 > %filenameTemp%
echo. >> %filenameTemp%
echo [-%regkeyFolders%] >> %filenameTemp%
goto :EOF


:: Deleting temp file subroutine
:DeleteFile-Temp
del /q %filenameTemp%
goto :EOF


:: Exit batch subroutine
:Exit
echo Press any key to exit
pause>nul
