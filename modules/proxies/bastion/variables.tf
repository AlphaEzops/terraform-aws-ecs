variable "environment" {
  type        = string
  description = "Environment for resources"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resources"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for resources"
}

variable "key_pair_name" {
  type        = string
  description = "Key pair name for resources"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for resources"

}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs for resources"

}
