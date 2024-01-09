# variables.tf

variable "namespace" {
  description = "Namespace for resources"
}

variable "environment" {
  description = "Environment for resources"
}

variable "domain_name" {
  description = "Domain name for CloudFront distribution"
}

variable "custom_origin_host_header" {
  description = "Custom header for the origin host"
}

# Add other variables as needed for your specific configuration
