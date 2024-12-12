variable "sg_name" {
  type        = string
  description = "name for security group"
}

variable "vpc_id" {
  type        = string
  description = "vpc id for ec2 instance"
}

variable "peer_vpc_cidr" {
  type        = string
  description = "other end VPC cidr"
}
