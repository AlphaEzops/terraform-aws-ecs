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

# module "load_balancer" {
#   source = "./modules/load_balancer"

#   name_prefix = var.name_prefix
#   environment = var.environment

#   vpc_id             = module.network.vpc_id
#   subnets_id         = module.network.public_subnets
#   security_groups_id = module.firewall.security_group_id
#   certificate_arn    = var.certificate_arn
# }

# module "dns" {
#   source = "./modules/dns"

#   name_prefix = var.name_prefix
#   environment = var.environment

#   zone_name = var.zone_name
#   zone_id   = var.zone_id

#   record_config = [
#     {
#       name    = "www"
#       type    = "CNAME"
#       ttl     = 300
#       records = ["www.example.com"]
#     },
#   ]
# }

module "cluster" {
  source                = "./modules/cluster"
  name_prefix           = var.name_prefix
  environment           = var.environment
  autoscaling_group_arn = module.scaling.autoscaling_group_arn
}
