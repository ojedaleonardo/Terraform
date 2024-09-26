module "vpc" {
  source         = "./modules/VPC"
  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
  private_a_cidr = var.private_a_cidr
  private_b_cidr = var.private_b_cidr
  public_a_cidr  = var.public_a_cidr
  public_b_cidr  = var.public_b_cidr
}

module "ec2" {
  source              = "./modules/EC2"
  ec2_windows_specs   = var.ec2_windows_specs
  ec2_linux_specs     = var.ec2_linux_specs
  ec2_aws_specs       = var.ec2_aws_specs
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
  vpc_id              = module.vpc.vpc_id
  natgw_id            = module.vpc.natgw_id
}

module "cognito" {
  source          = "./modules/COGNITO"
  user_pool_name  = var.user_pool_name
  app_client_name = var.app_client_name
}

module "ava" {
  source = "./modules/AVA"

  cognito_user_pool_id      = module.cognito.user_pool_id
  cognito_domain            = module.cognito.cognito_domain
  cognito_client_id         = module.cognito.user_pool_client_id
  cognito_client_secret     = module.cognito.user_pool_client_secret
  private_subnet_a_id       = module.vpc.private_subnet_a_id
  private_subnet_b_id       = module.vpc.private_subnet_b_id
  load_balancer_arn         = module.ec2.load_balancer_arn
  default_security_group_id = module.vpc.default_security_group_id
}

# module "Redis" {
#   source                  = "./modules/REDIS"
#   redis_subnet_group_id   = module.vpc.redis_subnet_group_id
#   redis_security_group_id = module.ec2.redis_security_group_id
# }


