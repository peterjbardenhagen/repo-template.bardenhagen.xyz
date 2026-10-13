# Enterprise AI platforms

How projects built from this template should use the enterprise AI clouds: **Microsoft Foundry on Azure**, **Amazon Bedrock on AWS**, and **Vertex AI / Gemini on Google Cloud** (with Google AI Studio for prototyping). Anthropic's Claude is available on all three, and the same principles apply to every provider.

Last reviewed: 14 October 2026.

## Principles for every provider

1. **One gateway in front of every model.** Route all model calls through one internal interface, such as an AI router, LiteLLM or the provider's own AI gateway. Application code then never names a vendor SDK directly, and you can switch models, regions or providers without a rewrite.
2. **No long-lived keys.** Use workload identity: Azure Managed Identity / Entra ID, AWS IAM roles (OIDC from CI), Google Workload Identity Federation. Where a key is unavoidable, keep it in the secret store (Key Vault, Secrets Manager, Secret Manager or Doppler) with rotation and an expiry alert.
3. **Private by default.** Use private endpoints / PrivateLink / Private Service Connect for model traffic in production. Keep data in the region your contracts require, and pin the inference region explicitly.
4. **Guardrails on input and output.** Use the platform's content-safety layer (Azure AI Content Safety and Prompt Shields, Bedrock Guardrails, Vertex AI safety filters / Model Armor), plus your own allow-lists for tools. Treat retrieved documents and tool output as untrusted input (prompt injection).
5. **Evaluate before you ship and keep evaluating.** Every prompt, model or agent change runs an offline eval set in CI (quality, groundedness, safety, cost and latency), followed by a canary in production with tracing. Use the platform evaluation services (Foundry evaluations, Bedrock model evaluation, Vertex AI evaluation) or your own harness, and store the results with the release.
6. **Trace everything.** Use OpenTelemetry GenAI semantic conventions for model and tool spans, with prompts and responses redacted for personal data, plus token and cost metrics per feature, per tenant and per agent. Alert on cost spikes, error and refusal rates, and loop detection.
7. **Budget and quota as code.** Declare model deployments, quotas (TPM/RPM, provisioned throughput) and budgets in infrastructure as code (Bicep/Terraform, CDK/CloudFormation, Terraform). Never click-ops a production deployment.
8. **Human approval for consequential actions.** Agents may draft, but anything that spends money, sends external communications, changes production or touches personal data waits for an approval step.
9. **Pick the smallest model that meets the bar.** Measure against your eval set, then try a smaller or cheaper model, prompt caching and batch APIs before scaling up.

## Microsoft Foundry (Azure)

- Use a **Foundry project** per application and environment, with RBAC through Entra ID groups and Managed Identity for the app. No API keys in app settings.
- Deploy models (Azure OpenAI, Claude, open-weight models) from the Foundry model catalogue. Choose **Global**, **Data Zone** or **Regional** deployment types deliberately to meet data-residency needs.
- Build agents with **Foundry Agent Service**. Connect tools through managed connections and MCP, and ground them with Azure AI Search or Foundry IQ knowledge indexes.
- Turn on **Content Safety** and Prompt Shields, and attach evaluations and continuous monitoring to every agent.
- Use **azd** templates or Bicep for repeatable environments. Put APIM / AI Gateway in front for quotas, token limits and logging.
- Installed skill: `microsoft-foundry` covers deploy, evaluate, fine-tune, quota and RBAC tasks.

## Amazon Bedrock (AWS)

- Call models through **Bedrock** with an IAM role scoped to specific model ARNs; use **inference profiles** for cross-region routing and capacity.
- Use **Bedrock Guardrails** (content filters, denied topics, PII redaction, contextual grounding) on every invocation that faces end users.
- Build agents with **Bedrock AgentCore** / Agents for Bedrock and **Knowledge Bases** for RAG. Keep the action-group Lambdas least-privilege.
- Use VPC endpoints (PrivateLink), CloudTrail for API audit, model invocation logging to S3/CloudWatch with KMS encryption.
- Use provisioned throughput only after measurement, and use batch inference for offline workloads.

## Google Cloud: Vertex AI, Gemini and AI Studio

- **Google AI Studio** with a Gemini API key is for prototyping only. Production runs on **Vertex AI**, which provides IAM, VPC-SC, CMEK, data residency and enterprise terms.
- Use the Gen AI SDK against Vertex with **Workload Identity Federation**. Use the global endpoint unless residency requires a region.
- Build agents with the **Agent Development Kit (ADK)** and deploy them to **Vertex AI Agent Engine**. Ground them with Vertex AI Search / RAG Engine.
- Protect them with **Model Armor** and safety settings, and use **VPC Service Controls** around AI APIs that handle sensitive data.
- Use context caching and batch prediction to control cost, and Vertex AI evaluation service for quality gates.

## Choosing between them

| Need | Lean towards |
|---|---|
| Microsoft 365 / Entra-centric enterprise, Copilot extensibility | Microsoft Foundry |
| AWS-native estate, strict IAM/VPC patterns, broad model choice | Amazon Bedrock |
| Google Workspace / BigQuery data, Gemini multimodal | Vertex AI |
| Portability across all three | A gateway (principle 1) and Claude, which is available on all three |
