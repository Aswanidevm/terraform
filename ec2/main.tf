data "aws_ami" "ec2" {
  most_recent = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners = ["973714476881"] 
}



resource "aws_instance" "ec2" {
  for_each = var.instances
  ami           = data.aws_ami.ec2.id
  instance_type = lookup(each.value, "instance_type", "t3.micro")
  tags = {
    Name = each.key
  }
}

provisioner "remote-exec" {

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }

  
    inline = [
     sudo labauto ansible,
     ansible-pull -i localhost, -U https://github.com/Aswanidevm/Devops/tree/f180152498705703a9801143a55ee8b4533d780a/ansible main.yml,
    ]
  }

  resource "aws_route53_record" "dns-record" {
    for_each = var.instances
  zone_id = Z04818282BOE8RVGV13K7
  name    = "${each.value["name"]}"
  type    = "A"
  ttl     = "300"
  records = ["aws_instance.ec2.private.ip"]
}

resource "aws_security_group" "sg" {
  for_each = var.instances
  name        = "${each.value["name"]}-sg"
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
    Name = each.value["name"]
  }
}


variable instances{
  default = {
    frontend = {
      instance_type = "t3.micro"
      name = "frontend"
   }

    mongodb = {
      instance_type = "t3.micro"
      name = "mongodb"
   }

    catalogue = {
      instance_type = "t3.micro"
      name = "catalogue"
   }

    mysql = {
      instance_type = "t3.micro"
      name = "mysql"
  }

    cart = {
      instance_type = "t3.micro"
      name = "cart"
  }

    shipping = {
      instance_type = "t3.micro"
      name = "shipping"
  }

    redis = {
      instance_type = "t3.micro"
      name = "redis"
  }

    rabbitmq = {
      instance_type = "t3.micro"
      name = "rabbitmq"
  }

    dispatch = {
      instance_type = "t3.micro"
      name = "dispatch"
  }

    user = {
      instance_type = "t3.micro"
      name = "user"
  }
 }
}