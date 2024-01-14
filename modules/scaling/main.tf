locals {
  name_prefix = format("%s-%s", var.environment, var.name_prefix)
}
#===============================================================================
# AUTO SCALING GROUP
#===============================================================================
resource "aws_placement_group" "this" {
  name     = format("%s-pg", var.name_prefix)
  strategy = "cluster"
}

resource "aws_autoscaling_group" "this" {
  name                      = format("%s-asg", var.name_prefix)
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = var.vpc_zone_identifier
  force_delete              = var.force_delete

  placement_group    = aws_placement_group.this.id
  capacity_rebalance = true

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTerminatingInstances"
  ]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.extra_tags != [] ? var.extra_tags : []
    content {
      key                 = tag.value.key
      propagate_at_launch = tag.value.propagate_at_launch
      value               = tag.value.value
    }
  }

  timeouts {
    delete = "15m"
    update = "10m"
  }
}

#===============================================================================
# AUTO SCALING POLICY
#===============================================================================
resource "aws_autoscaling_policy" "scaling_policy" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  name                   = format("%s-%s", aws_autoscaling_group.this.name, "cpu-scaling-up-policy")
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 1.0
    metric_interval_upper_bound = 2.0
  }

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 2.0
  }
}

#===============================================================================
# LAUNCH TEMPLATE
#===============================================================================
data "aws_region" "current" {}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = var.aws_ami_ids_name
  }

  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_key_pair" "key_name" {
  key_name   = format("%s-key", var.name_prefix)
  public_key = var.public_key
}

resource "aws_launch_template" "this" {
  name_prefix   = var.name_prefix
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_name.key_name
  image_id      = data.aws_ami.amazon_linux.image_id

  user_data = base64encode(templatefile("${path.module}/templates/ecs_userdata.sh.tpl", {
    AWS_REGION       = data.aws_region.current.name,
    ECS_CLUSTER_NAME = var.cluster_name
  }))

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_profile.arn
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    security_groups = var.security_groups
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name

      ebs {
        volume_size           = block_device_mappings.value.ebs.volume_size
        volume_type           = block_device_mappings.value.ebs.volume_type
        delete_on_termination = block_device_mappings.value.ebs.delete_on_termination
        encrypted             = block_device_mappings.value.ebs.encrypted
      }
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge({ CreatedBy = "Terraform" }, var.tags_specifications)
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tag_specifications["tags"],
    ]
  }
}

#===============================================================================
# INSTANCE PROFILE
#===============================================================================
resource "aws_iam_role" "role" {
  name               = format("aws_ltr-%s", split("-", uuid())[0])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = format("aws_ipr_role-%s", split("-", uuid())[0])
  role = aws_iam_role.role.name

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ecs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]

  }
}

data "aws_iam_policy_document" "workloads" {
  statement {
    sid    = "RoleForECSWorkloads"
    effect = "Allow"
    actions = [
      "ssmmessages:*",
      "cloudwatch:*",
      "ds:*",
      "logs:*",
      "ssm:*",
      "ec2messages:*",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:*",
      "appmesh:*",
      "autoscaling:*",
      "cloudformation:*",
      "cloudwatch:*",
      "codedeploy:*",
      "ec2:*",
      "ecs:*",
      "elasticfilesystem:*",
      "elasticloadbalancing:*",
      "events:*",
      "iam:*",
      "lambda:ListFunctions",
      "logs:*",
      "route53:*",
      "servicediscovery:*",
      "sns:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "attach_role_policy" {
  policy = data.aws_iam_policy_document.workloads.json
  role   = aws_iam_role.role.name
}
