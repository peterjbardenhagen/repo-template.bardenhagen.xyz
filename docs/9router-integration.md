# 9Router Configuration and Integration Guide

This document explains how to set up and use 9router with Hermes, Omniroute, and the repo-template.

## Summary

9router is a versatile AI gateway that provides OpenAI-compatible RESTful endpoints for accessing various AI capabilities. This guide covers:

1. **Basic Setup** - Installing and configuring 9router
2. **Creating API Keys** - Setting up authentication credentials
3. **Understanding API Endpoints** - How to interact with 9router's RESTful API
4. **Integrating with Hermes Profiles** - Connecting 9router to our AI agent system
5. **Using 9router Skills** - How to utilize the pre-built capabilities

## Quick Start Configuration

### 1. Install 9Router

```powershell
# Run the setup script
.\scripts\setup-9router.ps1

# Or manual installation
npm install -g 9router
```

### 2. Create API Key

Visit the [9router Dashboard](https://9router.com) to create credentials after starting the service.

### 3. Configure Environment Variables

```powershell
$env:NINEROUTER_URL = "http://localhost:20128"
$env:NINEROUTER_KEY = "sk-..."  # From dashboard
```

### 4. Verify Setup

```powershell
curl $env:NINEROUTER_URL/api/health
# Should return: {"ok":true}
```

## 🚀 Feature Details

### RTK Token Saver

Tool outputs (git diff, grep, find, ls, tree, log dumps...) often eat 30-50% of your prompt budget. RTK detects them and applies smart, lossless compression before the request hits the LLM:

**Filters:** git-diff, git-status, grep, find, ls, tree, dedup-log, smart-truncate, read-numbered, search-list

- **Auto-detect:** No config needed — RTK peeks the first 1KB of each tool_result and picks the right filter
- **Safe by design:** If a filter fails, throws, or makes output bigger, RTK silently keeps the original text
- **Universal:** Works across all formats (OpenAI, Claude, Gemini, Cursor, Kiro, OpenAI Responses)
- **Default ON:** Toggle anytime in Dashboard → Endpoint settings

**Result:** 47K tokens → 28K tokens (40% saved)

### 🧠 Headroom Token Saver (Optional)

Headroom runs separately. 9Router calls Headroom's local `/v1/compress` endpoint:

```bash
pip install "headroom-ai[proxy]"
headroom proxy --port 8787
```

Enable in Dashboard → Endpoint → Token Saver → Headroom

### 🐴 Ponytail (Lazy Senior Dev)

Injects a "lazy senior dev" system prompt into every request:

- **Lite:** Build what's asked, name the lazier alternative
- **Full:** YAGNI ladder enforced: stdlib → native → existing deps → one-liner → minimal code
- **Ultra:** YAGNI extremist: deletion first, ship the one-liner

Never trades away: input validation, error handling, security, accessibility

### 🎯 Smart 3-Tier Fallback

Create combos with automatic fallback:

```
Combo: "my-coding-stack"
  1. cc/claude-opus-4-6        (your subscription)
  2. glm/glm-4.7               (cheap backup, $0.6/1M)
  3. if/kimi-k2-thinking       (free fallback)
```

## Pricing at a Glance

| Tier | Provider | Cost | Quota Reset | Best For |
|------|----------|------|-------------|----------|
| 🚀 TOKEN SAVER | RTK (built-in) | FREE | Always on | Save 20-40% tokens on EVERY request |
| 💳 SUBSCRIPTION | Claude Code | $20-200/mo | 5h + weekly | Already subscribed |
| | Codex | $20-200/mo | 5h + weekly | OpenAI users |
| | GitHub Copilot | $10-19/mo | Monthly | GitHub users |
| | Cursor IDE | $20/mo | Monthly | Cursor users |
| 💰 CHEAP | GLM-5.1 / GLM-4.7 | $0.6/1M | Daily | Budget backup |
| | MiniMax M2.7 | $0.2/1M | 5-hour rolling | Cheapest option |
| | Kimi K2.5 | $9/mo flat | 10M tokens/mo | Predictable cost |
| 🆓 FREE | Kiro AI | $0 | 50 credits/mo | Claude 4.5 + GLM-5 + MiniMax free |
| | OpenCode Free | $0 | Varies* | No auth, auto-fetch models |
| | Vertex AI | $300 credits | New GCP accounts | Gemini 3 Pro + DeepSeek + GLM-5 |

**Pro Tip:** RTK + Kiro AI + OpenCode Free combo = $0 cost + 20-40% token savings!

## API Endpoints Overview

All requests use:
- Base URL: `${NINEROUTER_URL}/v1`
- Authentication: `Authorization: Bearer ${NINEROUTER_KEY}`
- Content-Type: `application/json`

### Key Endpoints

| Endpoint | Purpose | Example |
|----------|---------|---------|
| `/models` | List available models | `curl $NINEROUTER_URL/v1/models` |
| `/chat/completions` | Chat interactions | See API Reference below |
| `/search` | Web search | See `skills/9router-web-search/SKILL.md` |
| `/assessments` | Billing and usage tracking | `curl $NINEROUTER_URL/v1/assessments` |

## Chat Completions API

```bash
curl -X POST http://localhost:20128/v1/chat/completions \
  -H "Authorization: Bearer $NINEROUTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "cc/claude-opus-4-6",
    "messages": [{"role": "user", "content": "Write a function to..."}],
    "stream": true
  }'
```

## Use Cases

### Case 1: "I have Claude Pro subscription"

```
Combo: "maximize-claude"
  1. cc/claude-opus-4-7        (use subscription fully)
  2. glm/glm-5.1               (cheap backup)
  3. kr/claude-sonnet-4.5      (free emergency fallback)
```

### Case 2: "I want zero cost"

```
Combo: "free-forever"
  1. kr/claude-sonnet-4.5      (Claude 4.5 free via Kiro)
  2. kr/glm-5                  (GLM-5 free via Kiro)
  3. oc/<auto>                 (OpenCode Free, no auth)
```

### Case 3: "I need 24/7 coding, no interruptions"

```
Combo: "always-on"
  1. cc/claude-opus-4-7        (best quality)
  2. cx/gpt-5.5                (second subscription)
  3. glm/glm-5.1               (cheap, resets daily)
  4. minimax/MiniMax-M2.7      (cheapest, 5h reset)
  5. kr/claude-sonnet-4.5      (free via Kiro)
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Provider quota exhausted | Use combo fallback or switch to cheaper tier |
| Rate limiting | Add combo with GLM/MiniMax fallback |
| OAuth token expired | Auto-refreshed by 9Router; reconnect if issues persist |
| High costs | Enable RTK in Dashboard → Endpoint settings |
| Dashboard wrong port | Set PORT=20128 and NEXT_PUBLIC_BASE_URL |

## Integrating with Hermes Profiles

Profiles are automatically updated:

| Agent | Integration Level | File Location |
|-------|-------------------|---------------|
| **default** | ✅ Basic | `.hermes/profiles/default-profile.json` |
| **omniroute** | 🚀 Extended | `.hermes/profiles/omniroute-profile.json` |

## Next Steps

1. Run `.\scripts\setup-9router.ps1`
2. Start 9Router: `cd ~/.ai-infrastructure/9router-source && npm run dev`
3. Open http://localhost:20128/dashboard
4. Configure AI tools to use: `http://localhost:20128/v1` with API key