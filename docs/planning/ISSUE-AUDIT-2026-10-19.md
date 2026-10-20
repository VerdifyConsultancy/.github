# Issue audit: VerdifyConsultancy/.github (2026-10-19)

## Scope and method
Scope: every open issue in `VerdifyConsultancy/.github`. Only #2 is open, as observed 2026-10-19T23:00Z. The audit was read-only, with evidence from:
- `gh` issues, PRs, branches, commit status and check-runs, branch protection, rulesets and Actions permissions;
- the agents registry record `control-plane/agent-fleet-control/registry/repos/gh-1262232364.yaml` on `origin/main`;
- `kubectl --context vallery-api-vip` for pods and namespaces;
- this repo's `AGENTS.md` and `OWNERSHIP.md` on `main`.

The repo has no prior handoff or status convention: there is no `docs/` directory, and the root holds only `.agent-fleet/`, `.gitignore`, `AGENTS.md`, `OWNERSHIP.md` and `profile/`. This file sets the default path.

Re-verified 2026-10-20T01:31Z, with no change: #2 is still the only open issue (updatedAt 2026-10-13T17:38:29Z, 2 comments), there are no open PRs, main is at `2ed11831` with 0 statuses and 0 check runs, there are no native links, and the related jvallery/agents issues are in the states listed below.

## Coverage ledger summary
Assessed: 1. Pending: 0. Blocked: 0. Closures proposed: 0.

| Issue | Assessment | Priority | Next action |
|---|---|---|---|
| #2 [Get-well] reliable validation and a secretless repo pod | stale-needs-rewrite. The repo-pod half is superseded because the pod is retired. The validation-gating half is not started. | Medium (the repo has no priority labels, so none is applied) | Rewrite the title and body to validation-gating only. Open a no-op PR and read back `/commits/<sha>/status`. If no fleet context appears, file the producer defect in jvallery/agents. |

## Decisions
- Keep #2 open. Acceptance is not demonstrated: no status, no protection.
- Re-scope #2 instead of closing it. The repo-pod criteria are superseded by agents#4855 (open) and agents#4823 (open, program). The registry `desired_state: ci-only` comes from agents#4825 (closed). The validation and protection criteria stay in #2, which is their canonical issue.
- Correction to the chunk ledger: the criterion "AGENTS.md guidance says validation-only with no repo pod" is **already satisfied**. `AGENTS.md` on main (line about `.agent-fleet/ci.yaml`) states `desired_state: ci-only`, no repo pod, and points validation work at #2. Move it to satisfied.
- No priority or status labels are applied. The repo only has default labels plus `triage:2026-10-01`, and no labels are invented.

## Evidence (observed 2026-10-19T22:56Z to 23:00Z)
Verified:
- `main` HEAD is `2ed11831fa8fa7deaa3d347b8c22954cbd1ae92f` (PR #4, OWNERSHIP.md). Combined status is `pending` with 0 statuses, and there are 0 check runs.
- `main` is not protected (protection API returns 404), and there are 0 rulesets.
- Actions settings are `allowed_actions=all` with `sha_pinning_required=false`. There are no workflows; per AGENTS.md, CI goes through `.agent-fleet/ci.yaml`.
- The registry record `gh-1262232364.yaml` has `desired_state: ci-only`, validate-only, activation enabled and one `organization-files` step.
- No namespace or pod for this repo exists in cluster `vallery`.
- Secret scanning and push protection are off on this public repo. That is tracked in jvallery/agents#5129, which is open.

Inferred: the fleet CI status producer does not publish to VerdifyConsultancy repos, because verdify-www `main` also has no statuses.

Missing evidence: whether the agent-fleet-ci broker receives events for repo id 1262232364. To get it, open a no-op PR, then check the broker/dashboard logs for that repo id and read back `/commits/<sha>/status`.

## Native graph
#2 has no `blocked_by`, `blocking`, sub-issues or parent. No cycles. No edge fixes now. If the producer defect is confirmed, file it in jvallery/agents and add it as `blocked_by` on #2.

## Active branches and open PRs
- Open PRs: none.
- `main` is at `2ed11831fa8fa7deaa3d347b8c22954cbd1ae92f`.
- `fleet/ci-cd-contract-3507` is at `3e3a0233ba88dab05f2bffc6c2af341f1481c4c0`. It was the head of PR #1, merged 2026-08-03, and has diverged from main (ahead 1, behind 7) because the PR was squash-merged. It is a stale branch: Jason or the coordinator may delete it after confirming the one commit is in PR #1's merge.
- Merged related PRs: #1 (CI contract, 2026-08-03), #3 (2026-09-26), #4 (OWNERSHIP.md, 2026-10-19).

## Incomplete work and verification results
Every validation and gating criterion in #2 is outstanding:
- exact-SHA `fleet-ci/validation/argo` on PR and push, with green, red and cancel/retry cases and a durable target URL;
- `main` protection, with before/after readback;
- an Actions allowlist and SHA pinning.

Nothing has been deployed or verified for those criteria.

## Execution sequence
1. #2 phase 1 (ready): re-scope the issue body, then run the no-op PR status probe.
2. If no status appears: in jvallery/agents, diagnose why the fleet producer skips the VerdifyConsultancy org. File it and link it as `blocked_by` on #2.
3. #2 phase 2: once statuses are reliable, apply branch protection and the Actions policy, read both back, and close #2 with that readback evidence.

## Cross-repo dependencies
- jvallery/agents: the fleet CI producer and registry, which owns `.agent-fleet/ci.yaml`. Related issues: #4855 (open), #4823 (open), #4825 (closed), #4149 (open, Actions/trusted delivery policy) and #5129 (open, secret scanning).

## Standards
STD-CI-01, STD-CI-02, STD-CI-04; estate rule R17.

## Unresolved questions
- Does the fleet CI producer cover VerdifyConsultancy-org repos at all? The answer decides whether a new agents issue is needed.
- Should the Actions restriction for this repo be set per repo, or set org-wide under agents#4149?

## Exact next actions for the coordinator or the next agent
1. Replace #2's body with the ledger `status_block`, with the AGENTS.md criterion moved to satisfied, and retitle it to "[Get-well] Gate `VerdifyConsultancy/.github` main on fleet validation".
2. Open a trivial PR (for example, a whitespace change to `profile/README.md`, never `.agent-fleet/ci.yaml`). Wait, then run `gh api repos/VerdifyConsultancy/.github/commits/<sha>/status` and `/check-runs`.
3. Branch on the result: no context means filing the producer defect in jvallery/agents and adding `blocked_by`; a context present means testing the red and cancel cases next.
4. Snapshot the current state, apply protection, and read back `/branches/main/protection` and `/actions/permissions`.

---
_Applied to GitHub by the coordinator on 2026-10-19: 1 issue operations succeeded (status blocks, labels, native blocked-by and sub-issue links, evidence-based closures, follow-ups). Each issue's `<!-- planning-status -->` block is the live per-issue record._
