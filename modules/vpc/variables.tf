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
