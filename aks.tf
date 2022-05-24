# resource "azurerm_kubernetes_cluster" "aks" {
#     name = var.aks
#     location = var.region
#     resource_group_name = var.aks
#     dns_prefix = "testaks"
#     default_node_pool {
#       name = "default"
#       node_count = 1
#       vm_size = "Standard_D2_V2"
#     }

#     identity {
#       type = SystemAssigned
#     }

# }
