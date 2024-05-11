#==============================================================================
# GENERAL
#==============================================================================
variable "name_prefix" {
  type        = string
  description = "The prefix for all resources"
  default     = "test"
}

variable "environment" {
  type        = string
  description = "The environment for all resources"
  default     = "dev"
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


#==============================================================================
# SCALING
#==============================================================================
variable "public_key" {
  type        = string
  description = "The public key to install on the instance."
}

#==============================================================================
# NETWORK
#==============================================================================
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "azs" {
  type        = number
  description = "The availability zones for the VPC"
  default     = 2
}
#==============================================================================
# DNS
#==============================================================================

variable "existent_hostzone_name" {
  type        = string
  description = "The name of the existent hostzone"
}

variable "existent_acm_domain_name" {
  type        = string
  description = "The name of the existent certificate"
}

#===============================================================================
# SERVICES
#===============================================================================

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
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
