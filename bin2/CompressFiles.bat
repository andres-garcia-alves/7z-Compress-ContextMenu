@ECHO OFF

SET args=%1
IF NOT DEFINED args GOTO END

ECHO %~n0 was called with the following arguments: %1
ECHO.

MD %1\TEMP 1>nul 2>nul
MOVE %1\*.7z %1\TEMP\ 1>nul 2>nul
MOVE %1\*.rar %1\TEMP\ 1>nul 2>nul
MOVE %1\*.zip %1\TEMP\ 1>nul 2>nul

FOR %%I IN (%1\*.*) DO "C:\Program Files\7-Zip\7z.exe" -mx9 a "%%~dpnI.7z" "%%I"

MOVE %1\TEMP\*.7z %1\ 1>nul 2>nul
MOVE %1\TEMP\*.rar %1\ 1>nul 2>nul
MOVE %1\TEMP\*.zip %1\ 1>nul 2>nul
RD %1\TEMP 1>nul 2>nul
ECHO.

:END
PAUSE
