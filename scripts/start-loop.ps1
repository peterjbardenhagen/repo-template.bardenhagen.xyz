# Requires -Version 5.1
# ============================================================================
# start-loop.ps1 — Unattended Agentic SDLC Loop (Windows/PowerShell)
# ============================================================================
# Runs the agentic SDLC loop with exponential backoff on consecutive failures.
# Stop conditions: STOP file present, DONE marker in PROGRESS.md, time budget.
# ============================================================================

param(
    [int]$MaxIntervalSeconds = 3600,
    [int]$InitialIntervalSeconds = 30
)

$interval = $InitialIntervalSeconds
while (-not (Test-Path "STOP")) {
    if (Select-String -Path "PROGRESS.md" -Pattern "^DONE$" -Quiet -ErrorAction SilentlyContinue) {
        Write-Host "DONE marker found — stopping."
        break
    }

    claude -p "Continue the agentic SDLC loop: read PROGRESS.md, do the next task, checkpoint, commit." --dangerously-skip-permissions
    if ($LASTEXITCODE -eq 0) {
        $interval = $InitialIntervalSeconds
    } else {
        $interval = [Math]::Min($interval * 2, $MaxIntervalSeconds)
        Write-Host "Iteration failed — backing off to ${interval}s"
    }

    Start-Sleep -Seconds $interval
}
