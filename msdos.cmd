@echo off
reg query HKU\S-1-5-19 1>nul 2>nul
if not %errorlevel%==0 goto askforadmin
goto start
:start
choice /m "Would you like to restart Windows into MS-DOS Mode"
if %errorlevel%==1 goto setup else exit /b 0
:askforadmin
powershell -c start -verb runas %~df0
exit /b 0
:setup
copy "%~dp0*" "%systemroot%\System32"
cd %systemroot%\System32
if not exist dosexec.bat copy dosexec_default.bat dosexec.bat
reg import msdos.reg
shutdown /r /t 60 /c "Windows needs to restart into MS-DOS Mode. Please save your unsaved work. System will restart in one minute."
exit /b 0