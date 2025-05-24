module "shared_image" {
    source                    = "./modules/shared_images"
    uai_name                  = "uai-image"
    build_resource_group_name = "rg-image-build-chinanorth3"
    sig_resource_group        = module.shared_image_gallery.output_sig_rg
    gallery_name              = module.shared_image_gallery.output_gallery_name
    location                  = var.location
    subscription_id           = var.subscription_id
    images                    = var.image
    default_tags              = var.default_tags
}