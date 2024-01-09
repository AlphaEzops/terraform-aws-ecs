variable "domain_name" {
  type = string
  description = "value of domain name"
}

variable "record_name" {
  type = string
  description = "value of record name"
}

variable "loadbalancer_dns" {
  type = list(string)
  description = "value of load balancer dns"
}

variable "record_config" {
  type = map(string)
  description = "value of record config"
}

variable "common_tags" {
  type = map(string)
  description = "value of common tags"
}

variable "record_config" {
  type = map(object({
    name    = optional(string)
    type    = optional(string)
    ttl     = optional(number)
    records = optional(list(string))
  }))
  description = "dns route53 record config"
 
}

#===============================================================================
# EXISTENT HOSTZONE
#===============================================================================
variable "hostzone_exists" {
  type = bool
  description = "value of hostzone exists"
  default = false
}

variable "zone_id" {
  type = string
  description = "value of zone id"
}
