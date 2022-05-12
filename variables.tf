/* variable "aws_vpc" {
  default = "default"

} */
variable "region" {
  default = "East US"
}
variable "resource_group" {
  default = "rg-spservers"
}

/* variable "ami" {
  default = "ami-08ed5c5dd62794ec0"
  #type = map
} */

/* variable "Instance" {
  default = "t2.micro"
  #type = string
} */

variable "ServerName" {
  default = "SP2k19"
}
variable "loadbalancer" {
  default = "sp2019elb"
}
