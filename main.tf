provider "aws" {
  region = var.region
}

# Create a dedicated security group for each instance using for_each
resource "aws_security_group" "sg" {
  for_each = var.instance_configs

  name        = "${each.key}-sg"
  description = "Security group for ${each.key} instance"
  
  # Open required port(s)
  dynamic "ingress" {
    for_each = each.value.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${each.key}-sg"
  }
}

# Create EC2 instances, one for each config, attach each to its respective SG
resource "aws_instance" "ec2" {
  for_each = var.instance_configs

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  vpc_security_group_ids = [aws_security_group.sg[each.key].id]

  tags = {
    Name = "${each.key}-instance"
  }
}
