variable "environment" {
  type        = string
  description = "Environment for resources"
}

variable "ecs_task_desired_count" {
  description = "Desired count of ECS tasks"
  type        = number
  default     = 1
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during ECS task deployment"
  type        = number
  default     = 50
}

variable "ecs_task_deployment_maximum_percent" {
  description = "Maximum percent during ECS task deployment"
  type        = number
  default     = 200
}

variable "cpu_units" {
  description = "CPU units for ECS task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory for ECS task"
  type        = number
  default     = 512
}

variable "container_port" {
  description = "Container port for ECS task"
  type        = number
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "image" {
  description = "Docker image"
  type        = string
}

variable "hash" {
  description = "Docker image hash"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "secrets" {
  description = "values for secrets"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "environment_variables" {
  description = "values for environment variables"
  type        = list(any)
  default     = []
}

#===============================================================================
# ALB
#===============================================================================
variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "target_group" {
  description = "values for target group"
  type = object({
    port        = number
    protocol    = string
    target_type = string
    health_check = object({
      path                = string
      port                = string
      protocol            = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      interval            = number
    })
  })
  default = {
    port        = 443
    protocol    = "HTTPS"
    target_type = "ip"
    health_check = {
      path                = "/"
      port                = "443"
      protocol            = "HTTPS"
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 3
      interval            = 20
    }
  }
}

variable "alb_listener_port" {
  description = "Port of the ALB listener"
  type        = number
  default     = 443
}

variable "priority" {
  description = "Priority of the ALB listener rule"
  type        = number
  default     = 100
}

variable "condition" {
  description = "Condition of the ALB listener rule"
  type = list(object({
    path_pattern = list(string)
    host_header  = list(string)
  }))
  default = [{
    path_pattern = ["/"]
    host_header  = ["atlantis.dev.tmaior.com.br"]
  }]
}

#===============================================================================
# ROUTE53
#===============================================================================
variable "existent_hostzone_name" {
  type        = string
  description = "value of existent hostzone name"
  default     = null
}

variable "hostzone_name" {
  type        = string
  description = "value of hostzone name"
  default     = null
}

#===============================================================================
# NETWORK
#===============================================================================
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
