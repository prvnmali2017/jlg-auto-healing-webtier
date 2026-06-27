location = "australiaeast"
prefix   = "global360-webtier"

tags = {
  environment = "dev"
  project     = "global360-webtier"
  managed_by  = "terraform"
  region      = "australiaeast"
}

# Private VNet range; room for extra subnets later.
address_space = ["10.0.0.0/16"]

# Web tier subnet for VMSS; /24 is enough for 2+ VMs. .0.x left free for future use.
subnet_prefix = ["10.0.1.0/24"]

vmss_instance_count = 2

# Same as cloud-infra-task — smallest B-series v2; B1* not offered in many AU regions.
# Refer: https://azure.microsoft.com/en-au/pricing/details/virtual-machines/linux/
vmss_sku = "Standard_B2ls_v2"

# Spread 2 instances across zones 1 and 2 for zone-level HA.
vmss_zones = ["1", "2"]

container_image = "ghcr.io/prvnmali2017/global360-webtier:latest"

# Standard SKU required — Basic Load Balancer was retired 2025-09-30; new deployments cannot use it.
# Public IP + Standard LB (~AUD 25–30/mo combined — main cost driver).
# Refer: https://azure.microsoft.com/en-au/pricing/details/load-balancer/
domain_name_label = "global360-webtier-dev"
