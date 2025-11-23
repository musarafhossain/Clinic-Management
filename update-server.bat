@echo off
echo ===== Updating SERVER branch =====

git checkout main
git pull

git checkout server

:: Clean folder but keep .git, .gitignore, node_modules, .next, and all .bat files
for /f "delims=" %%i in ('dir /a /b') do (
    if /i not "%%i"==".git" (
        if /i not "%%i"==".gitignore" (
            if /i not "%%i"=="node_modules" (
                if /i not "%%i"==".next" (
                    if /i not "%%~xi"==".bat" (
                        echo Deleting %%i
                        rmdir /s /q "%%i" 2>nul
                        del /f /q "%%i" 2>nul
                    )
                )
            )
        )
    )
)

:: Restore ONLY tracked server folder from main branch
git checkout main -- server

:: Move all server files and folders to root
robocopy server . /E /MOVE >nul

git add .
git commit -m "Update server branch"
git push origin server

git checkout main

echo ===== SERVER branch updated =====
