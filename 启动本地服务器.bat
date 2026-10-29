@echo off
chcp 65001 >nul
title Phigros 网页版 - 本地服务器

echo ============================================
echo    Phigros 网页版 本地服务器启动器
echo ============================================
echo.

:: 切换到脚本所在目录（仓库根目录）
cd /d "%~dp0"

:: 检查 Python 是否可用
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

:: 检查 Node.js 是否可用
where node >nul 2>&1
if %errorlevel% equ 0 (
    set "SERVER_CMD=npx --yes serve -l 8000 ."
    goto :start_server
)

echo [错误] 未找到 Python 或 Node.js！
echo.
echo 请先安装以下任意一个：
echo   - Python 3.x (推荐): https://www.python.org/downloads/
echo   - Node.js: https://nodejs.org/
echo.
pause
exit /b 1

:start_server
echo [信息] 服务器目录: %cd%
echo [信息] 服务地址: http://localhost:8000
echo [信息] 按 Ctrl+C 可停止服务器
echo.
echo [提示] 正在打开浏览器...
echo.

:: 延迟2秒后用 Edge 打开浏览器
start "" /min cmd /c "timeout /t 2 /nobreak >nul && start msedge http://localhost:8000"

:: 启动服务器
%SERVER_CMD%

pause
