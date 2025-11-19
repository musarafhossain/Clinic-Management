@echo off
echo ===== Updating CLIENT branch =====

git checkout main
git pull

git checkout client

:: Clean folder but keep .git and all .bat files
for /f "delims=" %%i in ('dir /a /b') do (
    if /i not "%%i"==".git" (
        if /i not "%%~xi"==".bat" (
            rmdir /s /q "%%i" 2>nul
            del /f /q "%%i" 2>nul
        )
    )
)

git checkout main -- client

:: Move client files to root
move client\* . >nul

:: Remove the out folder from client source
rmdir /s /q client\out 2>nul

:: Delete leftover client folder
rmdir /s /q client

git add .
git commit -m "Update client branch"
git push origin client

echo ===== CLIENT branch updated =====
