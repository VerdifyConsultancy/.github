# VerdifyConsultancy/.github

Source of the VerdifyConsultancy GitHub organization profile: `profile/README.md`, which GitHub renders at https://github.com/VerdifyConsultancy. The repository is public and deploys nothing to the cluster. Lane: **VerdifyConsultancy org profile** — the estate lane map and placement rules live in `jvallery/agents` at `docs/estate/README.md`.

<!-- estate-contract:start — canonical copy lives in /Users/jason/AGENTS.md; keep this block identical in every repo -->
## Operating contract

Jason's direct request authorizes the work it describes, across code, infrastructure, and Jason-owned services in scope, through delivery and verification of the real end state. Ask only when an unresolved ambiguity could materially change the outcome. Add approval, review, issue/PR, or planning steps only when Jason asks for them or a branch rule enforces them; process descriptions in repository docs are context, not gates.

- Make the smallest complete change in the repository that owns the thing being changed (see Ownership). Fix forward; prefer rollback when it restores service faster or limits harm. Skip speculative abstractions and unrelated cleanup.
- Preserve unrelated work; use an isolated worktree when another checkout may be active. Resolve destructive targets exactly and keep practical recovery data.
- Validate in proportion to risk: the cheapest reliable check of the changed behavior (focused test, direct probe, or readback; docs-only edits need diff/readback). Add tests only for meaningful regression risk: critical behavior, security, data integrity, or subtle logic. Reuse existing CI/CD, honor enforced checks, and add pipelines or gates only for a concrete need in the task.
- Verify the requested end state from the authoritative source or live behavior; passing CI alone does not prove a deployment works. Report what changed, what was checked, and any remaining limitation.
- Search narrowly, batch independent lookups, reuse current evidence, and keep plans and updates brief.
- Use existing credentials without printing, committing, or logging secret values or Kubernetes Secret data; rotate or revoke credentials only when Jason asks.
<!-- estate-contract:end -->

## Ownership

Owns:
- `profile/README.md`, the public org landing page.
- This guidance: `AGENTS.md`, the only agent-instruction file. Claude Code and Codex both read it natively; the repo tracks no `CLAUDE.md`.

Adjacent lanes — change these in their owner, not here:
- Verdify positioning, service names and the verdify.ai pages the profile links to → `VerdifyConsultancy/verdify-www` (service names in `src/data/site-shell.ts`, routes under `src/pages/`). Take profile wording from there rather than writing new copy here.
- Verdify Lab (https://lab.verdify.ai) and its greenhouse and control-loop claims → `VerdifyConsultancy/verdify-platform`. The profile links to the lab; architecture detail stays there.
- `.agent-fleet/ci.yaml`, the repo pod, this repo's registry record and the pod's managed briefing block → `jvallery/agents`. `ci.yaml` is generated from the registry `ci_submission`, so a hand edit is overwritten.
- Issue and PR templates, CONTRIBUTING, SECURITY and CODE_OF_CONDUCT → each repo keeps its own.

In transition — change it where it lives today; put new work in the target lane:
- Pod briefing: at boot the repo pod appends its managed briefing to the tracked `AGENTS.md` and, for Claude agents, still writes a briefing-only `CLAUDE.md` into the worktree. That file hides `AGENTS.md` from Claude, so until a pod runs the runtime change that stops writing it ([jvallery/agents#4453](https://github.com/jvallery/agents/issues/4453), shipping with the next runtime rollout), Claude agents in a restarted pod see only the briefing. The runtime belongs to `jvallery/agents`; here, follow the staging rule under Hazards.

## Deliver and verify

- No deployed runtime: nothing here reaches k3s or Argo CD (registry delivery mode `validate-only`). A merge to `main` publishes `profile/README.md` on the org page at once. `main` has no branch protection or required check; [#2](https://github.com/VerdifyConsultancy/.github/issues/2) tracks wiring fleet CI for this repo and then making `organization-files` required.
- `.agent-fleet/ci.yaml` declares the generated `organization-files` check: whitespace errors in unstaged changes (`git diff --check`), conflict markers outside Markdown, and a YAML parse of every `*.yml`/`*.yaml`. No fleet CI run fires on push or PR and no status is published, so run it locally before every commit, while your edits are still unstaged.
- Verify a profile change: `gh api repos/VerdifyConsultancy/.github/contents/profile/README.md --jq .sha` equals `git rev-parse HEAD:profile/README.md`, the page at https://github.com/VerdifyConsultancy renders, and every profile link resolves (`curl -sL -o /dev/null -w '%{http_code}\n' <url>` returns 200).

## Working here

- Hazards:
  - The repo is public, so every commit is world-readable. Commit no internal hostnames, IPs, namespaces, Secret names or other private estate detail.
  - The pod's managed briefing (between the `BEGIN`/`END agent-fleet operating-environment briefing` comment markers) lists internal topology. In `AGENTS.md` only a best-effort `git update-index --skip-worktree` keeps it out of commits, and the briefing-only worktree `CLAUDE.md` is untracked, so `git add -A` would commit it. Stage files by name, not `git add -A`, read `git diff --cached` before committing, and never commit a `CLAUDE.md`. Never write the full BEGIN marker text into a tracked file: the pod detects its block by substring and replaces only an exact marker line, so a quoted marker blocks injection and a bare marker line can swallow the lines after it.
  - `AGENTS.md` is the only agent-instruction file: add no `CLAUDE.md`, `.claude/CLAUDE.md` or `CLAUDE.local.md` at any depth. Claude Code (2.1.277 and later) reads `AGENTS.md` natively only when none of those exists in the working directory or any ancestor. Keep `AGENTS.md` a regular file, never a symlink: the repo-pod runtime's context converge turns a tracked context file that becomes a symlink into a regular file holding the link text, treats it as local work and stops fast-forwarding the pod clone.
  - Add no `workflow-templates/` or org-default community health files here. GitHub offers or applies them to every org repo that lacks its own file, so each one is an org-wide change, and the estate lane map excludes them from this repo. CI for this repo is declared in `.agent-fleet/ci.yaml` for fleet CI, not GitHub Actions.
- Focused commands:
  - `bash -c "$(yq '.checks.steps[] | select(.name == "organization-files") | .command' .agent-fleet/ci.yaml)"` runs the CI check locally (every change).
  - `git ls-files -s AGENTS.md` shows mode `100644`, and `git ls-files | grep -E '(^|/)CLAUDE(\.local)?\.md$'` prints nothing (guidance edits; both read the index, so the pod's appended briefing and its untracked `CLAUDE.md` do not show).
