# variables.tf

variable "namespace" {
  type        = string
  description = "Namespace for resources"
}

variable "environment" {
  type        = string
  description = "Environment for resources"
}

variable "domain_name" {
  type        = string
  description = "Domain name for CloudFront distribution"
}

variable "custom_origin_host_header" {
  type        = string
  description = "Custom header for the origin host"
}

variable "origin_id" {
  type        = string
  description = "Origin ID for CloudFront distribution"
}

variable "cloudfront_certificate_arn" {
  type        = string
  description = "ARN for CloudFront certificate"
}

variable "target_origin_id" {
  type        = string
  description = "Target origin ID for CloudFront distribution"
}

# Add other variables as needed for your specific configuration
