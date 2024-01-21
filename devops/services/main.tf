#===============================================================================
# DATA SOURCES
#===============================================================================
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.cluster_name
}
data "aws_alb" "alb_name" {
  name = var.alb_name
}
data "aws_lb_target_group" "https_target_group" {
  name = var.target_group_name
}
data "aws_route53_zone" "zone" {
  name = try(var.existent_hostzone_name, var.hostzone_name)
}
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
  source           = "./atlantis"
  environment      = var.environment
  cluster_id       = data.aws_ecs_cluster.ecs_cluster.id
  target_group_arn = data.aws_lb_target_group.https_target_group.arn
  github_token     = data.aws_ssm_parameter.github_token.value
  github_owner     = data.aws_ssm_parameter.github_owner.value
  zone_id          = data.aws_route53_zone.zone.id
  zone_name        = data.aws_route53_zone.zone.name
  alb_dns_name     = data.aws_alb.alb_name.dns_name
}
