@echo off
title PDF BL Converter Launcher
echo ===================================================
echo        PDF BL Converter Local Server Launcher
echo ===================================================
echo.
echo Please keep this window open while using the app.
echo.

:: 1. Check Python
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo [INFO] Starting web server via Python...
    start "" "http://localhost:8000"
    python -m http.server 8000
    goto end
)

:: 2. Check Node.js
where node >nul 2>nul
if %errorlevel% equ 0 (
    echo [INFO] Starting web server via Node.js...
    start "" "http://localhost:8000"
    npx http-server -p 8000
    goto end
)

:: 3. Windows PowerShell Web Server (Fallback)
echo [INFO] Starting fallback web server via PowerShell...
start "" "http://localhost:8000"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l = New-Object System.Net.HttpListener; $l.Prefixes.Add('http://localhost:8000/'); $l.Start(); while($l.IsListening){ try { $c = $l.GetContext(); $r = $c.Response; $h = [System.IO.File]::ReadAllBytes('index.html'); $r.ContentLength64 = $h.Length; $r.ContentType = 'text/html; charset=utf-8'; $r.OutputStream.Write($h, 0, $h.Length); $r.OutputStream.Close() } catch {} }"

:end
pause
