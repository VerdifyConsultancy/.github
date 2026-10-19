# OWNERSHIP: VerdifyConsultancy/.github

This repository owns the **VerdifyConsultancy org profile** lane: `profile/README.md`, which GitHub renders on the organization page, and this repository's own guidance. It deploys nothing.

This repository is **public**. This file therefore records only the ownership facts; it carries no internal hostnames, addresses, namespaces or Secret names.

- Central record (one owner per item): [docs/fleet-inventory/ESTATE-INVENTORY.md](https://github.com/jvallery/agents/blob/main/docs/fleet-inventory/ESTATE-INVENTORY.md) in `jvallery/agents` (private), rendered from its estate-ownership policy (estate rule R1). Owner page for this repository: [docs/fleet-inventory/estate/VerdifyConsultancy__.github.md](https://github.com/jvallery/agents/blob/main/docs/fleet-inventory/estate/VerdifyConsultancy__.github.md).
- Lane map and rules: `jvallery/agents` [`docs/estate/README.md`](https://github.com/jvallery/agents/blob/main/docs/estate/README.md) sections 4.1 and 4.3 (R1 to R22).
- **How to update:** change the central entry in `jvallery/agents` and this file in the same change set (paired PRs that reference each other).

Inventory snapshot: 2026-10-19 (GitHub API). Central record status for every item matches the Status column below (final record, 2026-10-19). None of Jason's 2026-10-19 decisions (D-01 to D-23) changes an item owned here.

## Summary by kind

| Kind | Count | Ids |
|---|---|---|
| repo | 1 | `repo:verdifyconsultancy/.github` |
| **Total items** | **1** | |
| Kubernetes objects, containers, scheduled jobs | 0 | none |

## Repository

| Id | Name | Where | What | State | Source of truth | Health | Critical dependencies | Status / action |
|---|---|---|---|---|---|---|---|---|
| `repo:verdifyconsultancy/.github` | VerdifyConsultancy/.github | github.com/VerdifyConsultancy/.github (public, default branch `main`), rendered at https://github.com/VerdifyConsultancy | Org profile README (`profile/README.md`) and this repo's `AGENTS.md` | idle (last push 2026-09-26) | this repo `AGENTS.md`; content `profile/README.md` | none (no GitHub Actions workflows; the fleet `organization-files` check publishes no status; `main` unprotected) | `jvallery/agents` (registry record with `desired_state: ci-only`, generated `.agent-fleet/ci.yaml`); profile wording sourced from `VerdifyConsultancy/verdify-www`; lab links to `VerdifyConsultancy/verdify-platform` | owned. Get-well (fleet CI status, then a required `organization-files` check) is [#2](https://github.com/VerdifyConsultancy/.github/issues/2). |

## Coverage gaps

- `repo:verdifyconsultancy/.github`: no health signal. There is no runtime to probe; the gap that matters is that a broken profile link or YAML/whitespace error reaches `main` unchecked. Tracked by [#2](https://github.com/VerdifyConsultancy/.github/issues/2); no new alert is proposed.

## Open actions

| Kind | Objects | Action | Tracking |
|---|---|---|---|
| transition | `repo:verdifyconsultancy/.github` | Land this file and the R22 AGENTS.md sections; refresh the stale operating-contract block | proposed (actions.json) |
| coverage | `repo:verdifyconsultancy/.github` | Fleet CI status and required check | existing [#2](https://github.com/VerdifyConsultancy/.github/issues/2) |
