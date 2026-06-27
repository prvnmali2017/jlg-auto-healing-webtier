# Auto-Healing Web Tier

## Goal

Stand up an auto-healing web tier that can lose any single VM without downtime.

## Must-haves

- **Self-healing** – terminating an instance triggers the platform to replace it automatically.
- **Self-provisioning (IaC only)** – one command stands everything up; a second run makes no changes.
- **N + 1 capacity** – traffic is spread across at least two instances behind a load balancer.
- **Static web page** – a default NGINX “welcome” page (or equivalent) is sufficient.

## Templates

- **Preferred:** Terraform v-latest
- **Allowed:** Bicep / ARM (Azure) or CloudFormation / CDK (AWS)
- Choose either Azure or AWS and briefly explain your choice in the README.

## Optional bonus

**Containerise the page:**

- Provide a Dockerfile.
- Push the image to a free registry (e.g., GitHub Container Registry, Docker Hub).
- Use user-data / cloud-init to pull and run the image automatically on each VM.

## Deliverables

- **IaC code** – clear modules, variables, tagging and naming conventions.
- **README.md**
  - Steps to run a plan and (optionally) an apply.
  - Architecture diagram (hand-drawn, Visio, draw.io, etc.).
  - Assumptions and estimated monthly cost (≤ AUD 20 if fully deployed).
- **Pipeline (optional)** – lint / validate / plan-only is sufficient.
- **Commit history** – incremental commits so we can follow your process.

## Logistics

- **Target effort:** approximately 7–8 focused hours.
- Return a link to your Git repository within 5 calendar days.
- Provisioning the underlying infrastructure is completely optional; we will only review Terraform plan outputs.
