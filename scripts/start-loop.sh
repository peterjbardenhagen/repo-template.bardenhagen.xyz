#!/usr/bin/env bash
# ============================================================================
# start-loop.sh — Unattended Agentic SDLC Loop (Linux/macOS)
# ============================================================================
# Runs the agentic SDLC loop with exponential backoff on consecutive failures.
# Stop conditions: STOP file present, DONE marker in PROGRESS.md, time budget.
# Pre-iteration health checks verify repo state before each agent run.
# ============================================================================

set -euo pipefail

MAX_INTERVAL=3600
INTERVAL=30
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while [ ! -f STOP ]; do
  if grep -q '^DONE$' PROGRESS.md 2>/dev/null; then
    echo "DONE marker found — stopping."
    break
  fi

  # Run pre-iteration health checks
  if [ -f "$SCRIPT_DIR/agent-loop-healthcheck.sh" ]; then
    if ! bash "$SCRIPT_DIR/agent-loop-healthcheck.sh"; then
      HEALTHCHECK_EXIT=$?
      if [ $HEALTHCHECK_EXIT -eq 1 ]; then
        echo "STOP sentinel detected — halting loop."
        break
      elif [ $HEALTHCHECK_EXIT -eq 2 ]; then
        echo "Uncommitted changes detected. Attempting to stash and continue..."
        git stash push -m "auto-stash by start-loop $(date -u +%Y-%m-%dT%H:%M:%SZ)" || true
      elif [ $HEALTHCHECK_EXIT -eq 3 ]; then
        echo "Not on main branch. Attempting to checkout main..."
        git checkout main || true
      else
        echo "Healthcheck warning (exit $HEALTHCHECK_EXIT) — proceeding with caution."
      fi
    fi
  fi

  if claude -p "Continue the agentic SDLC loop: read PROGRESS.md, do the next task, checkpoint, commit." --dangerously-skip-permissions; then
    INTERVAL=30
  else
    interval=$(( INTERVAL * 2 < MAX_INTERVAL ? INTERVAL * 2 : MAX_INTERVAL ))
    echo "Iteration failed — backing off to ${interval}s"
  fi

  sleep "$interval"
done
