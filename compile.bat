@echo off
setlocal enableextensions enabledelayedexpansion
if q%1==q exit /b
set name=%~n1.eazzy.bat
set name1=%~n1.eazzy
if q%counter%==q set counter=0
set strnum=0
set hide=false
call :g3 %~1
echo @echo off>%~n1.eazzy.bat
echo set eazzydir=%%userprofile%%\eazzybatch>>!name!
echo goto next0>>!name!
echo :api>>!name!
echo call %%eazzydir%%\api\api.bat %%1 %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9>>!name!
echo exit /b>>!name!
echo :next0>>!name!
echo @echo on>>!name!
pushd "%~dp1"
for /F "tokens=* eol=#" %%a in (%~nx1) do (
	set /a strnum+=1
	set tmp=
	set end=false
	set str=%%a
	set func=
	set args=
	set g2end=false
	set tmp=!str:~0,8!
	if !strnum!==1 (
		if !str!==hidden (
			echo @echo off>>!name!
			set hide=true
			set end=true
		)
	)
	if q!tmp!==qfunction (
		set function=!str:~9!
		for /F "tokens=1,2 delims=()" %%b in ("!function!") do (
			set func=%%b
			for /F "tokens=1,2,3,4,5,6,7,8,9* delims=," %%d in ("%%c") do (
				set /A counter+=1
				echo goto next!counter!>>!name!
				echo :!func!>>!name!
				call :g1 q%%d 1 %~n1.eazzy.bat		
				call :g1 q%%e 2 %~n1.eazzy.bat
				call :g1 q%%f 3 %~n1.eazzy.bat
				call :g1 q%%g 4 %~n1.eazzy.bat
				call :g1 q%%h 5 %~n1.eazzy.bat
				call :g1 q%%i 6 %~n1.eazzy.bat
				call :g1 q%%j 7 %~n1.eazzy.bat
				call :g1 q%%k 8 %~n1.eazzy.bat
				call :g1 q%%l 9 %~n1.eazzy.bat
			)
			if q%%c==q (
				set /A counter+=1
				echo goto next!counter!>>!name!
				echo :!func!>>!name!
			)
		)
		set end=true
	)
	if not q!end!==qtrue (
		echo.%%a>tmp.txt
		find "(" tmp.txt>nul
		if !errorlevel!==0 (
			echo.%%a>tmp.txt
			find ")" tmp.txt>nul
			if !errorlevel!==0 (
				set tmp=!str:~0,3!
				if not !tmp!==for (
				set tmp=!str:~0,2!
				if not !tmp!==if (								set tmp=!str:~0,8!
				for /F "tokens=1,2 delims=()" %%b in ("!str!") do (
					set func=%%b
					for /F "tokens=1,2,3,4,5,6,7,8,9* delims=," %%d in ("%%c") do (
						call :g2 %%d %%e %%f %%g %%h %%i %%j %%k %%l
					)
					if q%%c==q (
						call :g2
					)
				)
				set end=true
				)				
				)
			)
			del tmp.txt 1>nul 2>&1
		)
		del tmp.txt 1>nul 2>&1
	)
	if not q!end!==qtrue (
		set tmp=!str:~0,3!
		if q!tmp!==qend (
			echo exit /b>>!name!
			echo :next!counter!>>!name!
			set end=true
		)
	)
	if not q!end!==qtrue (
		set tmp=!str:~0,7!
		if q!tmp!==qinclude (
			set args=!str:~8!
			call %0 "%~dp1\!args!">nul
			for /F "tokens=*" %%A in ("!args!") do (
			more +8 "%%~nA.eazzy.bat" >> !name!
			del %%~nA.eazzy.bat
			)
			echo.>>!name!
			set end=true
		)
	)
	if not q!end!==qtrue (
		set tmp=!str:~0,6!
		if q!tmp!==qreturn (
			set args=!str:~7!
			echo set result=!args!>>!name!
			set end=true
		)
	)
	if not q!end!==qtrue (
		echo.%%a>>!name!
	)
)
echo !hide!
popd
exit /b
:g1
if not %1==q (
	set tmp=%1
	set tmp=!tmp:~1!
	echo set !tmp!=%%%2>>%3
)
exit /b
:g2
if !func!==Msg (
	echo call :api msg "%~1" %2 "%~3">>!name!
) else (
	if !func!==BrowseFolder (
		echo call :api BrowseFolder "%~1">>!name!
	) else (
		if !func!==BrowseFile (
		echo call :api BrowseFile>>!name!
	) else (
	if !func!==GInput (
		echo call :api ginput "%~1" "%~2">>!name!
	) else (
	if !func!==GET (
		echo call :api get "%~1" "%~2" "%~3">>!name!
	) else (
	if !func!==POST (
		echo call :api post %*>>!name!
	) else (
	if !func!==Run (
		echo call :api run %1 %2 %3>>!name!
	) else (
	if !func!==md5 (
		echo call :api md5 %2 %1>>!name!
	) else (
	if !func!==crc32 (
		echo call :api crc32 %1>>!name!
	) else (
	if !func!==base64 (
		echo call :api base64 %2 %1 !name1!>>!name!
	) else (	if !func!==debase64 (
		echo call :api debase64 %2 %1 !name1!>>!name!
	) else (
	if !func!==extIP (
		echo call :api extip>>!name!
	) else (
	if !func!==scancode (
		echo call :api scancode>>!name!
	) else (
		echo call :!func! %1 %2 %3 %4 %5 %6 %7 %8 %9>>!name!
	)
)
)
)
)
)
)
)
)
)
)
))
exit /b
:g3
set allstr=0
for /F %%z in (%1) do set allstr+=1
exit /b
:compvars
pushd %~dp0
for /F "tokens=1,2* delims==" %%a in (vars.ini) do set %%a=%%bfor /F "tokens=1,2* delims==" %%a in (vars.ini) do set %%a=%%b
popd
exit /b