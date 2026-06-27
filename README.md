# jlg-auto-healing-webtier

Auto-healing web tier on **Azure** using Terraform and Docker. Built to ensure N+1 capacity and zero downtime.

## Azure

This solution is deployed on Azure because Linux VM Scale Sets (VMSS) with a Standard Load Balancer provide native self-healing and N+1 capacity behind a single public entry point. VMSS automatically replaces terminated instances, which maps directly to the assignment requirements. The stack will be provisioned in `australiaeast` via Terraform.

## Project structure

```
jlg-auto-healing-webtier/
├── Dockerfile
├── diagram.png              # added in Phase 8
├── README.md
├── question.md
└── terraform/
    ├── environments/
    │   └── dev.tfvars
    └── modules/
        ├── network/
        ├── load_balancer/
        └── vmss/
```

Further runbook, architecture diagram, and cost details will be added as the solution is built out phase by phase.

## Container image (Phase 1)

The web tier runs as an NGINX container. Build and push to GitHub Container Registry (GHCR):

```bash
# Build
docker build -t ghcr.io/prvnmali2017/jlg-webtier:latest .

# Log in (create a PAT with write:packages at github.com/settings/tokens)
echo $GHCR_TOKEN | docker login ghcr.io -u prvnmali2017 --password-stdin

# Push
docker push ghcr.io/prvnmali2017/jlg-webtier:latest
```

After pushing, set the package visibility to **Public** in GitHub (Packages → `jlg-webtier` → Package settings) so Azure VMs can pull without registry credentials.

Test locally:

```bash
docker run --rm -p 8080:80 ghcr.io/prvnmali2017/jlg-webtier:latest
# open http://localhost:8080
```
