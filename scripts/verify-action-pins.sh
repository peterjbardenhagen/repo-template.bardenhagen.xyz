#!/usr/bin/env bash
# ============================================================================
# verify-action-pins.sh — every pinned GitHub Action SHA must be real
# ============================================================================
# Supply-chain policy is to pin actions to a full commit SHA with the version
# in a trailing comment:
#
#     uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
#
# A SHA nobody verified is worse than a floating tag: the job does not run
# degraded, it fails to start with "Unable to resolve action ... unable to
# find version", and the cause is invisible in the workflow file because the
# SHA looks perfectly plausible. Invented SHAs are an easy mistake for both
# humans and agents.
#
# This script resolves each trailing-comment tag against the live repo and
# fails if the SHA does not match.
#
# Usage: ./scripts/verify-action-pins.sh [workflow-dir]   (default .github/workflows)
# ============================================================================

set -uo pipefail

WORKFLOW_DIR="${1:-.github/workflows}"
failures=0
checked=0

# Resolve a tag to its COMMIT sha. For an annotated tag, refs/tags/vX is the
# tag object, not the commit — querying both and taking the last sorted line
# yields the dereferenced commit when it exists, and the only line otherwise.
resolve() {
  git ls-remote "https://github.com/$1" "refs/tags/$2^{}" "refs/tags/$2" 2>/dev/null \
    | sort -k2 | tail -1 | cut -f1
}

echo "Verifying pinned action SHAs in ${WORKFLOW_DIR}"
echo

while read -r spec tag; do
  [ -z "${spec:-}" ] && continue
  action_path="${spec%@*}"
  sha="${spec#*@}"
  owner_repo=$(echo "$action_path" | cut -d/ -f1,2)

  checked=$((checked + 1))
  real=$(resolve "$owner_repo" "$tag")

  if [ -z "$real" ]; then
    printf '  FAIL  %-44s %-10s tag does not exist upstream\n' "$action_path" "$tag"
    failures=$((failures + 1))
  elif [ "$real" != "$sha" ]; then
    printf '  FAIL  %-44s %-10s pinned %s, %s is %s\n' \
      "$action_path" "$tag" "${sha:0:12}…" "$tag" "${real:0:12}…"
    failures=$((failures + 1))
  else
    printf '  ok    %-44s %s\n' "$action_path" "$tag"
  fi
done < <(
  grep -rhoE 'uses: [A-Za-z0-9_.-]+/[A-Za-z0-9_./-]+@[0-9a-f]{40} # v[0-9.]+' "$WORKFLOW_DIR" \
    | sed -E 's/^uses: //; s/ # / /' | sort -u
)

# A pin without a version comment cannot be verified, and Dependabot cannot
# bump it either — treat it as a failure rather than skipping silently.
while read -r line; do
  [ -z "${line:-}" ] && continue
  printf '  FAIL  %s\n          pinned SHA has no "# vX.Y.Z" comment — unverifiable and Dependabot cannot bump it\n' "$line"
  failures=$((failures + 1))
done < <(
  grep -rhoE 'uses: [A-Za-z0-9_.-]+/[A-Za-z0-9_./-]+@[0-9a-f]{40}([^ ]|$)' "$WORKFLOW_DIR" \
    | grep -vE '@[0-9a-f]{40} # v' | sed -E 's/^uses: //' | sort -u
)

# Floating tags (@v4) are the thing pinning exists to prevent.
while read -r line; do
  [ -z "${line:-}" ] && continue
  printf '  FAIL  %s\n          floating tag — pin to a full commit SHA\n' "$line"
  failures=$((failures + 1))
done < <(
  grep -rhoE 'uses: [A-Za-z0-9_.-]+/[A-Za-z0-9_./-]+@v[0-9][A-Za-z0-9_.-]*' "$WORKFLOW_DIR" \
    | sed -E 's/^uses: //' | sort -u
)

echo
if [ "$failures" -gt 0 ]; then
  echo "FAILED — ${failures} bad pin(s) across ${checked} verified."
  echo
  echo "Resolve a real SHA with:"
  echo "  git ls-remote https://github.com/OWNER/REPO refs/tags/TAG'^{}' refs/tags/TAG \\"
  echo "    | sort -k2 | tail -1 | cut -f1"
  exit 1
fi

echo "OK — ${checked} pin(s) verified against live tags."
