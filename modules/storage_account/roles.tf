resource "azurerm_role_assignment" "sa-role-assignment" {
    count                = length(var.principal_ids)
    scope                = azurerm_storage_account.sa-backend.id
    role_definition_name = "Storage Blob Data Owner"
    principal_id         = var.principal_ids[count.index]
    timeouts {
        create = "20m"
    }
}