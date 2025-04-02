provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Allow all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main-instance" {
  ami             = "ami-0f9de6e2d2f067fca"
  instance_type   = "t2.medium"
  key_name        = "project"
  security_groups = [aws_security_group.allow_all.name]

  tags = {
    Name = "main-instance"
  }
}

resource "aws_instance" "slave-instance" {
  ami             = "ami-0f9de6e2d2f067fca"
  instance_type   = "t2.micro"
  key_name        = "project"
  security_groups = [aws_security_group.allow_all.name]

  tags = {
    Name = "slave-instance"
  }
}

output "instance_ips" {
  value = {
    main_instance  = aws_instance.main-instance.public_ip
    slave_instance = aws_instance.slave-instance.public_ip
  }
}
