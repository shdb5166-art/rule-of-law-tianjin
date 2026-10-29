@echo off
title Local Server Launcher

echo ============================================
echo    Local Web Server Launcher
echo ============================================
echo.

cd /d "%~dp0"

where python >nul 2>&1
if %errorlevel% equ 0 (
    set "SERVER_CMD=python -m http.server 8000"
    goto :start_server
)

where py >nul 2>&1
if %errorlevel% equ 0 (
    set "SERVER_CMD=py -m http.server 8000"
    goto :start_server
)

where node >nul 2>&1
if %errorlevel% equ 0 (
    set "SERVER_CMD=npx --yes serve -l 8000 ."
    goto :start_server
)

if exist ".python\python.exe" (
    set "SERVER_CMD=.python\python.exe -m http.server 8000"
    goto :start_server
)

echo [INFO] Python / Node.js not found.
echo [INFO] Downloading portable Python (~10MB)...
echo.

set "PYTHON_ZIP=%TEMP%\python-embed.zip"
set "PYTHON_URL=https://www.python.org/ftp/python/3.12.7/python-3.12.7-embed-amd64.zip"

powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%PYTHON_ZIP%' -UseBasicParsing }"

if not exist "%PYTHON_ZIP%" (
    echo [ERROR] Download failed. Check your internet connection.
    echo.
    pause
    exit /b 1
)

echo [INFO] Download complete. Extracting...
echo.

if not exist ".python" mkdir ".python"
powershell -Command "Expand-Archive -Path '%PYTHON_ZIP%' -DestinationPath '.python' -Force"

for %%f in (.python\*._pth) do (
    powershell -Command "(Get-Content '%%f') -replace '#import site', 'import site' | Set-Content '%%f'"
)

del "%PYTHON_ZIP%" >nul 2>&1

if not exist ".python\python.exe" (
    echo [ERROR] Extraction failed.
    pause
    exit /b 1
)

echo [INFO] Portable Python ready!
echo.

set "SERVER_CMD=.python\python.exe -m http.server 8000"

:start_server
echo ============================================
echo [INFO] Root: %cd%
echo [INFO] URL:  http://localhost:8000
echo [INFO] Press Ctrl+C to stop
echo ============================================
echo.
echo [INFO] Opening browser...
echo.

start "" /min cmd /c "timeout /t 2 /nobreak >nul && start msedge http://localhost:8000"

%SERVER_CMD%

pause
