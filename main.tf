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

resource "azurerm_network_interface" "example" {
  #count = 11
  name                = var.nic
  location            = var.region
  resource_group_name = azurerm_resource_group.Vnet-SpServers

  ip_configuration {
    #count = 11
    name                          = var.ip
    subnet_id                     = azurerm_subnet.SP-Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

/* resource "azurerm_virtual_machine" "SP_VMs" {
  count = 11
  depends_on = [
    azurerm_availability_set.SP_wfe_AS
  ]
  name                  = "${var.ServerName}-${count.index}"
  location              = var.region
  resource_group_name   = azurerm_resource_group.SPservers.name
  vm_size               = "Standard_DS1_v2"
  availability_set_id   = azurerm_availability_set.SP_wfe_AS.id
  network_interface_ids = [azurerm_virtual_network.SP-Virtual-Network.id]
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

  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
 
 storage_image_reference {
   
 }

} */

resource "azurerm_windows_virtual_machine" "example" {
  count               = 11
  name                = "${var.ServerName}-${count.index}"
  resource_group_name = azurerm_resource_group.SPservers.name
  location            = var.region
  size                = "Standard_F2"
  admin_username      = "Administrator"
  admin_password      = "abcd1234!"
  network_interface_ids = [
    azurerm_virtual_network.SP-Virtual-Network.id
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

