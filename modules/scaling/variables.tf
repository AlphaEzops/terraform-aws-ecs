variable "name_prefix" {
  type = string
  default = "ecs"
}

variable "environment" {
  type = string
  description = "The environment for all resources"
  default = "dev"
}
#===============================================================================
# AUTOSCALING GROUP
#===============================================================================
variable "vpc_zone_identifier" {
  type = list(string)
  description = "A list of subnet IDs to launch resources in."
}

variable "max_size" {
  type = number
  description = "The maximum size of the Auto Scaling group."
  default = 2
}

variable "min_size" {
  type = number
  description = "The minimum size of the Auto Scaling group."
  default = 1
}

variable "health_check_grace_period" {
  type = number
  description = "The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service."
  default = 300
}

variable "health_check_type" {
  type = string
  description = "The service to use for the health checks."
  default = "EC2"
}

variable "desired_capacity" {
  type = number
  description = "The number of Amazon EC2 instances that should be running in the group."
  default = 1
}

variable "force_delete" {
  type = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
  default = true
}

#===============================================================================
# LAUNCH TEMPLATE
#===============================================================================
 variable "public_key" {
   type = string
   description = "The public key to install on the instance."
 }

variable "aws_ami_ids_name" {
  type        = list(string)
  description = "The name of the AMI (provided during image creation)."
  default = ["amzn-ami-*-amazon-ecs-optimized"]
}

variable "security_groups" {
  type = list(string)
  description = "value of the security group to associate with launched instances."
}

variable "cluster_name" {
  type = string
  description = "The name of the cluster."
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start."
  default     = "t3.micro"
}

variable "block_device_mappings" {
  type = list(any)
  description = "The user data to provide when launching the instance."
  default = [
    {
      device_name = "/dev/xvda"
      ebs = {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
        encrypted = true
      }
    }
  ]
}

# variable "block_device_mappings" {
#   type = map(any)
#   description = "The user data to provide when launching the instance."
#   default = {
#     device_name = "/dev/xvda"
#     ebs = {
#       volume_size = 8
#       volume_type = "gp2"
#       delete_on_termination = true
#     }
#   }
# }

variable "tags_specifications" {
  description = "The name of the resource."
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "The name of the resource."
  default = [
    {
        key                 = "Terraform"
        value               = true
        propagate_at_launch = true
    }
  ]
}
