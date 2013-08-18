@echo off
:: filep.bat
:: Evans Winner
:: 2006.3.3
:: for sur la table

if [%1] == [] (
	echo.
	echo filep.bat 				filep.bat
	echo.
	echo 	Verify existence of each in a list of files.
	echo.
	echo DESCRIPTION
	echo 	Confirms the existence of each file listed in
	echo 	a file^(s^) containing a newline-delimited list
	echo 	of files, and for each that exists, outputs
	echo 	the last-modififed date and time.
	echo.
	echo USE
	echo 	filep filespec1 ^[filespec2 ... filespec8^]
	echo.
	echo 	where ^`filespec^' is the path and filename
        echo 	for the text file containing a list of rela-
	echo 	tive or absolute file path^\names
	goto :EOF
)

if not exist %1 (
	echo %1 - file does not exist.
	echo Type ^`filep^' for help.
	goto :EOF
)

:run
for /f %%f in (%*) do (
        if exist %%f echo [  OK  ] %%~tf 	%%~nxf
        if not exist %%f echo [FAILED]			%%~nxf
)
