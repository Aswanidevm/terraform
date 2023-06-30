data "aws_ami" "ec2" {
  most_recent = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners = ["973714476881"] 
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ec2.id
  instance_type = "t3.micro"
  

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.name}-sg"
  description = "Allow TLS inbound traffic"


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
    Name = "var.name"
  }
}
variable name{}