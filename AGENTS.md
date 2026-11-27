# VerdifyConsultancy/.github

Source of the VerdifyConsultancy organization profile: GitHub renders `profile/README.md` at https://github.com/VerdifyConsultancy. The repository is public and runs nothing; a merge to `main` is the whole release.

`AGENTS.md` is the one agent instruction file here. Do not add a `CLAUDE.md` at any depth (`.gitignore` refuses it).

## This repository

- It owns `profile/README.md`, the public landing page of the organization. [`OWNERSHIP.md`](OWNERSHIP.md) lists the items.
- `ci/check.sh` is a local check. The repository has no GitHub Actions workflows and no required check.

## Change, check and publish

- Take wording, service names and links from the live site, https://verdify.ai. Do not write new marketing copy here, and never add a claim the site does not make.
- Work on a branch and open a pull request against `main`; `main` requires linear history, so merge by squash or rebase. Revert and merge to undo a change.
- Run `ci/check.sh` before committing, while your edits are still unstaged. It checks whitespace errors in the unstaged diff, conflict markers outside Markdown and that every YAML file parses (it needs `yq`). It does not read `profile/README.md` on a clean checkout, so review a profile edit in the diff.
- Prove it live: `gh api repos/VerdifyConsultancy/.github/contents/profile/README.md --jq .sha` equals `git rev-parse origin/main:profile/README.md`, the page at https://github.com/VerdifyConsultancy renders, and every profile link returns 200 from `curl -sL -o /dev/null -w '%{http_code}\n' <url>`.

## Hazards

- The repository is public: every commit, commit message, branch and pull request is readable by anyone, for good, and a scanner reads branch history. Add no internal hostnames, IP addresses, credentials, client names or absolute workstation paths (nothing that starts with a home or volume directory). Stage files by name and read `git diff --cached` before committing.
- GitHub applies some files in this repository to every repository in the organization that lacks its own: `workflow-templates/` and the default community health files (issue and pull request templates, CONTRIBUTING, SECURITY, CODE_OF_CONDUCT). Add none of them here; each repository keeps its own.
- The profile makes public claims about Verdify's services and the Public Proof Lab. Keep them consistent with the live site.

## Neighbours

- The verdify.ai site is the source of the profile's wording and links.
- Verdify Lab (https://lab.verdify.ai) and its greenhouse claims: [jvallery/verdify-platform](https://github.com/jvallery/verdify-platform).
- Organization settings and branch protection are managed by the organization owners.
