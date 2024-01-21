locals {
  name_prefix = format("%s-%s", var.environment, var.name_prefix)
}

#===============================================================================
# DATA | REGION
#===============================================================================
data "aws_region" "current" {}
#===============================================================================
# EIP | BASTION
#===============================================================================
resource "aws_eip" "bastion_eip" {
  domain = "vpc"
}
#===============================================================================
# ROUTE53 | ATLANTIS DNS
#===============================================================================
resource "aws_route53_record" "bastions_dns" {
  zone_id = var.zone_id
  name    = ".${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.bastion_eip.public_ip]
}
#===============================================================================
# AMI 
#===============================================================================
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = var.aws_ami_ids_name
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

#===============================================================================
#  POLICIES | DOCUMENTS
#===============================================================================
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
#===============================================================================
#  ROLE FOR INSTANCE PROFILE AND POLICY ATTACHMENT
#===============================================================================
resource "aws_iam_role" "role" {
  name               = format("iam_role-%s", split("-", uuid())[0])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
resource "aws_iam_role_policy" "attach_role_policy" {
  policy = data.aws_iam_policy_document.workloads.json
  role   = aws_iam_role.role.name
}
#===============================================================================
#  INSTANCE PROFILE
#===============================================================================
resource "aws_iam_instance_profile" "bastion_profile" {
  name = format("aws_ipr_role-%s", split("-", uuid())[0])
  role = aws_iam_role.role.name

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
#===============================================================================
# KEY PAIR | BASTION
#===============================================================================
resource "aws_key_pair" "key_name" {
  key_name   = format("%s-key", var.name_prefix)
  public_key = var.public_key
}
#===============================================================================
# EC2 | BASTION
#===============================================================================
resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amazon_linux.image_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.key_name.id
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  user_data_base64 = base64encode(templatefile("${path.module}/templates/teleport-userdata.sh", {
    AWS_REGION    = data.aws_region.current.name,
    DNS_NAME      = aws_route53_record.bastions_dns.fqdn,
    CLUSTER__NAME = var.cluster_name,
    EMAIL         = var.email,
  }))

  tags = {
    Name = format("%s-bastion", local.name_prefix)
  }
}
#===============================================================================
# EIP | ASSOCIATION
#===============================================================================
resource "aws_eip_association" "bastion_eip_association" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = aws_eip.bastion_eip.id
}
