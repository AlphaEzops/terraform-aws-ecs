variable "cluster_name" {
  type = string
  description = "The name of the ECS cluster"
  default = "demo"
}

variable "name_prefix" {
  type = string
  description = "The prefix for all resources"
  default = "test"
}

variable "environment" {
  type = string
  description = "The environment for all resources"
  default = "dev"
}

#==============================================================================
# NETWORK
#==============================================================================
variable "vpc_name" {
  type = string
  description = "The name of the VPC connection"
  default = "ecs"
}

variable "vpc_cidr" {
  type = string
  description = "The CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "azs" {
  type = number
  description = "The availability zones for the VPC"
  default = 2
}
#==============================================================================
# LAUNCH TEMPLATE
#==============================================================================
variable "public_key" {
  type = string
  description = "The public key to install on the instance."
}


