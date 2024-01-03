variable "enabled" {
  type = bool
  description = "value of enabled module"
  default = true
}

variable "name_prefix" {
  type = string
  description = "value of name"
  default = "demo"
}

variable "access_logs" {
  type = map(string)
  default = {}
  description = "value of access logs"
}

variable "subnets_id" {
  type = list(string)
  description = "value of subnets id"
}

variable "security_groups_id" {
  type = list(string)
  description = "value of security group id"
}

variable "enable_deletion_protection" {
  type = bool
  description = "value of deletion protection"
  default = true
}

variable "load_balancer_type" {
  type = string
  description = "value of load balancer type"
  default = "application"
}

variable "internal" {
  type = bool
  description = "value of internal"
  default = false
}

variable "common_tags" {
  type = map(string)
  description = "value of common tags"
  default = {}
}

variable "timeout" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default = {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

variable "vpc_id" {
  type = string
  description = "value of vpc id"
}

variable "certificate_arn" {
  type = string
  description = "value of certificate arn"
}

variable "ssl_policy" {
  type = string
  description = "value of ssl policy"
  default = "ELBSecurityPolicy-2016-08"
  
}