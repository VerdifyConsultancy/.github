# OWNERSHIP: VerdifyConsultancy/.github

This repository owns the VerdifyConsultancy organization profile: `profile/README.md`, which GitHub renders on the organization page. It deploys nothing. The repository is public, so this file states ownership only and carries no internal detail.

The central record is `ownership/record/` in jvallery/estate-platform, rendered to [ESTATE-INVENTORY.md](https://github.com/jvallery/estate-platform/blob/main/docs/estate/ESTATE-INVENTORY.md) and to [this repository's page](https://github.com/jvallery/estate-platform/blob/main/docs/estate/inventory/VerdifyConsultancy__.github.md). When an item is added, moved or retired, change the record and this file in the same piece of work.

## Owned here

| Item | What |
|---|---|
| `repo:verdifyconsultancy/.github` | Public repository, rendered at https://github.com/VerdifyConsultancy. |
| `profile/README.md` | The organization profile page. |
| `ci/check.sh` | A local whitespace, conflict-marker and YAML check. |

## Owned elsewhere

| Thing | Owner |
|---|---|
| Verdify positioning, service names and the verdify.ai pages | jvallery/verdify-www |
| Verdify Lab and its greenhouse claims | jvallery/verdify-platform |
| Organization settings, rulesets and the branch-protection baseline | jvallery/estate-platform |

## Known gaps

- The repository has no CI, so a broken profile link can reach `main` unchecked; `ci/check.sh` does not read `profile/README.md` on a clean checkout.
