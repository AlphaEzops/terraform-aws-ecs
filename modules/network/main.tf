data "aws_availability_zones" "available" {}

locals {
  azs         = slice(data.aws_availability_zones.available.names, 0, var.azs)
  name_prefix = format("%s-%s", var.name_prefix, var.environment)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name_prefix
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for key, value in local.azs : cidrsubnet(var.vpc_cidr, 4, key)]
  public_subnets  = [for key, value in local.azs : cidrsubnet(var.vpc_cidr, 8, key + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.commom_tags
}
