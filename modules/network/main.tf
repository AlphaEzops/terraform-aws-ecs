data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.azs)
  name_prefix = format("%s-%s", var.environment, var.name_prefix)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = format("%s-vpc", local.name_prefix)
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.commom_tags
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = format("%s-sg", local.name_prefix)
  description = "Security group for user-service"
  vpc_id      = module.vpc.vpc_cidr_block

  ingress_cidr_blocks      = [module.vpc.vpc_cidr_block]
  ingress_rules            = ["https-443-tcp", "http-80-tcp"]
  # ingress_with_cidr_blocks = [
  #   {
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     description = "http"
  #     cidr_blocks = module.vpc.vpc_cidr_block
  #   },
  #   {
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     description = "https"
  #     cidr_blocks = module.vpc.vpc_cidr_block
  #   }
  # ]
  tags = var.commom_tags
}