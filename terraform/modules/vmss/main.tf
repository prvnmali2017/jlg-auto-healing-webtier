resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  instances           = var.instance_count
  admin_username      = var.admin_username
  upgrade_mode        = "Manual"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = var.backend_pool_ids
    }
  }

  custom_data = var.custom_data
  tags        = var.tags
}

resource "azurerm_monitor_autoscale_setting" "this" {
  name                = "${var.name}-autoscale"
  location            = var.location
  resource_group_name = var.resource_group_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.this.id
  tags                = var.tags

  profile {
    name = "fixed-capacity"

    capacity {
      minimum = var.instance_count
      maximum = var.instance_count
      default = var.instance_count
    }
  }
}
