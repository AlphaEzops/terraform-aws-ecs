#===============================================================================
# DATA SOURCES
#===============================================================================
data "aws_region" "current" {}

data "aws_route53_zone" "zone" {
  name = try(var.existent_hostzone_name, var.hostzone_name)
}
#===============================================================================
# LOAD BALANCER TARGET GROUP HTTPS
#===============================================================================
resource "aws_lb_target_group" "target_group" {
  name        = format("%s-tg", var.service_name)
  port        = var.target_group.port
  protocol    = var.target_group.protocol
  target_type = var.target_group.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = var.target_group.health_check.path
    port                = var.target_group.health_check.port
    protocol            = var.target_group.health_check.protocol
    healthy_threshold   = var.target_group.health_check.healthy_threshold
    unhealthy_threshold = var.target_group.health_check.unhealthy_threshold
    timeout             = var.target_group.health_check.timeout
    interval            = var.target_group.health_check.interval
  }

  lifecycle {
    create_before_destroy = true
  }
}
#===============================================================================
# LOAD BALANCER LISTENER HTTP
#===============================================================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = var.alb_arn 
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
  }
}

#===============================================================================
# LOAD BALANCER LISTENER HTTPS
#===============================================================================
resource "aws_lb_listener" "https" {
  load_balancer_arn =  var.alb_arn #data.aws_alb.current.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
#===============================================================================
# LISTENER RULES
#===============================================================================
resource "aws_lb_listener_rule" "https_listener_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = var.priority
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  dynamic "condition" {
    for_each = var.condition
    content {

      dynamic "path_pattern" {
        for_each = condition.value.path_pattern
        content {
          values = [path_pattern.value]
        }
      }

      dynamic "host_header" {
        for_each = condition.value.host_header
        content {
          values = [host_header.value]
        }
      }
    }
  }
}

#===============================================================================
# ROUTE53 RECORD
#===============================================================================
locals {
  prod_stage   = format("%s-%s", var.service_name, data.aws_route53_zone.zone.name)
  other_stage  = format("%s-%s-%s", var.service_name, var.environment, data.aws_route53_zone.zone.name)
  records_name = var.environment == "prod" ? local.prod_stage : local.other_stage
}
resource "aws_route53_record" "this" {
  zone_id = var.hostzone_name #data.aws_route53_zone.zone.zone_id
  name    = local.records_name
  type    = "CNAME"
  ttl     = 300
  records = [var.dns_name]
}

#===============================================================================
# SERVICE
#===============================================================================
resource "aws_ecs_service" "service" {
  name                               = "${var.service_name}_${var.environment}"
  iam_role                           = aws_iam_role.ecs_task_iam_role.arn
  cluster                            = var.cluster_name #data.aws_ecs_cluster.current.id
  task_definition                    = aws_ecs_task_definition.default.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  # launch_type                        = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  ## Spread tasks evenly accross all Availability Zones for High Availability
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ## Make use of all available space on the Container Instances
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count]
  }
}
#===============================================================================
# ECS TASK DEFINITION
#===============================================================================
resource "aws_ecs_task_definition" "default" {
  family             = "${var.service_name}_ECS_TaskDefinition_${var.environment}"
  execution_role_arn = aws_iam_role.ecs_execution_iam_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn
  network_mode       = "awsvpc"

  container_definitions = jsonencode([
    {
      name   = var.service_name
      image  = "${var.image}:${var.hash}"
      cpu    = var.cpu_units
      memory = var.memory
      # memoryReservation = var.memoryReservation
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name,
          "awslogs-region"        = data.aws_region.current.name,
          "awslogs-stream-prefix" = "app"
        }
      }
      secrets = [
        for v in var.secrets :
        {
          name      = v.name
          valueFrom = v.valueFrom
        }
      ]
      environment = [
        for v in var.environment_variables :
        {
          name  = v.name
          value = v.value
        }
      ]
    }
  ])
}
#===============================================================================
# AWS CLOUDWATCH LOG GROUP
#===============================================================================
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/${lower(var.environment)}/ECS/${lower(var.service_name)}"
  retention_in_days = 7
}

#===============================================================================
# AWS IAM ROLE - TASK ROLE
#===============================================================================
data "aws_iam_policy_document" "task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_iam_role" {
  name               = "${var.environment}_ECS_TaskIAMRole_${var.service_name}"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

#===============================================================================
# AWS IAM ROLE - EXECUTION ROLE
#===============================================================================
data "aws_iam_policy_document" "execution_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_execution_iam_role" {
  name               = "${var.environment}_ECS_TaskExecutionRole_${var.service_name}"
  assume_role_policy = data.aws_iam_policy_document.execution_assume_role_policy.json
  
  # inline_policy {
  #   name = "ecs_execution_role_policy"
  #   policy = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  # }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
