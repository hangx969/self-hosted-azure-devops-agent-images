resource "azurerm_private_endpoint" "pe-storage-backend" {
    name                          = "pe-${azurerm_storage_account.sa-backend.name}-blob"
    resource_group_name           = azurerm_storage_account.sa-backend.resource_group_name
    location                      = azurerm_storage_account.sa-backend.location
    subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/rg-network-chinanorth3/providers/Microsoft.Network/virtualNetworks/vnet-chinanorth3/subnets/snet-endpoints"
    custom_network_interface_name = "nic-${azurerm_storage_account.sa-backend.name}-blob"

    private_service_connection {
        name                           = "psc-${azurerm_storage_account.sa-backend.name}-blob"
        is_manual_connection           = false
        private_connection_resource_id = azurerm_storage_account.sa-backend.id
        subresource_names              = ["blob"]
    }

    lifecycle {
        ignore_changes = [private_dns_zone_group]
    }
}