# Agent Role Rules

This directory contains role-based skill files for AI agents working in this project. Each file provides specialised instructions for a specific agent role.

## Available Roles

| Role | File | Responsibility |
|------|------|---------------|
| Architect | `01-architect.md` | System design, ADRs, technology decisions |
| Coder | `02-coder.md` | Feature implementation, refactoring, bug fixing |
| Reviewer | `03-reviewer.md` | Code review, quality gates, security review |
| Tester | `04-tester.md` | Test strategy, test automation, quality metrics |
| DevOps | `05-devops.md` | CI/CD, infrastructure, deployment, monitoring |
| UX | `06-ux.md` | User journeys, usability, accessibility, CX |
| Analyst | `07-analyst.md` | Requirements, acceptance criteria, scope verification |

### Two questions, not one

Roles 01–05 answer **"did we build it correctly."** Roles 06–07 answer **"did we
build the right thing"** — a question no test suite can answer, and the most
expensive one to get wrong, because correct code solving the wrong problem is a
total loss.

Start non-trivial work with **analyst** (criteria before code) and finish with it
(verification against the original request). Bring in **ux** for anything a user
sees, clicks, reads, or waits for.

## Usage

Agents should read the appropriate role file at session start. Multi-agent workflows hand off between roles using file-based artifacts (ADRs, specs, PRs, test plans).

## Adding New Roles

Create a new file using the numbering convention (`NN-role-name.md`). Update this README when adding a role.
