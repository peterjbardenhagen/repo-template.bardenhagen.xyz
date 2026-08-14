#!/usr/bin/env bash
# agent-loop-healthcheck.sh — Pre-iteration safety checks for unattended agent loops
# Usage: source this file or call it before each loop iteration
# Returns 0 if healthy, non-zero if the loop should abort.

set -euo pipefail

# 1. Check for STOP sentinel
if [ -f STOP ]; then
    echo "HEALTHCHECK FAILED: STOP sentinel found at repo root."
    exit 1
fi

# 2. Check for DONE marker
if [ -f PROGRESS.md ] && grep -q '^DONE$' PROGRESS.md 2>/dev/null; then
    echo "HEALTHCHECK PASSED: DONE marker found — loop should exit gracefully."
    exit 0
fi

# 3. Verify git working tree is clean (no uncommitted changes from prior iteration)
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "HEALTHCHECK FAILED: Uncommitted changes detected. Prior iteration did not clean up."
    echo "Run: git status"
    exit 2
fi

# 4. Verify main is reachable and up to date
if ! git rev-parse --abbrev-ref HEAD | grep -q '^main$'; then
    echo "HEALTHCHECK FAILED: Not on main branch."
    exit 3
fi

# 5. Verify CI is green on main (requires gh CLI and internet)
if command -v gh &> /dev/null; then
    ci_status=$(gh run list --branch main --status success --limit 1 --json status --jq '.[0].status' 2>/dev/null || echo "unknown")
    if [ "$ci_status" != "success" ]; then
        echo "HEALTHCHECK WARNING: Latest CI run on main is not successful (status: $ci_status)."
        echo "Consider pulling and inspecting before proceeding."
        # Non-fatal: warn but allow continuation so the agent can investigate
    fi
else
    echo "HEALTHCHECK SKIPPED: gh CLI not available — cannot verify CI status."
fi

# 6. Cost guard: check if a cost log exists and warn on spikes
if [ -f .agent-loop-costs.log ]; then
    median_cost=$(awk '{print $1}' .agent-loop-costs.log | sort -n | awk '{a[NR]=$1} END {print a[int(NR/2)]}')
    last_cost=$(tail -1 .agent-loop-costs.log | awk '{print $1}')
    if [ -n "$median_cost" ] && [ -n "$last_cost" ] && [ "$last_cost" -gt "$(( median_cost * 3 ))" ] 2>/dev/null; then
        echo "HEALTHCHECK WARNING: Last iteration cost ($last_cost) exceeds 3x rolling median ($median_cost)."
    fi
fi

echo "HEALTHCHECK PASSED: All pre-iteration checks succeeded."
exit 0
