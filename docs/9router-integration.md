# 9router Configuration and Integration Guide

This document explains how to set up and use 9router with Hermes, Omniroute, and the repo-template.

## Summary

9router is a versatile AI gateway that provides OpenAI-compatible RESTful endpoints for accessing various AI capabilities. This guide covers:

1. **Basic Setup** - Installing and configuring 9router
2. **Creating API Keys** - Setting up authentication credentials
3. **Understanding API Endpoints** - How to interact with 9router's RESTful API
4. **Integrating with Hermes Profiles** - Connecting 9router to our AI agent system
5. **Using 9router Skills** - How to utilize the pre-built capabilities

## Quick Start Configuration

### 1. Install 9router

#### Option A: Node.js (npm)
```bash
cd ~/Desktop && mkdir -p 9router && cd 9router
npm init -y
npm install @9router/9router-server
```

#### Option B: Binary Installation
Download the latest release:
- [GitHub Releases](https://github.com/decolua/9router/releases)
- Or use npm globally: `npm install -g @9router/9router-server`

#### Option C: Docker
```bash
docker pull decolua/9router-server:latest
docker run -d -p 20128:20128 -e NINEROUTER_PORT=20128 decolua/9router-server
```

### 2. Create API Key

Visit the [9router Dashboard](https://9router.com) to create credentials:

1. Login with your account (Google, GitHub, or email)
2. Go to Dashboard → Keys
3. Create new key with a name like "repo-template"
4. Copy the generated **Bearer Token**

### 3. Configure Environment Variables

```bash
# Local development
echo 'NINEROUTER_URL="http://localhost:20128"' >> ~/.hermes/.env
echo 'NINEROUTER_KEY="sk-..."' >> ~/.hermes/.env

# OR directly in config.yaml
hermes config set model.base_url "http://localhost:20128"
hermes config set model.provider "openai"
hermes config show
```

### 4. Verify Setup

```bash
curl $NINEROUTER_URL/api/health
# Should return: {"ok":true}
```

## API Endpoints Overview

All requests use:
- Base URL: `${NINEROUTER_URL}/v1`
- Authentication: `Authorization: Bearer ${NINEROUTER_KEY}`
- Content-Type: `application/json`

### Key Endpoints

| Endpoint | Purpose | Example |
|----------|---------|---------|
| `/models` | List available models | `curl $NINEROUTER_URL/v1/models` |
| `/chat/completions` | Chat interactions | `curl -X POST ... -d '{"model":"tavily","query":"test"}'` |
| `/assessments` | Billing and usage tracking | `curl $NINEROUTER_URL/v1/assessments` |
| `/search` | Web search | See `skills/9router-web-search/SKILL.md` |

## Integrating with Hermes Profiles

### For Default Profile
1. Update `.hermes/profiles/default-profile.json`
2. Add `"9router-setup": true` to skills list if needed
3. Ensure `@9router/9router-server` is in dependencies

### For OmniRoute Profile
1. Update `omniroute-profile.json` 
2. Add 9router skill references in skills_inclusion
3. Specify provider configuration in `profiles` section

## Hermes Profile Updates

I've updated the repository structure to include 9router skills:

1. **Created `.hermes/profiles/default-profile.json`** - Added 9router integration
2. **Created `.hermes/profiles/omniroute-profile.json`** - Added extended integration
3. **Updated `docs/software-development-environments.md`** - Added 9router setup section

## Support Matrix

| Agent | Integration Level | File Location | Notes |
|-------|-------------------|---------------|-------|
| **default** | ✅ Basic | `.hermes/profiles/default-profile.json` | Core integration |
| **omniroute** | 🚀 Extended | `.hermes/profiles/omniroute-profile.json` | Full 9router capabilities |
| **researcher** | 🔍 Detailed | `docs/research/ai-routing.md` | Has 9router research capabilities |

## Next Steps

1. [ ] Verify 9router service is running and responding to `curl $NINEROUTER_URL/api/health`
2. [ ] Confirm all API endpoints are working correctly
3. [ ] Test with various providers (tavily, brave-search, etc.)
4. [ ] Document usage patterns for your team

---

**Need help with any specific part of the integration?** Would you like me to add any additional configuration files, documentation sections, or setup scripts?