variable "sig_resource_group" {}
variable "build_resource_group_name" {}
variable "uai_name" {}
variable "gallery_name" {}

variable "subscription_id" {
  type    = string
  default = "12345678-1234-1234-1234-123456789012"
}

variable "location" {
  type    = string
  default = "chinanorth3"
}


variable "default_tags" {
  type    = map(string)
  default = {}
}
variable "images" {
  default = []
}