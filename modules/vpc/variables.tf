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

variable "enable_NAT_gateway" {
  type        = bool
  description = "NAT gateway available or not"
  default     = false
}


variable "vpc_peering" {
  type        = bool
  description = "VPC peering connection available or not"
  default     = false
}

variable "peering_vpc_name" {
  type        = string
  description = "name for peering VPC"
}

variable "peer_vpc_id" {
  type        = string
  description = "peering vpc id"
}
