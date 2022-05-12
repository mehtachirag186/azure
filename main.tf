resource "azurerm_resource_group" "SPservers" {
  name = var.resource_group
  location = var.region
 
}

resource "azurerm_resource_group" "Vnet-SpServers" {
  name = "${var.resource_group}-Vnet"
  location = var.region
 
}

resource "azurerm_resource_group" "aks" {
  name = "${var.resource_group}-aks "
  location = var.region
 
}

resource "azurerm_virtual_network" "SP-Virtual-Network" {
  name = var.Vnet
  location = var.region
  resource_group_name = "${var.resource_group}-Vnet"
  address_space = ["10.0.0.0/16"]
    
}
