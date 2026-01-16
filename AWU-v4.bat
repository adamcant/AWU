@echo off

set "params=%*"
cd /d "%~dp0"

fsutil dirty query %systemdrive% >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd /d ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 > "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

where winget >nul 2>&1


if errorlevel 1 (
	echo:
	echo Klicka "Y" och sedan "Enter" när text kommer upp!
	echo:
	timeout /t 4
	winget update
)

    where winget >nul 2>&1
    if errorlevel 1 (
        echo Failed to install Winget. Please install it manually and try again.
        timeout /t 15
        exit
    )
)

winget upgrade --all --include-unknown --force --disable-interactivity --silent --accept-source-agreements --accept-package-agreements

timeout /t 2
exit