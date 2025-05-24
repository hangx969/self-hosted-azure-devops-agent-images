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
  "3572dc78-1d9f-4b38-9445-2a3f497783d5",
  "75ae197e-17f5-4d8a-ba72-cd3c4d400e34"
]
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
| <a name="input_principal_ids"></a> [principal\_ids](#input\_principal\_ids) | n/a | `list(string)` | <pre>[<br/>  "3572dc78-1d9f-4b38-9445-2a3f497783d5",<br/>  "75ae197e-17f5-4d8a-ba72-cd3c4d400e34"<br/>]</pre> | no |
| <a name="input_sig_resource_group"></a> [sig\_resource\_group](#input\_sig\_resource\_group) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->