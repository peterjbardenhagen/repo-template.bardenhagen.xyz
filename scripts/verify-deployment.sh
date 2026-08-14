#!/usr/bin/env bash
# verify-deployment.sh — Post-deployment health verification
# Usage: ./scripts/verify-deployment.sh [url]
# If no URL provided, reads from $VERCEL_URL or the most recent Vercel deployment.

set -euo pipefail

if [ $# -ge 1 ]; then
    DEPLOY_URL="$1"
elif [ -n "${VERCEL_URL:-}" ]; then
    DEPLOY_URL="$VERCEL_URL"
elif command -v vercel &> /dev/null && [ -n "${VERCEL_TOKEN:-}" ]; then
    DEPLOY_URL=$(vercel ls --prod --token="$VERCEL_TOKEN" 2>/dev/null | head -n 1 | awk '{print $2}')
else
    echo "ERROR: No deployment URL provided and Vercel CLI not available."
    exit 1
fi

if [ -z "${DEPLOY_URL:-}" ]; then
    echo "ERROR: Could not determine deployment URL."
    exit 1
fi

echo "Verifying deployment: $DEPLOY_URL"

# 1. HTTP status check
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$DEPLOY_URL")
if [ "$HTTP_STATUS" != "200" ]; then
    echo "FAILED: HTTP $HTTP_STATUS"
    exit 1
fi
echo "PASSED: HTTP 200"

# 2. Content sanity check (look for a known string in the response)
CONTENT=$(curl -s "$DEPLOY_URL")
if echo "$CONTENT" | grep -qi "repo-template"; then
    echo "PASSED: Expected content found"
else
    echo "WARNING: Expected content not found in response body"
fi

# 3. Security headers check
HEADERS=$(curl -s -I "$DEPLOY_URL")
if echo "$HEADERS" | grep -qi "x-content-type-options"; then
    echo "PASSED: Security headers present"
else
    echo "WARNING: Missing security headers (X-Content-Type-Options)"
fi

# 4. Core Web Vitals probe (requires Lighthouse CI or web-vitals)
if command -v lhci &> /dev/null; then
    echo "Running Lighthouse CI..."
    lhci collect --url="$DEPLOY_URL" --numberOfRuns=1 2>/dev/null || echo "WARNING: Lighthouse CI collection failed"
else
    echo "SKIPPED: lhci not installed"
fi

echo "Deployment verification complete."
