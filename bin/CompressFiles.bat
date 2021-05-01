@echo off

set "args=%1"
if not defined args goto :Exit

echo %~n0 was called with the following arguments: %1
echo.

md %1\TEMP 1>nul 2>nul
move %1\*.7z %1\TEMP\ 1>nul 2>nul
move %1\*.rar %1\TEMP\ 1>nul 2>nul
move %1\*.zip %1\TEMP\ 1>nul 2>nul

for %%I in (%1\*.*) do "C:\Program Files\7-Zip\7z.exe" -mx9 a "%%~dpnI.7z" "%%I"

move %1\TEMP\*.7z %1\ 1>nul 2>nul
move %1\TEMP\*.rar %1\ 1>nul 2>nul
move %1\TEMP\*.zip %1\ 1>nul 2>nul
rd %1\TEMP 1>nul 2>nul
echo.

:Exit
echo Press any key to exit
pause>nul
