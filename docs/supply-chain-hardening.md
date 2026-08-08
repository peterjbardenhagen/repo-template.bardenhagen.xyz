# Supply Chain Hardening

> **Version:** 2.3.0  
> **Date:** August 2026

This document captures the supply chain security posture of this repository and the decisions behind each control.

## Defense Layers

| Layer | Mechanism | Status |
|-------|-----------|--------|
| **Prevention** | SHA-pinned actions, Harden-Runner, least-privilege permissions | Active |
| **Detection** | Gitleaks, CodeQL, OpenSSF Scorecard, dependency-review | Active |
| **Response** | Dependabot security updates, private vulnerability reporting | Active |
| **Provenance** | SLSA provenance, SBOM generation, cosign signing | Scaffolded |

## Actionable Controls

### 1. SHA-Pinned Actions
Every `uses:` reference in `.github/workflows/` MUST be pinned to a full-length commit SHA, not a tag.

```yaml
# Good
- uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1

# Bad
- uses: actions/checkout@v4
```

Run `./scripts/verify-action-pins.sh` to validate.

### 2. Least-Privilege Permissions
Workflows use `permissions:` blocks at the job or workflow level. The default is `contents: read`. Additional permissions are granted only when required.

### 3. Secret Scanning
Gitleaks runs on every push and PR, plus weekly full-history scans. It detects 800+ secret types.

### 4. Runtime Hardening
Harden-Runner is installed as the first step in CI jobs. It blocks credential exfiltration and monitors for compromised dependencies.

### 5. Dependency Hygiene
- Dependabot monitors npm, pip, cargo, gomod, nuget, docker, and GitHub Actions.
- Grouped updates reduce PR noise: security fixes in one group, minor/patch in another, majors isolated.
- Dependency-review action blocks vulnerable PRs.

### 6. Provenance and Attestation
- SBOM is generated with Syft on every release and push to main.
- Release artifacts are attested via `actions/attest`.
- Cosign keyless signing is scaffolded for future use.

## What We Do NOT Do (Yet)

| Control | Why Not |
|---------|---------|
| Cosign keyless signing enforcement | Requires a release pipeline with actual artifacts |
| Branch protection ruleset (JSON) | Requires GitHub Enterprise or org-level rulesets |
| OpenSSF Scorecard badge in README | Adds visual noise; results are published to Security tab |
| Harden-Runner `block` mode | Audit mode is safer for template repos with diverse stacks |

## References

- [GitHub Supply Chain Security](https://github.blog/security/supply-chain-security/)
- [Secure Repo Template (step-security)](https://github.com/step-security/secure-repo)
- [Sigil: Secure-by-default GitHub template](https://github.com/0-draft/sigil)
- [OpenSSF Scorecard](https://github.com/ossf/scorecard)
