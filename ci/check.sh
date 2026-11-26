#!/usr/bin/env bash
# Local repository check: whitespace errors in the unstaged diff, conflict
# markers outside Markdown, and a YAML parse of every *.yml and *.yaml file.
# Needs git, grep, find and yq.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
git diff --check
if grep -rInE --exclude-dir=.git --exclude='*.md' '^(<<<<<<<|=======$|>>>>>>>)' .; then
  echo "conflict markers found" >&2
  exit 1
fi
find . -path ./.git -prune -o -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
  | xargs -0 -r -n1 yq eval '.' >/dev/null
