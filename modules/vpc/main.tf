resource "aws_vpc" "main_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "private subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.vpc_name} igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route" "pulic_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.enable_NAT_gateway ? 1 : 0
  allocation_id = aws_eip.elastic_IP_address.id
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)
}

resource "aws_eip" "elastic_IP_address" {
  count = var.enable_NAT_gateway ? 1 : 0
  vpc   = true
  tags = {
    Name = "${var.vpc_name}-vpc-natGateway-EIP"
  }

}

resource "aws_route_table" "private_rt" {
  count  = var.enable_NAT_gateway ? 1 : 0
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route" "private_route" {
  count                  = var.enable_NAT_gateway ? 1 : 0
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_vpc_peering_connection" "peering_connection" {
  count       = var.vpc_peering ? 1 : 0
  vpc_id      = aws_vpc.main_vpc.id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true
  tags = {
    Name = "${var.vpc_name}<>${var.peering_vpc_name}"
  }
}

# resource "aws_network_acl" "public_ACL" {
#   vpc_id = aws_vpc.main_vpc.id
#   tags = {
#     Name = "${var.vpc_name}-public-NACL"
#   }
# }

# resource "aws_network_acl" "private_ACL" {
#   vpc_id = aws_vpc.main_vpc.id
#   tags = {
#     Name = "${var.vpc_name}-private-NACL"
#   }
# }
