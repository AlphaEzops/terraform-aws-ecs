#===============================================================================
# DATA SOURCES
#===============================================================================
# data "aws_ssm_parameter" "github_token" {
#   name = format("/%s/GH/TOKEN", upper(var.environment))
# }
# data "aws_ssm_parameter" "github_owner" {
#   name = format("/%s/GH/OWNER", upper(var.environment))
# }


#===============================================================================
# SERVICES
#===============================================================================
# module "atlantis" {
#   source                 = "./services/atlantis"
#   github_token           = data.aws_ssm_parameter.github_token.value
#   github_owner           = data.aws_ssm_parameter.github_owner.value
#   vpc_name               = module.network.vpc_name
#   cluster_name           = module.cluster.cluster_name
#   alb_name               = module.load_balancer.alb_name
#   environment            = var.environment
#   existent_hostzone_name = var.existent_hostzone_name
#   hostzone_name          = module.domain_name_server.existent_hostzone_name
  
  
# }
