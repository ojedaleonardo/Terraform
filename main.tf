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

# module "ebs" {
#   source      = "./modules/EBS"
#   instance_id = module.ec2.instance_id
#   kms_key_id  = var.kms_key_id
# }

# module "Redis" {
#   source                  = "./modules/REDIS"
#   redis_subnet_group_id   = module.vpc.redis_subnet_group_id
#   redis_security_group_id = module.ec2.redis_security_group_id
# }


