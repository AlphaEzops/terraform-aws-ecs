#===============================================================================
# SUPPORTING RESOURCES | ATLANTIS
#===============================================================================
resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}
#===============================================================================
# ROUTE53 | ATLANTIS DNS
#===============================================================================
resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = "atlantis.${var.zone_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]
}
#===============================================================================
# GITHUB | ATLANTIS WEBHOOK
#===============================================================================
module "github_repository_webhooks" {
  source = "../../../modules/git_repository/github/webhook"

  repositories   = ["*"]
  webhook_url    = "${aws_route53_record.this.name}/events"
  webhook_secret = random_password.webhook_secret.result
}

#===============================================================================
# SERVICE | ATLANTIS
#===============================================================================
module "service" {
  source = "../../../modules/service"

  service_name                                = var.service_name
  environment                                 = var.environment
  cluster_id                                  = var.cluster_id
  target_group_arn                            = var.target_group_arn
  image                                       = var.image
  hash                                        = var.hash
  cpu_units                                   = var.cpu_units
  memory                                      = var.memory
  container_port                              = var.container_port
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
