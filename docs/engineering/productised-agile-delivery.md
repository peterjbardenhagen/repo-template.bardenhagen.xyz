# Productised delivery: epics, features, tasks, releases and safe change

**Status:** Standard  
**Applies to:** New products, internal tools, experiments that may become products, and existing repositories adopting this template.

The product is not an afterthought. Every repository starts with a minimum viable product-management, architecture, security, operations and lifecycle contract on day zero. Start small, but make the first increment supportable, observable, configurable, testable, accessible, versioned and releasable.

## 1. Plan at multiple levels

Use the smallest hierarchy that matches the work; do not create ceremony for its own sake.

| Level | Purpose | Required fields |
|---|---|---|
| Product / outcome | Why the capability exists and who benefits | Product owner, users, measurable outcome, constraints, success measure |
| Epic | A coherent business outcome spanning multiple increments | Outcome, owner, priority, target window, risks, exit criteria |
| Feature | A user-visible or operational capability that contributes to an epic | User/business value, dependencies, acceptance criteria, telemetry and security/privacy impact |
| Task / story | A small, reviewable unit of work | Scope, testable acceptance criteria, owner, estimates where useful, verification evidence |
| Defect / hotfix | A failure or urgent risk requiring correction | Severity, impact, reproduction/evidence, mitigation, regression test and follow-up |
| Release | A traceable, deployable product state | Version, changelog, artefacts, migration notes, verification, rollout and rollback plan |

Map tasks to features and features to epics using durable IDs in the issue tracker. Use labels and links rather than copying the same plan into multiple competing files. Keep an auditable link from business outcome → epic → feature → task/PR → tests/evidence → release.

## 2. Start productised on day zero

Even a proof of concept should have an explicit path to either productionisation or retirement.

- Define target users, problem, non-goals, success measures, supported environments and product owner.
- Establish a thin architecture, threat model, data classification, privacy/retention policy and ADRs for material choices.
- Separate domain logic, UI, persistence, integrations and infrastructure according to the project's stack.
- Use configuration for environment-specific values, feature switches, endpoints, limits, model/provider selection and tenant-specific behaviour. Validate configuration at startup and fail clearly for missing required settings.
- Keep secrets out of source, prompts, test fixtures, logs and client bundles. Use the approved secret manager or platform identity.
- Define health/readiness, structured redacted logs, correlation IDs, error handling, telemetry, cost limits and operational ownership.
- Add deterministic tests, security/dependency checks, accessibility checks where applicable, a local development path, CI, deployment notes and rollback before broadening scope.
- Document installation, upgrade, backup/restore, support, data export and uninstall/retirement.
- Prefer portable interfaces and replaceable providers; avoid coupling product logic to one vendor unless the decision is explicit and recorded.
- Make an experiment's timebox, owner, data boundary and productionisation decision date visible.

“Productised” is a minimum bar, not a mandate to build a large platform before validating value. Use a thin vertical slice and evolve it through measured increments.

## 3. Avoid hard-coded behaviour and environment coupling

Do not hard-code credentials, URLs, tenant identifiers, machine paths, ports, environment assumptions, customer-specific copy, model names, policy thresholds or deployment targets inside reusable business logic.

Use typed configuration, environment variables, managed configuration, feature flags or tenant-scoped records as appropriate. Keep safe defaults explicit; validate allowed values; document each setting in an example file without real secrets. Tests should inject configuration rather than depend on a developer's machine.

Domain constants that define a published standard or stable protocol may live in versioned data modules, with a source URL, source version/date, owner and review date. Do not confuse a legitimate standard definition with an environment-specific hard-coded value.

## 4. Versioning and release policy

- Use Semantic Versioning (MAJOR.MINOR.PATCH) for published APIs and products where the compatibility contract fits SemVer.
- Prefer Conventional Commits and an automated changelog/release workflow; versions must be generated from committed source, not hand-maintained in multiple places.
- Use 0.y.z while the public contract is intentionally unstable. Document breaking changes and migration paths.
- Tag immutable release commits (vX.Y.Z) and attach provenance, SBOM and test/security evidence where applicable.
- Keep main releasable. Merge short-lived feature branches through reviewed PRs and required checks.
- A release is a verified state, not simply “whatever is currently on main”. For continuous delivery, publish a versioned release record/artefact for each production promotion and record the deployed commit and configuration version.
- Pin dependencies and container images to reviewed versions/digests where reproducibility requires it; automate update PRs and security review rather than pinning forever.
- Never label a build or release as passing unless the relevant checks actually ran and passed.

## 5. Hotfix and incident path

1. Record severity, customer/business impact, affected versions and safe mitigation.
2. Branch from the affected release/tag (or current production commit), not from unrelated unfinished work.
3. Make the smallest safe correction and add a regression test. Avoid unrelated refactors.
4. Run targeted tests plus mandatory security, build and compatibility gates. If a check cannot run, record the exception and obtain the authorised risk decision—do not disguise it as a pass.
5. Create a patch release (PATCH increment) and publish notes, artefact provenance and rollback guidance.
6. Deploy with the appropriate approval, verify health and key user journeys, and monitor.
7. Forward-port/cherry-pick the fix to supported release lines and main; verify no branch was left vulnerable.
8. Complete a blameless review with owners and dated follow-up tasks. Do not close the incident merely because the deployment completed.

## 6. Deletion, retention and reversible change

**Do not hard-delete business records by default.** Use a lifecycle state such as active, archived, deleted or purge-pending, with deleted_at, actor, reason and correlation/audit metadata where appropriate. Exclude inactive records from normal views while preserving traceability.

- Prefer archive/soft-delete, reversible migrations and tombstones for business data and integration records.
- Use explicit retention schedules, legal holds, privacy obligations and least-privilege access to decide when physical purge is permitted.
- Implement purge as a separately authorised, logged, idempotent process with a preview/count, retention check, backup/restore considerations and an auditable result.
- Cascade deletion must be explicit and tested; default to restrict or detach where deleting a parent could silently destroy related records.
- For files and cloud resources, prefer deactivation, quarantine or staged retirement before irreversible deletion.
- Provide undo/restore where technically and legally appropriate; document cases where recovery is impossible.
- Secrets are different: compromised credentials should be revoked/rotated promptly, not preserved for reversibility. Logs must not retain secret material.
- Follow applicable privacy and statutory deletion requirements; soft-delete is not permission to retain personal data indefinitely.

## 7. Definition of ready and done

**Ready:** outcome and owner known; acceptance criteria testable; scope/non-goals defined; dependencies and risk assessed; design/data changes and migration plan understood.

**Done:** implementation and docs updated; tests and relevant quality/security/accessibility checks executed; configuration and telemetry handled; migration/rollback considered; PR reviewed; version/changelog/provenance handled; known limitations and residual risks disclosed; deployment/productionisation owner identified.

## 8. Required workflow for agents

At the start of each iteration: inspect current state and open work, confirm the target release and priorities, and plan the next epics/features/tasks. During work: keep tasks small, link each PR to the relevant issue, preserve unrelated work, and avoid silent scope changes. At the end: report completed items, evidence, failures, blockers, version/release impact and the next ranked iteration.

Agents may draft and implement within approved scope. They must not self-approve their own PRs, waive security gates, accept material business risk, or perform irreversible production/data actions without the required human authority.
