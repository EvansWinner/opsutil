@echo off
:: pingls.bat --- send a ping to each address listed in a file
:: Evans Winner 2006.3.3, updated 2013.8.2


:: Clear out vars in case this was run previously and ended by force.
set bell=
set loop=
set delay=
set exit=

:parse
if [%1] == [/b] (
	set bell=
	shift
	goto parse
)

if [%1] == [/l] (
	set loop=t
	shift
	goto parse
)

if [%1] == [/d] (
	set delay=%2
	shift
	shift
	goto parse
)

if [%1] == [] goto help
if [%1] == [help] goto help
if [%1] == [h] goto help
if [%1] == [/?] goto help
if [%1] == [/help] goto help
if [%1] == [/h] goto help

for %%f in (%1 %2 %3 %4 %5 %6 %7 %8 %9) do (
	if not exist %%f (
		echo %%f does not exist
		set exit=t
	)
)

if [%exit%] == [t] (
	echo Type ^`pingls /?^' for help.
	goto :end
)

:: Default delay is ten seconds
if [%delay%] == [] set delay=15000

::::::::::::::::::::::
:: Prettify.
echo.
echo Starting pingls.bat...
echo.
echo Press Ctrl-c at any time to stop.

:start
echo.
for /f %%a in (%1 %2 %3 %4 %5 %6 %7 %8 %9) do (
	ping -n 1 %%a > nul
	if not errorlevel 1 echo Ping of %%a	...	[  OK  ]
	if errorlevel 1 echo Ping of %%a	...	%bell%[FAILED]
	ping 1.1.1.1 -n 1 -w %delay% > nul
)

if [%loop%] == [t] (
	echo.
	echo Restarting IP list...
	echo Press Ctrl-c at any time to stop.
	echo.
	goto start
)
goto :end


:help
echo PINGLS.BAT		User Information		PINGLS.BAT
echo.
echo.
echo.
echo NAME
echo      pingls -- Ping each IP address listed in a file^(s^) and return
echo      a result of OK or FAILURE for each.
echo.
echo SYNOPSIS
echo      pingls ^[^/b^] ^[^/l^] ^[^/d ms^] ipfile1 ^[ipfile2 ... ipfile9^]
echo.
echo DESCRIPTION
echo      pingls pings a list of IP addresses and/or resolvable DNS or
echo      host names supplied in a flat text file^(s^), one to a line.
echo      It displays OK or FAILURE status for each to stdout.  Uses
echo      ping.exe in the following syntax:
echo.
echo        ping -n 1 nnn.nnn.nnn.nnn
echo.
echo OPTIONS
echo      ^/l     -- loop infintely through IPs in ipfile^(s^).
echo      ^/d ms  -- Delay.  Where ms is a number in miliseconds to 
echo                wait between pinging each new address.
echo      ^/b     -- If set to yes, ring system bell on
echo                ping failure.  Default off.
echo.
echo EXAMPLE
echo      pingls ^/b ^/l ^/d 60000 iplist1 iplist2
echo. 
echo        -- Runs pingls on the files iplist1 and iplist2, rings
echo           the system bell when a ping fails, repeats the list
echo           indefintely and waits 60 seconds between addresses.
echo.
echo NOTES
echo      Max alowable files are the maximum number of DOS batch
echo      command args ^(9^) minus the number of options ^(^/d counts
echo      as two.^)  Therefore in the example above, the user could 
echo      specify up to 3 additional infiles.
echo.
echo      Use of the delay option is recommended when using pingls
echo      in loop mode.  This way you won't flood the target sites
echo      with ping requests.  Generally speaking, no more than one
echo      ping per site per 15 minutes is a good average.  Therefore
echo      if your IP list consists of 60 sites, set ^/d 15000 to
echo      delay fifteen seconds per ping, thus 15 minutes per loop.
echo.
echo FILES
echo      infile  --   Path and filename to list of full IP 
echo                   addresses or resolvable DNS^/hostnames.
echo                   One to a line.
echo.
echo      Also requires: cmd.exe, and ping.exe
echo.
echo DIAGNOSTICS
echo      If command line options are not parsed it will dump this
echo      help page and exit.
echo.
echo BUGS
echo      None, of course.  It's perrrrrrfect.
echo.
echo AUTHOR
echo      Evans Winner
echo.
echo.
echo Windows XP				Last change^: 2013.7.31

:end 
:: Clear the vars again in case we want to run it again with different
:: parms
set bell=
set loop=
set delay=
set exit=

