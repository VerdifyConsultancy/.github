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
- This guidance: `AGENTS.md`, plus `CLAUDE.md`, a regular one-line file holding `@AGENTS.md` (Claude Code's import) so Claude reads this file too.

Adjacent lanes — change these in their owner, not here:
- Verdify positioning, service names and the verdify.ai pages the profile links to → `VerdifyConsultancy/verdify-www` (service names in `src/data/site-shell.ts`, routes under `src/pages/`). Take profile wording from there rather than writing new copy here.
- Verdify Lab (https://lab.verdify.ai) and its greenhouse and control-loop claims → `VerdifyConsultancy/verdify-platform`. The profile links to the lab; architecture detail stays there.
- `.agent-fleet/ci.yaml`, the repo pod, this repo's registry record and the pod's managed briefing block → `jvallery/agents`. `ci.yaml` is generated from the registry `ci_submission`, so a hand edit is overwritten.
- Issue and PR templates, CONTRIBUTING, SECURITY and CODE_OF_CONDUCT → each repo keeps its own.

In transition — change it where it lives today; put new work in the target lane:
- Profile copy: `profile/README.md` has its own tagline and service names, which have drifted from verdify.ai. Edit the profile here, taking the wording from verdify-www ([jvallery/agents#4492](https://github.com/jvallery/agents/issues/4492)).
- Pod briefing: at boot the repo pod appends its managed briefing to the tracked `AGENTS.md` and, for Claude, to `CLAUDE.md`, so Claude in the pod reads it twice (once in `CLAUDE.md`, once through its `@AGENTS.md` import). The fix that moves it out of worktrees into user-level files belongs to `jvallery/agents` and is still open ([jvallery/agents#4453](https://github.com/jvallery/agents/issues/4453)); until it lands, follow the staging rule under Hazards.

## Deliver and verify

- No deployed runtime: nothing here reaches k3s or Argo CD (registry delivery mode `validate-only`). A merge to `main` publishes `profile/README.md` on the org page at once. `main` has no branch protection or required check; [#2](https://github.com/VerdifyConsultancy/.github/issues/2) tracks wiring fleet CI for this repo and then making `organization-files` required.
- `.agent-fleet/ci.yaml` declares the generated `organization-files` check: whitespace errors in unstaged changes (`git diff --check`), conflict markers outside Markdown, and a YAML parse of every `*.yml`/`*.yaml`. No fleet CI run fires on push or PR and no status is published, so run it locally before every commit, while your edits are still unstaged.
- Verify a profile change: `gh api repos/VerdifyConsultancy/.github/contents/profile/README.md --jq .sha` equals `git rev-parse HEAD:profile/README.md`, the page at https://github.com/VerdifyConsultancy renders, and every profile link resolves (`curl -sL -o /dev/null -w '%{http_code}\n' <url>` returns 200).

## Working here

- Hazards:
  - The repo is public, so every commit is world-readable. Commit no internal hostnames, IPs, namespaces, Secret names or other private estate detail.
  - The pod's managed briefing in `AGENTS.md` and `CLAUDE.md` (between the `BEGIN`/`END agent-fleet operating-environment briefing` comment markers) lists internal topology, and only a best-effort `git update-index --skip-worktree` keeps it out of commits. Stage files by name, not `git add -A`, and read `git diff --cached` before committing. Never write the full BEGIN marker text into a tracked file: the pod detects its block by substring and replaces only an exact marker line, so a quoted marker blocks injection and a bare marker line can swallow the lines after it.
  - Keep `CLAUDE.md` the regular one-line `@AGENTS.md` import, not a symlink, and put guidance in `AGENTS.md`. The repo-pod runtime's context converge turns a newly introduced `CLAUDE.md` or `AGENTS.md` symlink into a regular file holding the link text, treats it as local work and stops fast-forwarding the pod clone ([jvallery/agents#4453](https://github.com/jvallery/agents/issues/4453)).
  - Add no `workflow-templates/` or org-default community health files here. GitHub offers or applies them to every org repo that lacks its own file, so each one is an org-wide change, and the estate lane map excludes them from this repo. CI for this repo is declared in `.agent-fleet/ci.yaml` for fleet CI, not GitHub Actions.
- Focused commands:
  - `bash -c "$(yq '.checks.steps[] | select(.name == "organization-files") | .command' .agent-fleet/ci.yaml)"` runs the CI check locally (every change).
  - `git ls-files -s AGENTS.md CLAUDE.md` shows both as mode `100644`, and `git show :CLAUDE.md` prints only `@AGENTS.md` (guidance edits; both read the index, so the pod's appended briefing does not show).
