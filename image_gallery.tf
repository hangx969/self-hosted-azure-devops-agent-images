data "azurerm_subscription" "current" {}

module "shared_image_gallery" {
  source              = "./modules/shared_image_gallery"
  gallery_name        = "shared_image_gallery_cn3"
  gallery_rg_name     = "rg-shared-image-gallery-chinanorth3"
  location            = var.location
  default_tags        = var.default_tags
}

