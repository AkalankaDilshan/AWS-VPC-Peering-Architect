resource "aws_vpc_peering_connection" "peering_connection" {
  count       = var.vpc_peering ? 1 : 0
  vpc_id      = aws_vpc.main_vpc.id
  peer_vpc_id = var.peering_vpc_id
  auto_accept = true
  tags = {
    Name = "${var.vpc_name}<>${var.peering_vpc_name}"
  }
}
