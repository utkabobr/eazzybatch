@echo off
if "%1"=="BrowseFile" goto BrowseFile
if "%1"=="BrowseFolder" goto BrowseFolder
if "%1"=="msg" goto msg
if "%1"=="get" goto get
if "%1"=="post" goto post
if "%1"=="ginput" goto ginput
if "%1"=="run" goto run
if "%1"=="base64" goto base64
if "%1"=="debase64" goto debase64
if "%1"=="md5" goto md5
if "%1"=="crc32" goto crc32
if "%1"=="extip" goto extip
if "%1"=="scancode" goto scancode
if "%1"=="checkversion" goto checkversion
exit /b
:BrowseFile
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);close();resizeTo(0,0);</script>"
for /f "tokens=*" %%a in ('mshta.exe %dialog%') do set "result=%%a"
exit /b
:BrowseFolder
for /f "tokens=*" %%a in ('cscript //nologo %~dp0\BrowseFolder.vbs %2') do set "result=%%a"
exit /b
:msg
for /f "tokens=*" %%a in ('cscript //nologo %~dp0\MsgBox.vbs %2 %3 %4') do set "result=%%a"
exit /b
:ginput
for /f "tokens=*" %%a in ('cscript //nologo %~dp0\GPromptForInput.vbs %2 %3') do set "result=%%a"
exit /b
:get
if not "%~3"=="" (
call %~dp0\wget.exe "%~2" -O "%~3" %~4
) else (
call %~dp0\wget.exe "%~2"
)
exit /b
:post
set postargs=
call :postg1 %3
call :postg1 %4
call :postg1 %5
call :postg1 %6
call :postg1 %7
call :postg1 %8
call :postg1 %9
call %~dp0\curl.exe %postargs% %2
echo.
exit /b
:postg1
if not "%~1"=="" (
set postargs=%postargs% -F %~1
)
exit /b
:run
echo Set oShell = WScript.CreateObject("WScript.Shell")>run.vbs
echo oShell.Run "%~2", %3, %4>>run.vbs
cscript //nologo run.vbs
del run.vbs>nul
exit /b
:base64
echo.>%temp%\%~4result.txt
if q%2==qfile (
for /F "tokens=*" %%a in ('%~dp0\base64.exe -e %3') do (
echo %%a>>%temp%\%~4result.txt
)
)
if q%2==qtext (
for /F "tokens=*" %%a in ('echo %~3^|%~dp0\base64.exe -e') do (
echo %%a>>%temp%\%~4result.txt
)
)
exit /b
:debase64
echo.>%temp%\%~4result.txt
if q%2==qfile (
for /F "tokens=*" %%a in ('%~dp0\base64.exe -d %3') do (
echo %%a>>%temp%\%~4result.txt
)
)
if q%2==qtext (
for /F "tokens=*" %%a in ('echo %~3^|%~dp0\base64.exe -d') do (
echo %%a>>%temp%\%~4result.txt
)
)
exit /b
:crc32
for /F "tokens=1,2" %%a in ('%~dp0\crc32.exe %2') do set result=%%a
exit /b
:md5
if q%2==qfile (
for /F "tokens=1,2" %%a in ('%~dp0\md5.exe %3') do set result=%%a
)
if q%2==qtext (
echo %~3>tmp.txt
for /F "tokens=1,2" %%a in ('%~dp0\md5.exe tmp.txt') do set result=%%a
del tmp.txt>nul
)
exit /b
:extip
for /F "tokens=*" %%a in ('cscript //nologo %~dp0\myIP.vbs') do set result=%%a
exit /b
:scancode
%~dp0\scancode
set result=%errorlevel%
set errorlevel=
exit /b
:checkversion
set apiversion=0.1
if not "%compillerversion%"=="%apiversion%" (
echo ERR: API version not passed!
pause
exit
)
exit /b