locals {
  name_prefix = format("%s-%s", var.name_prefix, var.environment)
}
#===============================================================================
# LOAD BALANCER
#===============================================================================
resource "aws_lb" "this" {
  count                      = var.enabled ? 1 : 0
  name                       = local.name_prefix
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_groups_id
  subnets                    = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.access_logs != null ? [var.access_logs] : []

    content {
      bucket  = access_logs.value.bucket_id
      prefix  = access_logs.value.prefix
      enabled = access_logs.value.enabled
    }
  }

  tags = var.common_tags

  timeouts {
    create = lookup(var.timeout, "create", null)
    update = lookup(var.timeout, "update", null)
    delete = lookup(var.timeout, "delete", null)
  }
}
