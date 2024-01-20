
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

variable "commom_tags" {
  type        = map(string)
  description = "The common tags for all resources"
  default     = {}
}

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
