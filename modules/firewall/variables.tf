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

variable "vpc_id" {
  type = string
  description = "The VPC ID"
}

variable "vpc_cidr_block" {
  type = string
  description = "The CIDR block for the VPC"
}

variable "commom_tags" {
  type = map(string)
  description = "The common tags for all resources"
  default = {
    Terraform = "true"
    Environment = "dev"
  }
}

