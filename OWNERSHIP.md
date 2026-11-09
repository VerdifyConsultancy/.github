# OWNERSHIP: VerdifyConsultancy/.github

This repository owns the **VerdifyConsultancy org profile** lane: `profile/README.md`, which GitHub renders on the organization page, and this repository's own guidance. It deploys nothing.

This repository is **public**. This file therefore records only the ownership facts; it carries no internal hostnames, addresses, namespaces or Secret names.

- Central record (one owner per item): [docs/fleet-inventory/ESTATE-INVENTORY.md](https://github.com/jvallery/agents/blob/main/docs/fleet-inventory/ESTATE-INVENTORY.md) in `jvallery/agents` (private), rendered from its estate-ownership policy (estate rule R1). The record and its render path are planned to move to `jvallery/estate-platform` when `jvallery/agents` retires. Owner page for this repository: [docs/fleet-inventory/estate/VerdifyConsultancy__.github.md](https://github.com/jvallery/agents/blob/main/docs/fleet-inventory/estate/VerdifyConsultancy__.github.md).
- Lane map and rules: `jvallery/agents` [`docs/estate/README.md`](https://github.com/jvallery/agents/blob/main/docs/estate/README.md) sections 4.1 and 4.3 (R1 to R22); standards register `docs/estate/STANDARDS.md` beside it. Both are planned to move to `jvallery/estate-platform`.
- **How to update:** change the central entry in `jvallery/agents` and this file in the same change set (paired PRs that reference each other).

Inventory snapshot: 2026-11-08 (GitHub API read during the estate convergence census). Central record status for every item matches the Status column below. The central record still reads `state: idle`, which this file keeps.

## Summary by kind

| Kind | Count | Ids |
|---|---|---|
| repo | 1 | `repo:verdifyconsultancy/.github` |
| **Total items** | **1** | |
| Kubernetes objects, containers, scheduled jobs | 0 | none |

## Repository

| Id | Name | Where | What | State | Source of truth | Health | Critical dependencies | Status / action |
|---|---|---|---|---|---|---|---|---|
| `repo:verdifyconsultancy/.github` | VerdifyConsultancy/.github | github.com/VerdifyConsultancy/.github (public, default branch `main`), rendered at https://github.com/VerdifyConsultancy | Org profile README (`profile/README.md`) and this repo's `AGENTS.md` | idle (last push 2026-11-06) | this repo `AGENTS.md`; content `profile/README.md` | none (no GitHub Actions workflows and no status checks; `main` protected with linear history and no force pushes or deletions, no required check; `ci/check.sh` is operator-run) | `jvallery/agents` registry record (`desired_state: ci-only`), planned to retire with `jvallery/agents`; profile wording sourced from `jvallery/verdify-www`; lab links to `jvallery/verdify-platform` | owned. No workflow or required check is planned (no VerdifyConsultancy runner set). |

## Coverage gaps

- `repo:verdifyconsultancy/.github`: no health signal. There is no runtime to probe; a broken profile link or YAML/whitespace error can reach `main` unchecked, because `ci/check.sh` is operator-run and does not read `profile/README.md` on a clean checkout. Accepted for a non-deployed repository; no new alert or workflow is proposed.

## Open actions

| Kind | Objects | Action | Tracking |
|---|---|---|---|
| retirement | `repo:verdifyconsultancy/.github` | Retire this repo's registry record and derived catalog rows in `jvallery/agents` | planned with the `jvallery/agents` retirement |
