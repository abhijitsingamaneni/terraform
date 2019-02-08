variable "vpc_name" {
  default                                   = "testvpc"
  description                               = "Nmae of the VPC"
}
variable "vpc_cidr" {
  default                                   = "10.0.0.0/16"
  description                               = "CIDR for the VPC"
}
variable "enable_hostnames" {
  default                                   = "true"
  description                               = "enable/disable DNS hostnames in the VPC"
}
variable "enable_dns" {
  default                                   = "false"
  description                               = "enable/disable DNS support in the VPC"
}
variable "vpc_subnets" {
  type                                      = "list"
  default                                   = ["10.0.2.0/24", "10.0.3.0/24"]
  description                               = "Subnets with in VPC"
}
variable "availability_zone" {
  type                                      = "list"
  default                                   = []
  description                               = "A list of Availability zones in the region"
}