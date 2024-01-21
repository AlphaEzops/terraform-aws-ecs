#===============================================================================
#  GENERAL CONFIGURATION
#===============================================================================
variable "environment" {
  type        = string
  description = "Environment for resources"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resources"
}
#===============================================================================
#  NETWORK CONFIGURATION
#===============================================================================
variable "subnet_id" {
  type        = string
  description = "Subnet ID for resources"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs for resources"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate public IP address for resources"
  default     = true
}
#===============================================================================
#  INSTANCE CONFIGURATION
#===============================================================================
variable "public_key" {
  type        = string
  description = "Key pair name for resources"
}

variable "aws_ami_ids_name" {
  type        = list(string)
  description = "The name of the AMI (provided during image creation)."
  default     = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
}

variable "instance_type" {
  type        = string
  description = "Instance type for resources"
  default     = "t3.micro"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name for resources"
}

variable "email" {
  type        = string
  description = "Email for resources"
  default     = "arthur@ezops.cloud"
}
#===============================================================================
#  DNS CONFIGURATION
#===============================================================================
variable "zone_name" {
  type        = string
  description = "Zone name for resources"
}

variable "zone_id" {
  type        = string
  description = "Zone ID for resources"
}
