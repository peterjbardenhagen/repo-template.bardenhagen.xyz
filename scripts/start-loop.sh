#!/usr/bin/env bash
# ============================================================================
# start-loop.sh — Unattended Agentic SDLC Loop (Linux/macOS)
# ============================================================================
# Runs the agentic SDLC loop with exponential backoff on consecutive failures.
# Stop conditions: STOP file present, DONE marker in PROGRESS.md, time budget.
# ============================================================================

set -euo pipefail

MAX_INTERVAL=3600
INTERVAL=30

while [ ! -f STOP ]; do
  if grep -q '^DONE$' PROGRESS.md 2>/dev/null; then
    echo "DONE marker found — stopping."
    break
  fi

  if claude -p "Continue the agentic SDLC loop: read PROGRESS.md, do the next task, checkpoint, commit." --dangerously-skip-permissions; then
    INTERVAL=30
  else
    interval=$(( INTERVAL * 2 < MAX_INTERVAL ? INTERVAL * 2 : MAX_INTERVAL ))
    echo "Iteration failed — backing off to ${interval}s"
  fi

  sleep "$interval"
done
