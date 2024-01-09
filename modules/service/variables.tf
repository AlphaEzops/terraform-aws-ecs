variable "namespace" {
  description = "Namespace for resources"
}

variable "environment" {
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

variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}