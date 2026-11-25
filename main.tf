module "vpc" {
  source = "./modules/vpc"

  name               = var.project_name
  vpc_cidr           = var.vpc_cidr
  az_count           = var.az_count
  enable_nat_gateway = var.enable_nat_gateway
}


module "security" {
  source = "./modules/security"

  name   = var.project_name
  vpc_id = module.vpc.vpc_id
}


module "ec2" {
  source = "./modules/ec2"

  name = var.project_name

  image_tag = var.image_tag

  ecr_repository_url = module.ecr.repository_url

  aws_region = var.aws_region

  ecr_repository_arn = module.ecr.repository_arn

  app_subnet_ids = module.vpc.app_subnet_ids

  app_security_group_id = module.security.app_security_group_id

  target_group_arns = [module.alb.target_group_arn]
}

module "alb" {
  source = "./modules/alb"

  name = var.project_name

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id
}

module "rds" {
  source = "./modules/rds"

  name = var.project_name

  db_subnet_ids = module.vpc.db_subnet_ids

  db_security_group_id = module.security.db_security_group_id

  final_snapshot_identifier = "${var.project_name}-mysql-final-v1"
}

module "ecr" {
  source = "./modules/ecr"

  name = "${var.project_name}-sudoku"
}
