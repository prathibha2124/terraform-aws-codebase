provider "aws" {
 region = var.aws_region
}

module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source    = "./security_groups"
  vpc_id    = module.vpc.vpc_id
}

module "ecr" {
  source = "./ecr"
}

module "keypair" {
  source          = "./keypair"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}


module "ec2" {
  source                 = "./ec2"
  vpc_id                 = module.vpc.vpc_id
  security_group_id      = module.security_groups.ec2_sg_id
  public_subnet_id       = module.vpc.public_subnet_ids[0]
  key_name               = module.keypair.key_name
  ecr_repository_url     = module.ecr.repository_url
  ecr_repository_name    = module.ecr.repository_name
  aws_region             = var.aws_region
}

module "alb" {
  source                 = "./alb"
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  security_group_id      = module.security_groups.alb_sg_id
  instance_id            = module.ec2.instance_id
}

resource "null_resource" "push_docker_image" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${module.ecr.repository_url}
      docker build -t ${module.ecr.repository_name} .
      docker tag ${module.ecr.repository_name}:latest ${module.ecr.repository_url}:latest
      docker push ${module.ecr.repository_url}:latest
    EOT
  }


  depends_on = [module.ecr]
} 