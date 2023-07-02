data "aws_ami" "ec2" {
  most_recent = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners = ["973714476881"] 
}

resource "aws_instance" "ec2" {
   ami           = data.aws_ami.ec2.id
  instance_type = var.instance_type
  tags = {
    Name = var.component
  }

}

resource "null_resource" "ansible"{
  depends_on = [ aws_instance.ec2, aws_route53_record.wwww]
  provisioner "remote-exec" {

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_instance.ec2.public_ip
  }

  
    inline = [
     "sudo labauto ansible",
     "ansible-pull -i localhost, -U https://github.com/Aswanidevm/Devops/tree/f180152498705703a9801143a55ee8b4533d780a/ansible main.yml",
    ]
  }
}

resource "aws_route53_record" "wwww" {
  zone_id = "Z04818282BOE8RVGV13K7"
  name    = "${var.component}.myprojecdevops.info"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ec2.private_ip]
}

resource "aws_security_group" "sg" {
  name        = "${var.component}-sg"
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
    Name = var.component
  }
}


variable "component"{}
variable "instance_type"{}