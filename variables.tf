
variable "tenant_id" {
  type    = string
  default = "xxxx"
}

variable "subscription_id" {
  type    = string
  default = "xxxx"
}


variable "location" {
  type    = string
  default = "chinanorth3"
}

variable "default_tags" {
  type    = map(string)
  default = {
    "created-by"  = "terraform"
    "devops-repo" = "lz-cn-xxxx-image-gallery"
  }
}

variable "image" {
  default = []
}
