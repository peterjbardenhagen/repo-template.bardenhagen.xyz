# Support

## Where to go

| You want to… | Go here |
|---|---|
| Report something broken | [Open a bug report](../../issues/new?template=bug_report.yml) |
| Propose a capability | [Open a feature request](../../issues/new?template=feature_request.yml) |
| Promote an improvement into the template | [Open a template uplift](../../issues/new?template=template_uplift.yml) |
| Report a security vulnerability | **Do not open an issue** — see [SECURITY.md](SECURITY.md) |
| Ask how something works | Check [`docs/`](docs/) first, then open an issue |

## Before opening an issue

1. **Search existing issues**, including closed ones — a closed issue often
   carries the answer or the reason it will not change.
2. **Read the relevant doc.** [`docs/getting-started.md`](docs/getting-started.md)
   for setup, [`docs/ci-cd.md`](docs/ci-cd.md) for pipeline failures,
   [`docs/git-workflow.md`](docs/git-workflow.md) for branching and merges.
3. **Confirm the version.** If the app shows build info in its footer, include
   the version and commit — it is often the whole answer, because the fix may
   already be deployed or the build may be older than expected.

## What makes a report actionable

- **Reproduction steps from a known starting state.** A bug nobody can
  reproduce rarely gets fixed.
- **Expected versus actual**, stated separately.
- **The exact error text.** "It errored" and `TypeError: undefined is not a
  function at cart.ts:42` lead to very different response times.
- **Whether it is consistent or intermittent**, and anything that changed
  before it started.

## Response expectations

This is a personal project. Issues are looked at as time allows — there is no
SLA. Security reports are prioritised over everything else.

## Contributing a fix

Fixes are welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) and
[`docs/git-workflow.md`](docs/git-workflow.md) first — the short version is:
branch from a current `main`, keep the change small, use conventional commits,
and make sure `CI Gate` is green.
