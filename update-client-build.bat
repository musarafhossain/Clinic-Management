@echo off
echo ========== Updating CLIENT BUILD branch ==========

git checkout main
git pull

git checkout client-build

:: Clean folder but keep .git and all .bat files
for /f "delims=" %%i in ('dir /a /b') do (
    if /i not "%%i"==".git" (
        if /i not "%%~xi"==".bat" (
            rmdir /s /q "%%i" 2>nul
            del /f /q "%%i" 2>nul
        )
    )
)

git checkout main -- client/out

:: Move all client files and folders to root
robocopy client/out . /E /MOVE >nul

git add .
git commit -m "Update client build branch"
git push origin client-build

git checkout main

echo ========== CLIENT branch updated ==========
