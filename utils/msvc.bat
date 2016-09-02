@echo off
setlocal

if "%TARGET_ARCH%" == "" (
    set TARGET_ARCH=x64
)
if "%TARGET_ENV%" == "" (
    set TARGET_ENV=vc2013
)

if "%TARGET_ENV%" == "vc2013" (
    echo set Microsoft Visual Studio 12.0
    set MSVC_ROOT="C:\Program Files (x86)\Microsoft Visual Studio 12.0"
)
if "%TARGET_ENV%" == "vc2015" (
    echo set Microsoft Visual Studio 14.0
    set MSVC_ROOT="C:\Program Files (x86)\Microsoft Visual Studio 14.0"
)

echo TARGET_ENV: %TARGET_ENV%
echo TARGET_ARCH: %TARGET_ARCH%
echo MSVC_ROOT: %MSVC_ROOT%

if not exist %MSVC_ROOT%\VC\vcvarsall.bat (
    echo Can not found vcvarsall.bat under %MSVC_ROOT%\VC directory.
    exit /b 1
)

setlocal
    call %MSVC_ROOT%\VC\vcvarsall.bat %TARGET_ARCH%
    call %*
endlocal
