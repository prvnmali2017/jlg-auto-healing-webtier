location = "australiaeast"
prefix   = "jlg-webtier"

tags = {
  environment = "dev"
  project     = "jlg-webtier"
  managed_by  = "terraform"
  region      = "australiaeast"
}

# Private VNet range; room for extra subnets later.
address_space = ["10.0.0.0/16"]

# Web tier subnet for VMSS; /24 is enough for 2+ VMs. .0.x left free for future use.
subnet_prefix = ["10.0.1.0/24"]

vmss_instance_count = 2

# Cheapest burstable SKU in australiaeast (B1ls_v2 not available in this region).
# Refer: https://azure.microsoft.com/en-au/pricing/details/virtual-machines/linux/
vmss_sku = "Standard_B1ls"

container_image = "ghcr.io/prvnmali2017/jlg-webtier:latest"

# Public IP + Standard LB (~AUD 25–30/mo combined — main cost driver). 
# Refer: https://azure.microsoft.com/en-au/pricing/details/load-balancer/
domain_name_label = "jlg-webtier-dev"
