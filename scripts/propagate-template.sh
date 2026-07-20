#!/usr/bin/env bash
# ============================================================================
# propagate-template.sh — Propagate template updates to downstream repos
# ============================================================================
# Called by the nightly cron job. For each downstream repo:
#   1. Checks the repo exists and is not archived
#   2. Syncs template files (AI configs, rules, workflows, docs, configs)
#   3. Handles conflicts per-file (template wins for AI configs, project wins for source)
#   4. Creates PR or commits directly
#   5. Reports status for each repo
# ============================================================================
# Usage: ./scripts/propagate-template.sh [--dry-run] [--repo repo1,repo2,...]
#   --dry-run: Simulate without making changes
#   --repo:    Comma-separated list of repos to update (default: all configured)
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_VERSION="2.0.0"

# ============================================================================
# Configuration — list of downstream repos to propagate to
# ============================================================================
# Format: "owner/repo" or "repo" (owner defaults to peterjbardenhagen)
DOWNSTREAM_REPOS=(
  "peterjbardenhagen/peter.bardenhagen.xyz"
  "peterjbardenhagen/apartment-1507"
  "peterjbardenhagen/AgentsOS"
  "peterjbardenhagen/app.mydesk.digitalresponse.com.au"
  "peterjbardenhagen/mydesk.digitalresponse.com.au"
  "peterjbardenhagen/hermes"
  "peterjbardenhagen/master-orchestrator"
  "peterjbardenhagen/ai-test-orchestrator"
  "peterjbardenhagen/enterprise-data-intelligence"
  "peterjbardenhagen/dashypjb"
)

# Template files to propagate (relative paths from template root)
TEMPLATE_FILES=(
  # AI Agent configs
  "AGENTS.md"
  "CLAUDE.md"
  "CODEX.md"
  "COPILOT_INSTRUCTIONS.md"
  "AI_CONTEXT.md"
  ".cursorrules"
  ".windsurfrules"
  ".cursor/rules/project-rules.mdc"

  # Project configs
  ".editorconfig"
  ".gitattributes"
  ".gitignore"
  ".env.example"
  ".prettierrc"

  # GitHub workflows & templates
  ".github/workflows/ci.yml"
  ".github/workflows/codeql-analysis.yml"
  ".github/workflows/auto-assign.yml"
  ".github/dependabot.yml"
  ".github/CODEOWNERS"
  ".github/ISSUE_TEMPLATE/bug_report.md"
  ".github/ISSUE_TEMPLATE/feature_request.md"
  ".github/ISSUE_TEMPLATE/config.yml"
  ".github/PULL_REQUEST_TEMPLATE.md"

  # Role-based rules
  "rules/README.md"
  "rules/01-architect.md"
  "rules/02-coder.md"
  "rules/03-reviewer.md"
  "rules/04-tester.md"
  "rules/05-devops.md"

  # Documentation
  "docs/agentic-sdlc.md"
  "docs/architecture.md"
  "docs/decisions/README.md"
  "docs/decisions/ADR-001-record-architecture-decisions.md"
  "docs/getting-started.md"
  "CHANGELOG.md"

  # Scripts
  "scripts/init-project.sh"
  "scripts/propagate-template.sh"
)

# ============================================================================
# Functions
# ============================================================================

log_info()  { echo "[INFO]  $*"; }
log_ok()    { echo "[OK]    $*"; }
log_warn()  { echo "[WARN]  $*"; }
log_error() { echo "[ERROR] $*"; }
log_skip()  { echo "[SKIP]  $*"; }

# Check if a GitHub repo exists and is not archived
check_repo() {
  local repo="$1"
  local data

  data=$(gh api "repos/${repo}" --jq '{archived: .archived, name: .name, default_branch: .default_branch}' 2>/dev/null) || {
    log_error "Repo '${repo}' not found on GitHub (may have been deleted or renamed)"
    return 1
  }

  local archived
  archived=$(echo "$data" | jq -r '.archived')
  if [ "$archived" = "true" ]; then
    log_error "Repo '${repo}' is archived — skipping"
    return 1
  fi

  local branch
  branch=$(echo "$data" | jq -r '.default_branch')

  # Ensure branch is lowercase
  if [ "$(echo "$branch" | tr '[:upper:]' '[:lower:]')" != "$branch" ]; then
    log_warn "Repo '${repo}' default branch is '${branch}' — should be lowercase"
  fi

  echo "$data"
  return 0
}

# Clone repo to temp directory
clone_repo() {
  local repo="$1"
  local dest="$2"

  # Support both "owner/repo" and just "repo" formats
  local clone_url="https://github.com/${repo}.git"

  if [ -d "$dest" ]; then
    rm -rf "$dest"
  fi

  git clone --depth 1 "$clone_url" "$dest" 2>/dev/null || {
    log_error "Failed to clone '${repo}'"
    return 1
  }

  return 0
}

# Propagate template files to a repo
propagate_to_repo() {
  local repo="$1"
  local dry_run="${2:-false}"
  local repo_dir
  local default_branch
  local repo_name
  local changes_made=false

  log_info "Processing repo: ${repo}"

  # Check repo status
  local repo_data
  repo_data=$(check_repo "$repo") || return 1

  default_branch=$(echo "$repo_data" | jq -r '.default_branch')
  repo_name=$(echo "$repo_data" | jq -r '.name')

  # Clone
  repo_dir=$(mktemp -d -t "prop-${repo_name}-XXXXXX")
  clone_repo "$repo" "$repo_dir" || {
    rm -rf "$repo_dir"
    return 1
  }

  pushd "$repo_dir" > /dev/null
  git checkout "$default_branch" 2>/dev/null || git checkout -b "$default_branch"

  # Copy each template file
  for tfile in "${TEMPLATE_FILES[@]}"; do
    local src="${TEMPLATE_DIR}/${tfile}"
    local dst="${repo_dir}/${tfile}"

    if [ ! -f "$src" ]; then
      log_skip "Template file '${tfile}' not found — skipping"
      continue
    fi

    # Create destination directory if needed
    mkdir -p "$(dirname "$dst")"

    # Check if file already exists in the repo
    if [ -f "$dst" ]; then
      # For AI agent configs and rules, template always wins (overwrite)
      # For other files, only copy if the repo doesn't have its own version
      case "$tfile" in
        AGENTS.md|CLAUDE.md|CODEX.md|COPILOT_INSTRUCTIONS.md|AI_CONTEXT.md)
          cp "$src" "$dst"
          log_ok "Updated ${tfile} (template overrides project)"
          changes_made=true
          ;;
        .cursorrules|.windsurfrules|.cursor/rules/*)
          cp "$src" "$dst"
          log_ok "Updated ${tfile} (template overrides project)"
          changes_made=true
          ;;
        rules/*)
          cp "$src" "$dst"
          log_ok "Updated ${tfile} (template overrides project)"
          changes_made=true
          ;;
        docs/*)
          # Only copy if project doesn't have its own version
          log_skip "Skipped ${tfile} (project has its own version)"
          ;;
        .github/*)
          # Copy workflows/templates if project doesn't have its own
          if [ ! -f "$dst" ]; then
            cp "$src" "$dst"
            log_ok "Added ${tfile} (new file)"
            changes_made=true
          else
            log_skip "Skipped ${tfile} (project has its own version)"
          fi
          ;;
        *)
          # Config files: template overwrites
          cp "$src" "$dst"
          log_ok "Updated ${tfile}"
          changes_made=true
          ;;
      esac
    else
      # New file — always add
      cp "$src" "$dst"
      log_ok "Added ${tfile} (new file)"
      changes_made=true
    fi
  done

  # Commit and push if changes were made
  if [ "$changes_made" = true ]; then
    if [ "$dry_run" = true ]; then
      log_info "Dry run — changes prepared but not committed for ${repo}"
      git diff --stat
    else
      git add -A
      git commit -m "chore: sync template updates from repo-template v${TEMPLATE_VERSION}" \
        -m "Automated propagation from template version ${TEMPLATE_VERSION}." \
        -m "Template files (AI configs, rules, workflows): template overwrites project" \
        -m "Project-specific files (docs, source): project version preserved"

      if git push origin "$default_branch" 2>&1; then
        log_ok "Pushed changes to ${repo} (${default_branch})"
      else
        log_error "Failed to push changes to ${repo}"
      fi
    fi
  else
    log_ok "No changes needed for ${repo}"
  fi

  popd > /dev/null
  rm -rf "$repo_dir"
}

# ============================================================================
# Main
# ============================================================================

DRY_RUN=false
FILTER_REPOS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --repo)
      IFS=',' read -ra FILTER_REPOS <<< "$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--dry-run] [--repo repo1,repo2,...]"
      exit 1
      ;;
  esac
done

# Determine which repos to process
if [ ${#FILTER_REPOS[@]} -gt 0 ]; then
  REPOS_TO_PROCESS=("${FILTER_REPOS[@]}")
else
  REPOS_TO_PROCESS=("${DOWNSTREAM_REPOS[@]}")
fi

echo "========================================================"
echo "  Repo Template Propagation v${TEMPLATE_VERSION}"
echo "  Dry run: ${DRY_RUN}"
echo "  Date:    $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo "  Repos:   ${#REPOS_TO_PROCESS[@]}"
echo "========================================================"
echo ""

SUCCESS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0

for repo in "${REPOS_TO_PROCESS[@]}"; do
  echo "----------------------------------------"
  if propagate_to_repo "$repo" "$DRY_RUN"; then
    ((SUCCESS_COUNT++))
  else
    # Check if it was a "not found" error and track separately
    ((FAIL_COUNT++))
  fi
  echo ""
done

echo "========================================================"
echo "  Propagation Complete"
echo "  Successful: ${SUCCESS_COUNT}"
echo "  Failed:     ${FAIL_COUNT}"
echo "  Total:      ${#REPOS_TO_PROCESS[@]}"
echo "========================================================"

exit $((FAIL_COUNT > 0 ? 1 : 0))
