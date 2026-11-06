#!/usr/bin/env bash
# Portable repository check: runs the same on any runner (self-hosted Actions
# runner, Forgejo/Gitea Actions, or a laptop). Carries the organization-files
# check that the retired fleet CI spec ran. Needs git, find and yq.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
git diff --check
if git grep -n -E '^(<<<<<<<|=======$|>>>>>>>)' -- . ':!*.md'; then
  echo "conflict markers found" >&2
  exit 1
fi
find . -path ./.git -prune -o -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
  | xargs -0 -r -n1 yq eval '.' >/dev/null
