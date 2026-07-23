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

## Usage

Agents should read the appropriate role file at session start. Multi-agent workflows hand off between roles using file-based artifacts (ADRs, specs, PRs, test plans).

## Adding New Roles

Create a new file using the numbering convention (`NN-role-name.md`). Update this README when adding a role.
