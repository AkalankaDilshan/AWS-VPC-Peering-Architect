# data "aws_ami" "latest_ami" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = [var.ami_name_pattern]
#   }

#   filter {
#     name   = "architecture"
#     values = [var.ami_name_pattern]
#   }

#}
data "aws_ami" "latest_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}


resource "aws_instance" "server_instance" {
  ami                         = data.aws_ami.latest_ami.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = var.allow_public_ip

  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
    encrypted   = true
  }

  key_name = var.key_pair_name

  tags = {
    Name = var.instance_name
  }
}
