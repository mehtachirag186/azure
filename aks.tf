resource "azurerm_kubernetes_cluster" "aks" {
    name = var.aks
    location = var.region
    resource_group_name = var.aks
    dns_prefix = "testaks"
  
}