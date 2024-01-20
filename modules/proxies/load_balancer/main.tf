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

#===============================================================================
# LOAD BALANCER TARGET GROUP HTTP
#===============================================================================
resource "aws_lb_target_group" "http" {
  name        = format("%s-http-tg", local.name_prefix)
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 20
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}

#===============================================================================
# LOAD BALANCER LISTENER HTTP
#===============================================================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
    target_group_arn = aws_lb_target_group.http.arn
  }
}

#===============================================================================
# LOAD BALANCER TARGET GROUP HTTPS
#===============================================================================
resource "aws_lb_target_group" "https" {
  name        = format("%s-https-tg", local.name_prefix)
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    port                = "443"
    protocol            = "HTTPS"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 20
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}
#===============================================================================
# LOAD BALANCER LISTENER HTTPS
#===============================================================================
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this[0].arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }
}
