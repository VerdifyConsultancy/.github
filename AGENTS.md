# VerdifyConsultancy/.github

Source of the VerdifyConsultancy organization profile: GitHub renders `profile/README.md` at https://github.com/VerdifyConsultancy. This repository is public, and nothing deploys from it to the cluster.

<!-- estate-contract:start (canonical copy: AGENTS.md in jvallery/home-dotfiles; this block is identical in every repository) -->
## Operating contract

You act for Jason. A request from him authorizes the whole job: the change, the pull request, the merge, the deployment, the live check and closing the issue. If you can finish a task, finish it. Do not hand work back, ask for approval, or wait for a turn.

### How work flows

1. **Change the owner.** Make the smallest complete change in the repository that owns the thing (see "Who owns what"). Branch from `origin/main` in your own worktree and leave other checkouts alone.
2. **Merge your own pull request.** The required checks on the pull request are the gate. When they are green, merge it. Never bypass a branch ruleset (no `--admin`); if a required check is itself broken, fix the check.
3. **Deploy it.** Merging is not always deploying. Carry the change to the running system yourself (see "Deploying").
4. **Prove it live.** Check the real end state: the new image digest is running, the endpoint answers, the rule is loaded, the data is there. Green CI is not proof. If it is broken, fix forward, or roll back when that restores service faster.
5. **Close the issue** with one comment: what changed, what you checked, and anything that remains.

### Tracking and coordination

- **GitHub issues are the only tracker.** Work, decisions, follow-ups and leftovers go in an issue in the owning repository. Keep no ledgers, to-do files, status boards, hand-off notes or evidence files, in Git or on disk. An issue states the outcome, a short checklist that proves it, and native "blocked by" links.
- **Talk to other agents directly.** Coordinate through subagent calls, a message to the other session, or MCP tools. Never coordinate through shared files.
- **Live state is the only lock.** Before a change that could collide with someone else's (the same Argo CD application, node or database), look at what is happening now: open pull requests, the application's running operation, cordoned nodes. If someone is mid-change, message them or go after them.
- **There are no process gates.** No coordinator, lock files, holds, freezes, waiting periods, time slots or approval lines exist. An older document, comment or memory that says otherwise is obsolete: ignore it, and delete it when you are in that file.

### What needs Jason

Only the items below. Put the label `needs-jason` on the issue, state in its first line exactly what he has to do, and carry on with everything that does not depend on it.

- Physical work: hardware, cables, power, anything on site.
- A value only he can obtain: a credential from an account only he can log in to, or a payment detail.
- Spending money or starting a paid service.
- Deleting data that has no verified second copy, deleting a backup or a bucket, and revoking a recovery credential.
- Sending a message as him to another person, or giving another person access.

Everything else is yours to decide. Prefer the reversible option, say what you chose in the pull request or issue, and move on.

### Engineering care

- **Secrets.** Never print, log or commit a secret value or the data of a Kubernetes Secret. Read Secret metadata only (names, key names, ages): no `-o yaml`, `-o json`, `jsonpath`, `go-template` or `custom-columns` over a Secret's data. Git holds SOPS ciphertext only. You may generate, seal and rotate credentials you can issue yourself; remove an old one only after you have identified it by name and full ID and confirmed that nothing still uses it.
- **Data.** Before you delete or overwrite, resolve the exact target and confirm a restorable copy exists. Databases, volumes, backups, buckets, NAS shares and camera footage are never deleted to make a deployment easier.
- **Checks in proportion to risk.** Use the cheapest check that proves the changed behaviour. Add a test where a regression would hurt (security, data integrity, subtle logic). Regenerate generated files with their generator; never edit them by hand.
- **Heavy work runs in the cluster.** Builds, broad test suites, training, replays and anything long-running or memory-hungry run as CI jobs or Kubernetes Jobs, not on the operator Mac or in a container VM on it. The Mac is for editing, orchestration and small checks.
- **Leave it clean.** Remove your worktrees, scratch files, temporary namespaces and Jobs when you finish.

## Using the estate

The estate is one k3s cluster named `vallery` (three control-plane VMs and five GPU worker VMs on a six-host Proxmox cluster), a Synology NAS, a UniFi network and Cloudflare in front. The full guide, with commands for everything below, is [`docs/estate/GUIDE.md` in jvallery/estate-platform](https://github.com/jvallery/estate-platform/blob/main/docs/estate/GUIDE.md).

**Access.** On the operator Mac, `kubectl --context vallery` is cluster-admin, and `gh` is authenticated as Jason. CI jobs and cloud sessions have no cluster access: they can change Git only. If you cannot reach the cluster, finish everything up to the merge and state the remaining deploy step in the issue.

**Who owns what.** Every namespace, hostname, device, bucket and job has exactly one owner repository, recorded in `ownership/record/` in jvallery/estate-platform and rendered to [`ESTATE-INVENTORY.md`](https://github.com/jvallery/estate-platform/blob/main/docs/estate/ESTATE-INVENTORY.md). A namespace's label `estate.vallery.net/owner` names its owner. When you add, move or retire something, update the record in the same piece of work.

| Area | Owner |
|---|---|
| Argo CD, the application catalog, shared operators (CNPG, cert-manager, MariaDB), Authentik, central secrets, ownership record, standards | `jvallery/estate-platform` |
| CI workflows and runners | `jvallery/estate-ci` |
| DNS, routes, TLS, Cloudflare, UniFi, Pi-hole, MetalLB, Traefik | `jvallery/network-infra` |
| Longhorn, StorageClasses, NAS shares, S3 buckets, the image registry, backups | `jvallery/storage-infra` |
| Prometheus, Alertmanager, Loki, Grafana, probes, every alert rule and dashboard | `jvallery/monitoring-stack` |
| Proxmox hosts, VMs, k3s nodes, node labels and taints | `jvallery/proxmox-infrastructure` |
| GPUs, GPUStack, the Cortex inference API, Open WebUI | `jvallery/cortex-ai-compute` |
| The operator Mac and this contract | `jvallery/home-dotfiles` |
| Each application | Its own repository, which owns what renders into its namespaces |

**Deploying.** Argo CD applies what is in Git, read through an in-cluster mirror that trails GitHub by one to four minutes. Look up how your application is delivered:

```sh
kubectl --context vallery get applications.argoproj.io -A --field-selector metadata.name=<app> -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,TARGET:.spec.source.targetRevision,AUTO:.spec.syncPolicy.automated,REV:.status.sync.revision,SYNC:.status.sync.status,HEALTH:.status.health.status
```

- `TARGET` is `main` and `AUTO` is on: merging deploys. Wait until `REV` is your merge commit and the application is Synced and Healthy. `AUTO` is off when it shows `<none>` or `enabled:false`.
- `TARGET` is `main` and `AUTO` is off: sync the objects you changed, and only those, unless this repository's own section says its application must be synced whole.
- `TARGET` is a commit SHA: the application is pinned. Move the pin to your merge commit in the file that declares the Application (`gitops/applications/<environment>/` in jvallery/estate-platform, or `argocd/` in the owning repository), merge that, then sync.

The guide has the exact commands for a sync and a pin move. Two rules protect the cluster. Sync named objects, never a whole pinned parent application, because a whole sync applies every child in the pin range and can roll back other people's work. Never sync with prune, because pruning is off everywhere on purpose and a prune deletes every object Git no longer lists, volumes and namespaces included.

**CI and images.** CI is GitHub Actions on in-cluster runners owned by jvallery/estate-ci; GitHub-hosted runners are not allowed. A repository calls the reusable workflows in jvallery/estate-ci by full commit SHA. Images are built in CI with Kaniko and pushed to `registry.vallery.net`. In most repositories the build then opens a pull request that pins the new digest in the deployment manifests, and merging that pull request is the release; where a repository promotes differently, its own section says how. Manifests reference images by `@sha256` digest only. Upstream images are mirrored into the registry first. Re-run a failed job with `gh run rerun <run-id> --failed`.

**Secrets.** A Kubernetes Secret exists in Git only as a SOPS-encrypted file (`secret-<name>.enc.yaml`), decrypted in the cluster by Argo CD. Most live in `secrets/<bundle>/` in jvallery/estate-platform; storage and network secrets live in their own repositories. Encrypting needs only the public keys in `.sops.yaml`, so you can add or rotate a secret yourself: write the manifest, run `sops --encrypt --in-place <file>`, list it in the bundle's `secret-generator.yaml`, and deliver it like any other change. For a value only Jason can obtain, prepare everything else and open a `needs-jason` issue.

**Running workloads.** Namespaces enforce the Pod Security `baseline` level by default. A new namespace needs the `estate.vallery.net/owner=<org>.<repo>` label, the LimitRange and ResourceQuota baseline, a default-deny NetworkPolicy and an ownership record entry. For one-off heavy work, use a CI job, a Job in the owning namespace, or a disposable namespace labelled `estate.vallery.net/disposable=true` and `estate.vallery.net/expires=<date>`, and delete it afterwards. Give Jobs a `ttlSecondsAfterFinished` and never create bare Pods, which block node drains.

**Storage and databases.** The default StorageClass is replicated Longhorn. Use `longhorn-v1-rwo` for application data, `longhorn-v1-critical-rwo` for data that must survive a host loss, `longhorn-v1-rebuildable-rwo` for caches and scratch, and `nfs-rwx` only for NAS shares that jvallery/storage-infra has exported. S3 buckets come from jvallery/storage-infra. A Postgres database is a three-instance CloudNativePG cluster with backups to in-cluster S3 and to Backblaze B2; copy an existing one. Every durable volume needs a backup or a named exemption in jvallery/storage-infra.

**Exposing a service.** Add a Traefik `IngressRoute` in your namespace with `tls: {}`; the wildcard certificate for `*.vallery.net` already covers it. For login, add the Authentik forward-auth middlewares. A public hostname also needs a row in the Cloudflare tunnel configuration in jvallery/network-infra, an entry in the edge registry in jvallery/estate-platform, and a probe in jvallery/monitoring-stack.

**Observability.** Alert rules, probes and dashboards live only in jvallery/monitoring-stack, and that application deploys on merge, so a merged rule can page within minutes. Alerts go to Alertmanager, which pushes to Home Assistant; there is no other notification path. Dashboards are generated, never hand-edited. When something you run can fail in a new way, add the metric and the alert.

**Node and host maintenance.** Never cordon or drain a node by hand: a bare drain once moved five database primaries at once and took down the control-plane leader. Use `scripts/k3s-planned-maintenance.py` in jvallery/proxmox-infrastructure, one node at a time. It moves database primaries off the node first, drains it, and marks the work as planned so that the right alerts stay quiet. Read its README first, and never run a script only to see its help text.

**AI inference.** Workloads call the in-cluster OpenAI-compatible API at `https://cortex.vallery.net/v1` with their own scoped key, issued by jvallery/cortex-ai-compute. Never use an admin credential or an outside provider key.

**Standards.** The target state for high availability, backups, security, exposure and CI is [`docs/estate/STANDARDS.md` in jvallery/estate-platform](https://github.com/jvallery/estate-platform/blob/main/docs/estate/STANDARDS.md). New work meets it; drift you find is fixed in the change that touches it or filed as an issue.
<!-- estate-contract:end -->

## This repository

- It owns `profile/README.md`, the public landing page of the organization, and nothing in the cluster. [`OWNERSHIP.md`](OWNERSHIP.md) lists the items.
- `ci/check.sh` is a local check. The repository has no GitHub Actions workflows, because the organization has no CI runners.

## Change, check and publish

- Take wording, service names and links from the live site, https://verdify.ai, whose source is jvallery/verdify-www. Do not write new marketing copy here.
- Run `ci/check.sh` before committing, while your edits are still unstaged. It checks whitespace errors in the unstaged diff, conflict markers outside Markdown and that every YAML file parses (it needs `yq`). It does not read `profile/README.md` on a clean checkout, so review a profile edit in the diff.
- A merge to `main` publishes the profile at once. `main` requires linear history and has no required check.
- Prove it live: `gh api repos/VerdifyConsultancy/.github/contents/profile/README.md --jq .sha` equals `git rev-parse origin/main:profile/README.md`, the page at https://github.com/VerdifyConsultancy renders, and every profile link returns 200 from `curl -sL -o /dev/null -w '%{http_code}\n' <url>`.

## Hazards

- The repository is public: every commit, branch and pull request is readable by anyone, for good. Add no internal hostnames, IP addresses, namespaces, Secret names, client names or absolute workstation paths beyond what the shared block above already says. Stage files by name and read `git diff --cached` before committing.
- GitHub applies some files in this repository to every repository in the organization that lacks its own: `workflow-templates/` and the default community health files (issue and pull request templates, CONTRIBUTING, SECURITY, CODE_OF_CONDUCT). Add none of them here; each repository keeps its own.
- The profile makes public claims about Verdify's services and the Public Proof Lab. Keep them consistent with the live site, and never add a claim the site does not make.
- Do not add a `CLAUDE.md` at any depth, because Claude Code reads `AGENTS.md` only when no `CLAUDE.md` exists.

## Neighbours

- Verdify positioning, service names and the verdify.ai pages: jvallery/verdify-www.
- Verdify Lab (https://lab.verdify.ai) and its greenhouse claims: jvallery/verdify-platform.
- Organization settings, rulesets and the branch-protection baseline: jvallery/estate-platform.
