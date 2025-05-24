
variable "tenant_id" {
  type    = string
  default = "12345678-1234-1234-1234-123456789012"
}

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
  default = {
    "created-by"  = "terraform"
    "devops-repo" = "lz-cn-image-gallery"
  }
}

variable "image" {
  default = []
}
