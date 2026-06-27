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
