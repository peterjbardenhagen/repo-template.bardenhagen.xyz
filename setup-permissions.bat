@echo off
echo Setting executable permissions for scripts...

bash -c "chmod +x scripts/commit-and-clean.sh scripts/open-repo.sh"

if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Scripts are now executable.
) else (
    echo [ERROR] Failed to set permissions. Make sure Git Bash is in your PATH.
)
pause