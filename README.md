# jlg-auto-healing-webtier

Auto-healing web tier on **Azure** using Terraform and Docker. Built to ensure N+1 capacity and zero downtime.

## Azure

This solution is deployed on Azure because Linux VM Scale Sets (VMSS) with a Standard Load Balancer provide native self-healing and N+1 capacity behind a single public entry point. VMSS automatically replaces terminated instances, which maps directly to the assignment requirements. The stack will be provisioned in `australiaeast` via Terraform.

## Steps that I will follow

0 | Get the repo ready — README, folders, ignore files |
1 | Package the website in Docker and upload it to GitHub |
2 | Wire up Terraform basics (providers, settings, config file) |
3 | Create the Azure network (resource group, firewall rules, virtual network) |
4 | Add the load balancer so traffic has one front door |
5 | Spin up the auto-healing VMs and have them run your Docker app |
6 | Add useful outputs and confirm Terraform runs cleanly twice |
7 | Add GitHub Actions so every push gets checked automatically |
8 | Finish the README, diagram, and cost notes for submission |

## Project structure that I am going to Use

```
jlg-auto-healing-webtier/
├── Dockerfile
├── diagram.png              
├── README.md
├── question.md
└── terraform/
    ├── versions.tf
    ├── variables.tf
    ├── environments/
    │   └── dev.tfvars
    └── modules/
        ├── network/
        ├── load_balancer/
        └── vmss/
```

Further runbook, architecture diagram, and cost details will be added as the solution is built out phase by phase.

## Container image 

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

## Terraform (Phase 2)

Foundation config is in `terraform/`. Validate before adding modules:

```bash
cd terraform
terraform init
terraform validate
```

Use `environments/dev.tfvars` for environment-specific values (region, image, naming prefix).
