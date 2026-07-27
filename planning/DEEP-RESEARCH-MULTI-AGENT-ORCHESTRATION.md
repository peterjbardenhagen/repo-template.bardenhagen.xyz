# Deep Research — Multi-Agent Orchestration, AI Gateways & Next AgentsOS Iteration

**Date:** July 27, 2026
**Sources:** Sakana AI Conductor paper (ICLR 2026), academic surveys on multi-agent orchestration, 9router & OmniRoute gateway analysis
**Method:** Web search + direct page scraping via Firecrawl

---

## 1. Sakana AI Conductor — Key Findings

**Paper:** "Learning to Orchestrate Agents in Natural Language with the Conductor" (ICLR 2026, arXiv:2512.04388)

### 1.1 What It Is

A **7B parameter model trained via Reinforcement Learning** to orchestrate a pool of frontier models (GPT-5, Gemini, Claude, open-source). Instead of solving problems directly, the Conductor acts as a manager — writing natural language instructions that delegate tasks to other models.

### 1.2 Core Innovation

- **Orchestration as an RL problem**: Rather than prompt-engineering workflows by hand, the Conductor *learns* how to orchestrate through reward signals
- **Dynamic complexity adaptation**: Simple factual queries → single model query. Hard coding problems → autonomous pipeline of planners, coders, and verifiers
- **Self-selection as worker**: The Conductor can include itself in the team it builds. When it reads its own team's prior output and realizes failure, it spins up a corrective workflow on the fly
- **Natural language as the interface**: All orchestration happens through plain text instructions — no code, no config files, no DAG definitions

### 1.3 Key Results

- Outperforms Mixture-of-Agents at a fraction of compute cost
- The 7B Conductor + pool of frontier models beats single large models on complex tasks
- Learned orchestration patterns that no human engineer would have designed manually

### 1.4 Implications for AgentsOS

| Conductor Finding | AgentsOS Impact |
|-------------------|-----------------|
| RL can learn orchestration patterns | Our genetic engine evolves DAG structure, but doesn't learn *how to orchestrate* — it optimizes *what to execute* |
| Dynamic complexity scaling | Our planner always produces full DAGs. Conductor shows simple tasks should bypass the pipeline entirely |
| Self-selection as corrective worker | Our agents don't self-evaluate and retry. The conductor's self-awareness pattern is a gap |
| Natural language orchestration | Our orchestration is code-based (Planner → Scheduler → DAG). Conductor proves NL instructions can be more flexible |

**Bottom line:** The Conductor demonstrates that *learning to orchestrate* is more valuable than *learning to execute*. AgentsOS's genetic engine is closest to this philosophy but operates at the wrong abstraction level — it evolves DAG structure, not orchestration strategy.

---

## 2. Academic Landscape — Multi-Agent Orchestration

### 2.1 The Four Orchestration Patterns (from survey literature)

| Pattern | Description | Examples | AgentsOS Status |
|---------|-------------|----------|-----------------|
| **Centralized Router** | Single model picks which agent handles each task | Simple LLM router, 9router | ❌ Not implemented |
| **Hierarchical Manager** | Manager decomposes → delegates → aggregates | Sakana Conductor, HALO | ✅ MasterOrchestrator (static) |
| **Peer-to-Peer Negotiation** | Agents debate and vote on solutions | CrewAI discussions | ❌ Not implemented |
| **Evolutionary/Memetic** | Populations of solutions evolve via selection | AgentsOS GeneticEngine | ✅ Implemented + tenant-isolated |

### 2.2 Key Papers Referenced

| Paper | Key Idea | Relevance |
|-------|----------|-----------|
| **HALO** (Hou et al., 2025) | Hierarchical autonomous logic-oriented orchestration | Validates our MasterOrchestrator pattern |
| **Evolving Orchestration** (Dang et al., 2025) | Orchestration topology evolves alongside task execution | Directly validates our genetic engine approach |
| **Multi-Agent Fact Checking** (Lin et al., 2025) | Agents cross-verify each other's outputs | We lack output verification — gap |
| **Agentic LLM Survey** (Fu et al., 2024) | Comprehensive taxonomy of agent architectures | Confirms DAG + evolution is a recognized pattern |

### 2.3 The Gap Between Theory and Practice

The academic literature reveals a key insight: **most production multi-agent systems use rigid, human-designed workflows** (pattern 1 or 2). Only research prototypes explore patterns 3 and 4. AgentsOS is unusual in that it has pattern 4 (evolution) in production-ready code — but without the learning loop that would make it truly adaptive.

The Conductor paper shows the bridge: **RL-trained orchestration that learns from outcomes**, not just evolves structure.

---

## 3. AI Gateway Analysis — 9router vs OmniRoute

### 3.1 Feature Comparison

| Feature | 9router | OmniRoute | AgentsOS (native) |
|---------|---------|-----------|-------------------|
| **Provider Count** | 60+ | 290+ | ~10 (via ModelManager) |
| **Free Providers** | Some | 90+ | N/A (self-hosted) |
| **OpenAI Compat** | ✅ | ✅ | ❌ (custom API) |
| **Auto-Fallback** | 3-tier | 18 routing strategies | ❌ Manual config |
| **Token Saving** | RTK + Caveman (20-65%) | Auto-combo engine | ❌ None built-in |
| **MCP Support** | ✅ | 95 MCP tools | ✅ (MCP registry) |
| **A2A Protocol** | ❌ | ✅ | ❌ |
| **Cost Tracking** | ✅ | ✅ | ✅ (UsageMeter) |
| **Self-Hosted** | ✅ | ✅ | ✅ (core design) |
| **License** | Free | MIT | Open Core |
| **Stars/Adoption** | Growing | 30.6k GitHub stars | N/A |

### 3.2 What Gateways Do That We Don't

1. **Model routing by cost/latency**: 9router and OmniRoute automatically pick the cheapest/fastest provider that meets quality thresholds. AgentsOS delegates this to manual ModelManager config.

2. **Auto-fallback chains**: When a provider is down or rate-limited, gateways transparently switch. AgentsOS has no fallback logic — if the configured model fails, the task fails.

3. **Token optimization**: 9router's RTK (Real-Time Kernel) and Caveman modes save 20-65% tokens. OmniRoute's auto-combo engine merges prompts across providers. We have nothing equivalent.

4. **Multi-modal routing**: 9router supports Chat, Embeddings, TTS, STT, Image Gen, Vision, Video, Web Search through one endpoint. AgentsOS is text-only.

5. **Provider abstraction**: Gateways present one OpenAI-compatible endpoint regardless of backend. AgentsOS requires per-provider configuration.

### 3.3 What We Do That Gateways Don't

| AgentsOS Capability | Gateway Equivalent | Verdict |
|---------------------|-------------------|---------|
| DAG planning & execution | ❌ None | **Our moat** |
| Genetic evolution of plans | ❌ None | **Our moat** |
| Multi-tenant isolation | ❌ None | **Our moat** |
| Provenance ledger | ❌ None | **Our moat** |
| Business management (MyDesk) | ❌ None | **Our moat** |
| Governance / RBAC / audit | ❌ None | **Our moat** |
| Legal vertical agents | ❌ None | **Our moat** |

**Key insight:** Gateways are Layer 1 (model routing). AgentsOS is Layer 3 (orchestration + business logic). They're complementary, not competitive. We should *consume* gateway capabilities, not replicate them.

---

## 4. Gap Analysis — What We're Missing

### 4.1 Critical Gaps (vs Conductor + Gateways)

| Gap | Severity | Source | Effort to Close |
|-----|----------|--------|-----------------|
| **No learned orchestration** | High | Conductor paper | Medium — add RL feedback loop to genetic engine |
| **No model routing/fallback** | High | 9router/OmniRoute | Low — integrate 9router as model backend |
| **No dynamic complexity scaling** | Medium | Conductor paper | Low — add task complexity classifier |
| **No self-corrective workflows** | Medium | Conductor paper | Medium — add output verification agent |
| **No token optimization** | Medium | 9router Caveman | Low — 9router skill already exists |
| **No multi-modal support** | Low | 9router/OmniRoute | High — new agent types needed |
| **No A2A protocol** | Low | OmniRoute | Medium — new inter-agent communication |

### 4.2 Architectural Mismatch

The Conductor and gateways share a philosophy: **the intelligence is in the routing, not the execution**. Our current architecture puts intelligence in the execution (genetic engine evolves what to do, not how to route).

The missing piece: a **Learned Router** that sits between the Planner and the ModelManager, deciding:
- Which model/provider handles each task (cost + latency + quality)
- Whether a task needs the full pipeline or can be solved simply
- When to retry, escalate, or switch strategies

This is exactly what the Conductor does — and what 9router does at the infrastructure layer.

---

## 5. Recommended Next Iteration Scope

### 5.1 The Core Thesis

**AgentsOS should become a Conductor-like orchestrator that routes through gateway infrastructure, not a gateway that happens to have orchestration.**

The differentiation is clear:
- 9router/OmniRoute = model routing (Layer 1)
- AgentsOS = learned orchestration + business logic + governance (Layer 3)
- The gap = a learned routing layer that connects them

### 5.2 Phase 5 Scope — "Conductor Integration"

| Sprint | What | Why | Effort |
|--------|------|-----|--------|
| **S5.1: Smart Router** | Add a task-level model router that picks provider + model per task based on cost, latency, quality, and tenant policy | Conductor shows routing is where the intelligence lives. 9router provides the infrastructure. We need the decision layer. | 2 weeks |
| **S5.2: Dynamic Complexity** | Classify incoming tasks by complexity. Simple → single model. Medium → planner + executor. Hard → full DAG pipeline with verification. | Conductor's key insight: not every task needs the full pipeline. Saves cost + latency. | 1 week |
| **S5.3: Self-Corrective Loop** | After task execution, a verification agent checks output quality. If below threshold, trigger corrective workflow (retry, escalate, switch model). | Conductor's self-selection pattern. Catches failures before they propagate through the DAG. | 2 weeks |
| **S5.4: 9router Integration** | Replace direct ModelManager calls with 9router as the model backend. Gain auto-fallback, token optimization, 60+ providers. | Stop reinventing model routing. Use the gateway. Focus on orchestration. | 1 week |
| **S5.5: RL Feedback Loop** | Wire task completion signals (success/fail, quality score, cost, latency) back into the genetic engine as reward signals. Evolve routing strategies, not just DAG structure. | Conductor's core innovation: learn from outcomes. Our genetic engine already has the infrastructure — add the learning signal. | 2 weeks |

### 5.3 What We Stop Doing

| Stop | Reason |
|------|--------|
| Building more model adapters | 9router/OmniRoute already do this |
| Expanding provider count natively | Use the gateway |
| Manual fallback configuration | Gateway handles it |
| Static task-type-to-model mapping | Learned router replaces it |

### 5.4 What We Double Down On

| Keep | Why |
|------|-----|
| DAG evolution (genetic engine) | Proven moat, now enhanced with RL feedback |
| Tenant-isolated populations | Data governance + competitive moat |
| Provenance ledger | Regulatory requirement, no competitor has it |
| Legal vertical | Beachhead market, deep domain value |
| MyDesk business management | Nobody else does AI OS + business platform |

### 5.5 Competitive Positioning After Phase 5

| vs Competitor | Current Gap | After Phase 5 |
|---------------|-------------|---------------|
| **vs 9router** | We don't route models | We orchestrate *through* 9router |
| **vs OmniRoute** | We don't have 290+ providers | We use OmniRoute/9router as backend |
| **vs CrewAI** | No learned orchestration | RL-trained routing + evolution |
| **vs IBM watsonx** | Static workflows | Dynamic complexity adaptation |
| **vs Sakana Conductor** | 7B model vs our genetic engine | Complementary: Conductor = NL orchestration, AgentsOS = DAG evolution + business logic |

---

## 6. Implementation Notes

### 6.1 Smart Router Architecture

```
Task Input
    │
    ▼
┌─────────────────┐
│ Task Classifier  │ ← complexity, type, risk, tenant policy
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌────────┐ ┌────────────────┐
│ Simple │ │ Complex        │
│ Route  │ │ Route          │
└───┬────┘ └───────┬────────┘
    │              │
    ▼              ▼
┌────────┐ ┌────────────────┐
│ Single │ │ DAG Pipeline   │
│ Model  │ │ (Planner→      │
│ via    │ │  Executor→     │
│ 9router│ │  Verifier)     │
└────────┘ └────────────────┘
    │              │
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │ Feedback Loop │ → genetic engine + RL rewards
    └──────────────┘
```

### 6.2 Integration Points

- `control-plane/app/orchestrator/master_orchestrator.py` — add complexity classification before `plan_project`
- `control-plane/app/evolution/genetic_engine.py` — add RL reward signals from task completion
- New: `control-plane/app/orchestrator/smart_router.py` — task classification + model selection
- New: `control-plane/app/orchestrator/verifier.py` — output quality check + corrective trigger
- Config: 9router as model backend in `control-plane/app/core/config.py`

### 6.3 Risk Assessment

| Risk | Mitigation |
|------|------------|
| 9router availability | Fallback to direct ModelManager if gateway down |
| RL training instability | Start with bandit-style learning, not full RL |
| Over-routing (latency overhead) | Cache routing decisions, simple tasks bypass router |
| Tenant policy conflicts | Router respects tier quotas + data residency |

---

## 7. Summary

The research reveals a clear strategic opportunity:

1. **The Conductor proves** that learned orchestration outperforms hand-designed workflows — and AgentsOS's genetic engine is the closest production implementation to this philosophy

2. **9router/OmniRoute prove** that model routing is solved infrastructure — AgentsOS should consume, not replicate

3. **The gap** is a learned routing layer that sits between our orchestration engine and gateway infrastructure — deciding *how* to route, not just *where*

4. **Phase 5** closes this gap with 5 focused sprints: Smart Router, Dynamic Complexity, Self-Corrective Loop, 9router Integration, RL Feedback Loop

5. **The moat remains** our unique combination: DAG evolution + tenant isolation + provenance ledger + legal vertical + MyDesk business management — now enhanced with learned orchestration that gets smarter with every project

**Next move:** Implement S5.1 (Smart Router) as the foundation for all subsequent sprints.
