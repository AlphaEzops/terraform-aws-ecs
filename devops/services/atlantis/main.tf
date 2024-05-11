#===============================================================================
# SUPPORTING RESOURCES | ATLANTIS
#===============================================================================
resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}
#===============================================================================
# GITHUB | ATLANTIS WEBHOOK
#===============================================================================
module "github_repository_webhooks" {
  source = "../../../modules/git_repository/github/webhook"

  repositories   = ["*"]
  webhook_url    = format("%s.%s/events", "atlantis", try(var.existent_hostzone_name, var.hostzone_name))
  webhook_secret = random_password.webhook_secret.result
}

#===============================================================================
# SERVICE | ATLANTIS
#===============================================================================
module "service" {
  source                                      = "../../../modules/service"
  certificate_arn                             = ""
  environment                                 = var.environment
  service_name                                = var.service_name
  cluster_name                                = var.cluster_name
  alb_name                                    = var.alb_name
  vpc_name                                    = var.vpc_name
  existent_hostzone_name                      = var.existent_hostzone_name
  hostzone_name                               = var.hostzone_name
  image                                       = var.image
  hash                                        = var.hash
  container_port                              = var.container_port
  memory                                      = var.memory
  cpu_units                                   = var.cpu_units
  ecs_task_desired_count                      = var.ecs_task_desired_count
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  environment_variables = [
    {
      name  = "ATLANTIS_GH_USER"
      value = var.github_owner
    },
    {
      name  = "ATLANTIS_REPO_ALLOWLIST"
      value = var.atlantis_repo_allowlist
    },
    {
      name  = "ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT"
      value = "true"
    },
    {
      name  = "ATLANTIS_ATLANTIS_URL"
      value = "https://atlantis.${try(var.existent_hostzone_name, var.hostzone_name)}:443"
    }
  ]
  secrets = [
    {
      name      = "ATLANTIS_GH_TOKEN"
      valueFrom = var.github_token
    },
    {
      name      = "ATLANTIS_GH_WEBHOOK_SECRET"
      valueFrom = random_password.webhook_secret.result
    },
  ]
}
