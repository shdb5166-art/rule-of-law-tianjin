@echo off
chcp 65001 >nul
title Phigros 网页版 - 本地服务器

echo ============================================
echo    Phigros 网页版 本地服务器启动器
echo ============================================
echo.

:: 切换到脚本所在目录（仓库根目录）
cd /d "%~dp0"

:: ========== 第一步：检测系统已有的 Python / Node.js ==========
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

:: ========== 第二步：检测本地便携版 Python（之前下载过的） ==========
if exist ".python\python.exe" (
    set "SERVER_CMD=.python\python.exe -m http.server 8000"
    goto :start_server
)

:: ========== 第三步：自动下载便携版 Python ==========
echo [信息] 未检测到 Python / Node.js
echo [信息] 正在自动下载便携版 Python（约 10MB）...
echo.

set "PYTHON_ZIP=%TEMP%\python-embed.zip"
set "PYTHON_URL=https://www.python.org/ftp/python/3.12.7/python-3.12.7-embed-amd64.zip"

:: 用 PowerShell 下载
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%PYTHON_ZIP%' -UseBasicParsing }"

if not exist "%PYTHON_ZIP%" (
    echo [错误] 下载失败，请检查网络连接
    echo.
    pause
    exit /b 1
)

echo [信息] 下载完成，正在解压...
echo.

:: 创建 .python 目录并解压
if not exist ".python" mkdir ".python"
powershell -Command "Expand-Archive -Path '%PYTHON_ZIP%' -DestinationPath '.python' -Force"

:: 修改 _pth 文件，启用 site 模块（这样标准库才能完整加载）
for %%f in (.python\*._pth) do (
    powershell -Command "(Get-Content '%%f') -replace '#import site', 'import site' | Set-Content '%%f'"
)

:: 删除临时 zip
del "%PYTHON_ZIP%" >nul 2>&1

if not exist ".python\python.exe" (
    echo [错误] 解压失败
    pause
    exit /b 1
)

echo [信息] 便携版 Python 安装完成！
echo.

set "SERVER_CMD=.python\python.exe -m http.server 8000"

:start_server
echo ============================================
echo [信息] 服务器目录: %cd%
echo [信息] 服务地址: http://localhost:8000
echo [信息] 按 Ctrl+C 可停止服务器
echo ============================================
echo.
echo [提示] 正在打开浏览器...
echo.

:: 延迟2秒后用 Edge 打开浏览器
start "" /min cmd /c "timeout /t 2 /nobreak >nul && start msedge http://localhost:8000"

:: 启动服务器
%SERVER_CMD%

pause
