#===============================================================================
# COMMON RECORDS
#===============================================================================
variable "existent_hostzone_name" {
  type        = string
  description = "value of existent hostzone name"
  default     = null
}

variable "hostzone_name" {
  type        = string
  description = "value of hostzone name"
  default     = null
}

variable "common_tags" {
  type        = map(string)
  description = "value of common tags"
  default     = {}
}

variable "record_config" {
  type        = map(any)
  description = "dns route53 record config"
  default = {
    "name" = {
      name    = "value"
      type    = "CNAME"
      records = ["www.example.com"]
      ttl     = 300
    }
  }
}

#===============================================================================
# CERTIFICATE VALIDATION RECORD ON ROUTE53
#===============================================================================
variable "existent_acm_domain_name" {
  type        = string
  description = "value of existent acm domain name"
  default     = null
}

variable "acm_domain_name" {
  type        = string
  description = "value of acm domain name"
  default     = null
}
