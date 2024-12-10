provider "aws" {
  region = var.region
}
module "markerting_vpc" {
  source                  = "./modules/vpc"
  vpc_name                = "Marketing-VPC"
  cidr_block              = "10.0.0.0/16"
  availability_zones      = ["eu-north-1a"]
  public_subnet_cidrs     = ["10.0.1.0/24"]
  private_subnet_cidrs    = ["10.0.4.0/24"]
  enable_internet_gateway = true
  enable_NAT_gateway      = true
  vpc_peering             = true
  peer_vpc_id             = module.financial_vpc.vpc_id
  peering_vpc_name        = module.financial_vpc.vpc_name
}

module "financial_vpc" {
  source                  = "./modules/vpc"
  vpc_name                = "Financial-VPC"
  cidr_block              = "172.0.0.0/16"
  availability_zones      = ["eu-north-1a"]
  public_subnet_cidrs     = ["172.0.1.0/24"]
  private_subnet_cidrs    = ["172.0.4.0/24"]
  enable_internet_gateway = true
  enable_NAT_gateway      = true
  vpc_peering             = true
  peer_vpc_id             = module.markerting_vpc.vpc_id
  peering_vpc_name        = module.markerting_vpc.vpc_name
}
