# ==============================================================================
# NETWORK | VPC - SUBNETS - ROUTE TABLES - INTERNET GATEWAY - NAT GATEWAY - VPN
# ==============================================================================
module "network" {
  source = "../modules/network"
  name_prefix = var.name_prefix
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  azs         = var.azs
}

# ==============================================================================
# FIREWALL | SECURITY GROUPS
# ==============================================================================
module "firewall" {
  source = "../modules/firewall"

  name_prefix    = var.name_prefix
  environment    = var.environment
  vpc_id         = module.network.vpc_id
  vpc_cidr_block = module.network.vpc_cidr_block
}

# ==============================================================================
# DNS | ROUTE 53 - CERTIFICATE MANAGER
# ==============================================================================
module "domain_name_server" {
  source = "../modules/domain_name_server"

  existent_hostzone_name   = var.existent_hostzone_name
  existent_acm_domain_name = var.existent_acm_domain_name
}

# ==============================================================================
# PROXIES | LOAD BALANCER - TARGET GROUP - LISTENER - RULES
# ==============================================================================
module "load_balancer" {
  source = "../modules/proxies/load_balancer"

  name_prefix = var.name_prefix
  environment = var.environment
  # vpc_id             = module.network.vpc_id
  subnets_id         = module.network.public_subnets
  security_groups_id = [module.firewall.load_balancer_sg_id]
  # certificate_arn    = module.domain_name_server.existent_certificate_arn
}
# ==============================================================================
# SCALING | AUTOSCALING GROUP - LAUNCH CONFIGURATION
# ==============================================================================
module "scaling" {
  source = "../modules/scaling"

  name_prefix         = var.name_prefix
  environment         = var.environment
  security_groups     = [module.firewall.ecs_sg_id]
  vpc_zone_identifier = module.network.private_subnets
  cluster_name        = module.cluster.cluster_name
  public_key          = var.public_key
  aws_ami_ids_name    = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
}

# ==============================================================================
# CLUSTER | ECS CLUSTER
# ==============================================================================
module "cluster" {
  source = "../modules/cluster"

  name_prefix           = var.name_prefix
  environment           = var.environment
  autoscaling_group_arn = module.scaling.autoscaling_group_arn
}
# ==============================================================================
# BASTION | EC2 INSTANCE
# ==============================================================================
module "bastion" {
  source = "../modules/proxies/bastion"

  name_prefix            = var.name_prefix
  environment            = var.environment
  cluster_name           = module.cluster.cluster_name
  subnet_id              = module.network.public_subnets[0]
  public_key             = var.public_key
  vpc_security_group_ids = [module.firewall.bastion_sg_id]
  zone_name              = module.domain_name_server.existent_hostzone_name #try(, module.domain_name_server.hostzone_name)
  zone_id                = module.domain_name_server.extistent_zone_id      #try(module.domain_name_server.existent_hostzone_id, module.domain_name_server.hostzone_id)
}
