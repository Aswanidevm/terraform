module "ec2"{
  for_each = var.instances
  source = "./ec2"
  component = each.value["name"]
  instance_type = lookup(each.value, "instance_type", "t3.small")
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