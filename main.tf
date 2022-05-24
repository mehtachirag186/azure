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

resource "azurerm_subnet" "SP-Subnet" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.Vnet-SpServers.name
  virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.SP-Virtual-Network
  ]

}

resource "azurerm_network_interface" "sp-nic" {
  #count = 11
  name                = var.nic
  location            = var.region
  resource_group_name = azurerm_resource_group.Vnet-SpServers.name


  ip_configuration {
    #count = 11
    name                          = var.ip
    subnet_id                     = azurerm_subnet.SP-Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "sp-vm" {
  count               = 3
  name                = "${var.ServerName}-${count.index}"
  resource_group_name = azurerm_resource_group.SPservers.name
  location            = var.region
  size                = "Standard_D2as_v4"
  admin_username      = "chiragmehta"
  admin_password      = "abcd1234!"
  network_interface_ids = [
    azurerm_network_interface.sp-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

