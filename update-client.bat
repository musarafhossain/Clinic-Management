@echo off
echo ===== Updating CLIENT branch =====

git checkout main
git pull

git checkout client

:: Clean folder but keep .git, .gitignore, .bat, node_modules, .next
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

:: Restore ONLY tracked files from main/client (node_modules & .next won't be replaced)
git checkout main -- client

:: Move all client files and folders to root
robocopy client . /E /MOVE >nul

:: Remove out folder from client source
rmdir /s /q out 2>nul

git add .
git commit -m "Update client branch"
git push origin client

git checkout main

echo ===== CLIENT branch updated =====
