provider "aws" {
  region = var.region
}
module "markerting_vpc" {
  source               = "./modules/vpc"
  vpc_name             = "Marketing-VPC"
  cidr_block           = "10.10.0.0/16"
  availability_zones   = ["eu-north-1a"]
  public_subnet_cidrs  = ["10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.4.0/24"]
  enable_NAT_gateway   = false
  peer_vpc_cidr        = [module.financial_vpc.vpc_cidr]
  peering_con_id       = [module.vpc_peering_connection.peering_connection_id]
}

module "financial_vpc" {
  source               = "./modules/vpc"
  vpc_name             = "Financial-VPC"
  cidr_block           = "173.31.0.0/16"
  availability_zones   = ["eu-north-1a"]
  public_subnet_cidrs  = ["173.31.1.0/24"]
  private_subnet_cidrs = ["173.31.4.0/24"]
  enable_NAT_gateway   = false
  peer_vpc_cidr        = [module.markerting_vpc.vpc_cidr]
  peering_con_id       = [module.vpc_peering_connection.peering_connection_id]
}

module "vpc_peering_connection" {
  source           = "./modules/vpc_peering"
  vpc_name         = module.markerting_vpc.vpc_name
  vpc_id           = module.markerting_vpc.vpc_id
  peering_vpc_name = module.financial_vpc.vpc_name
  peering_vpc_id   = module.financial_vpc.vpc_id
}

module "server_sg_financial" {
  source        = "./modules/security_group"
  sg_name       = "financial_ec2_sg"
  vpc_id        = module.financial_vpc.vpc_id
  peer_vpc_cidr = [module.markerting_vpc.vpc_cidr]
}

module "server_sg_markerting" {
  source        = "./modules/security_group"
  sg_name       = "markerting_ec2_sg"
  vpc_id        = module.markerting_vpc.vpc_id
  peer_vpc_cidr = [module.financial_vpc.vpc_cidr]
}

module "marketing_instance" {
  source          = "./modules/EC2"
  instance_type   = "t3.micro"
  instance_name   = "markerting_server"
  subnet_id       = module.markerting_vpc.public_subnet_id[0]
  security_group  = module.server_sg_markerting.sg_id
  allow_public_ip = true
  ebs_volume_size = 8
  ebs_volume_type = "gp2"
  key_pair_name   = "new-ec2-key"
}

module "financial_instance" {
  source          = "./modules/EC2"
  instance_type   = "t3.micro"
  instance_name   = "financial_server"
  subnet_id       = module.financial_vpc.public_subnet_id[0]
  security_group  = module.server_sg_financial.sg_id
  allow_public_ip = true
  ebs_volume_size = 8
  ebs_volume_type = "gp2"
  key_pair_name   = "new-ec2-key"
}
