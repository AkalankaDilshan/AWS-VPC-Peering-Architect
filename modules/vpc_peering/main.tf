resource "aws_vpc_peering_connection" "peering_connection" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peering_vpc_id
  auto_accept = true
  tags = {
    Name = "${var.vpc_name}<>${var.peering_vpc_name}"
  }
}
