provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "data.aws_ami.ec2.id" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = var.name
  }
}

data "aws_ami" "ec2" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["self"]
}

resource "aws_security_group" "sg" {
  name        = "${var.name}-sg"
  description = "Allow all inbound traffic"
 
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}"
  }
}

variable name{}