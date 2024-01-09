variable "domain_name" {
  type = string
  description = "value of domain name"
}

variable "record_config" {
  type = map(any)
  description = "dns route53 record config"
  default = {
    "name" = {
      name = "value"
      type = "CNAME"
      records = [ "www.example.com" ]
      ttl =  300
    }
  }
}
#===============================================================================
# EXISTENT HOSTZONE
#===============================================================================
variable "hostzone_exists" {
  type = bool
  description = "value of hostzone exists"
  default = false
}

variable "common_tags" {
  type = map(string)
  description = "value of common tags"
  default = {}
}