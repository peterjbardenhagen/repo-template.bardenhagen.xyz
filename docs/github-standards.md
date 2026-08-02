# GitHub Repository Standards

How a repository should present and configure itself. Complements
[`ci-cd.md`](./ci-cd.md) (pipelines) and [`git-workflow.md`](./git-workflow.md)
(branching) — this one is about the repo as an artifact other people encounter.

---

## 1. Social Preview Card

The image GitHub shows whenever the repo is linked in Slack, Teams, LinkedIn, or
X. Without one, the link unfurls as the owner's avatar plus a wall of text.

| Spec | Value |
|---|---|
| Dimensions | **1280 × 640** (2:1) |
| Safe area | **40pt inset on every edge** |
| Format | PNG, JPG, or GIF — under 1 MB |
| Upload | Settings → General → Social preview → Edit |

**The safe area is the part people get wrong.** Different surfaces crop the card
differently — some to 2:1, some nearer square. Anything within 40pt of an edge
can be cut off, so keep every word and logo inside the guide.

Start from [`templates/social-preview.svg`](../templates/social-preview.svg),
which ships with the safe-area guide drawn on. Edit the title, subtitle, and
accent, delete the `safe-area-guide` group, then export at exactly 1280×640:

```bash
rsvg-convert -w 1280 -h 640 social-preview.svg -o social-preview.png
```

Content rules: repo name at ~28 characters or fewer, one subtitle line at ~70,
and enough contrast to survive both light and dark chat themes.

## 2. Repository Metadata

Set these once. They drive GitHub search, the sidebar, and every unfurled link.

- [ ] **Description** — one sentence on what it does. Not "my project"
- [ ] **Topics** — 3–8 tags (language, framework, domain). Primary discovery mechanism
- [ ] **Website** — the deployed URL, if there is one
- [ ] **Social preview** — see above
- [ ] **Default branch** is `main`, lowercase
- [ ] Features switched off if unused (Wiki, Projects) — an empty tab reads as abandoned
- [ ] **Archive** rather than delete when a repo is retired, so links keep resolving

## 3. Community Health Files

GitHub surfaces these in its Community Standards checklist and links them from
the issue and PR UI.

| File | Purpose | In this template |
|---|---|---|
| `README.md` | What, why, how to run | ✅ |
| `LICENSE` | Terms of use | ✅ |
| `CONTRIBUTING.md` | How to contribute | ✅ |
| `CODE_OF_CONDUCT.md` | Behavioural expectations | ✅ |
| `SECURITY.md` | How to report a vulnerability privately | ✅ |
| `SUPPORT.md` | Where to ask questions | ✅ |
| `.github/CODEOWNERS` | Automatic review routing | ✅ |
| `CITATION.cff` | How to cite | Add only for research/published work |
| `.github/FUNDING.yml` | Sponsor links | Add only if accepting sponsorship |

Org-wide defaults can live in a `.github` repository; anything defined in the
repo itself wins.

## 4. Issue Forms, Not Issue Templates

Use **YAML issue forms** (`.yml`), not the older markdown templates (`.md`).
Forms give required fields, dropdowns, and validation, so reports arrive with
the information needed to act on them instead of an empty heading someone
deleted. They also parse reliably, which matters when an agent triages them.

Shipped here:

| Form | Purpose |
|---|---|
| `bug_report.yml` | Requires repro steps and expected-vs-actual |
| `feature_request.yml` | Asks for the problem and an observable outcome, not just a proposed solution |
| `template_uplift.yml` | Promotes an improvement from a downstream project back into this template |

`config.yml` controls blank issues and contact links.

## 5. Security Configuration

- [ ] **Secret scanning** + **push protection** — blocks a commit containing a
      credential before it reaches the remote
- [ ] **Dependabot alerts** and **security updates**
- [ ] **Code scanning (CodeQL)** — Settings → Code security → Code scanning.
      Analysis fails to upload until this is on; see [`ci-cd.md`](./ci-cd.md)
- [ ] **Private vulnerability reporting** — gives researchers a non-public channel
- [ ] **Rulesets** on `main` (not classic branch protection) — see
      [`git-workflow.md`](./git-workflow.md)
- [ ] Actions permissions restricted to what workflows need; SHA-pinned actions
      verified by `scripts/verify-action-pins.sh`

### GitHub App installation tokens are changing format

GitHub App installation tokens are moving to a **stateless format**: the
`ghs_` prefix stays, but tokens become **substantially longer (~520 characters)**.

Anything that hardcodes a token length, allocates a fixed-size buffer, stores
tokens in a length-constrained database column, or pattern-matches on the old
length **will break**. The prefix is stable; the length is not — never validate
on length.

Audit any code that touches tokens:

```bash
grep -rnE "ghs_|gho_|ghp_|github_pat_|token.{0,20}length|VARCHAR\([0-9]{1,3}\)" .
```

Checked in this template: no length assumptions exist here. The risk is in
downstream projects that call the GitHub API or persist tokens — check those.

## 6. Releases

- Tag with semver: `v1.2.3`
- Auto-generate release notes from PR titles — which is why PR titles must be
  written as conventional commits (`git-workflow.md`)
- Mark pre-releases as such so package managers do not pick them up
- Keep `CHANGELOG.md` in step with tags

## 7. New Repository Checklist

- [ ] Generated from this template; `scripts/init-project.sh` run
- [ ] Description, topics, and website set
- [ ] Social preview uploaded (1280×640, 40pt safe area)
- [ ] `main` is default; ruleset applied requiring `CI Gate`
- [ ] Secret scanning, push protection, Dependabot, code scanning enabled
- [ ] `SECURITY.md` names a real reporting route
- [ ] `CODEOWNERS` points at real reviewers
- [ ] README states what it is, how to run it, and how to deploy it
- [ ] `./scripts/verify-action-pins.sh` passes
