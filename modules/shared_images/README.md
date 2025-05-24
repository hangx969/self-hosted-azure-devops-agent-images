<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```terraform
module "example" {
  	 source  = "<module-path>"
        
	 # Required variables
        	 build_resource_group_name  = 
        	 gallery_name  = 
        	 sig_resource_group  = 
        	 uai_name  = 
        
	 # Optional variables
        	 default_tags  = {}
        	 images  = []
        	 location  = "chinanorth3"
        	 subscription_id  = "34f170aa-f0c2-489c-ba2f-d5d429c08835"
}
```
## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_resource_group.build-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.ig-role-assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_shared_image.shared-image-dif](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) | resource |
| [azurerm_subnet.ig-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.ig-uai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_resource_group_name"></a> [build\_resource\_group\_name](#input\_build\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_gallery_name"></a> [gallery\_name](#input\_gallery\_name) | n/a | `any` | n/a | yes |
| <a name="input_images"></a> [images](#input\_images) | n/a | `list` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"chinanorth3"` | no |
| <a name="input_sig_resource_group"></a> [sig\_resource\_group](#input\_sig\_resource\_group) | n/a | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `"34f170aa-f0c2-489c-ba2f-d5d429c08835"` | no |
| <a name="input_uai_name"></a> [uai\_name](#input\_uai\_name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->