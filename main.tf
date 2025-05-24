terraform {
  required_version = ">= 1.2.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  environment                     = "china"
  tenant_id                       = var.tenant_id
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}