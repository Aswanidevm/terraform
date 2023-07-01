module "frontend"{
    source = "./ec2"
  
}

module "mongodb"{
    source = "./ec2"
  
}

module "catalogue"{
    source = "./ec2"
   
}

module "mysql"{
    source = "./ec2"
    
}

module "cart"{
    source = "./ec2"
    

module "shipping"{
    source = "./ec2"
   
}

module "redis"{
    source = "./ec2"
   
}

module "rabbitmq"{
    source = "./ec2"
 
}

module "dispatch"{
    source = "./ec2"
  
}

module "user"{
    source = "./ec2"
 
}

