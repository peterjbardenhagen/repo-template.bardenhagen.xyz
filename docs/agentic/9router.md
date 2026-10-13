# AI Gateway Integration

This document explains how to configure an AI gateway (such as 9Router, LiteLLM, or a custom proxy) with your project's AI tooling.

## Summary

An AI gateway provides OpenAI-compatible RESTful endpoints for accessing various AI capabilities. This guide covers:

1. **Basic Setup** — Installing and configuring the gateway
2. **Creating API Keys** — Setting up authentication credentials
3. **Understanding API Endpoints** — How to interact with the gateway
4. **Integrating with Agent Profiles** — Connecting the gateway to your AI agent system
5. **Using Gateway Skills** — How to utilise pre-built capabilities

## Quick Start Configuration

### 1. Install the Gateway

```bash
# Run the setup script provided by your gateway
./scripts/setup-gateway.sh

# Or manual installation (example for 9Router)
npm install -g 9router
```

### 2. Create API Key

Visit the gateway dashboard to create credentials after starting the service.

### 3. Configure Environment Variables

```bash
export GATEWAY_URL="http://localhost:20128"
export GATEWAY_KEY="sk-..."  # From dashboard
```

### 4. Verify Setup

```bash
curl $GATEWAY_URL/api/health
# Should return: {"ok":true}
```

## Token Optimisation

Tool outputs (git diff, grep, find, ls, tree, log dumps...) often consume a large portion of your prompt budget. A token saver detects them and applies smart, lossless compression before the request hits the LLM:

- **Auto-detect:** No config needed — the saver peeks at tool output and picks the right filter
- **Safe by design:** If a filter fails, the original text is preserved
- **Universal:** Works across all formats (OpenAI, Claude, Gemini, etc.)
- **Default ON:** Toggle in the gateway dashboard

## Code Generation Optimiser

Injects a "lazy senior dev" system prompt into every request:

- **Lite:** Build what's asked, name the lazier alternative
- **Full:** YAGNI ladder enforced: stdlib → native → existing deps → one-liner → minimal code
- **Ultra:** YAGNI extremist: deletion first, ship the one-liner

Never trades away: input validation, error handling, security, accessibility
