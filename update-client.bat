@echo off
echo ========== Updating CLIENT branch (SAFE MODE) ==========

REM STEP 1 — Always start from main
git checkout main
git pull

REM STEP 2 — Create a temp folder
rmdir /s /q _client_temp 2>nul
mkdir _client_temp

REM STEP 3 — Copy ONLY the client folder into temp
robocopy client _client_temp /E >nul

REM STEP 4 — Switch to client branch
git checkout client

REM STEP 5 — Clean branch but keep .git and .bat files
for /f "delims=" %%i in ('dir /a /b') do (
    if /i not "%%i"==".git" (
        if /i not "%%~xi"==".bat" (
            rmdir /s /q "%%i" 2>nul
            del /f /q "%%i" 2>nul
        )
    )
)

REM STEP 6 — Move temp client folder content to repo root
robocopy _client_temp . /E /MOVE >nul

REM STEP 7 — Remove out folder
rmdir /s /q out 2>nul

REM STEP 8 — Delete temp
rmdir /s /q _client_temp 2>nul

REM STEP 9 — Commit changes
git add .
git commit -m "Update client branch"
git push origin client

REM STEP 10 — Go back to main
git checkout main

echo ========== CLIENT branch updated SAFELY ==========
