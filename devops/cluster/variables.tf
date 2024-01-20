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
