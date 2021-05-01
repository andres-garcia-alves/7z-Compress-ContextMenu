@echo off

set "args=%1"
if not defined args goto :Exit

echo %~n0 was called with the following arguments: %1
echo.

for /d %%I in (%1\*.*) do "C:\Program Files\7-Zip\7z.exe" -mx9 a "%%I.7z" "%%I"
echo.

:Exit
echo Press any key to exit
pause>nul
