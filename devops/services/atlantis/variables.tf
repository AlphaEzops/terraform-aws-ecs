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
  default     = 80
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "nginx"
}

variable "image" {
  description = "Docker image"
  type        = string
  default     = "nginx"
}

variable "hash" {
  description = "Docker image hash"
  type        = string
  default     = "latest"
}

variable "cluster_id" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "zone_id" {
  description = "Zone ID of the Route53 record"
  type        = string
}

variable "zone_name" {
  description = "Zone name of the Route53 record"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "alb_dns_name" {
  description = "Name of the ALB"
  type        = string
}

variable "atlantis_repo_allowlist" {
  description = "Atlantis repo allowlist"
  type        = string
  default     = "*"
}

variable "github_token" {
  description = "GitHub token"
  type        = string
  default     = null
}

variable "github_owner" {
  description = "Atlantis repo config"
  type        = string
  default     = null
}
