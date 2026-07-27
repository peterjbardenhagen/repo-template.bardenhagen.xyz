# Claude Capabilities Reference

This document maps enterprise AI capabilities (BytePlus ModelArk) to Claude implementation patterns available in this template.

## Model Capabilities

| Capability | Claude Implementation | Status | Notes |
|---|---|---|---|
| **Text Generation** | Messages API, Responses API | ✓ Native | Core foundation for all text tasks |
| **Multi-modal Understanding** | Vision API (Images, PDFs, Videos) | ✓ Native | `vision` parameter in messages; Files API for preprocessing |
| **Image Understanding** | Vision API | ✓ Native | Direct image/screenshot analysis |
| **Video Understanding** | Files API + Vision | ✓ Native | Upload via Files API, then reference in messages |
| **Document Understanding** | Files API (PDFs) | ✓ Native | PDF parsing + structured output |
| **Audio Understanding** | Files API (transcription) | 🔄 Via partner | Use external transcription, then feed text to Claude |
| **Image Generation** | External integration (DALL-E, etc.) | 🔄 Tool-based | Invoke via function calling / MCP |
| **Video Generation** | External integration (Runway, etc.) | 🔄 Tool-based | Invoke via function calling / MCP |

## Advanced Features

| Feature | Claude Implementation | Status | Config |
|---|---|---|---|
| **Deep Reasoning** | Extended thinking | ✓ Native | `budget_tokens` param (40k-100k) |
| **Tool Use** | Function calling + MCP | ✓ Native | `.claude/agents/`, `.claude/skills/` |
| **Cloud-Deployed MCP** | MCP servers | ✓ Native | Managed Agents, remote MCP via `mcp_servers` config |
| **Structured Output** | JSON mode + schemas | ✓ Native | Pass `json_schema` to tool definitions |
| **Context Caching** | Prompt caching | ✓ Native | `cache_control: {"type": "ephemeral"}` on messages |
| **Batch Inference** | Batch API | ✓ Native | Queue requests, lower cost, eventual consistency |
| **Streaming Output** | Server-sent events (SSE) | ✓ Native | `stream: true` in API calls |
| **Prefill-based Response** | `system` role + priming | ✓ Native | Set assistant message prefix to guide output |
| **Visual Grounding** | Vision + JSON + coordinate math | ✓ Native | Return bounding boxes / coordinates in structured output |
| **Web Search** | MCP integration + Firecrawl | ✓ via MCP | Use web search MCP or Firecrawl skill |
| **Embeddings** | API endpoint | ✓ Native | Use via Claude SDK or external service |
| **Managed Agents** | Delegated agent sessions | ✓ Native | BytePlus ModelArk Managed Agents API |
| **Context Management** | System prompts + memory | ✓ Native | CLAUDE.md, persistent memory, context windows |

## Local Configuration

**Extended Thinking (Deep Reasoning):**
```json
{
  "thinking": {
    "type": "enabled",
    "budget_tokens": 50000
  }
}
```

**Structured Output:**
```python
response = client.messages.create(
  model="claude-3-5-sonnet",
  max_tokens=1024,
  tools=[{
    "name": "extract_data",
    "input_schema": {
      "type": "object",
      "properties": {
        "field": {"type": "string"}
      },
      "required": ["field"]
    }
  }]
)
```

**Context Caching:**
```python
response = client.messages.create(
  system=[
    {"type": "text", "text": "You are helpful assistant"},
    {
      "type": "text",
      "text": cached_context,
      "cache_control": {"type": "ephemeral"}
    }
  ]
)
```

**Vision (Multi-modal Understanding):**
```python
response = client.messages.create(
  model="claude-3-5-sonnet",
  messages=[{
    "role": "user",
    "content": [
      {"type": "text", "text": "What's in this image?"},
      {
        "type": "image",
        "source": {
          "type": "url",
          "url": "https://..."
        }
      }
    ]
  }]
)
```

**Tool Use (Function Calling):**
- See `.claude/agents/` and `.claude/skills/` for pattern
- Use MCP for cloud-deployed integrations
- Firecrawl skill for web search / scraping

**Batch API (Lower Cost):**
```python
client.beta.messages.batches.create(
  requests=[
    {"custom_id": "id1", "params": {...}},
    {"custom_id": "id2", "params": {...}}
  ]
)
```

## Agent Capabilities (Managed Agents)

Claude Code + Managed Agents enable:
- Autonomous task delegation
- Persistent agent memory
- File uploads / mounting
- Multi-agent workflows
- Session-based reasoning

See `.claude/agents/` for role-based subagent definitions.

## Missing Capabilities

| Feature | Workaround | Notes |
|---|---|---|
| Native audio generation | External tool (ElevenLabs, etc.) | Use MCP / function calling to invoke |
| Real-time streaming control | Server-side chunking | Streaming API returns partial responses |
| Direct video generation | External integration (Runway, Synthesia) | Invoke via tool use |

## Quick Links

- [Anthropic Docs](https://docs.anthropic.com) — official Claude API reference
- [Files API](https://docs.anthropic.com/en/docs/build-a-system/files) — upload videos, PDFs, images for preprocessing
- [Vision](https://docs.anthropic.com/en/docs/vision) — multi-modal understanding
- [Extended Thinking](https://docs.anthropic.com/en/docs/build-a-system/extended-thinking) — deep reasoning
- [Structured Output](https://docs.anthropic.com/en/docs/build-a-system/structured-output) — JSON schemas
- [Prompt Caching](https://docs.anthropic.com/en/docs/build-a-system/prompt-caching) — reduce costs for repeated context
- [Batch API](https://docs.anthropic.com/en/docs/build-a-system/batch-processing) — async processing for cost savings
- [Tool Use](https://docs.anthropic.com/en/docs/build-a-system/tool-use) — function calling
- [MCP (Model Context Protocol)](https://modelcontextprotocol.io) — integrate external tools and services

## Claude Code Specific

- **Ponytail** (`/ponytail full`) — code generation optimizer (54% LOC reduction)
- **Caveman** (`/caveman full`) — terse output mode
- **Agents** (`.claude/agents/`) — specialized subagents for reviews, exploration, architecture
- **Skills** (`.claude/skills/`) — reusable workflows (Firecrawl, web search, design reviews, etc.)
- **MCP Servers** (`.claude/settings.json`) — connect external APIs and tools

## Equivalent Capabilities by Use Case

| Use Case | BytePlus | Claude | Setup |
|---|---|---|---|
| Chat with documents | Document understanding | Files API + Vision | Upload PDF via Files API |
| Web search | Web search API | MCP web search plugin | Install via MCP marketplace |
| Image analysis | Image understanding | Vision API | Pass image URL or base64 |
| Extract structured data | Structured output | JSON mode + schema | Define JSON schema in tool |
| Long reasoning tasks | Deep reasoning | Extended thinking | Set `budget_tokens` |
| Cost optimization | Context caching | Prompt caching | Use `cache_control` headers |
| Background processing | Batch inference | Batch API | Queue requests asynchronously |
| Custom tools | Cloud-deployed MCP | Local/remote MCP | Define via `.claude/agents/` |

