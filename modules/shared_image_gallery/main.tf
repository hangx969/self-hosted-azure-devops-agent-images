resource "azurerm_resource_group" "gallery_rg" {
  name     = var.gallery_rg_name
  location = var.location
  tags     = var.default_tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = azurerm_resource_group.gallery_rg.name
  location            = var.location
  description         = var.description
  tags                = var.default_tags
  lifecycle {
    ignore_changes = [tags]
  }
}

output "output_gallery_name" {
  value       = azurerm_shared_image_gallery.gallery.name
}

output "output_sig_rg" {
  value       = azurerm_resource_group.gallery_rg
}