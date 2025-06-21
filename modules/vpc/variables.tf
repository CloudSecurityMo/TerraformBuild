variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR block"
  type = string
  default = "10.0.20.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR bloc"
  type = string
  default = "10.0.10.0/24"
}

variable "availability_zones" {
  description = "Availability Zones for Subnets"
  type = list(string)
  default = [ "eu-west-1a", "eu-west-1b" ]
}
