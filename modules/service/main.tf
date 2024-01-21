
#===============================================================================
# DATA SOURCES
#===============================================================================
data "aws_region" "current" {}

#===============================================================================
# SERVICE
#===============================================================================
resource "aws_ecs_service" "service" {
  name                               = "${var.service_name}_${var.environment}"
  iam_role                           = aws_iam_role.ecs_task_iam_role.arn
  cluster                            = var.cluster_id
  task_definition                    = aws_ecs_task_definition.default.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent

  load_balancer {
    target_group_arn = var.target_group_arn
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
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn

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
# AWS IAM ROLE
#===============================================================================
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.environment}_ECS_TaskExecutionRole_${var.service_name}"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

data "aws_iam_policy_document" "task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_iam_role" {
  name               = "${var.environment}_ECS_TaskIAMRole_${var.service_name}"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}
