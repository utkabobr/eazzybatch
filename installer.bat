@echo off
mkdir %userprofile%\eazzybatch
mkdir %userprofile%\eazzybatch\api\
copy "%~dp0api\*" %userprofile%\eazzybatch\api\
copy "%~dp0start.bat" %userprofile%\eazzybatch\
copy "%~dp0compile.bat" %userprofile%\eazzybatch\
copy "%~dp0vars.ini" %userprofile%\eazzybatch\
assoc .eazzy=eazzyfile
ftype eazzyfile="%userprofile%\eazzybatch\start.bat" %%1
echo [*] Done!
pause