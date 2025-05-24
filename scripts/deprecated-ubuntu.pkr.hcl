source "azure-arm" "ubuntu_image_generator" {
  cloud_environment_name            = var.cloud_environment_name
  managed_image_name                = var.managed_image_name
  managed_image_resource_group_name = var.sig_resource_group
  image_publisher                   = var.image_publisher
  image_offer                       = var.image_offer
  image_sku                         = var.image_sku
  vm_size                           = var.vm_size
  os_type                           = var.os_type

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  build_resource_group_name              = var.build_resource_group_name
  private_virtual_network_with_public_ip = var.private_virtual_network_with_public_ip
  async_resourcegroup_delete             = true

  virtual_network_name                = var.virtual_network_name
  virtual_network_subnet_name         = var.virtual_network_subnet_name
  virtual_network_resource_group_name = "rg-network-chinanorth3"

  communicator            = "ssh"
  ssh_timeout             = "10m"
  ssh_username            = "ubuntu"
  ssh_keep_alive_interval = "10s"
  ssh_private_key_file    = var.ssh_private_key_file

  shared_image_gallery_destination {
    storage_account_type = "Standard_LRS"
    subscription         = var.subscription_id
    gallery_name         = var.image_gallery_name
    image_name           = var.gallery_vm_image_dif_name
    image_version        = var.image_version
    resource_group       = var.sig_resource_group
    replication_regions  = ["${var.location}"]
  }
}

build {
  sources = [
    "source.azure-arm.ubuntu_image_generator"
  ]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E bash '{{ .Path }}'"
    script          = var.script_file
  }
}

variable "subscription_id" {}
variable "tenant_id" {}
variable "script_file" {}
variable "client_id" {}
variable "client_secret" {}
variable "image_offer" {}
variable "image_publisher" {}
variable "image_sku" {}
variable "sig_resource_group" {}
variable "virtual_network_name" {}
variable "virtual_network_subnet_name" {}
variable "build_resource_group_name" {}
variable "gallery_vm_image_dif_name" {}
variable "image_gallery_name" {}
variable "ssh_private_key_file" {}
variable "managed_image_name" {}
variable "image_version" {}
variable "location" {}
variable "cloud_environment_name" {}
variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = false
}
variable "os_type" {
  type    = string
  default = "Linux"
}
variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}