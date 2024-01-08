locals {
  name_prefix = format("%s-%s", var.environment, var.name_prefix)
}


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = format("%s-sg", local.name_prefix)
  description = "Security group for user-service"
  vpc_id      = module.vpc.vpc_cidr_block

  ingress_cidr_blocks = [var.vpc_cidr_block] 
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]

  # ingress_with_cidr_blocks = [
  #   {
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     description = "http"
  #     cidr_blocks = ["10.0.0.0/16"]
  #   },
  #   {
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     description = "https"
  #     cidr_blocks = ["10.0.0.0/16"]
  #   }
  # ]
  tags = var.commom_tags
}
