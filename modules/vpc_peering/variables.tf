variable "vpc_id" {
  type        = string
  description = "id for main vpc"
}
variable "vpc_name" {
  type        = string
  description = "main vpc name"
}

variable "peering_vpc_id" {
  type        = string
  description = "peering vpc id"
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
