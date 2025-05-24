<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```terraform
module "example" {
  	 source  = "<module-path>"
        
	 # Required variables
        	 sig_resource_group  = 
        
	 # Optional variables
        	 location  = "chinanorth3"
        	 principal_ids  = [
  "123",
  "456"
]
        	 subscription_id  = "12345678-1234-1234-1234-123456789012"
}
```
## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.pe-storage-backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.sa-role-assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.sa-backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container-backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.container-backend-backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"chinanorth3"` | no |
| <a name="input_principal_ids"></a> [principal\_ids](#input\_principal\_ids) | n/a | `list(string)` | <pre>[<br/>  "123",<br/>  "456"<br/>]</pre> | no |
| <a name="input_sig_resource_group"></a> [sig\_resource\_group](#input\_sig\_resource\_group) | n/a | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `"12345678-1234-1234-1234-123456789012"` | no |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->