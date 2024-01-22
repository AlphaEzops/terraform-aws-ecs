variable "environment" {
  type        = string
  description = "Environment for resources"
}

variable "owner" {
  type        = string
  description = "Owner of the resources"
  default     = "DevOps Team"
}

variable "project" {
  type        = string
  description = "The project name"
  default     = "test"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

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

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
