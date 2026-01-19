# Key pair for SSH login
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Default subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group allowing SSH, HTTP, HTTPS
resource "aws_security_group" "my_security_group" {
  name        = "automate_sg"
  description = "TF generated security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate_sg"
  }
}

# EC2 instances using for_each
resource "aws_instance" "my_instance" {
  for_each = var.instances

  # ami                    = "ami-076838d6a293cb49e"  
  ami                    = var.ec2_ami_id
  instance_type          = each.value              
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = aws_key_pair.my_key.key_name
  user_data              = file("install_nginx.sh")


  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
    Env  = var.env
  }
}
