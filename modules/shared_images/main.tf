resource "azurerm_resource_group" "build-rg" {
  name     = var.build_resource_group_name
  location = var.location
  tags     = var.default_tags
}

resource "azurerm_shared_image" "shared-image-dif" {
  name                                = "Ubuntu_2204_ADOagent_gen1"
  os_type                             = "Linux"
  hyper_v_generation                  = "V1"
  gallery_name                        = var.gallery_name
  resource_group_name                 = var.sig_resource_group.name
  location                            = var.location
  accelerated_network_support_enabled = true

  identifier {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
  }

  timeouts {
    create = "20m"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}