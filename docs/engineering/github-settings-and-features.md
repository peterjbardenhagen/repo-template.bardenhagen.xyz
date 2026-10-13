# GitHub Repository Settings and Features

This guide is the operational checklist for configuring this template and repositories created from it. It separates repository files (which can be version-controlled) from GitHub account settings (which must be configured in GitHub's UI or through an appropriately authorised API).

> **Current source-repository snapshot:** GitHub's repository metadata reports that Pages and Discussions are enabled for `peterjbardenhagen/repo-template.bardenhagen.xyz`. That confirms the feature flags, but does not confirm the Pages publishing source, a successful deployment, or the Discussion categories. Verify those in the repository UI before relying on them.

## 1. GitHub Pages documentation site

The documentation source is under `docs/`; `docs/index.md` is the landing page. Before publishing, choose the intended URL and hosting owner carefully. Do not point GitHub Pages at a custom domain already used by Vercel or another host.

### Configure Pages

1. Open the repository's **Settings → Pages**.
2. Under **Build and deployment**, choose **GitHub Actions** if the repository uses a custom documentation build workflow; otherwise choose **Deploy from a branch** and select `main` + `/docs` only if the contents are compatible with the chosen Jekyll setup.
3. Confirm the published URL shown by GitHub and open it in a private/incognito browser.
4. Check the landing page, navigation, internal links, images, mobile layout, and 404 handling.
5. Check the latest Pages deployment under **Actions** and confirm it completed successfully.

GitHub Pages sites are public on the internet. Never publish secrets, private project notes, internal URLs, customer information, or generated files containing sensitive data.

### Recommended documentation publishing standard

- Publish only documentation intended for public consumption.
- Prefer a dedicated documentation build (for example, MkDocs) for a large Markdown corpus; it resolves navigation and renders links consistently.
- Build and validate on pull requests; publish only from the default branch.
- Use least-privilege workflow permissions: read repository contents and write Pages deployment artefacts only where needed.
- Pin third-party GitHub Actions to reviewed commit SHAs, not mutable tags, in line with the repository's supply-chain policy.
- Keep the docs source in Git and make the published site reproducible. Do not manually edit generated output.

## 2. GitHub Discussions

The source repository's metadata reports Discussions enabled. Open [the Discussions board](https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz/discussions) to verify the tab is visible and configure the welcome post and categories.

### Suggested categories

| Category | Format | Use it for |
|---|---|---|
| Announcements | Announcement | Maintainer updates and important changes |
| General | Open-ended | Broad community conversation |
| Q&A | Question and answer | Questions with a reusable answer |
| Ideas | Open-ended | Improvement proposals before they become committed work |
| Show and tell | Open-ended | Examples, experiments, and projects built from the template |
| Polls | Poll | Community preference gathering |

Keep the boundary clear:

- **Discussion:** explore, ask, propose, share, and clarify.
- **Issue:** track a specific bug, task, or accepted piece of work.
- **Pull Request:** propose and review a concrete change to the repository.

Pin a welcome announcement linking to the README, contribution guide, security policy, and documentation. Explain that security vulnerabilities must be reported using the private process in [SECURITY.md](../../SECURITY.md), not posted publicly.

### Welcome post starter

> Welcome to the Repo Template community. Use Discussions for questions, ideas, implementation experiences, and general conversation about agentic software delivery. Use Issues for actionable work and Pull Requests for proposed changes. Please do not post secrets, credentials, personal information, or details of an unpatched vulnerability. Start with the README and the documentation index, and follow the Code of Conduct.

## 3. Recommended repository settings

Apply these defaults when the project and GitHub plan support them. The right controls depend on the repository's risk and whether it is a solo project or a team-owned production system.

### Access and collaboration

- [ ] Keep the repository visibility intentional; review public exposure before publishing.
- [ ] Grant the minimum permissions required. Prefer teams over individual grants when working in an organisation.
- [ ] Review collaborators and installed GitHub Apps periodically.
- [ ] Use a `CODEOWNERS` file with real owners; do not leave placeholder teams.
- [ ] Enable **Automatically delete head branches** after merge.
- [ ] Enable **Allow auto-merge** only when required checks and review rules are meaningful; auto-merge must not bypass required controls.

### Pull requests and the default branch

- [ ] Protect `main` with a branch ruleset or branch protection rule.
- [ ] Require pull requests for changes to `main`; prohibit force-push and deletion of the default branch.
- [ ] Require relevant CI checks before merge; remove placeholder checks and ensure checks actually test the project.
- [ ] Require at least one independent approval for team production repositories. For solo projects, use explicit self-review and automated checks instead of pretending an independent review exists.
- [ ] Dismiss stale approvals when new commits materially change the reviewed code, and require conversation resolution where practical.
- [ ] Require signed commits only if the team can reliably comply with the policy.
- [ ] Use squash merge as the default for focused changes unless project history requires another strategy.
- [ ] Consider a merge queue for busy repositories with reliable `merge_group` CI support.

### Security and supply chain

- [ ] Enable Dependabot alerts and security updates where supported.
- [ ] Enable secret scanning and push protection where supported by the account plan and repository eligibility.
- [ ] Enable CodeQL or an equivalent static-analysis workflow for supported languages.
- [ ] Enable dependency review for pull requests and review licence/security impact.
- [ ] Keep Actions permissions read-only by default; grant write permissions at job level only when needed.
- [ ] Restrict which actions can run where feasible, and pin third-party actions to verified full-length commit SHAs.
- [ ] Use GitHub environments for deployment and configure required reviewers or branch restrictions for production where appropriate.
- [ ] Prefer OIDC and short-lived credentials over long-lived cloud tokens.
- [ ] Keep a private vulnerability reporting route and a current `SECURITY.md`.
- [ ] Review audit/security alerts and workflow failures regularly.

### Project planning and community

- [ ] Keep Issues enabled when the team needs a tracked backlog; use issue forms/templates and labels.
- [ ] Enable Discussions for community Q&A, ideas, announcements, and show-and-tell.
- [ ] Use GitHub Projects when a cross-issue board, roadmap, or iteration view is useful; do not create a board just to duplicate Issues.
- [ ] Add a Code of Conduct and contribution guidance for public repositories.
- [ ] Set repository topics and a meaningful description so people can discover the project.
- [ ] Configure release notes/changelog conventions and use GitHub Releases if versioned distributions are produced.
- [ ] Enable a Wiki only if it has a clear owner and purpose; otherwise keep durable documentation in version control.

### Automation and delivery

- [ ] Ensure CI runs on pull requests and the default branch.
- [ ] Include `merge_group` if using a merge queue.
- [ ] Use concurrency to avoid wasting runner minutes on superseded PR runs.
- [ ] Configure Dependabot for supported ecosystems and GitHub Actions.
- [ ] Use scheduled maintenance workflows sparingly and ensure stale-item automation does not close active work incorrectly.
- [ ] Verify production deployment health after every release; keep rollback instructions documented.
- [ ] Avoid enabling workflows that depend on secrets until those secrets and permissions are configured.

## 4. Template repository-specific checks

For the source template, also verify:

- [ ] **Settings → General → Template repository** remains enabled.
- [ ] The default branch is `main`.
- [ ] The public README clearly explains what the template contains and how to create a repository from it.
- [ ] Actions workflows are safe and useful for a derived repository; document which workflows require secrets or project-specific edits.
- [ ] The template does not contain real credentials, private configuration, client data, or misleading sample owners.
- [ ] Documentation and starter instructions explain that template-created repositories do not automatically receive future template updates.
- [ ] Pages publishes only the intended documentation and does not replace the existing production hosting setup.

## 5. What can and cannot be version-controlled

| Setting or feature | Stored in the repository? | Notes |
|---|---|---|
| README, contribution and security policies | Yes | Commit changes via PR |
| Issue and PR templates, CODEOWNERS | Yes | CODEOWNERS needs valid GitHub usernames/team slugs |
| Actions workflows | Yes | Repository Actions permissions/secrets still need configuration |
| Pages build configuration | Partly | Workflow/config can be versioned; publishing source, custom domain and access settings require repository settings |
| Discussion categories and welcome post | No, generally configured in GitHub UI | Verify the board after enabling it |
| Branch protection / rulesets | Not in ordinary files | Configure in Settings or manage through an authorised API/IaC workflow |
| Secrets, environments and deployment approvals | No, not as plaintext files | Configure securely in Settings |
| Dependabot configuration | Partly | `.github/dependabot.yml` is version-controlled; alert/security-update settings may also need UI configuration |
| Repository topics and feature toggles | No | Configure in repository settings |

## 6. Manual settings runbook

Open these sections from the repository's **Settings** tab and record the outcome in the project onboarding checklist:

1. **General:** description, topics, template-repository toggle, merge options, automatically delete head branches.
2. **Collaborators and teams:** least-privilege access and CODEOWNERS alignment.
3. **Branches / Rules:** default branch protections, required checks, review and bypass policy.
4. **Actions → General:** workflow permissions and allowed actions.
5. **Pages:** source, deployment status, URL and custom-domain/DNS safety.
6. **Code security and analysis:** Dependabot, secret scanning, push protection, code scanning, dependency review.
7. **Environments:** deployment branch restrictions, required approvals and secret scope.
8. **Discussions:** enablement, categories, welcome post, pinned announcements and moderation.
9. **Issues / Projects:** templates, labels, milestones and project board if needed.
10. **Insights / Security:** review activity, dependencies, alerts and policy compliance.

GitHub plan availability varies. If a control is unavailable, document the gap and use an equivalent control rather than assuming it is active.

## Official references

- [GitHub Pages: publishing sources](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
- [GitHub Pages: create a site](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site)
- [GitHub Discussions quickstart](https://docs.github.com/en/discussions/quickstart)
- [Protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)
