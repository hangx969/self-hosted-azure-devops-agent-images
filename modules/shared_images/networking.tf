# Create a new subnet in existing VNET for Image Build
resource "azurerm_subnet" "ig-subnet" {
  name                 = "snet-image-build"
  resource_group_name  = "rg-network-chinanorth3"
  virtual_network_name = "vnet-chinanorth3"
  address_prefixes     = ["10.0.0.1/28"]
}