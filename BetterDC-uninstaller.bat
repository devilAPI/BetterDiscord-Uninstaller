@ECHO off
:reallydelete
set /P c=Thanks for downloading my uninstaller! Do you really want to uninstall BetterDiscord/BandagedDB [Y/N]? 
echo.
if /I "%c%" EQU "Y" goto :remove
if /I "%c%" EQU "N" goto :eof
goto :reallydelete
:remove
echo Making Backup of BetterDiscord Folder...
Xcopy /E /I %appdata%\BetterDiscord C:\Users\%USERNAME%\Desktop\BetterDiscord
echo Backup successfull.
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
    echo Folder "%~1" does not exist.
)
goto:eof
:end
echo.
echo Restarting Discord...
taskkill /f /im Discord.exe 1 2
"%localappdata%\Discord\Update.exe" --processStart Discord.exe
echo.
echo BetterDiscord/bandagedDB has been removed! Thanks for using my tool!
echo Discord should now restart.
echo if not, please 
echo.
pause
