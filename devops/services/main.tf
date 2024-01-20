#===============================================================================
# DATA SOURCES
#===============================================================================
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.cluster_name
}

data "aws_lb_target_group" "https_target_group" {
  name = var.target_group_name
}

#===============================================================================
# SERVICE
#===============================================================================
module "service" {
  source = "../../modules/service"

  service_name                                = var.service_name
  environment                                 = var.environment
  cluster_id                                  = data.aws_ecs_cluster.ecs_cluster.id
  target_group_name_arn                       = data.aws_lb_target_group.https_target_group.arn
  image                                       = var.image
  hash                                        = var.hash
  cpu_units                                   = var.cpu_units
  memory                                      = var.memory
  container_port                              = var.container_port
  ecs_task_desired_count                      = var.ecs_task_desired_count
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
}
