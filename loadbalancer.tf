resource "azurerm_lb" "WFE_LB" {
  name                = var.loadbalancer
  resource_group_name = "${var.resource_group}-loadbalancer"
  location            = var.region
}

resource "azurerm_availability_set" "SP_wfe_AS" {
  name                         = var.avset
  resource_group_name          = "${var.resource_group}-AvailabilitySet"
  location                     = var.region
  platform_fault_domain_count  = 2
  platform_update_domain_count = 3
}

