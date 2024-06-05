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
module "atlantis" {
  source                 = "./services/atlantis"
  github_token           = "test" 
  github_owner           = "test"
  vpc_id                 = module.network.vpc_id
  cluster_name           = module.cluster.cluster_name
  alb_arn                = module.load_balancer.alb_arn
  dns_name               = module.load_balancer.dns_name
  environment            = var.environment
  existent_hostzone_name = var.existent_hostzone_name
  hostzone_name          = module.domain_name_server.existent_hostzone_name
}
