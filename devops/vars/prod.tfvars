#----------------------------------
# GENERAL
#----------------------------------
name_prefix = "demo"
environment = "prod"
owner       = "DevOps Team"
project     = "unknown"
#----------------------------------
# NETWORK
#----------------------------------
vpc_name = "demo-prod"
vpc_cidr = "10.0.0.0/16"
azs      = 3
#----------------------------------
# SCALING
#----------------------------------
public_key = "your_public_key"
#----------------------------------
# CLUSTER
#----------------------------------
#----------------------------------
# CONTENT DELIVERY NETWORK
#----------------------------------
existent_hostzone_name   = "prod.ezops.com.br"
existent_acm_domain_name = "*.prod.ezops.com.br"
#----------------------------------
# DOMAIN NAME SERVER
#----------------------------------
#----------------------------------
# FIREWALL
#----------------------------------
#----------------------------------
# PROXY
#----------------------------------
#----------------------------------
# SERVICE
#----------------------------------
cluster_name      = "demo-prod"
alb_name          = "demo-prod"
target_group_name = "demo-prod-https-tg"
