provider "aws" {
  region = var.region
}
module "markerting_vpc" {
  source               = "./modules/vpc"
  vpc_name             = "Marketing-VPC"
  cidr_block           = "10.0.0.0/16"
  availability_zones   = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
