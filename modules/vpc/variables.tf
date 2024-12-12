variable "vpc_name" {
  type        = string
  description = "name for VPC"
}

variable "cidr_block" {
  type        = string
  description = "cidr block value for vpc"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability_zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "cidr values for public subnet"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "cidr values for private subnet"
}

# variable "enable_internet_gateway" {
#   type        = bool
#   description = "internet_gateway available or not"
#   default     = false
# }
variable "enable_NAT_gateway" {
  type        = bool
  description = "NAT gateway available or not"
  default     = false
}
variable "peer_vpc_cidr" {
  type        = list(string)
  description = "peering vpc cidr"
}
variable "peering_con_id" {
  type        = list(string)
  description = "vpc peering connection id"
}
