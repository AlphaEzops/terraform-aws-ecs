#===============================================================================
# DATA SOURCES
#===============================================================================
data "aws_ssm_parameter" "github_token" {
  name = format("/%s/GH/TOKEN", upper(var.environment))
}
data "aws_ssm_parameter" "github_owner" {
  name = format("/%s/GH/OWNER", upper(var.environment))
}

#===============================================================================
# SERVICES
#===============================================================================
module "atlantis" {
  source                 = "./atlantis"
  github_token           = data.aws_ssm_parameter.github_token.value
  github_owner           = data.aws_ssm_parameter.github_owner.value
  environment            = var.environment
  cluster_name           = var.cluster_name
  existent_hostzone_name = var.existent_hostzone_name
  hostzone_name          = var.hostzone_name
  alb_name               = var.alb_name
  vpc_name               = var.vpc_name
}
