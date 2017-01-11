@echo off
cd %~dp1
set hide=false
for /F "tokens=*" %%a in ('call %~dp0\compile.bat %~nx1') do set hide=%%a
if %hide%==true (
echo Set oShell = WScript.CreateObject^("WScript.Shell"^)>run.vbs
echo oShell.Run "%~n1.eazzy.bat", 0, true>>run.vbs
start run.vbs
ping -n 1 -w 10 192.255.255.255>nul
del run.vbs>nul
)
if %hide%==false (
call %~n1.eazzy.bat
)
del %~n1.eazzy.bat