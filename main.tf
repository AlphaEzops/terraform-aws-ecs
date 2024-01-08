module "network" {
  source = "./modules/network"

  vpc_cidr    = var.vpc_cidr
  azs         = var.azs
  name_prefix = var.name_prefix
  environment = var.environment
}

module "firewall" {
  source = "./modules/firewall"

  vpc_cidr_block = module.network.vpc_cidr_block
  name_prefix    = var.name_prefix
  environment    = var.environment
}

module "scaling" {
  source              = "./modules/scaling"

  vpc_zone_identifier = module.network.private_subnets
  security_groups     = [module.firewall.security_group_id]
  cluster_name        = var.cluster_name
  aws_ami_ids_name    = "amzn2-ami-ecs-hvm-2.0.20200616-x86_64-ebs"
  public_key          = var.public_key
}

module "cluster" {
  source                = "./modules/cluster"

  cluster_name          = var.cluster_name
  autoscaling_group_arn = module.scaling.autoscaling_group
}
