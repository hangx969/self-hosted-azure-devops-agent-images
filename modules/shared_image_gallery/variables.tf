variable "gallery_name" {
  type        = string
}

variable "gallery_rg_name" {
  type        = string
}

variable "location" {
  type        = string
  default     = "chinanorth3"
}

variable "description" {
  type        = string
  default     = "Shared Image Gallery for devops agent pool images"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
}
