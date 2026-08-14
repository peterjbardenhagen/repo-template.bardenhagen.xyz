# Requires -Version 5.1
# ============================================================================
# start-loop.ps1 — Unattended Agentic SDLC Loop (Windows/PowerShell)
# ============================================================================
# Runs the agentic SDLC loop with exponential backoff on consecutive failures.
# Stop conditions: STOP file present, DONE marker in PROGRESS.md, time budget.
# Pre-iteration health checks verify repo state before each agent run.
# ============================================================================

param(
    [int]$MaxIntervalSeconds = 3600,
    [int]$InitialIntervalSeconds = 30
)

$interval = $InitialIntervalSeconds
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

while (-not (Test-Path "STOP")) {
    if (Select-String -Path "PROGRESS.md" -Pattern "^DONE$" -Quiet -ErrorAction SilentlyContinue) {
        Write-Host "DONE marker found — stopping."
        break
    }

    # Run pre-iteration health checks (bash must be available; use WSL/Git Bash if needed)
    $healthcheck = Join-Path $scriptDir "agent-loop-healthcheck.sh"
    if (Test-Path $healthcheck) {
        $hcResult = bash $healthcheck 2>&1
        $hcExit = $LASTEXITCODE
        Write-Host $hcResult
        if ($hcExit -eq 1) {
            Write-Host "STOP sentinel detected — halting loop."
            break
        } elseif ($hcExit -eq 2) {
            Write-Host "Uncommitted changes detected. Attempting to stash..."
            git stash push -m "auto-stash by start-loop $(Get-Date -Format o)" 2>&1 | Out-Null
        } elseif ($hcExit -eq 3) {
            Write-Host "Not on main branch. Attempting to checkout main..."
            git checkout main 2>&1 | Out-Null
        } elseif ($hcExit -ne 0) {
            Write-Host "Healthcheck warning (exit $hcExit) — proceeding with caution."
        }
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
