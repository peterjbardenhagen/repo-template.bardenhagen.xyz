# Rules — Role-Based Agent Skills

This directory contains specialized skill files for different AI agent roles. Each file defines the context, constraints, and workflow for that agent role when operating in this repository.

## How to Use

When an agent is assigned a task that maps to a specific role, it should load that role's rule file first, then the general `AGENTS.md`, before starting work.

## Roles

| # | Role | File | When to Use |
|---|------|------|-------------|
| 01 | Architect | `01-architect.md` | Making architectural decisions, writing ADRs, designing system structure |
| 02 | Coder | `02-coder.md` | Implementing features, fixing bugs, writing code |
| 03 | Reviewer | `03-reviewer.md` | Reviewing pull requests, performing code quality checks |
| 04 | Tester | `04-tester.md` | Writing tests, setting up test infrastructure, QA automation |
| 05 | DevOps | `05-devops.md` | Setting up CI/CD, managing infrastructure, deployment |

## Role Hierarchy

```
Architect → defines structure
     ↓
   Coder → implements
     ↓
Reviewer → validates quality
     ↓
  Tester → verifies correctness
     ↓
  DevOps → deploys & operates
```
