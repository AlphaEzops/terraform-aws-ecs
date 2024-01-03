variable "name_prefix" {
  type = string
  default = "ecs"
}

#===============================================================================
# AUTOSCALING GROUP
#===============================================================================

variable "aws_autoscaling_group" {
  description = "The name of the Auto Scaling group."
  type = list(object({
    name                      = string
    max_size                  = number
    min_size                  = number
    health_check_grace_period = number
    health_check_type         = string
    desired_capacity          = number
    force_delete              = bool
    vpc_zone_identifier       = list(string)

  }))
  default = []
}

variable "extra_tags" {
  default = [
    {
        key                 = "Terraform"
        value               = true
        propagate_at_launch = true
    }
  ]
}

variable "launch_template_id" {
  type = string
  description = "launch template id"
}

#===============================================================================
# LAUNCH TEMPLATE
#===============================================================================
variable "launch_template_version" {
  type = string
  description = "launch template version"
}

variable "aws_ami_ids_name" {
  type        = string
  description = "The name of the AMI (provided during image creation)."
}

variable "aws_launch_template" {
  description = "The name of the launch template."
  type = list(object({
    name_prefix = string

    /* image_id      = string */
    instance_type = string
    key_name      = string
    ebs_block_device = list(object({
      device_name           = string
      volume_size           = number
      volume_type           = string
      delete_on_termination = bool
      encrypted             = bool
    }))
    security_groups = list(string)
  }))
  default = []
}

variable "tags_specifications" {
  description = "The name of the resource."
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
  default     = ""
}