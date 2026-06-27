location = "australiaeast"
prefix   = "jlg-webtier"

tags = {
  environment = "dev"
  project     = "jlg-webtier"
  managed_by  = "terraform"
  region      = "australiaeast"
}

address_space = ["10.0.0.0/16"]
subnet_prefix = ["10.0.1.0/24"]

vmss_instance_count = 2
vmss_sku            = "Standard_B1ls_v2"

container_image   = "ghcr.io/prvnmali2017/jlg-webtier:latest"
domain_name_label = "jlg-webtier-dev"
