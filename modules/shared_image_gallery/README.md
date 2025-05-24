<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```terraform
module "example" {
  	 source  = "<module-path>"
        
	 # Required variables
        	 gallery_name  = 
        	 gallery_rg_name  = 
        
	 # Optional variables
        	 default_tags  = {}
        	 description  = "Shared Image Gallery for devops agent pool images"
        	 location  = "chinanorth3"
}
```
## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.gallery_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_shared_image_gallery.gallery](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"Shared Image Gallery for devops agent pool images"` | no |
| <a name="input_gallery_name"></a> [gallery\_name](#input\_gallery\_name) | n/a | `string` | n/a | yes |
| <a name="input_gallery_rg_name"></a> [gallery\_rg\_name](#input\_gallery\_rg\_name) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"chinanorth3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output_gallery_name"></a> [output\_gallery\_name](#output\_output\_gallery\_name) | n/a |
| <a name="output_output_sig_rg"></a> [output\_sig\_rg](#output\_output\_sig\_rg) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->