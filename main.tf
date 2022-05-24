resource "azurerm_resource_group" "SPservers" {
  name     = var.resource_group
  location = var.region

}

resource "azurerm_resource_group" "Vnet-SpServers" {
  name     = "${var.resource_group}-Vnet"
  location = var.region

}

resource "azurerm_resource_group" "aks" {
  name     = "${var.resource_group}-aks"
  location = var.region

}

resource "azurerm_resource_group" "sp-availability-set" {
  name     = "${var.resource_group}-availabilityset"
  location = var.region

}

resource "azurerm_resource_group" "load-balancer" {
  name     = "${var.resource_group}-loadbalancer"
  location = var.region

}


resource "azurerm_virtual_network" "SP-Virtual-Network" {
  name                = var.Vnet
  location            = var.region
  resource_group_name = "${var.resource_group}-Vnet"
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_virtual_machine" "SP_VMs" {
  count = 11
  depends_on = [
    azurerm_availability_set.SP_wfe_AS
  ]
  name                  = "${var.ServerName}-${count.index}"
  location              = var.region
  resource_group_name   = "${var.loadbalancer}-RG"
  vm_size               = "Standard_DS1_v2"
  availability_set_id   = azurerm_availability_set.SP_wfe_AS.id
  network_interface_ids = ["azurerm_virtual_network.Vnet-SpServers.id"]
  os_profile {
    computer_name  = "${var.ServerName}-${count.index}-WFE"
    admin_username = "Administrator"
    admin_password = "abc1234"

  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

  }

}

