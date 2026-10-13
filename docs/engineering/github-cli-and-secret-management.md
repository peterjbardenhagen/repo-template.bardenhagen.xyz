# GitHub CLI and Secure Credential Lifecycle

Use GitHub CLI (`gh`) for everyday GitHub operations. Never put access tokens, API keys, passwords, certificates or refresh tokens in source files, plain-text notes, command-line arguments, screenshots, issue comments or logs.

## Install GitHub CLI

### Windows

```powershell
winget install --id GitHub.cli
gh --version
```

### macOS

```bash
brew install gh
gh --version
```

### Ubuntu / Debian

Follow the official installation instructions at [GitHub CLI](https://github.com/cli/cli#installation), as package availability and supported distributions change.

## Authenticate without saving a token in a text file

For an interactive developer workstation:

```powershell
gh auth login
gh auth status
gh auth setup-git
```

Choose GitHub.com, HTTPS, and browser authentication. Allow GitHub CLI to use the operating system credential store. Do **not** use `--insecure-storage`. If the OS credential store is unavailable, fix the credential-store setup rather than accepting a plain-text fallback. Review the reported storage method using `gh auth status`.

GitHub CLI can store credentials securely in the system credential store, but it may fall back to a plain-text configuration file if no supported store is available. Verify the result on every machine. Reference: [gh auth login](https://cli.github.com/manual/gh_auth_login).

For git operations, `gh auth setup-git` configures Git to use GitHub CLI as a credential helper. Avoid copying the output of `gh auth token` into files or terminal logs.

## Recommended credential hierarchy

1. **Prefer short-lived identity over secrets.** Use workload identity federation/OIDC, managed identities, or provider-native identity where available.
2. **Azure workloads:** use Microsoft Entra managed identity to access Azure Key Vault; avoid a client secret when the deployment environment supports identity.
3. **GitHub Actions to Azure:** use OIDC federation. Keep only non-secret identifiers such as tenant, client, subscription and vault names in workflow configuration; grant the federated identity only the required Key Vault permissions.
4. **Local developer credentials:** use GitHub CLI's OS credential store, Windows Credential Manager/DPAPI, macOS Keychain or an approved enterprise credential manager.
5. **Cross-platform team secrets:** use Doppler, 1Password Secrets Automation, HashiCorp Vault or an equivalent approved secrets manager with role-based access, audit logs and rotation support.
6. **Vercel runtime:** use Vercel environment variables or a supported secret-manager integration for runtime-only secrets. Prefer Vercel's native identity/OIDC support where available. Never expose server secrets with a `NEXT_PUBLIC_` prefix or embed them in client bundles.

Do not keep secrets in `.env`, `.env.local`, `set-env.cmd`, PowerShell scripts or JSON configuration committed to Git. Local environment files may be used as a development interface only if they are ignored by Git, access-controlled, not synced to untrusted storage, and populated from an approved secret store. A file being in `.gitignore` does not encrypt it.

## Azure Key Vault + GitHub Actions (recommended for Azure)

Use GitHub Actions OIDC to authenticate to Azure, then retrieve only the secrets required for that job. This avoids a long-lived Azure client secret in GitHub. Configure a federated identity credential restricted to the exact repository and branch/environment, then assign the smallest practical Key Vault role.

Example outline (replace action versions with reviewed, full commit SHAs from the official repositories):

```yaml
permissions:
  contents: read
  id-token: write

steps:
  - name: Azure login using OIDC
    uses: azure/login@<REVIEWED_FULL_COMMIT_SHA>
    with:
      client-id: ${{ secrets.AZURE_CLIENT_ID }}
      tenant-id: ${{ secrets.AZURE_TENANT_ID }}
      subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

  - name: Read only the required Key Vault secret
    uses: azure/get-keyvault-secrets@<REVIEWED_FULL_COMMIT_SHA>
    with:
      keyvault: ${{ vars.KEYVAULT_NAME }}
      secrets: 'service-api-key'
```

This is an illustrative pattern, not a drop-in workflow. Pin and review actions, validate the action's current inputs, mask secret outputs, avoid echoing values, and pass secrets only to the step/process that needs them. Official guide: [Use Azure Key Vault secrets in GitHub Actions](https://learn.microsoft.com/en-us/azure/developer/github/github-actions-key-vault).

## Expiry, renewal and rotation

There is no universal mechanism that can safely renew every token. Different credentials have different lifecycle APIs and rotation semantics. Use this decision order:

- **OIDC / managed identity:** obtain short-lived credentials on demand; let the supported SDK/action acquire and refresh tokens. Do not copy access tokens into a vault for reuse.
- **OAuth refresh tokens:** use the provider's supported refresh flow and token rotation rules; store refresh tokens in a secrets manager and rotate/revoke them as required.
- **API keys / client secrets:** create a new credential through the provider's API or admin workflow, validate it, switch consumers, confirm health, then revoke the old credential. Use overlap periods when supported.
- **Key Vault secret versions:** enable expiry metadata and monitoring; trigger rotation through the relevant service's rotation API or a reviewed automation. Key Vault stores and versions secrets; it cannot independently renew an unrelated provider token without an authorised integration.
- **Doppler or equivalent:** use the platform's supported service-token, workload identity and secret-sync features. Confirm whether each integration rotates the underlying provider credential or only refreshes access to the secret store.

For each credential, document owner, source, consumers, permissions, expiry, renewal method, last successful rotation, revocation procedure and alert threshold. Alert before expiry, run rotation in a test environment, verify the new credential before revoking the old one, and test failure/rollback paths. If a credential cannot be renewed automatically, create a tracked owner-assigned renewal task rather than claiming automatic renewal.

## Incident response

If a secret may have been exposed:
1. Revoke/rotate it immediately at the issuing provider; do not merely delete the file.
2. Review provider audit logs and identify affected systems and time window.
3. Remove the secret from current files and Git history where possible, while recognising clones, forks, caches and logs may persist.
4. Rotate downstream credentials and investigate access.
5. Add a regression test/secret-scanning rule and document the incident.

## Checklist

- [ ] No secrets in tracked files, sample configs, logs, screenshots or documentation.
- [ ] Secret files are ignored and local permissions are restricted.
- [ ] Credential storage method is verified; no plaintext fallback.
- [ ] Workload identity/OIDC is used where supported.
- [ ] Least-privilege scopes and access are reviewed.
- [ ] Expiry alerts, owner, renewal procedure and revocation are documented.
- [ ] Secret scanning runs in pull requests and default-branch CI.
- [ ] Rotation and incident response have been tested.
