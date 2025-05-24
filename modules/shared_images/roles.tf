resource "azurerm_user_assigned_identity" "ig-uai" {
  name                = var.uai_name
  location            = var.location
  resource_group_name = var.sig_resource_group.name

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_role_assignment" "ig-role-assignment" {
  depends_on           = [azurerm_user_assigned_identity.ig-uai]
  scope                = var.sig_resource_group.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.ig-uai.principal_id
  timeouts {
    create = "20m"
  }
}

# If we use the managed identity as the aservice connection in ado, then we need to create this federated credential
# resource "azurerm_federated_identity_credential" "example" {
#   name                = "ado-service-connection"
#   resource_group_name = var.sig_resource_group.name
#   audience            = ["api://AzureADTokenExchange"]
#   issuer              = "https://vstoken.dev.azure.com/<organization>"
#   parent_id           = azurerm_user_assigned_identity.ig-uai.id
#   subject             = "sc://xxx/xxx/xxxx"
# }