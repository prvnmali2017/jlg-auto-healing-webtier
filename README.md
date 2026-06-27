# global360-auto-healing-webtier

A small auto-healing web tier on Azure: two VM Scale Set instances behind a load balancer, serving a containerised NGINX page. If you delete a VM, the platform replaces it automatically — the site stays up.

**Repo:** https://github.com/prvnmali2017/jlg-auto-healing-webtier

## Why Azure?

VM Scale Sets (VMSS) plus a Standard Load Balancer give you self-healing and N+1 capacity out of the box — one public entry point, traffic spread across two VMs. Each new instance runs cloud-init, pulls a Docker image from GitHub Container Registry (GHCR), and starts NGINX. Everything deploys to `australiaeast`.

Resource names follow the `global360-webtier` convention (e.g. `rg-global360-webtier`, `vmss-global360-webtier`) to align with the reference task.

## Architecture

![Architecture diagram](diagram.png) · [Editable SVG](docs/architecture.svg)

```
Internet → Public IP → Standard LB (:80)
                              ↓
              VMSS — 2 instances (zones 1 & 2)
              cloud-init → docker pull → NGINX
                              ↑
                         GHCR (public image)
```

## What you need

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/install) ≥ 1.5

No Docker required for review — the container image is already built and published.

### Log in to Azure

```bash
az login
az account set --subscription "<subscription_id_or_name>"
```

For CI or automation, use a service principal and export `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, and `ARM_TENANT_ID`.

## Container image

The web page is already packaged and available as a **public** image on GHCR — reviewers do not need to build or push anything:

**`ghcr.io/prvnmali2017/global360-webtier:latest`** (`linux/amd64`)

cloud-init on each VMSS instance pulls this image automatically. The `Dockerfile` in the repo is for reference if you want to rebuild it later. If applying, ensure this tag exists on GHCR (retag and push from the previous `jlg-webtier` image if needed).

## Deploy with Terraform

```bash
cd terraform
terraform init
terraform validate
terraform plan -var-file=environments/dev.tfvars -out=tfplan
terraform apply tfplan   # optional — plan output is enough for review
```

A second `terraform plan` after apply should show **no changes**.

Useful outputs: `load_balancer_public_ip`, `load_balancer_fqdn`, `web_url`, `vmss_id`, `resource_group_name`.

## Verify it works

**Check the site:**

```bash
curl -I http://$(terraform output -raw load_balancer_public_ip)
```

You should get HTTP 200 and the Global360 welcome page.

**Test auto-healing:**

1. Confirm the site responds (`curl` above)
2. Azure Portal → `vmss-global360-webtier` → **Instances** → delete one VM
3. Wait 2–5 minutes for replacement and cloud-init
4. `curl` again — the site should still be up

**Debug a VM** (cloud-init, Docker, local HTTP):

```bash
az vmss run-command invoke \
  -g rg-global360-webtier -n vmss-global360-webtier --instance-id 0 \
  --command-id RunShellScript \
  --scripts "cloud-init status; docker ps; curl -I http://localhost:80"
```

## CI

On push/PR to `terraform/`, GitHub Actions runs `fmt`, `validate`, and `plan`. Plan needs these repository secrets: `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`.

See [.github/workflows/terraform-ci.yml](.github/workflows/terraform-ci.yml).

## Assumptions

- **Region:** `australiaeast`
- **Naming:** `global360-webtier` prefix on all resources
- **Capacity:** 2× `Standard_B2ls_v2` VMs across zones 1 and 2
- **Load balancer:** Standard SKU with HTTP health probe on port 80
- **Image:** public GHCR package (no Azure Container Registry)
- **Networking:** VMs have no public IP — traffic enters only via the load balancer
- **Review:** apply is optional; tear down when done

## Cost

| Resource | ~AUD/month |
|----------|------------|
| 2× Standard_B2ls_v2 VMs | 12–16 |
| Standard Public IP | 5 |
| Standard Load Balancer | 25–30 |
| **Total (24/7)** | **42–51** |

The brief asks for ≤ AUD 20/month, but the Standard Load Balancer alone exceeds that. Reviewers only need `terraform plan` — **destroy the stack after demo** to avoid charges.

### Why not Basic Load Balancer?

Azure retired Basic Load Balancer on **30 September 2025** (no new ones after **31 March 2025**). For a new Terraform deployment today, Standard is the only viable option — Basic would fail at apply or leave you on an unsupported service without an SLA.

Standard LB also supports health probes and zone-aware VMSS backends, which this design relies on.

- [Basic LB lifecycle](https://learn.microsoft.com/en-us/lifecycle/products/azure-basic-load-balancer)
- [Upgrade guidance](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-basic-upgrade-guidance)
- [VM pricing](https://azure.microsoft.com/en-au/pricing/details/virtual-machines/linux/) · [LB pricing](https://azure.microsoft.com/en-au/pricing/details/load-balancer/)

## Project layout

```
global360-auto-healing-webtier/
├── .github/workflows/terraform-ci.yml
├── Dockerfile
├── diagram.png
├── docs/architecture.svg
└── terraform/
    ├── main.tf, variables.tf, outputs.tf, versions.tf
    ├── cloud-init.tpl
    ├── environments/dev.tfvars
    └── modules/ (network, load_balancer, vmss)
```

## Tear down

```bash
cd terraform
terraform destroy -var-file=environments/dev.tfvars
```
