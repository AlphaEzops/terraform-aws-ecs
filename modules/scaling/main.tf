#===============================================================================
# AUTO SCALING GROUP
#===============================================================================
resource "aws_placement_group" "this" {
  name     = format("%s-pg", var.name_prefix)
  strategy = "cluster"
}

resource "aws_autoscaling_group" "this" {
  name                      = each.value.name
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  desired_capacity          = each.value.desired_capacity
  health_check_grace_period = each.value.health_check_grace_period
  health_check_type         = each.value.health_check_type
  vpc_zone_identifier       = each.value.vpc_zone_identifier
  force_delete              = each.value.force_delete
  
  placement_group           = aws_placement_group.this.id
  capacity_rebalance        = true

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTerminatingInstances"
  ]

  launch_template {
    id      = var.launch_template_id      
    version = var.launch_template_version
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
    for_each = var.extra_tags ? [true] : []
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
  count                  = length(var.aws_autoscaling_group)
  autoscaling_group_name = aws_autoscaling_group.this[count.index].name
  name                   = format("%s-%s", aws_autoscaling_group.this[count.index].name, "cpu-scaling-up-policy")
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
    values = [var.aws_ami_ids_name]
  }

  filter {
    name = "owner-alias"

    values = ["amazon"]
  }
}

resource "aws_launch_template" "this" {
  for_each = { for key, value in var.aws_launch_template : key => value }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_profile.arn
  }

  instance_type = each.value.instance_type
  name_prefix   = each.value.name_prefix
  key_name      = each.value.key_name
  image_id      = data.aws_ami.amazon_linux.image_id
  user_data = base64encode(templatefile("${path.module}/templates/ecs_userdata.sh.tpl", {
    AWS_REGION       = data.aws_region.current.name,
    ECS_CLUSTER_NAME = var.cluster_name
  }))

  network_interfaces {
    security_groups = each.value.security_groups
  }

  block_device_mappings {
    device_name = each.value.ebs_block_device[each.key].device_name

    ebs {
      volume_size           = each.value.ebs_block_device[each.key].volume_size
      volume_type           = each.value.ebs_block_device[each.key].volume_type
      delete_on_termination = each.value.ebs_block_device[each.key].delete_on_termination
      encrypted             = each.value.ebs_block_device[each.key].encrypted
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
      identifiers = ["ec2.amazonaws.com"]
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
