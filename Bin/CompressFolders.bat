@ECHO OFF

SET args=%1
IF NOT DEFINED args GOTO END

ECHO %~n0 was called with the following arguments: %1
ECHO.

FOR /d %%I IN (%1\*.*) DO "C:\Program Files\7-Zip\7z.exe" -mx9 a "%%I.7z" "%%I"
ECHO.

:END
PAUSE
