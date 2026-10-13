# Local LLM Platforms: Foundry Local and Ollama

Local inference can reduce data movement and recurring inference cost, enable offline workflows and lower latency. It does **not** automatically make an application secure or compliant: model downloads, telemetry, logs, plugins, MCP tools, network endpoints and application data flows still need controls.

## Platform positioning

**Preferred enterprise default:** Microsoft Foundry for managed enterprise model and agent lifecycles where Azure governance, identity, evaluation, deployment and operations fit.

**Preferred Microsoft on-device option:** Microsoft Foundry Local for embedding supported small models into applications or running local inference on supported developer/end-user devices.

**Flexible local developer runtime:** Ollama for convenient model management, local model serving and experimentation across a broad range of model families.

Use a provider-neutral adapter so application logic does not become coupled to one inference endpoint.

| Need | Starting point | Key considerations |
|---|---|---|
| Enterprise-managed agents, evaluations, governance and cloud operations | Microsoft Foundry | Azure region, identity, data handling, model availability, quotas and costs |
| Embedded, on-device inference; offline use after model download | Foundry Local | Supported platforms/models, hardware acceleration, model licence and update lifecycle |
| Local development, model experimentation and a local API | Ollama | Model provenance/licence, host exposure, GPU/memory fit, updates and endpoint access |
| Mixed local/cloud fallback | Provider adapter with explicit policy | Never silently send sensitive content to a cloud fallback |

## Reference architecture

\`\`\`mermaid
flowchart TD
    App[Application / agent runtime] --> Policy[Data classification and routing policy]
    Policy -->|Enterprise-approved cloud workload| Foundry[Microsoft Foundry]
    Policy -->|On-device inference| FL[Foundry Local SDK / runtime]
    Policy -->|Local developer or self-hosted model| Ollama[Ollama local API]
    Policy -->|Not authorised| Block[Block or request approval]
    Foundry --> Eval[Shared evaluations and telemetry policy]
    FL --> Eval
    Ollama --> Eval
\`\`\`

## Microsoft Foundry Local

Foundry Local is a local inference runtime with SDKs for C#, JavaScript, Python and Rust, a curated model catalogue and hardware acceleration. It can run models offline after required model/runtime downloads are cached; no Azure subscription is required for the on-device product. Supported platforms, models and preview features can change, so check the official documentation.

### Install and explore

On supported Windows systems, the official CLI quick start documents:

\`\`\`powershell
winget install Microsoft.FoundryLocal
foundry --version
foundry model list
foundry model info phi-4-mini
foundry chat phi-4-mini
\`\`\`

On macOS with Apple silicon, follow the current Homebrew instructions in the official docs. For production application integration, prefer the SDK embedded in the application when it meets the requirement; use the optional REST server only when its additional endpoint/process boundary is needed.

### Foundry Local controls

- Download models and runtime components only from trusted sources; validate model identity, version, licence and integrity.
- Pin model versions for reproducibility; update through a tested release process.
- Restrict access to model caches and diagnostics; caches may contain proprietary model weights and usage artefacts.
- Keep prompts, retrieved documents and outputs out of telemetry unless necessary and approved.
- If the optional local REST server is enabled, bind it to loopback by default, firewall it, and add authentication/network controls before any non-local exposure.
- Evaluate model quality and safety on target hardware. Local models may differ in capability, context size and refusal behaviour from cloud models.

Official docs: [Foundry Local](https://learn.microsoft.com/en-us/azure/foundry-local/), [What is Foundry Local?](https://learn.microsoft.com/en-us/azure/foundry-local/what-is-foundry-local), [CLI quick start](https://learn.microsoft.com/en-us/azure/foundry-local/how-to/how-to-use-foundry-local-cli).

## Ollama

Ollama provides local model management and an HTTP API commonly available at localhost port 11434. The default local API is intended for local use; do not expose it directly to a LAN or the internet without a reviewed authentication and network boundary.

### Install and run

Use the official installer for your operating system, then choose a model whose licence, hardware requirements and quality fit the task. For example:

\`\`\`powershell
ollama --version
ollama list
ollama run qwen3
\`\`\`

The model name is illustrative; check the current library, hardware fit and licence before standardising on a model.

### Ollama controls

- Treat downloaded model tags and third-party model files as dependencies: review provenance, licence, digest/version and update history.
- Keep the API bound to localhost unless a secured service boundary is intentionally designed.
- Do not assume the local API authenticates callers. Apply host firewalling and process/user permissions; use a secured gateway for shared access.
- Avoid passing sensitive documents to model tools unless the user and policy authorise the data flow.
- Use explicit timeouts, payload limits, concurrency controls and resource budgets.
- Track model version, quantisation, runtime version and evaluation results alongside application changes.
- Test prompt injection, unsafe output, tool misuse and data leakage with synthetic data.

Official docs: [Ollama documentation](https://docs.ollama.com/), [API reference](https://docs.ollama.com/api).

## Common application interface

Implement a small adapter interface rather than embedding provider-specific calls throughout the codebase:

\`\`\`typescript
export type InferenceRequest = {
  messages: Array<{ role: "system" | "user" | "assistant"; content: string }>;
  model?: string;
  maxOutputTokens?: number;
  timeoutMs: number;
};

export type InferenceResponse = {
  text: string;
  provider: string;
  model: string;
  latencyMs: number;
};

export interface InferenceProvider {
  generate(request: InferenceRequest): Promise<InferenceResponse>;
}
\`\`\`

This is a design example, not a promise that every provider supports identical features. Add capability metadata for tool calling, streaming, structured output, multimodal input, context length and cancellation. Avoid silently downgrading safety controls or changing data residency when routing between providers.

## Model selection and evaluation

Compare models using representative tasks and the same evaluation set. Track:
- Task success, groundedness and factuality.
- Safety, refusal behaviour and prompt-injection resilience.
- Privacy and data residency of all inputs/outputs.
- Latency, throughput, memory/VRAM, CPU/GPU/NPU usage and offline behaviour.
- Total cost, including hardware, electricity, engineering and operations.
- Licence, distribution rights, commercial-use constraints and update policy.

## Fallback policy

\`\`\`mermaid
flowchart TD
    Req[Request and data classification] --> Route{Approved for cloud?}
    Route -- No --> Local{Approved local model available?}
    Local -- Yes --> RunLocal[Run local inference]
    Local -- No --> Hold[Decline or ask for authorised alternative]
    Route -- Yes --> Cloud[Use approved Foundry deployment]
    Cloud --> Fail{Cloud unavailable?}
    Fail -- No --> Return[Return result]
    Fail -- Yes --> Policy{Local fallback explicitly allowed?}
    Policy -- Yes --> RunLocal
    Policy -- No --> Hold
\`\`\`

Never implement a cloud fallback for sensitive data as a hidden retry. Make routing decisions auditable and explain relevant limitations to the user.
