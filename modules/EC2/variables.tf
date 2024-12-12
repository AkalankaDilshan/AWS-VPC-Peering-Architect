variable "instance_type" {
  type        = string
  description = "type for EC2 instance"
  default     = "t2.micro"
}

variable "instance_name" {
  type        = string
  description = "EC2 instance name"
}

variable "ami_name_pattern" {
  description = "the pattern to match the AMI name"
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}
variable "ami_architecture" {
  description = "The pattern to match the AMI name"
  type        = string
  default     = "x86_64"
}
variable "subnet_id" {
  type        = string
  description = "subnet for ec2 instance"
}

variable "security_group" {
  type        = string
  description = "security_group_id"
}

variable "allow_public_ip" {
  type        = bool
  default     = false
  description = "allow public ip or not"
}

variable "ebs_volume_type" {
  type        = string
  description = "type of instance value"
  default     = "gp2"
}

variable "ebs_volume_size" {
  type        = number
  description = "size of instance value"
  default     = 8
}

variable "key_pair_name" {
  type        = string
  description = "name for ec2 instance key-pair"
}
