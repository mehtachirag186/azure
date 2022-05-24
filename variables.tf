variable "region" {
  default = "northeurope"
}
variable "resource_group" {
  default = "rg-spservers"
}

variable "Vnet" {
  default = "SP-Virtual-Network"
}

variable "subnet" {
  default = "SP-subnet"
}
variable "nic" {
  default = "nic"
}
variable "ip" {
  default = "ip"
}
variable "ServerName" {
  default = "SP2k19"
}
variable "loadbalancer" {
  default = "sp2019lb"
}
variable "aks" {
  default = "aks-cluster"
}

variable "avset" {
  default = "sp-as"
}

