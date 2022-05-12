variable "region" {
  default = "East US"
}
variable "resource_group" {
  default = "rg-spservers"
}

variable "Vnet" {
  default = "SP-Virtual-Network"
  
}
variable "ServerName" {
  default = "SP2k19"
}
variable "loadbalancer" {
  default = "sp2019elb"
}
