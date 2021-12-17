data "azurerm_resource_group" "mcds_test" {
  name = var.resource_group_name
}
data "azurerm_virtual_network" "mcds_net" {
  name                = var.network
  resource_group_name = data.azurerm_resource_group.mcds_test.name
}
data "azurerm_subnet" "mcds_subnet" {
  name                 = var.subnet
  virtual_network_name = data.azurerm_virtual_network.mcds_net.name
  resource_group_name  = data.azurerm_resource_group.mcds_test.name

