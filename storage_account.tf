module "storage-backend" {
    source              = "./modules/storage_account"
    sig_resource_group  = module.shared_image_gallery.output_sig_rg
    location            = var.location
}