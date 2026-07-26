# Vercel OIDC Integration

Vercel OIDC Federation lets you use short-lived tokens instead of long-lived secrets when deploying from GitHub Actions. This eliminates the risk of leaking persistent credentials.

## How It Works

When Vercel runs a build, it automatically generates a new OIDC token and assigns it to the `VERCEL_OIDC_TOKEN` environment variable. GitHub Actions can verify this token without storing any long-lived keys.

## Setup

### 1. Enable OIDC on Vercel

1. Open your Vercel project
2. Go to **Settings → Security → Secure backend access with OIDC**
3. Toggle to **Team** mode (recommended) or keep **Global**
4. Copy the issuer URL (e.g., `https://oidc.vercel.com/<team>`)

### 2. Configure GitHub Actions

In your deployment workflow, add `id-token: write` to permissions and configure the deployment using the Vercel CLI with the OIDC token:

```yaml
permissions:
  contents: read
  id-token: write  # Required for OIDC token generation

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
    steps:
      - uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11 # v4.3.1

      - name: Install Vercel CLI
        run: npm install --global vercel@latest

      - name: Pull Vercel environment
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build
        run: vercel build --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
```

### 3. Future-Proofing: OIDC to Cloud Providers

You can also exchange the Vercel OIDC token for AWS/GCP/Azure credentials. See:

- [Vercel OIDC with AWS](https://vercel.com/docs/oidc/aws)
- [Vercel OIDC with GCP](https://vercel.com/docs/oidc/google-cloud)
- [Vercel OIDC with Azure](https://vercel.com/docs/oidc/azure)

## Security Benefits

| Benefit | Description |
|---------|-------------|
| Short-lived tokens | Tokens expire after 45–60 minutes |
| No long-lived secrets | `VERCEL_TOKEN` is still needed for Vercel CLI, but rotate regularly |
| Cloud auth | Exchange Vercel OIDC for AWS/GCP/Azure IAM roles |
| Audit trail | Every token issuance is logged by Vericle |

## Fallback

If OIDC is not yet enabled on your Vercel plan, continue using `VERCEL_TOKEN` as a secret. Rotate it quarterly via the Vercel dashboard.
