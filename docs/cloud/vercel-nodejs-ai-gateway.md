# Vercel, Node.js and Vercel AI Gateway

Use Vercel for suitable Node.js applications, Next.js apps, serverless functions and AI workloads. Keep the application layer portable and isolate Vercel-specific deployment/authentication details behind adapters where portability matters.

## Recommended stack

- Node.js LTS supported by the chosen Vercel runtime.
- TypeScript and a lockfile.
- Vercel CLI for local development, project linking and deployment.
- Vercel AI SDK (`ai`) for model-agnostic generation, streaming, structured output and tool loops.
- Vercel AI Gateway for a single endpoint and model routing across supported providers.
- Vercel environment variables or a supported secrets-manager integration for server-side configuration.
- Tests, linting, type checking, dependency scanning and preview deployments before production promotion.

## Setup

Install the Vercel CLI and authenticate interactively:

```bash
npm install --global vercel
vercel login
vercel link
vercel dev
```

For a Node.js AI project:

```bash
npm install ai
npm install --save-dev typescript @types/node
```

Use the currently supported Node.js version for your Vercel project and pin dependency versions through the package manager lockfile. The commands above are a starting point; adapt them to the selected framework and existing repository.

## Vercel AI Gateway

AI Gateway offers a unified API to multiple model providers and can reduce provider-specific integration work. On Vercel deployments, prefer supported native authentication/OIDC where available; for local development or other hosting environments, use an AI Gateway API key stored in an approved secret store.

Example using the AI SDK:

```typescript
import { generateText } from "ai";

const result = await generateText({
  model: "openai/gpt-4.1-mini",
  prompt: "Summarise the purpose of this service in one sentence.",
});

console.log(result.text);
```

Model identifiers are illustrative; use a currently available model and validate capability, price, context window, data policy and licence before standardising on it. Do not log prompts or results containing sensitive data.

Official docs: [Vercel AI Gateway SDKs and APIs](https://vercel.com/docs/ai-gateway/sdks-and-apis), [Vercel AI SDK](https://vercel.com/docs/ai-sdk), [AI Gateway + AI SDK agent guide](https://vercel.com/kb/guide/ai-gateway-and-ai-sdk).

## Secrets and identity

- Never commit `AI_GATEWAY_API_KEY`, provider keys, Vercel tokens or deployment credentials.
- Never put a server-side secret in `NEXT_PUBLIC_*` variables, browser code or client components.
- Use Vercel project/environment settings for runtime values; keep development, preview and production credentials separate.
- Prefer OIDC/native Vercel authentication where supported. For other environments, fetch a narrowly scoped secret at runtime from Key Vault, Doppler or another approved manager.
- If a secret is synchronised into Vercel environment variables, treat the Vercel value as a managed copy: define update propagation, redeployment/restart behaviour and rollback.
- Do not assume that Key Vault automatically rotates Vercel or AI Gateway credentials. Renewal must be implemented using the issuing provider's supported API or a reviewed operator workflow.
- Use secret scanning, restricted project/team permissions, audit logs and expiry alerts.

## Production checklist

- [ ] Runtime Node.js version and framework support are verified.
- [ ] Dependencies are locked and scanned.
- [ ] Server-only credentials never reach the browser bundle.
- [ ] AI Gateway model access, spending limits, timeouts and rate limits are configured.
- [ ] Data handling, retention, residency and provider terms are reviewed for the workload.
- [ ] AI outputs and tool arguments are validated; tools have explicit permissions.
- [ ] Preview deployments use non-production data/credentials.
- [ ] Production promotion requires tests and any necessary human approval.
- [ ] Observability redacts prompts, credentials and sensitive content.
- [ ] Rollback and credential revocation procedures are documented.
