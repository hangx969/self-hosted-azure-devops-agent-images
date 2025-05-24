variable "sig_resource_group" {}
variable "location" {
  type    = string
  default = "chinanorth3"
}

variable "principal_ids" {
  type    = list(string)
  default = ["123", "456"]
}

variable "subscription_id" {
  type    = string
  default = "12345678-1234-1234-1234-123456789012"
}