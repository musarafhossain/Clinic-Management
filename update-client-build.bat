@echo off
echo ===== Updating CLIENT BUILD branch =====

git checkout main
git pull

git checkout client-build

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

:: Copy ONLY the tracked build folder from main branch
git checkout main -- client/out

:: Move build files to root
robocopy client/out . /E /MOVE >nul

:: Remove the emptied client folder
rmdir /s /q client 2>nul

git add .
git commit -m "Update client build branch"
git push origin client-build

git checkout main

echo ===== CLIENT BUILD branch updated =====
