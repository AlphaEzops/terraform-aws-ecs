module "network" {
  source = "./modules/network"

  name_prefix = var.name_prefix
  environment = var.environment

  vpc_cidr = var.vpc_cidr
  azs      = var.azs
}

module "firewall" {
  source = "./modules/firewall"

  name_prefix = var.name_prefix
  environment = var.environment

  vpc_cidr_block = module.network.vpc_cidr_block
}

module "domain_name_server" {
  source = "./modules/domain_name_server"

  hostzone_exists = true              
  domain_name     = "example.com"
}

module "load_balancer" {
  source = "./modules/proxies/load_balancer"

  name_prefix = var.name_prefix
  environment = var.environment

  vpc_id             = module.network.vpc_id
  subnets_id         = module.network.public_subnets
  security_groups_id = module.firewall.security_group_id
  certificate_arn    = var.certificate_arn
}

module "scaling" {
  source = "./modules/scaling"

  name_prefix = var.name_prefix
  environment = var.environment

  security_groups     = module.firewall.security_group_id
  vpc_zone_identifier = module.network.private_subnets
  cluster_name        = module.cluster.cluster_name
  public_key          = var.public_key
  aws_ami_ids_name    = ["amzn-ami-*-amazon-ecs-optimized"]
}

module "cluster" {
  source                = "./modules/cluster"
  name_prefix           = var.name_prefix
  environment           = var.environment
  autoscaling_group_arn = module.scaling.autoscaling_group_arn
}
