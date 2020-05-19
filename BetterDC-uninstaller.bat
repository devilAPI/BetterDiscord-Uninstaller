@ECHO off

:prompt
set /P c=Thanks for using my uninstaller! Are you sure you want to uninstall BetterDiscord [Y/N]? 
echo.
if /I "%c%" EQU "Y" goto :removeBetterDiscord
if /I "%c%" EQU "N" goto :eof
goto :prompt

:removeBetterDiscord
echo Backing up BetterDiscord...
echo.
Xcopy /E /I "C:\Users\%USERNAME%\AppData\Roaming\BetterDiscord" "C:\Users\%USERNAME%\Desktop\BetterDiscord"
echo Removing BetterDiscord...
echo.
call:deleteFolder %appdata%\BetterDiscord
for /d %%G in ("%localappdata%\Discord\app-*") do (
    call:deleteFolder "%%G\resources\node_modules\BetterDiscord"
    call:deleteFolder "%%G\resources\app"
)

goto:end

:deleteFolder
if exist "%~1" (
    @RD /S /Q "%~1"
    echo Folder "%~1" removed.
) else (
    echo Folder "%~1" does not exist. This is NOT an Error. Uninstallation should still work.
)
goto:eof

:end
echo.
echo Restarting Discord...
taskkill /f /im Discord.exe 1>nul 2>nul
"%localappdata%\Discord\Update.exe" --processStart Discord.exe

echo.
echo BetterDiscord has been removed!
echo.

pause
